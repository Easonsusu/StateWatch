import Foundation

struct RecoveryScoreEngine {
    func score(snapshot: DailyHealthSnapshot, baseline: HealthBaseline) -> Int {
        // TODO: Implement recovery scoring based on HRV and resting HR trends.
        return StateAssessment.mock.recoveryScore
    }
}
