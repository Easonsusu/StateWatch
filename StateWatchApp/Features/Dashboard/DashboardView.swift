import Foundation
import SwiftUI

struct DashboardAssessmentResult: Equatable {
    let assessment: StateAssessment
    let source: DashboardAssessmentSource
    let notice: String?

    var usesHealthKitDerivedData: Bool {
        source == .healthKitDerived
    }
}

enum DashboardAssessmentSource: Equatable {
    case mock
    case healthKitDerived
    case lowDataFallback
    case fallback
}

struct DashboardAssessmentProvider {
    typealias SnapshotLoader = (Int) async throws -> [DailyHealthSnapshot]

    static let lookbackDays = 30

    private let isFeatureEnabled: () -> Bool
    private let snapshotLoader: SnapshotLoader
    private let fallbackAssessment: StateAssessment

    init(
        featureFlag: HealthKitDashboardFeatureFlag = HealthKitDashboardFeatureFlag(),
        snapshotLoader: @escaping SnapshotLoader = DashboardAssessmentProvider.defaultSnapshotLoader,
        fallbackAssessment: StateAssessment = .mock
    ) {
        self.init(
            isFeatureEnabled: { featureFlag.isEnabled },
            snapshotLoader: snapshotLoader,
            fallbackAssessment: fallbackAssessment
        )
    }

    init(
        isFeatureEnabled: @escaping () -> Bool,
        snapshotLoader: @escaping SnapshotLoader = DashboardAssessmentProvider.defaultSnapshotLoader,
        fallbackAssessment: StateAssessment = .mock
    ) {
        self.isFeatureEnabled = isFeatureEnabled
        self.snapshotLoader = snapshotLoader
        self.fallbackAssessment = fallbackAssessment
    }

    func loadAssessment() async -> DashboardAssessmentResult {
        guard isFeatureEnabled() else {
            return DashboardAssessmentResult(
                assessment: fallbackAssessment,
                source: .mock,
                notice: nil
            )
        }

        do {
            let snapshots = try await snapshotLoader(Self.lookbackDays)
            guard snapshots.contains(where: { !$0.availableMetrics.isEmpty }) else {
                let source: DashboardAssessmentSource = snapshots.isEmpty ? .fallback : .lowDataFallback
                let notice = snapshots.isEmpty
                    ? "HealthKit data was unavailable, so the dashboard is showing mock data."
                    : "Recent data is limited, so the dashboard is showing mock data."
                return DashboardAssessmentResult(
                    assessment: fallbackAssessment,
                    source: source,
                    notice: notice
                )
            }

            guard let assessment = Self.makeHealthKitAssessment(from: snapshots),
                  assessment.confidence != .low,
                  assessment.confidence != .unavailable
            else {
                return DashboardAssessmentResult(
                    assessment: fallbackAssessment,
                    source: .lowDataFallback,
                    notice: "Recent data is limited, so the dashboard is showing mock data."
                )
            }

            return DashboardAssessmentResult(
                assessment: assessment,
                source: .healthKitDerived,
                notice: nil
            )
        } catch {
            return DashboardAssessmentResult(
                assessment: fallbackAssessment,
                source: .fallback,
                notice: "HealthKit data was unavailable, so the dashboard is showing mock data."
            )
        }
    }

    static func makeHealthKitAssessment(from snapshots: [DailyHealthSnapshot]) -> StateAssessment? {
        let sortedSnapshots = snapshots.sorted { $0.date < $1.date }
        guard sortedSnapshots.contains(where: { !$0.availableMetrics.isEmpty }) else {
            return nil
        }

        return OverallStateEngine().assess(history: sortedSnapshots, window: .thirtyDays)
    }

    private static func defaultSnapshotLoader(days: Int) async throws -> [DailyHealthSnapshot] {
        await HealthKitDataFetcher().fetchRecentSnapshots(days: days)
    }
}

struct DashboardView: View {
    @State var assessment: StateAssessment
    @State private var isShowingSettings = false

    private let assessmentProvider: DashboardAssessmentProvider
    private let loadsAssessmentProvider: Bool

