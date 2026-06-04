import SwiftUI

struct WatchDashboardView: View {
    let assessment: StateAssessment

    init(assessment: StateAssessment = .mock) {
        self.assessment = assessment
    }

    var body: some View {
        VStack(spacing: 8) {
            WatchScoreView(score: assessment.overallScore, level: assessment.level.rawValue)
            WatchSuggestionView(text: assessment.primarySuggestion)
        }
        .padding()
        // TODO: Replace mock assessment with locally synced iPhone assessment after watch connectivity is planned.
    }
}

#Preview("Mock Today") {
    WatchDashboardView()
}

#Preview("Lower Energy Mock") {
    WatchDashboardView(assessment: .mockLow)
}
