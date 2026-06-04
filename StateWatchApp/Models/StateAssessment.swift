import Foundation

struct StateAssessment: Codable {
    let date: Date
    let overallScore: Int
    let recoveryScore: Int
    let sleepScore: Int
    let stressFatigueScore: Int
    let activityLoadScore: Int
    let reasons: [String]
    let suggestion: String

    static let mock = StateAssessment(
        date: Date(),
        overallScore: 76,
        recoveryScore: 78,
        sleepScore: 74,
        stressFatigueScore: 72,
        activityLoadScore: 80,
        reasons: [
            "Sleep duration was close to your typical range.",
            "Recovery markers look slightly better than baseline."
        ],
        suggestion: "Consider a moderate training day with normal hydration."
    )
}
