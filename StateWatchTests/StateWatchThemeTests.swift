import XCTest
@testable import StateWatchApp

final class StateWatchThemeTests: XCTestCase {
    func testScoreClampingBelowZeroReturnsZero() {
        XCTAssertEqual(StateWatchTheme.clampedScore(-12), 0)
    }

    func testScoreClampingAboveOneHundredReturnsOneHundred() {
        XCTAssertEqual(StateWatchTheme.clampedScore(132), 100)
    }

    func testScoreColorCategoryCoversHighScore() {
        XCTAssertEqual(StateWatchTheme.scoreColorCategory(for: 92), .high)
    }

    func testScoreColorCategoryCoversMediumScore() {
        XCTAssertEqual(StateWatchTheme.scoreColorCategory(for: 76), .medium)
    }

    func testScoreColorCategoryCoversCautionScore() {
        XCTAssertEqual(StateWatchTheme.scoreColorCategory(for: 52), .caution)
    }

    func testScoreColorCategoryCoversLowScore() {
        XCTAssertEqual(StateWatchTheme.scoreColorCategory(for: 28), .low)
    }

    func testScoreColorCategoryCoversUnavailableScore() {
        XCTAssertEqual(StateWatchTheme.scoreColorCategory(for: nil), .unavailable)
    }

    func testConfidenceLabelMapping() {
        XCTAssertEqual(StateWatchTheme.confidenceLabel(for: .high), "High")
        XCTAssertEqual(StateWatchTheme.confidenceLabel(for: .medium), "Medium")
        XCTAssertEqual(StateWatchTheme.confidenceLabel(for: .low), "Low data")
        XCTAssertEqual(StateWatchTheme.confidenceLabel(for: .unavailable), "Unavailable")
    }

    func testMiniTrendNormalizationHandlesEmptyValues() {
        XCTAssertEqual(StateWatchMiniTrendChart.normalizedValues([]), [])
    }

    func testMiniTrendNormalizationScalesValues() {
        XCTAssertEqual(StateWatchMiniTrendChart.normalizedValues([10, 20, 30]), [0, 0.5, 1])
    }

    func testMiniTrendNormalizationUsesMidpointForFlatValues() {
        XCTAssertEqual(StateWatchMiniTrendChart.normalizedValues([42, 42, 42]), [0.5, 0.5, 0.5])
    }
}
