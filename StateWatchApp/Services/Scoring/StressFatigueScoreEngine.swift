import Foundation

struct StressFatigueScoreEngine {
    func score(snapshot: DailyHealthSnapshot, checkIn: UserCheckIn?) -> Int {
        // TODO: Combine physiological proxies and optional check-in context.
        return StateAssessment.mock.stressFatigueScore
    }
}
