import XCTest
@testable import StateWatchApp

final class BaselineCalculatorTests: XCTestCase {
    func testEmptySnapshotsReturnEmptyBaseline() {
        let baseline = BaselineCalculator().calculate(from: [])

        XCTAssertEqual(baseline.sampleCount, 0)
        XCTAssertNil(baseline.restingHeartRateAverage)
        XCTAssertEqual(baseline.confidence(for: .restingHeartRate), .unavailable)
    }

    func testMockSnapshotsProduceBaselineAverages() {
        let baseline = BaselineCalculator().calculate(from: DailyHealthSnapshot.mockWeek)

        XCTAssertEqual(baseline.sampleCount, DailyHealthSnapshot.mockWeek.count)
        XCTAssertNotNil(baseline.sleepDurationAverage)
    }

    func testBaselineIgnoresNilValuesAndCalculatesMetricAverages() {
        let snapshots = [
            snapshot(day: 1, restingHeartRate: 60, averageHeartRate: 74, hrv: 50, sleep: 7, energy: 500, exercise: 30, steps: 8_000),
            snapshot(day: 2, restingHeartRate: nil, averageHeartRate: 76, hrv: 55, sleep: nil, energy: 600, exercise: nil, steps: 9_000),
            snapshot(day: 3, restingHeartRate: 66, averageHeartRate: nil, hrv: 60, sleep: 8, energy: nil, exercise: 45, steps: nil),
            snapshot(day: 4, restingHeartRate: 63, averageHeartRate: 80, hrv: nil, sleep: 7.5, energy: 700, exercise: 60, steps: 10_000)
        ]

        let baseline = BaselineCalculator().calculate(from: snapshots, window: .sevenDays)

        XCTAssertEqual(baseline.restingHeartRateAverage ?? 0, 63, accuracy: 0.001)
        XCTAssertEqual(baseline.averageHeartRateAverage ?? 0, 76.667, accuracy: 0.001)
        XCTAssertEqual(baseline.heartRateVariabilityAverage ?? 0, 55, accuracy: 0.001)
        XCTAssertEqual(baseline.sleepDurationAverage ?? 0, 7.5, accuracy: 0.001)
        XCTAssertEqual(baseline.activeEnergyAverage ?? 0, 600, accuracy: 0.001)
        XCTAssertEqual(baseline.exerciseMinutesAverage ?? 0, 45, accuracy: 0.001)
        XCTAssertEqual(baseline.stepCountAverage ?? 0, 9_000, accuracy: 0.001)
        XCTAssertEqual(baseline.validSampleCount(for: .restingHeartRate), 3)
    }

    func testBaselineRequiresMinimumValidSamplesBeforeExposingAverage() {
        let snapshots = [
            snapshot(day: 1, sleep: 7),
            snapshot(day: 2, sleep: nil),
            snapshot(day: 3, sleep: 8)
        ]

        let baseline = BaselineCalculator().calculate(from: snapshots, window: .sevenDays)

        XCTAssertNil(baseline.sleepDurationAverage)
        XCTAssertEqual(baseline.validSampleCount(for: .sleepDuration), 2)
        XCTAssertEqual(baseline.confidence(for: .sleepDuration), .low)
    }

    func testBaselineSupportsSevenFourteenAndThirtyDayWindows() {
        let snapshots = (1...30).map { day in
            snapshot(day: day, restingHeartRate: Double(50 + day))
        }
        let calculator = BaselineCalculator()

        let sevenDayBaseline = calculator.calculate(from: snapshots, window: .sevenDays)
        let fourteenDayBaseline = calculator.calculate(from: snapshots, window: .fourteenDays)
        let thirtyDayBaseline = calculator.calculate(from: snapshots, window: .thirtyDays)

        XCTAssertEqual(sevenDayBaseline.window, .sevenDays)
        XCTAssertEqual(fourteenDayBaseline.window, .fourteenDays)
        XCTAssertEqual(thirtyDayBaseline.window, .thirtyDays)
        XCTAssertEqual(sevenDayBaseline.sampleCount, 7)
        XCTAssertEqual(fourteenDayBaseline.sampleCount, 14)
        XCTAssertEqual(thirtyDayBaseline.sampleCount, 30)
        XCTAssertEqual(sevenDayBaseline.restingHeartRateAverage ?? 0, 77, accuracy: 0.001)
        XCTAssertEqual(fourteenDayBaseline.restingHeartRateAverage ?? 0, 73.5, accuracy: 0.001)
        XCTAssertEqual(thirtyDayBaseline.restingHeartRateAverage ?? 0, 65.5, accuracy: 0.001)
    }

    func testLowDataHistoryProducesLowConfidence() {
        let baseline = BaselineCalculator().calculate(from: [snapshot(day: 1, heartRateVariability: 55)], window: .sevenDays)

        XCTAssertEqual(baseline.confidence(for: .heartRateVariability), .low)
        XCTAssertEqual(baseline.overallConfidence, .low)
        XCTAssertFalse(baseline.hasEnoughHistory)
    }

    private func snapshot(
        day: Int,
        restingHeartRate: Double? = nil,
        averageHeartRate: Double? = nil,
        heartRateVariability hrv: Double? = nil,
        hrv explicitHRV: Double? = nil,
        sleep: Double? = nil,
        energy: Double? = nil,
        exercise: Double? = nil,
        steps: Double? = nil
    ) -> DailyHealthSnapshot {
        DailyHealthSnapshot(
            date: date(day: day),
            restingHeartRate: restingHeartRate,
            averageHeartRate: averageHeartRate,
            heartRateVariability: hrv ?? explicitHRV,
            sleepDurationHours: sleep,
            activeEnergyKcal: energy,
            exerciseMinutes: exercise,
            stepCount: steps
        )
    }

    private func date(day: Int) -> Date {
        let components = DateComponents(timeZone: TimeZone(secondsFromGMT: 0), year: 2026, month: 1, day: day)
        return Calendar(identifier: .gregorian).date(from: components) ?? Date(timeIntervalSince1970: 0)
    }
}
