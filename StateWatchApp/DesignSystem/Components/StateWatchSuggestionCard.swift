import SwiftUI

struct StateWatchSuggestionCard: View {
    let title: String
    let suggestion: String
    let accentColor: Color

    var body: some View {
        StateWatchGlassCard(accentColor: accentColor, showsGlow: true) {
            VStack(alignment: .leading, spacing: StateWatchSpacing.sm) {
                Text(title)
                    .font(StateWatchTypography.cardTitle)
                    .foregroundStyle(StateWatchColors.textPrimary)

                Text(suggestion)
                    .font(StateWatchTypography.body)
                    .foregroundStyle(StateWatchColors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .accessibilityElement(children: .combine)
    }
}

#Preview("Suggestion Card") {
    ZStack {
        StateWatchColors.backgroundPrimary.ignoresSafeArea()
        StateWatchSuggestionCard(
            title: "Suggestion",
            suggestion: "Consider a lighter day if that matches how you feel.",
            accentColor: StateWatchColors.accentCyan
        )
        .padding()
    }
    .preferredColorScheme(.dark)
}
