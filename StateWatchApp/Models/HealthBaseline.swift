import Foundation

struct HealthBaseline: Equatable {
    let restingHeartRateAverage: Double?
    let heartRateVariabilityAverage: Double?
    let sleepDurationAverage: Double?
    let activeEnergyAverage: Double?
    let sampleCount: Int

    var hasEnoughHistory: Bool {
        sampleCount >= 7
    }
}

extension HealthBaseline {
    static let mock = HealthBaseline(
        restingHeartRateAverage: 60,
        heartRateVariabilityAverage: 58,
        sleepDurationAverage: 7.2,
        activeEnergyAverage: 500,
        sampleCount: 14
    )

    static let empty = HealthBaseline(
        restingHeartRateAverage: nil,
        heartRateVariabilityAverage: nil,
        sleepDurationAverage: nil,
        activeEnergyAverage: nil,
        sampleCount: 0
    )
}
