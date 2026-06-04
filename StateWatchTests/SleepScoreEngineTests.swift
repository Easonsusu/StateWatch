import XCTest
@testable import StateWatchApp

final class SleepScoreEngineTests: XCTestCase {
    func testMissingSleepDataReturnsConservativePlaceholderScore() {
        let snapshot = DailyHealthSnapshot(date: .now)
        let component = SleepScoreEngine().score(snapshot: snapshot, baseline: .empty)

        XCTAssertEqual(component.title, "Sleep")
        XCTAssertEqual(component.score, 50)
    }

    func testSleepSummaryAvoidsMedicalClaim() {
        let component = SleepScoreEngine().score(snapshot: .mockToday, baseline: .mock)

        XCTAssertFalse(component.summary.localizedCaseInsensitiveContains("diagnosis"))
    }

    // TODO: Add duration and consistency scenario tests after target setup.
}
