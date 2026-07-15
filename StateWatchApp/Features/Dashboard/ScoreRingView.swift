import SwiftUI

struct ScoreRingView: View {
    let score: Int
    let title: String

    var body: some View {
        ZStack {
            Circle()
                .stroke(.secondary.opacity(0.2), lineWidth: 18)
            Circle()
                .trim(from: 0, to: CGFloat(score) / 100)
                .stroke(.green, style: StrokeStyle(lineWidth: 18, lineCap: .round))
                .rotationEffect(.degrees(-90))
            VStack(spacing: 6) {
                Text("\(score)")
                    .font(.system(size: 56, weight: .bold, design: .rounded))
                    .monospacedDigit()
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(width: 220, height: 220)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(
            String.localizedStringWithFormat(
                String(localized: "Daily wellness score %d, %@"),
                score,
                title
            )
        )
    }
}

#Preview {
    ScoreRingView(score: 76, title: "Mixed")
}
