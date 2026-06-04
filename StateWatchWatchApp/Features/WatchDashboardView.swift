import SwiftUI

struct WatchDashboardView: View {
    var body: some View {
        VStack(spacing: 10) {
            WatchScoreView(score: 76)
            WatchSuggestionView(text: "Consider a moderate activity day.")
        }
        .padding(8)
    }
}

#Preview {
    WatchDashboardView()
}
