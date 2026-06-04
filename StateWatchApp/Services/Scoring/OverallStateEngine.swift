import Foundation

struct OverallStateEngine {
    func score(recovery: Int, sleep: Int, stressFatigue: Int, activityLoad: Int) -> Int {
        let raw = (recovery + sleep + stressFatigue + activityLoad) / 4
        return max(0, min(100, raw))
    }
}
