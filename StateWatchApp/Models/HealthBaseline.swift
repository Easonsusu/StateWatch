import Foundation

struct HealthBaseline: Codable {
    let restingHeartRate: Double?
    let heartRateVariability: Double?
    let sleepHours: Double?
    let activeEnergy: Double?

    static let mock = HealthBaseline(
        restingHeartRate: 60,
        heartRateVariability: 40,
        sleepHours: 7.0,
        activeEnergy: 500
    )
}
