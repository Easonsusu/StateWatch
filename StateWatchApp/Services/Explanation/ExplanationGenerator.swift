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
            .map {
                String.localizedStringWithFormat(
                    String(localized: "%@: %@"),
                    $0.title,
                    $0.summary
                )
            }

        if !baseline.hasEnoughHistory {
            output.append(String(localized: "Baseline history is still building, so today's reflection is lower confidence."))
        }

        if snapshot.checkIn != nil {
            output.append(String(localized: "Your check-in adds subjective context to today's wellness signals."))
        }

        return output
    }

}
