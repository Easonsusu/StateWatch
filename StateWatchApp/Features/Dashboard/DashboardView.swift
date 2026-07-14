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
                    ? DashboardPresentationModel.unavailableFallbackNotice
                    : DashboardPresentationModel.lowDataFallbackNotice
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
                    notice: DashboardPresentationModel.lowDataFallbackNotice
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
                notice: DashboardPresentationModel.unavailableFallbackNotice
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
    @State private var assessmentResult: DashboardAssessmentResult
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
        _assessmentResult = State(
            initialValue: DashboardAssessmentResult(assessment: assessment, source: .mock, notice: nil)
        )
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
                        noticeCard
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
        assessmentResult = result
    }

    private var content: DashboardPresentationModel {
        DashboardPresentationModel(result: assessmentResult)
    }

    var assessment: StateAssessment {
        assessmentResult.assessment
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
                        Text(content.sourceBadgeText)
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
        .accessibilityElement(children: .combine)
        .accessibilityLabel(content.accessibilitySummary)
    }

    @ViewBuilder
    private var noticeCard: some View {
        if let noticeText = content.noticeText,
           let accessibilityLabel = content.noticeAccessibilityLabel {
            StateWatchGlassCard(accentColor: StateWatchColors.accentBlue.opacity(0.52)) {
                HStack(alignment: .top, spacing: StateWatchSpacing.sm) {
                    Image(systemName: "info.circle")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(StateWatchColors.accentCyan)

                    Text(noticeText)
                        .font(StateWatchTypography.body)
                        .foregroundStyle(StateWatchColors.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel(accessibilityLabel)
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
                if content.showsTrendChart {
                    HStack(alignment: .firstTextBaseline) {
                        sectionTitle("7-day trend")
                        Spacer()
                        Text(content.trendCaption)
                            .font(StateWatchTypography.caption)
                            .foregroundStyle(StateWatchColors.textMuted)
                    }

                    StateWatchMiniTrendChart(values: content.trendValues, accentColor: content.accentColor)
                        .accessibilityHidden(true)
                } else {
                    sectionTitle("7-day trend")

                    if let title = content.trendUnavailableTitle,
                       let message = content.trendUnavailableMessage {
                        VStack(alignment: .leading, spacing: StateWatchSpacing.xs) {
                            Text(title)
                                .font(StateWatchTypography.cardTitle)
                                .foregroundStyle(StateWatchColors.textPrimary)

                            Text(message)
                                .font(StateWatchTypography.body)
                                .foregroundStyle(StateWatchColors.textSecondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(content.trendAccessibilitySummary)
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

#Preview("Mock Today") {
    DashboardView()
}

#Preview("Lower Energy Mock") {
    DashboardView(assessment: .mockLow)
}
