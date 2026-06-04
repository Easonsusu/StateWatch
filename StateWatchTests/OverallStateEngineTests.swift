import XCTest
@testable import StateWatchApp

final class OverallStateEngineTests: XCTestCase {
    func testAssessmentCombinesFourComponents() {
        let assessment = OverallStateEngine().assess(snapshot: .mockToday, baseline: .mock)

        XCTAssertEqual(assessment.recovery.title, "Recovery")
        XCTAssertEqual(assessment.sleep.title, "Sleep")
        XCTAssertEqual(assessment.stressFatigue.title, "Stress/Fatigue")
        XCTAssertEqual(assessment.activityLoad.title, "Activity Load")
    }

    func testAssessmentProducesReasonsAndSuggestions() {
        let assessment = OverallStateEngine().assess(snapshot: .mockToday, baseline: .mock)

        XCTAssertFalse(assessment.reasons.isEmpty)
        XCTAssertFalse(assessment.suggestions.isEmpty)
    }

    // TODO: Add missing-data confidence and wording tests once the app target compiles.
}
