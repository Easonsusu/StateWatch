import SwiftUI

#if DEBUG
struct StateWatchVisualPreviewView: View {
    @State private var selectedState: StateWatchVisualPreviewState = .normal

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    StateWatchColors.backgroundPrimary,
                    StateWatchColors.backgroundSecondary.opacity(0.92),
                    StateWatchColors.backgroundPrimary
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: StateWatchSpacing.xl) {
                    header
                    statePicker
                    heroCard
                    metricsSection
                    reasonsSection
                    suggestionSection
                    trendSection
                }
                .padding(StateWatchSpacing.lg)
            }
        }
        .navigationTitle("Visual Preview")
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
    }

    private var content: StateWatchVisualPreviewContent {
        selectedState.content
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: StateWatchSpacing.xs) {
            HStack(alignment: .firstTextBaseline) {
                Text("Today")
                    .font(StateWatchTypography.screenTitle)
                    .foregroundStyle(StateWatchColors.textPrimary)

                Spacer()

                Text("Visual Preview")
                    .font(StateWatchTypography.badge)
                    .foregroundStyle(StateWatchColors.accentCyan)
                    .padding(.horizontal, StateWatchSpacing.sm)
                    .padding(.vertical, StateWatchSpacing.xs)
                    .background(StateWatchColors.panel.opacity(0.82))
                    .clipShape(Capsule())
            }

            Text(content.updatedText)
                .font(StateWatchTypography.caption)
                .foregroundStyle(StateWatchColors.textMuted)
        }
    }

    private var statePicker: some View {
        Picker("Preview state", selection: $selectedState) {
            ForEach(StateWatchVisualPreviewState.allCases) { state in
                Text(state.title).tag(state)
            }
        }
        .pickerStyle(.segmented)
        .tint(StateWatchColors.accentCyan)
    }

    private var heroCard: some View {
        StateWatchGlassCard(accentColor: content.accentColor, showsGlow: true) {
            VStack(spacing: StateWatchSpacing.lg) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: StateWatchSpacing.sm) {
                        Text(content.kicker)
                            .font(StateWatchTypography.badge)
                            .foregroundStyle(content.accentColor)

                        Text(content.summary)
                            .font(StateWatchTypography.cardTitle)
                            .foregroundStyle(StateWatchColors.textPrimary)
                            .fixedSize(horizontal: false, vertical: true)

                        StateWatchConfidenceBadge(confidence: content.confidence)
                    }

                    Spacer(minLength: StateWatchSpacing.md)
                }

                StateWatchScoreRing(
                    score: content.score,
                    label: content.label,
                    confidence: content.ringConfidence,
                    size: 208
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
            title: "Suggestion",
            suggestion: content.suggestion,
            accentColor: content.accentColor
        )
    }

    private var trendSection: some View {
        StateWatchGlassCard(accentColor: StateWatchColors.accentBlue.opacity(0.62)) {
            VStack(alignment: .leading, spacing: StateWatchSpacing.md) {
                HStack {
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

enum StateWatchVisualPreviewState: String, CaseIterable, Identifiable {
    case normal
    case lowData
    case unavailable

    var id: String { rawValue }

    var title: String {
        switch self {
        case .normal: return "Normal"
        case .lowData: return "Low Data"
        case .unavailable: return "Unavailable"
        }
    }

    var content: StateWatchVisualPreviewContent {
        switch self {
        case .normal:
            return StateWatchVisualPreviewContent(
                score: 76,
                label: "Mixed",
                confidence: .medium,
                ringConfidence: .medium,
                updatedText: "Updated 12:40",
                kicker: "Medium confidence",
                summary: "Your recent signals look mixed.",
                accentColor: StateWatchColors.accentCyan,
                metrics: [
                    StateWatchVisualMetric(title: "Recovery", value: "68", subtitle: "HRV slightly below recent baseline", progress: 0.68, accentColor: StateWatchColors.recoveryGreen),
                    StateWatchVisualMetric(title: "Sleep", value: "81", subtitle: "Close to your recent pattern", progress: 0.81, accentColor: StateWatchColors.accentCyan),
                    StateWatchVisualMetric(title: "Fatigue Context", value: "64", subtitle: "Recent signals look mixed", progress: 0.64, accentColor: StateWatchColors.cautionAmber),
                    StateWatchVisualMetric(title: "Activity Load", value: "75", subtitle: "Moderate recent movement", progress: 0.75, accentColor: StateWatchColors.accentBlue)
                ],
                reasons: [
                    "Sleep is close to your recent pattern.",
                    "Recovery signals are slightly softer than your baseline.",
                    "Recent activity load looks moderate."
                ],
                suggestion: "Consider a lighter day if that matches how you feel.",
                trendValues: [62, 67, 64, 72, 70, 76, 74],
                trendCaption: "Mock data"
            )
        case .lowData:
            return StateWatchVisualPreviewContent(
                score: 52,
                label: "Limited data",
                confidence: .low,
                ringConfidence: .low,
                updatedText: "Waiting for more local history",
                kicker: "Low data",
                summary: "Recent data is limited, so this estimate is cautious.",
                accentColor: StateWatchColors.cautionAmber,
                metrics: [
                    StateWatchVisualMetric(title: "Recovery", value: "Low data", subtitle: "More local history can improve confidence", progress: nil, accentColor: StateWatchColors.cautionAmber),
                    StateWatchVisualMetric(title: "Sleep", value: "Low data", subtitle: "Sleep context is still building", progress: nil, accentColor: StateWatchColors.accentCyan),
                    StateWatchVisualMetric(title: "Fatigue Context", value: "Low data", subtitle: "Signals are incomplete today", progress: nil, accentColor: StateWatchColors.textMuted),
                    StateWatchVisualMetric(title: "Activity Load", value: "Low data", subtitle: "Recent movement is optional context", progress: nil, accentColor: StateWatchColors.accentBlue)
                ],
                reasons: [
                    "Recent data is limited, so this estimate is cautious.",
                    "Missing signals lower confidence rather than the wellness score."
                ],
                suggestion: "Check in with how you feel before adjusting your day.",
                trendValues: [62, 64, 63],
                trendCaption: "Limited"
            )
        case .unavailable:
            return StateWatchVisualPreviewContent(
                score: 0,
                label: "No data",
                confidence: .unavailable,
                ringConfidence: .unavailable,
                updatedText: "No recent update",
                kicker: "Apple Health unavailable",
                summary: "Apple Health data is unavailable. StateWatch can keep showing demo data until local Health data is available.",
                accentColor: StateWatchColors.textMuted,
                metrics: [
                    StateWatchVisualMetric(title: "Recovery", value: "--", subtitle: "Waiting for local data", progress: nil, accentColor: StateWatchColors.textMuted),
                    StateWatchVisualMetric(title: "Sleep", value: "--", subtitle: "Waiting for local data", progress: nil, accentColor: StateWatchColors.textMuted),
                    StateWatchVisualMetric(title: "Fatigue Context", value: "--", subtitle: "Waiting for local data", progress: nil, accentColor: StateWatchColors.textMuted),
                    StateWatchVisualMetric(title: "Activity Load", value: "--", subtitle: "Waiting for local data", progress: nil, accentColor: StateWatchColors.textMuted)
                ],
                reasons: [
                    "Apple Health data is unavailable.",
                    "The production dashboard can continue using mock data."
                ],
                suggestion: "You can revisit Apple Health settings when local data is available.",
                trendValues: [],
                trendCaption: "No data"
            )
        }
    }
}

struct StateWatchVisualPreviewContent {
    let score: Int
    let label: String
    let confidence: ScoreConfidence
    let ringConfidence: ScoreConfidence
    let updatedText: String
    let kicker: String
    let summary: String
    let accentColor: Color
    let metrics: [StateWatchVisualMetric]
    let reasons: [String]
    let suggestion: String
    let trendValues: [Double]
    let trendCaption: String
}

struct StateWatchVisualMetric: Identifiable {
    var id: String { title }

    let title: String
    let value: String
    let subtitle: String
    let progress: Double?
    let accentColor: Color
}

#Preview("Visual Dashboard Preview") {
    NavigationStack {
        StateWatchVisualPreviewView()
    }
}
#endif
