import SwiftUI

struct WatchScoreView: View {
    let score: Int

    var body: some View {
        VStack {
            Text("Readiness")
                .font(.caption)
            Text("\(score)")
                .font(.title)
                .bold()
        }
    }
}

#Preview {
    WatchScoreView(score: 76)
}
