import SwiftUI

struct WatchScoreView: View {
    let score: Int
    let level: String
    let confidence: String
    let updatedText: String

    var body: some View {
        WatchPage {
            VStack(spacing: 9) {
                ZStack {
                    Circle()
                        .stroke(WatchStyle.border.opacity(0.85), lineWidth: 9)

                    Circle()
                        .trim(from: 0, to: CGFloat(min(100, max(0, score))) / 100)
                        .stroke(
                            WatchStyle.scoreColor(for: score),
                            style: StrokeStyle(lineWidth: 9, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                        .shadow(color: WatchStyle.scoreColor(for: score).opacity(0.34), radius: 9, x: 0, y: 0)

                    VStack(spacing: 1) {
                        Text("\(score)")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .monospacedDigit()
                            .foregroundStyle(WatchStyle.textPrimary)

                        Text(WatchLocalization.stateLabel(level))
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                            .lineLimit(1)
                            .minimumScaleFactor(0.74)
                            .foregroundStyle(WatchStyle.scoreColor(for: score))
                    }
                }
                .frame(width: 116, height: 116)

                VStack(spacing: 3) {
                    Text(WatchLocalization.text(confidence))
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundStyle(WatchStyle.accentCyan)

                    Text(WatchLocalization.text(updatedText))
                        .font(.system(size: 11, weight: .medium, design: .rounded))
                        .foregroundStyle(WatchStyle.textMuted)
                }
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            }
        }
        .accessibilityLabel(
            Text(WatchLocalization.formatted(
                "Mock wellness score %d, %@, confidence %@, %@",
                score,
                WatchLocalization.stateLabel(level),
                WatchLocalization.text(confidence),
                WatchLocalization.text(updatedText)
            ))
        )
    }
}

#Preview {
    WatchScoreView(score: 76, level: "Mixed", confidence: "Medium", updatedText: "Demo")
}
