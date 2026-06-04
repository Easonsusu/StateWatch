import Foundation

struct BaselineCalculator {
    func calculate(from snapshots: [DailyHealthSnapshot]) -> HealthBaseline {
        guard !snapshots.isEmpty else { return .empty }

        return HealthBaseline(
            restingHeartRateAverage: average(snapshots.compactMap(\.restingHeartRate)),
            heartRateVariabilityAverage: average(snapshots.compactMap(\.heartRateVariability)),
            sleepDurationAverage: average(snapshots.compactMap(\.sleepDurationHours)),
            activeEnergyAverage: average(snapshots.compactMap(\.activeEnergyKcal)),
            sampleCount: snapshots.count
        )
    }

    private func average(_ values: [Double]) -> Double? {
        guard !values.isEmpty else { return nil }
        return values.reduce(0, +) / Double(values.count)
    }

    // TODO: Add rolling windows, missing-data confidence, and outlier handling.
}
