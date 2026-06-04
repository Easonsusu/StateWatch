import Foundation

struct ExplanationGenerator {
    func reasons(
        snapshot: DailyHealthSnapshot,
        baseline: HealthBaseline,
        components: [ScoreComponent]
    ) -> [String] {
        var output = components
            .sorted { $0.score < $1.score }
            .prefix(2)
            .map { "\($0.title): \($0.summary)" }

        if !baseline.hasEnoughHistory {
            output.append("Baseline history is still building, so today's reflection is lower confidence.")
        }

        if snapshot.checkIn != nil {
            output.append("Your check-in adds subjective context to today's wellness signals.")
        }

        return output
    }

    // TODO: Add localization and a blocked-word review for medical claims.
}
