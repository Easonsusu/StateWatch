import SwiftUI

struct WatchDashboardView: View {
    let content: WatchDashboardDisplayModel

    init(assessment: StateAssessment = .mock) {
        self.content = WatchDashboardDisplayModel(assessment: assessment)
    }

    init(displayModel: WatchDashboardDisplayModel) {
        self.content = displayModel
    }

    var body: some View {
        TabView {
            WatchScoreView(
                score: content.score,
                level: content.stateLabel,
                confidence: content.confidenceText,
                updatedText: content.updatedText
            )

            WatchCheckInView()

            componentSummary

            WatchSuggestionView(text: content.suggestion)

            confidenceSummary
        }
        .background(WatchStyle.backgroundGradient)
        .preferredColorScheme(.dark)
        // TODO: Keep this mock-only until a future local production data phase is explicitly approved.
    }

    private var componentSummary: some View {
        WatchPage {
            VStack(alignment: .leading, spacing: 10) {
                Text("Signals")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(WatchStyle.textPrimary)

                VStack(spacing: 7) {
                    ForEach(content.metrics) { metric in
                        WatchMetricRow(
                            title: metric.title,
                            score: metric.score,
                            color: WatchStyle.metricColor(for: metric.id)
                        )
                    }
                }
            }
        }
        .accessibilityLabel("Mock signal summary. Recovery 68. Sleep 81. Fatigue Context 64. Activity Load 75.")
    }

    private var confidenceSummary: some View {
        WatchPage {
            VStack(alignment: .leading, spacing: 10) {
                Text("Estimate")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(WatchStyle.textPrimary)

                VStack(alignment: .leading, spacing: 8) {
                    WatchStatusPill(text: "Confidence: \(content.confidenceText)", color: WatchStyle.confidenceColor(for: content.confidence))
                    WatchStatusPill(text: "Updated: \(content.updatedText)", color: WatchStyle.accentCyan)
                }

                Text(content.dataSourceText)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(WatchStyle.textMuted)
                    .lineLimit(1)
                    .minimumScaleFactor(0.82)
            }
        }
        .accessibilityLabel("Confidence \(content.confidenceText). Updated \(content.updatedText). Mock data only.")
    }
}

struct WatchPage<Content: View>: View {
    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            WatchStyle.backgroundGradient
                .ignoresSafeArea()

            content
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}

private struct WatchMetricRow: View {
    let title: String
    let score: Int
    let color: Color

    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(color)
                .frame(width: 7, height: 7)
                .shadow(color: color.opacity(0.4), radius: 4, x: 0, y: 0)

            Text(title)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundStyle(WatchStyle.textSecondary)
                .lineLimit(1)
                .minimumScaleFactor(0.72)

            Spacer(minLength: 4)

            Text("\(score)")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .monospacedDigit()
                .foregroundStyle(WatchStyle.textPrimary)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(WatchStyle.panel)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(WatchStyle.border.opacity(0.82), lineWidth: 1)
        )
    }
}

private struct WatchStatusPill: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .semibold, design: .rounded))
            .lineLimit(1)
            .minimumScaleFactor(0.76)
            .foregroundStyle(color)
            .padding(.horizontal, 10)
            .padding(.vertical, 7)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(WatchStyle.panel)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(color.opacity(0.32), lineWidth: 1)
            )
    }
}

enum WatchStyle {
    static let backgroundPrimary = Color(red: 8.0 / 255.0, green: 11.0 / 255.0, blue: 18.0 / 255.0)
    static let backgroundSecondary = Color(red: 14.0 / 255.0, green: 19.0 / 255.0, blue: 32.0 / 255.0)
    static let panel = Color(red: 20.0 / 255.0, green: 27.0 / 255.0, blue: 42.0 / 255.0).opacity(0.82)
    static let border = Color(red: 40.0 / 255.0, green: 52.0 / 255.0, blue: 74.0 / 255.0)
    static let textPrimary = Color(red: 244.0 / 255.0, green: 248.0 / 255.0, blue: 255.0 / 255.0)
    static let textSecondary = Color(red: 170.0 / 255.0, green: 183.0 / 255.0, blue: 204.0 / 255.0)
    static let textMuted = Color(red: 101.0 / 255.0, green: 115.0 / 255.0, blue: 140.0 / 255.0)
    static let accentCyan = Color(red: 53.0 / 255.0, green: 231.0 / 255.0, blue: 255.0 / 255.0)
    static let accentBlue = Color(red: 77.0 / 255.0, green: 124.0 / 255.0, blue: 255.0 / 255.0)
    static let recoveryGreen = Color(red: 92.0 / 255.0, green: 242.0 / 255.0, blue: 177.0 / 255.0)
    static let cautionAmber = Color(red: 255.0 / 255.0, green: 202.0 / 255.0, blue: 99.0 / 255.0)
    static let softRed = Color(red: 255.0 / 255.0, green: 107.0 / 255.0, blue: 107.0 / 255.0)

    static var backgroundGradient: LinearGradient {
        LinearGradient(
            colors: [backgroundPrimary, backgroundSecondary, backgroundPrimary],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    static func scoreColor(for score: Int) -> Color {
        switch min(100, max(0, score)) {
        case 80...100:
            return recoveryGreen
        case 60..<80:
            return accentCyan
        case 40..<60:
            return cautionAmber
        default:
            return softRed
        }
    }

    static func confidenceColor(for confidence: ScoreConfidence) -> Color {
        switch confidence {
        case .high:
            return recoveryGreen
        case .medium:
            return accentCyan
        case .low:
            return cautionAmber
        case .unavailable:
            return textMuted
        }
    }

    static func metricColor(for id: String) -> Color {
        switch id {
        case "recovery":
            return recoveryGreen
        case "sleep":
            return accentCyan
        case "stressFatigue":
            return cautionAmber
        case "activityLoad":
            return accentBlue
        default:
            return textMuted
        }
    }
}

#Preview("Mock Today") {
    WatchDashboardView()
}

#Preview("Lower Energy Mock") {
    WatchDashboardView(assessment: .mockLow)
}
