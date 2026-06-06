import SwiftUI

struct StateWatchMetricCard: View {
    let title: String
    let value: String
    let subtitle: String
    let progress: Double?
    let accentColor: Color

    var body: some View {
        StateWatchGlassCard(accentColor: accentColor.opacity(0.7)) {
            VStack(alignment: .leading, spacing: StateWatchSpacing.sm) {
                HStack(alignment: .center, spacing: StateWatchSpacing.xs) {
                    Circle()
                        .fill(accentColor)
                        .frame(width: 8, height: 8)
                        .shadow(color: accentColor.opacity(0.28), radius: 8, x: 0, y: 0)

                    Text(title)
                        .font(StateWatchTypography.cardTitle)
                        .foregroundStyle(StateWatchColors.textSecondary)
                }

                Text(value)
                    .font(StateWatchTypography.metricValue)
                    .monospacedDigit()
                    .foregroundStyle(StateWatchColors.textPrimary)

                Text(subtitle)
                    .font(StateWatchTypography.caption)
                    .foregroundStyle(StateWatchColors.textMuted)
                    .fixedSize(horizontal: false, vertical: true)

                if let progress {
                    progressBar(value: progress)
                }
            }
        }
        .accessibilityElement(children: .combine)
    }

    private func progressBar(value: Double) -> some View {
        let clamped = min(1, max(0, value))

        return GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(StateWatchColors.border.opacity(0.48))
                Capsule()
                    .fill(accentColor)
                    .frame(width: proxy.size.width * clamped)
                    .shadow(color: accentColor.opacity(0.2), radius: 8, x: 0, y: 0)
            }
        }
        .frame(height: 6)
        .accessibilityLabel("\(title) progress")
        .accessibilityValue("\(Int(clamped * 100)) percent")
    }
}

#Preview("Metric Cards") {
    ZStack {
        StateWatchColors.backgroundPrimary.ignoresSafeArea()
        VStack(spacing: StateWatchSpacing.md) {
            StateWatchMetricCard(
                title: "Recovery",
                value: "68",
                subtitle: "Slightly softer than baseline",
                progress: 0.68,
                accentColor: StateWatchColors.recoveryGreen
            )
            StateWatchMetricCard(
                title: "Sleep",
                value: "81",
                subtitle: "Close to your recent pattern",
                progress: 0.81,
                accentColor: StateWatchColors.accentCyan
            )
            StateWatchMetricCard(
                title: "Fatigue Context",
                value: "64",
                subtitle: "Recent signals look mixed",
                progress: 0.64,
                accentColor: StateWatchColors.cautionAmber
            )
        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
