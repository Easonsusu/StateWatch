import SwiftUI

struct WatchDashboardView: View {
    let assessment: StateAssessment

    var body: some View {
        VStack(spacing: 8) {
            WatchScoreView(score: assessment.overallScore, level: assessment.level.rawValue)
            WatchSuggestionView(text: assessment.suggestions.first ?? "Check your iPhone for more context.")
        }
        .padding()
    }
}

#Preview {
    WatchDashboardView(assessment: .mock)
}
