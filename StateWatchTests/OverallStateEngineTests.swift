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

    func testOverallScoreCombinesComponentsWithWeights() {
        let score = OverallStateEngine.weightedOverallScore(
            recovery: 80,
            sleep: 60,
            stressFatigue: 70,
            activityLoad: 50
        )

        XCTAssertEqual(score, 68)
    }

    func testAssessmentFromHistoryUsesLatestSnapshotAndBaseline() throws {
        let history = (1...10).map { day in
            DailyHealthSnapshot(
                date: date(day: day),
                restingHeartRate: day == 10 ? 66 : 58,
                heartRateVariability: day == 10 ? 48 : 62,
                sleepDurationHours: day == 10 ? 6.0 : 7.4,
                activeEnergyKcal: 520,
                exerciseMinutes: 35,
                stepCount: 8_000
            )
        }

        let assessment = try XCTUnwrap(OverallStateEngine().assess(history: history, window: .sevenDays))

        XCTAssertEqual(assessment.date, date(day: 10))
        XCTAssertLessThan(assessment.recovery.score, 75)
        XCTAssertLessThan(assessment.sleep.score, 75)
        XCTAssertEqual(assessment.confidence, .high)
    }

    func testSparseHistoryProducesLowConfidenceAssessment() throws {
        let history = [
            DailyHealthSnapshot(date: date(day: 1), sleepDurationHours: 6.5)
        ]

        let assessment = try XCTUnwrap(OverallStateEngine().assess(history: history, window: .sevenDays))

        XCTAssertEqual(assessment.confidence, .low)
        XCTAssertTrue(assessment.reasons.contains { $0.localizedCaseInsensitiveContains("lower confidence") })
    }

    func testAllNilHistoryStaysCautiousAndDoesNotUseMedicalWording() throws {
        let history = (1...4).map { day in
            DailyHealthSnapshot(date: date(day: day))
        }

        let assessment = try XCTUnwrap(OverallStateEngine().assess(history: history, window: .sevenDays))
        let userFacingText = (
            assessment.reasons
                + assessment.suggestions
                + assessment.components.map(\.summary)
                + [assessment.level.rawValue]
        ).joined(separator: " ")

        XCTAssertEqual(assessment.confidence, .unavailable)
        XCTAssertTrue(assessment.components.allSatisfy { $0.confidence == .unavailable })
        XCTAssertGreaterThanOrEqual(assessment.overallScore, 0)
        XCTAssertLessThanOrEqual(assessment.overallScore, 100)
        XCTAssertTrue(assessment.reasons.contains { $0.localizedCaseInsensitiveContains("lower confidence") })
        for forbiddenTerm in ["diagnos", "disease", "illness", "clinical stress", "detect"] {
            XCTAssertFalse(
                userFacingText.localizedCaseInsensitiveContains(forbiddenTerm),
                "Unexpected medical-style wording: \(forbiddenTerm)"
            )
        }
    }

    private func date(day: Int) -> Date {
        let components = DateComponents(timeZone: TimeZone(secondsFromGMT: 0), year: 2026, month: 1, day: day)
        return Calendar(identifier: .gregorian).date(from: components) ?? Date(timeIntervalSince1970: 0)
    }
}