    init() {
        self.init(
            assessment: .mock,
            assessmentProvider: DashboardAssessmentProvider(),
            loadsAssessmentProvider: true
        )
    }

    init(assessment: StateAssessment) {
        self.init(
            assessment: assessment,
            assessmentProvider: DashboardAssessmentProvider(fallbackAssessment: assessment),
            loadsAssessmentProvider: false
        )
    }

    init(
        assessment: StateAssessment = .mock,
        assessmentProvider: DashboardAssessmentProvider,
        loadsAssessmentProvider: Bool = true
    ) {
        _assessment = State(initialValue: assessment)
        self.assessmentProvider = assessmentProvider
        self.loadsAssessmentProvider = loadsAssessmentProvider
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        StateWatchColors.backgroundPrimary,
                        StateWatchColors.backgroundSecondary.opacity(0.94),
                        StateWatchColors.backgroundPrimary
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: StateWatchSpacing.xl) {
                        header
                        heroCard
                        metricsSection
                        reasonsSection
                        suggestionSection
                        trendSection
                    }
                    .padding(StateWatchSpacing.lg)
                }
            }
            .sheet(isPresented: $isShowingSettings) {
                SettingsView()
            }
            .preferredColorScheme(.dark)
        }
        .task {
            await loadAssessmentIfNeeded()
        }
        // TODO: Keep HealthKit-derived dashboard output behind the local feature flag until real-device QA is complete.
    }

    @MainActor
    private func loadAssessmentIfNeeded() async {
        guard loadsAssessmentProvider else { return }
        let result = await assessmentProvider.loadAssessment()
        assessment = result.assessment
    }

    private var content: DashboardDisplayModel {
        DashboardDisplayModel(assessment: assessment)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: StateWatchSpacing.xs) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: StateWatchSpacing.xxs) {
                    Text("Today")
                        .font(StateWatchTypography.screenTitle)
                        .foregroundStyle(StateWatchColors.textPrimary)

                    Text(content.updatedText)
                        .font(StateWatchTypography.caption)
                        .foregroundStyle(StateWatchColors.textMuted)
                }

                Spacer()

                Button {
                    isShowingSettings = true
                } label: {
                    Image(systemName: "gearshape")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundStyle(StateWatchColors.textPrimary)
                        .frame(width: 42, height: 42)
                        .background(StateWatchColors.panel.opacity(0.82))
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(StateWatchColors.border.opacity(0.7), lineWidth: 1)
                        )
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Settings")
            }
        }
    }

    private var heroCard: some View {
        StateWatchGlassCard(accentColor: content.accentColor, showsGlow: true) {
            VStack(alignment: .leading, spacing: StateWatchSpacing.lg) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: StateWatchSpacing.sm) {
                        Text("Mock wellness estimate")
                            .font(StateWatchTypography.badge)
                            .foregroundStyle(content.accentColor)

                        Text(content.summary)
                            .font(StateWatchTypography.sectionTitle)
                            .foregroundStyle(StateWatchColors.textPrimary)
                            .fixedSize(horizontal: false, vertical: true)

                        StateWatchConfidenceBadge(confidence: content.confidence)
                    }

                    Spacer(minLength: StateWatchSpacing.md)
                }

                StateWatchScoreRing(
                    score: content.score,
                    label: content.stateLabel,
                    confidence: content.confidence,
                    size: 216
                )
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }

    private var metricsSection: some View {
        VStack(alignment: .leading, spacing: StateWatchSpacing.md) {
            sectionTitle("Signals")

            LazyVGrid(columns: metricColumns, spacing: StateWatchSpacing.md) {
                ForEach(content.metrics) { metric in
                    StateWatchMetricCard(
                        title: metric.title,
                        value: metric.value,
                        subtitle: metric.subtitle,
                        progress: metric.progress,
                        accentColor: metric.accentColor
                    )
                }
            }
        }
    }

    private var reasonsSection: some View {
        StateWatchGlassCard {
            VStack(alignment: .leading, spacing: StateWatchSpacing.md) {
                sectionTitle("Reasons")

                ForEach(content.reasons, id: \.self) { reason in
                    StateWatchReasonRow(text: reason, accentColor: content.accentColor)
                }
            }
        }
    }

    private var suggestionSection: some View {
        StateWatchSuggestionCard(
            title: "Today's suggestion",
            suggestion: content.suggestion,
            accentColor: content.accentColor
        )
    }

    private var trendSection: some View {
        StateWatchGlassCard(accentColor: StateWatchColors.accentBlue.opacity(0.62)) {
            VStack(alignment: .leading, spacing: StateWatchSpacing.md) {
                HStack(alignment: .firstTextBaseline) {
                    sectionTitle("7-day trend")
                    Spacer()
                    Text(content.trendCaption)
                        .font(StateWatchTypography.caption)
                        .foregroundStyle(StateWatchColors.textMuted)
                }

                StateWatchMiniTrendChart(values: content.trendValues, accentColor: content.accentColor)
            }
        }
    }

    private var metricColumns: [GridItem] {
        [
            GridItem(.flexible(), spacing: StateWatchSpacing.md),
            GridItem(.flexible(), spacing: StateWatchSpacing.md)
        ]
    }

    private func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(StateWatchTypography.cardTitle)
            .foregroundStyle(StateWatchColors.textPrimary)
    }
}

