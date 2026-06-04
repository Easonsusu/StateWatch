import Foundation

struct HealthBaseline: Codable, Equatable {
    let restingHeartRateAverage: Double?
    let heartRateVariabilityAverage: Double?
    let sleepDurationAverage: Double?
    let activeEnergyAverage: Double?
    let sampleCount: Int

    var hasEnoughHistory: Bool {
        sampleCount >= 7
    }

    var isEmpty: Bool {
        sampleCount == 0
            && restingHeartRateAverage == nil
            && heartRateVariabilityAverage == nil
            && sleepDurationAverage == nil
            && activeEnergyAverage == nil
    }

    // TODO: Replace this simple history threshold with confidence scoring after local HealthKit storage exists.
}

extension HealthBaseline {
    static let mock = MockSampleData.baseline

    static let empty = HealthBaseline(
        restingHeartRateAverage: nil,
        heartRateVariabilityAverage: nil,
        sleepDurationAverage: nil,
        activeEnergyAverage: nil,
        sampleCount: 0
    )
}
