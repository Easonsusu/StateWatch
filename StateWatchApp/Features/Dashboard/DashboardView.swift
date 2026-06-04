import SwiftUI

struct DashboardView: View {
    let assessment: StateAssessment

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ScoreRingView(score: assessment.overallScore)
                ReasonCardView(reasons: assessment.reasons)
                TodaySuggestionView(suggestion: assessment.suggestion)
            }
            .padding()
        }
        .navigationTitle("Today")
    }
}

#Preview {
    DashboardView(assessment: .mock)
}
