import SwiftUI

struct DashboardView: View {
    let assessment: StateAssessment

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ScoreRingView(score: assessment.overallScore, title: assessment.level.rawValue)

                    VStack(spacing: 12) {
                        componentRow(assessment.recovery)
                        componentRow(assessment.sleep)
                        componentRow(assessment.stressFatigue)
                        componentRow(assessment.activityLoad)
                    }

                    ForEach(assessment.reasons, id: \.self) { reason in
                        ReasonCardView(reason: reason)
                    }

                    TodaySuggestionView(suggestions: assessment.suggestions)
                }
                .padding()
            }
            .navigationTitle("Today")
        }
    }

    private func componentRow(_ component: ScoreComponent) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(component.title).font(.headline)
                Text(component.summary).font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
            Text("\(component.score)")
                .font(.headline.monospacedDigit())
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    DashboardView(assessment: .mock)
}
