import SwiftUI

struct DashboardView: View {
    let assessment: StateAssessment

    init(assessment: StateAssessment = .mock) {
        self.assessment = assessment
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ScoreRingView(score: assessment.overallScore, title: assessment.level.rawValue)
                        .padding(.vertical, 12)

                    ForEach(assessment.components) { component in
                        componentRow(component)
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
        // TODO: Inject a real assessment once local HealthKit snapshots and scoring are wired together.
    }

    private func componentRow(_ component: ScoreComponent) -> some View {
        HStack(alignment: .center, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(component.title)
                    .font(.headline)
                Text(component.summary)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer(minLength: 8)
            Text("\(component.score)")
                .font(.headline.monospacedDigit())
                .foregroundStyle(.primary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview("Mock Today") {
    DashboardView()
}

#Preview("Lower Energy Mock") {
    DashboardView(assessment: .mockLow)
}
