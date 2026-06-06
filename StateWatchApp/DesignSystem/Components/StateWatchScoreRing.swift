import SwiftUI

struct StateWatchScoreRing: View {
    let score: Int
    let label: String
    let confidence: ScoreConfidence?
    let size: CGFloat

    private var clampedScore: Int {
        StateWatchTheme.clampedScore(score)
    }

    private var progress: CGFloat {
        CGFloat(clampedScore) / 100
    }

    private var ringColor: Color {
        confidence == .unavailable ? StateWatchColors.textMuted : StateWatchTheme.scoreColor(for: clampedScore)
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(StateWatchColors.border.opacity(0.72), lineWidth: ringWidth)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(ringColor, style: StrokeStyle(lineWidth: ringWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .shadow(color: ringColor.opacity(confidence == .unavailable ? 0 : 0.32), radius: ringWidth, x: 0, y: 0)

            VStack(spacing: StateWatchSpacing.xs) {
                Text(confidence == .unavailable ? "--" : "\(clampedScore)")
                    .font(.system(size: size * 0.29, weight: .bold, design: .rounded))
                    .monospacedDigit()
                    .foregroundStyle(StateWatchColors.textPrimary)

                Text(label)
                    .font(StateWatchTypography.cardTitle)
                    .lineLimit(1)
                    .minimumScaleFactor(0.72)
                    .foregroundStyle(ringColor)

                if let confidence {
                    Text(StateWatchTheme.confidenceLabel(for: confidence))
                        .font(StateWatchTypography.badge)
                        .foregroundStyle(StateWatchTheme.confidenceColor(for: confidence))
                }
            }
            .frame(width: size * 0.68)
        }
        .frame(width: size, height: size)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityText)
    }

    private var ringWidth: CGFloat {
        max(8, size * 0.075)
    }

    private var accessibilityText: String {
        var parts = ["Wellness score \(clampedScore)", label]
        if let confidence {
            parts.append("Confidence \(StateWatchTheme.confidenceLabel(for: confidence))")
        }
        return parts.joined(separator: ", ")
    }
}

#Preview("Score Rings") {
    ZStack {
        StateWatchColors.backgroundPrimary.ignoresSafeArea()
        VStack(spacing: StateWatchSpacing.xl) {
            HStack(spacing: StateWatchSpacing.xl) {
                StateWatchScoreRing(score: 92, label: "Steady", confidence: .high, size: 160)
                StateWatchScoreRing(score: 76, label: "Mixed", confidence: .medium, size: 160)
            }
            HStack(spacing: StateWatchSpacing.xl) {
                StateWatchScoreRing(score: 52, label: "Cautious", confidence: .low, size: 160)
                StateWatchScoreRing(score: 0, label: "No data", confidence: .unavailable, size: 160)
            }
        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
