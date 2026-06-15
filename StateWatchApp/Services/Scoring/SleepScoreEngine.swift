import Foundation

struct SleepScoreEngine {
    func score(
        snapshot: DailyHealthSnapshot,
        baseline: HealthBaseline,
        recentSnapshots: [DailyHealthSnapshot] = []
    ) -> ScoreComponent {
        guard let sleep = snapshot.sleepDurationHours else {
            return ScoreComponent(
                title: "Sleep",
                score: 50,
                confidence: .unavailable,
                summary: "Sleep data is unavailable for today."
            )
        }

        guard let baselineSleep = baseline.sleepDurationAverage else {
            return ScoreComponent(
                title: "Sleep",
                score: 60,
                confidence: .low,
                summary: "Sleep duration is available, but baseline history is still building."
            )
        }

        var score = 70
        let difference = sleep - baselineSleep
        if difference < -1.5 {
            score -= 18
        } else if difference < -0.75 {
            score -= 10
        } else if difference > 0.5 {
            score += 6
        }

        let recentSleepValues = recentSnapshots.suffix(7).compactMap(\.sleepDurationHours)
        if !recentSleepValues.isEmpty {
            let recentAverage = recentSleepValues.reduce(0, +) / Double(recentSleepValues.count)
            if recentAverage < baselineSleep - 0.5 {
                score -= 6
            }

            let sleepDebt = recentSleepValues
                .map { max(0, baselineSleep - $0) }
                .reduce(0, +)

            if sleepDebt > 4 {
                score -= 8
            } else if sleepDebt > 2 {
                score -= 4
            }
        }

        let confidence = baseline.confidence(for: .sleepDuration)
        let summary: String
        switch confidence {
        case .high, .medium:
            summary = "Sleep reflects duration, recent trend, and estimated sleep debt compared with your baseline."
        case .low:
            summary = "Sleep uses limited baseline history, so this remains a softer wellness estimate."
        case .unavailable:
            summary = "Sleep baseline history is unavailable, so this score stays cautious."
        }

        return ScoreComponent(
            title: "Sleep",
            score: clamp(score),
            confidence: confidence,
            summary: summary
        )
    }

    private func clamp(_ value: Int) -> Int {
        min(100, max(0, value))
    }

    // TODO: Add sleep-stage handling only after validating HealthKit data availability.
}
