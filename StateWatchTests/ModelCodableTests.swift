import XCTest
@testable import StateWatchApp

final class ModelCodableTests: XCTestCase {
    func testDailyHealthSnapshotSupportsOptionalHealthDataAndCodableRoundTrip() throws {
        let snapshot = DailyHealthSnapshot.mockPartial

        XCTAssertNil(snapshot.restingHeartRate)
        XCTAssertNil(snapshot.heartRateVariability)
        XCTAssertEqual(snapshot.availableMetrics, [.sleepDuration, .steps])

        let data = try JSONEncoder().encode(snapshot)
        let decoded = try JSONDecoder().decode(DailyHealthSnapshot.self, from: data)

        XCTAssertEqual(decoded, snapshot)
    }

    func testStateAssessmentCodableRoundTripUsesMockData() throws {
        let assessment = StateAssessment.mock

        XCTAssertEqual(assessment.components.count, 4)
        XCTAssertFalse(assessment.primarySuggestion.isEmpty)

        let data = try JSONEncoder().encode(assessment)
        let decoded = try JSONDecoder().decode(StateAssessment.self, from: data)

        XCTAssertEqual(decoded, assessment)
    }

    func testUserCheckInCodableRoundTripPreservesOptionalNoteContext() throws {
        let checkIn = UserCheckIn.mock

        XCTAssertTrue(checkIn.hasNote)

        let data = try JSONEncoder().encode(checkIn)
        let decoded = try JSONDecoder().decode(UserCheckIn.self, from: data)

        XCTAssertEqual(decoded, checkIn)
    }

    // TODO: Move these into a real XCTest target after the Xcode project is created.
}