struct DashboardDisplayModel {
    let score: Int
    let stateLabel: String
    let confidence: ScoreConfidence
    let updatedText: String
    let summary: String
    let accentColor: Color
    let metrics: [DashboardMetricDisplay]
    let reasons: [String]
    let suggestion: String
    let trendValues: [Double]
    let trendCaption: String

    init(assessment: StateAssessment) {
        score = StateWatchTheme.clampedScore(assessment.overallScore)
        stateLabel = assessment.level.rawValue
        confidence = assessment.confidence
        updatedText = "Demo data - Updated \(Self.formattedTime(for: assessment.date))"
        summary = Self.summary(for: assessment.level)
        accentColor = StateWatchTheme.stateLabelColor(for: assessment.level)
        metrics = assessment.components.map(DashboardMetricDisplay.init(component:))
        reasons = assessment.reasons
        suggestion = assessment.primarySuggestion
        trendValues = [62, 67, 64, 72, 70, 76, 74]
        trendCaption = "Mock data"
    }

    var searchableText: String {
        (
            [stateLabel, updatedText, summary, suggestion, trendCaption]
                + reasons
                + metrics.flatMap { [$0.title, $0.value, $0.subtitle] }
        ).joined(separator: " ")
    }

    private static func summary(for level: StateLevel) -> String {
        switch level {
        case .steady:
            return "Your recent signals look steady."
        case .mixed:
            return "Your recent signals look mixed."
        case .low:
            return "Recent signals are softer than your mock baseline."
        case .needsRest:
            return "Recent signals support a gentler plan if that matches how you feel."
        }
    }

    private static func formattedTime(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

struct DashboardMetricDisplay: Identifiable {
    let id: String
    let title: String
    let value: String
    let subtitle: String
    let progress: Double
    let accentColor: Color

    init(component: ScoreComponent) {
        id = component.id
        title = Self.displayTitle(for: component)
        value = "\(StateWatchTheme.clampedScore(component.score))"
        subtitle = component.summary
        progress = Double(StateWatchTheme.clampedScore(component.score)) / 100
        accentColor = Self.accentColor(for: component)
    }

    private static func displayTitle(for component: ScoreComponent) -> String {
        if component.id == "stressFatigue" {
            return "Fatigue Context"
        }

        return component.title
    }

    private static func accentColor(for component: ScoreComponent) -> Color {
        switch component.id {
        case "recovery":
            return StateWatchColors.recoveryGreen
        case "sleep":
            return StateWatchColors.accentCyan
        case "stressFatigue":
            return StateWatchColors.cautionAmber
        case "activityLoad":
            return StateWatchColors.accentBlue
        default:
            return StateWatchTheme.scoreColor(for: component.score)
        }
    }
}

#Preview("Mock Today") {
    DashboardView()
}

#Preview("Lower Energy Mock") {
    DashboardView(assessment: .mockLow)
}
