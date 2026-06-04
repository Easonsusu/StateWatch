import Foundation

struct RecoveryScoreEngine {
    func score(snapshot: DailyHealthSnapshot, baseline: HealthBaseline) -> ScoreComponent {
        var score = 75

        if let hrv = snapshot.heartRateVariability,
           let baselineHRV = baseline.heartRateVariabilityAverage,
           hrv < baselineHRV * 0.9 {
            score -= 8
        }

        if let rhr = snapshot.restingHeartRate,
           let baselineRHR = baseline.restingHeartRateAverage,
           rhr > baselineRHR * 1.08 {
            score -= 8
        }

        return ScoreComponent(
            title: "Recovery",
            score: clamp(score),
            summary: "Recovery signals are based on personal baseline comparisons."
        )
    }

    private func clamp(_ value: Int) -> Int {
        min(100, max(0, value))
    }

    // TODO: Replace placeholder scoring after validating baseline rules with mock scenarios.
}
