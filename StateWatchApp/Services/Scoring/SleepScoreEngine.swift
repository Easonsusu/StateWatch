import Foundation

struct SleepScoreEngine {
    func score(snapshot: DailyHealthSnapshot, baseline: HealthBaseline) -> Int {
        // TODO: Implement sleep score from duration and consistency.
        return StateAssessment.mock.sleepScore
    }
}
