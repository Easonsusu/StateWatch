import Foundation

struct BaselineCalculator {
    func calculate(from snapshots: [DailyHealthSnapshot]) -> HealthBaseline {
        guard !snapshots.isEmpty else { return .mock }
        // TODO: Implement rolling-window baseline logic.
        return .mock
    }
}
