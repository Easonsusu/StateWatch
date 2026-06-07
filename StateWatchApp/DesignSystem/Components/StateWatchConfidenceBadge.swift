import SwiftUI

struct StateWatchConfidenceBadge: View {
    let confidence: ScoreConfidence

    var body: some View {
        Text(StateWatchTheme.confidenceLabel(for: confidence))
            .font(StateWatchTypography.badge)
            .foregroundStyle(StateWatchTheme.confidenceColor(for: confidence))
            .padding(.horizontal, StateWatchSpacing.sm)
            .padding(.vertical, StateWatchSpacing.xs)
            .background(
                Capsule()
                    .fill(StateWatchColors.backgroundSecondary.opacity(0.82))
            )
            .overlay(
                Capsule()
                    .stroke(StateWatchTheme.confidenceColor(for: confidence).opacity(0.62), lineWidth: 1)
            )
            .accessibilityLabel("Confidence \(StateWatchTheme.confidenceLabel(for: confidence))")
    }
}

#Preview("Confidence Badges") {
    ZStack {
        StateWatchColors.backgroundPrimary.ignoresSafeArea()
        VStack(spacing: StateWatchSpacing.md) {
            ForEach(ScoreConfidence.allCases) { confidence in
                StateWatchConfidenceBadge(confidence: confidence)
            }
        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
