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

    func testSleepBelowBaselineLowersSleepScore() {
        let baseline = HealthBaseline(
            window: .sevenDays,
            restingHeartRate: .unavailable,
            averageHeartRate: .unavailable,
            heartRateVariability: .unavailable,
            sleepDuration: .available(average: 7.5, validSampleCount: 7),
            activeEnergy: .unavailable,
            exerciseMinutes: .unavailable,
            stepCount: .unavailable,
            sampleCount: 7
        )
        let steady = DailyHealthSnapshot(date: .now, sleepDurationHours: 7.4)
        let shorter = DailyHealthSnapshot(date: .now, sleepDurationHours: 5.8)

        let steadyScore = SleepScoreEngine().score(snapshot: steady, baseline: baseline).score
        let shorterScore = SleepScoreEngine().score(snapshot: shorter, baseline: baseline).score

        XCTAssertLessThan(shorterScore, steadyScore)
    }

    func testMissingSleepDataReturnsUnavailableConfidence() {
        let component = SleepScoreEngine().score(snapshot: DailyHealthSnapshot(date: .now), baseline: .empty)

        XCTAssertEqual(component.confidence, .unavailable)
        XCTAssertGreaterThanOrEqual(component.score, 0)
        XCTAssertLessThanOrEqual(component.score, 100)
    }
}
