import SwiftUI

struct WatchScoreView: View {
    let score: Int
    let level: String

    var body: some View {
        VStack(spacing: 4) {
            Text("\(score)")
                .font(.system(.largeTitle, design: .rounded).weight(.bold))
                .monospacedDigit()
            Text(level)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .accessibilityLabel("Wellness score \(score), \(level)")
    }
}

#Preview {
    WatchScoreView(score: 76, level: "Mixed")
}
