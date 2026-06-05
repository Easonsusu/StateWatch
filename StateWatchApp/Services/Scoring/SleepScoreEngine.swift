import Foundation

struct SleepScoreEngine {
    func score(snapshot: DailyHealthSnapshot, baseline: HealthBaseline) -> ScoreComponent {
        guard let sleep = snapshot.sleepDurationHours else {
            return ScoreComponent(title: "Sleep", score: 50, summary: "Sleep data is unavailable for today.")
        }

        var score = 70
        if sleep >= 7 { score += 12 }
        if let baselineSleep = baseline.sleepDurationAverage, sleep < baselineSleep - 1 { score -= 10 }

        return ScoreComponent(
            title: "Sleep",
            score: clamp(score),
            summary: "Sleep score reflects duration and recent consistency as wellness context."
        )
    }

    private func clamp(_ value: Int) -> Int {
        min(100, max(0, value))
    }

    // TODO: Add sleep-stage handling only after validating HealthKit data availability.
}
