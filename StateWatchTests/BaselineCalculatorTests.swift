import XCTest
@testable import StateWatchApp

final class BaselineCalculatorTests: XCTestCase {
    func testEmptySnapshotsReturnEmptyBaseline() {
        let baseline = BaselineCalculator().calculate(from: [])

        XCTAssertEqual(baseline.sampleCount, 0)
        XCTAssertNil(baseline.restingHeartRateAverage)
    }

    func testMockSnapshotsProduceBaselineAverages() {
        let baseline = BaselineCalculator().calculate(from: DailyHealthSnapshot.mockWeek)

        XCTAssertEqual(baseline.sampleCount, DailyHealthSnapshot.mockWeek.count)
        XCTAssertNotNil(baseline.sleepDurationAverage)
    }

    // TODO: Add sparse data, outlier, and rolling-window tests after the Xcode project exists.
}
