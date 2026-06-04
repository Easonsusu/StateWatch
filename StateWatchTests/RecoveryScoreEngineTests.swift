import XCTest
@testable import StateWatchApp

final class RecoveryScoreEngineTests: XCTestCase {
    func testRecoveryScoreStaysWithinBounds() {
        let component = RecoveryScoreEngine().score(snapshot: .mockToday, baseline: .mock)

        XCTAssertGreaterThanOrEqual(component.score, 0)
        XCTAssertLessThanOrEqual(component.score, 100)
    }

    func testRecoverySummaryUsesWellnessWording() {
        let component = RecoveryScoreEngine().score(snapshot: .mockToday, baseline: .mock)

        XCTAssertFalse(component.summary.localizedCaseInsensitiveContains("diagnos"))
        XCTAssertFalse(component.summary.localizedCaseInsensitiveContains("disease"))
    }

    // TODO: Add red/green tests for HRV and resting-heart-rate changes once targets compile.
}
