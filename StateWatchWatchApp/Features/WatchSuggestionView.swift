import SwiftUI

struct WatchSuggestionView: View {
    let text: String

    var body: some View {
        WatchPage {
            VStack(alignment: .leading, spacing: 12) {
                Text(WatchLocalization.text("Suggestion"))
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(WatchStyle.textPrimary)

                Text(WatchLocalization.text(text))
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .lineSpacing(2)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(WatchStyle.textPrimary)
                    .fixedSize(horizontal: false, vertical: true)

                Text(WatchLocalization.text("If it matches how you feel"))
                    .font(.system(size: 11, weight: .medium, design: .rounded))
                    .foregroundStyle(WatchStyle.textMuted)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(WatchStyle.panel)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(WatchStyle.accentCyan.opacity(0.28), lineWidth: 1)
            )
        }
        .accessibilityLabel(
            Text(WatchLocalization.formatted(
                "Suggestion. %@", WatchLocalization.text(text)
            ))
        )
    }
}

#Preview {
    WatchSuggestionView(text: "Consider a lighter day if that matches how you feel.")
}
