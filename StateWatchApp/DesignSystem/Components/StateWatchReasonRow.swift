import SwiftUI

struct StateWatchReasonRow: View {
    let text: String
    let accentColor: Color?

    init(text: String, accentColor: Color? = nil) {
        self.text = text
        self.accentColor = accentColor
    }

    var body: some View {
        HStack(alignment: .top, spacing: StateWatchSpacing.sm) {
            Circle()
                .fill((accentColor ?? StateWatchColors.accentCyan).opacity(0.95))
                .frame(width: 8, height: 8)
                .padding(.top, 6)

            Text(text)
                .font(StateWatchTypography.body)
                .foregroundStyle(StateWatchColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .accessibilityElement(children: .combine)
    }
}

#Preview("Reason Row") {
    ZStack {
        StateWatchColors.backgroundPrimary.ignoresSafeArea()
        StateWatchGlassCard {
            StateWatchReasonRow(
                text: "Sleep is close to your recent pattern.",
                accentColor: StateWatchColors.accentCyan
            )
        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
