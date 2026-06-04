import Foundation

struct StressFatigueScoreEngine {
    func score(snapshot: DailyHealthSnapshot, baseline: HealthBaseline) -> ScoreComponent {
        var score = 72

        if snapshot.checkIn?.fatigue == .high { score -= 12 }
        if snapshot.checkIn?.perceivedStress == .high { score -= 10 }

        if let hrv = snapshot.heartRateVariability,
           let baselineHRV = baseline.heartRateVariabilityAverage,
           hrv < baselineHRV * 0.85 {
            score -= 8
        }

        return ScoreComponent(
            title: "Stress/Fatigue",
            score: clamp(score),
            summary: "Stress and fatigue context combines wearable signals with your check-in."
        )
    }

    private func clamp(_ value: Int) -> Int {
        min(100, max(0, value))
    }

    // TODO: Keep this wellness-only; never present this as stress diagnosis.
}
