import Foundation

struct DailyHealthSnapshot: Codable {
    let date: Date
    let restingHeartRate: Double?
    let heartRateVariability: Double?
    let sleepHours: Double?
    let activeEnergy: Double?
    let steps: Int?

    static let mock = DailyHealthSnapshot(
        date: Date(),
        restingHeartRate: 58,
        heartRateVariability: 42,
        sleepHours: 7.4,
        activeEnergy: 520,
        steps: 8400
    )
}
