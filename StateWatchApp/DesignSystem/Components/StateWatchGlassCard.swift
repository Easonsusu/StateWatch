import SwiftUI

struct StateWatchGlassCard<Content: View>: View {
    let accentColor: Color?
    let showsGlow: Bool
    let content: Content

    init(
        accentColor: Color? = nil,
        showsGlow: Bool = false,
        @ViewBuilder content: () -> Content
    ) {
        self.accentColor = accentColor
        self.showsGlow = showsGlow
        self.content = content()
    }

    var body: some View {
        content
            .padding(StateWatchSpacing.lg)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(cardBackground)
            .overlay(cardBorder)
            .shadow(color: glowColor, radius: showsGlow ? 18 : 0, x: 0, y: 0)
    }

    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: StateWatchRadius.large, style: .continuous)
            .fill(
                LinearGradient(
                    colors: [
                        StateWatchColors.panelElevated.opacity(0.82),
                        StateWatchColors.panel.opacity(0.72)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }

    private var cardBorder: some View {
        RoundedRectangle(cornerRadius: StateWatchRadius.large, style: .continuous)
            .stroke(
                (accentColor ?? StateWatchColors.border).opacity(accentColor == nil ? 0.72 : 0.64),
                lineWidth: 1
            )
    }

    private var glowColor: Color {
        (accentColor ?? .clear).opacity(0.18)
    }
}

#Preview("Glass Card") {
    ZStack {
        StateWatchColors.backgroundPrimary.ignoresSafeArea()
        StateWatchGlassCard(accentColor: StateWatchColors.accentCyan, showsGlow: true) {
            VStack(alignment: .leading, spacing: StateWatchSpacing.sm) {
                Text("Glass Card")
                    .font(StateWatchTypography.cardTitle)
                    .foregroundStyle(StateWatchColors.textPrimary)
                Text("Dark panel, thin border, restrained glow.")
                    .font(StateWatchTypography.body)
                    .foregroundStyle(StateWatchColors.textSecondary)
            }
        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
