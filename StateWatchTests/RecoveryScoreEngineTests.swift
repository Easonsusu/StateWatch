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

    func testHRVBelowBaselineLowersRecoveryScore() {
        let baseline = baseline(hrv: 70, restingHeartRate: 58)
        let steady = snapshot(hrv: 70, restingHeartRate: 58)
        let lowerHRV = snapshot(hrv: 52, restingHeartRate: 58)

        let steadyScore = RecoveryScoreEngine().score(snapshot: steady, baseline: baseline).score
        let lowerScore = RecoveryScoreEngine().score(snapshot: lowerHRV, baseline: baseline).score

        XCTAssertLessThan(lowerScore, steadyScore)
    }

    func testRestingHeartRateAboveBaselineLowersRecoveryScore() {
        let baseline = baseline(hrv: 60, restingHeartRate: 55)
        let steady = snapshot(hrv: 60, restingHeartRate: 55)
        let elevatedRHR = snapshot(hrv: 60, restingHeartRate: 64)

        let steadyScore = RecoveryScoreEngine().score(snapshot: steady, baseline: baseline).score
        let elevatedScore = RecoveryScoreEngine().score(snapshot: elevatedRHR, baseline: baseline).score

        XCTAssertLessThan(elevatedScore, steadyScore)
    }

    func testRecoveryScoreHandlesMissingDataWithLowConfidence() {
        let component = RecoveryScoreEngine().score(snapshot: DailyHealthSnapshot(date: .now), baseline: .empty)

        XCTAssertEqual(component.confidence, .unavailable)
        XCTAssertGreaterThanOrEqual(component.score, 0)
        XCTAssertLessThanOrEqual(component.score, 100)
    }

    private func baseline(hrv: Double, restingHeartRate: Double) -> HealthBaseline {
        HealthBaseline(
            window: .sevenDays,
            restingHeartRate: .available(average: restingHeartRate, validSampleCount: 7),
            averageHeartRate: .unavailable,
            heartRateVariability: .available(average: hrv, validSampleCount: 7),
            sleepDuration: .unavailable,
            activeEnergy: .unavailable,
            exerciseMinutes: .unavailable,
            stepCount: .unavailable,
            sampleCount: 7
        )
    }

    private func snapshot(hrv: Double, restingHeartRate: Double) -> DailyHealthSnapshot {
        DailyHealthSnapshot(date: .now, restingHeartRate: restingHeartRate, heartRateVariability: hrv)
    }
}
