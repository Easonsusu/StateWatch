import Foundation
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

    func testScoreColorCategoryBoundaryValues() {
        let cases: [(score: Int?, category: StateWatchTheme.ScoreColorCategory)] = [
            (nil, .unavailable),
            (-1, .low),
            (0, .low),
            (39, .low),
            (40, .caution),
            (59, .caution),
            (60, .medium),
            (79, .medium),
            (80, .high),
            (100, .high),
            (101, .high)
        ]

        for testCase in cases {
            XCTAssertEqual(
                StateWatchTheme.scoreColorCategory(for: testCase.score),
                testCase.category,
                "Unexpected category for \(String(describing: testCase.score))"
            )
        }
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

    func testMiniTrendNormalizationIgnoresNonFiniteValues() {
        XCTAssertEqual(
            StateWatchMiniTrendChart.normalizedValues([10, Double.nan, Double.infinity, 20, -Double.infinity, 30]),
            [0, 0.5, 1]
        )
    }

    func testMiniTrendNormalizationReturnsEmptyWhenOnlyNonFiniteValuesExist() {
        XCTAssertEqual(StateWatchMiniTrendChart.normalizedValues([Double.nan, Double.infinity, -Double.infinity]), [])
    }

    func testMiniTrendNormalizationKeepsMixedValuesBetweenZeroAndOne() {
        let normalized = StateWatchMiniTrendChart.normalizedValues([-20, 0, 40, 100])

        XCTAssertEqual(normalized.count, 4)
        XCTAssertTrue(normalized.allSatisfy { $0 >= 0 && $0 <= 1 })
        XCTAssertEqual(normalized.first, 0)
        XCTAssertEqual(normalized.last, 1)
    }
}

final class DashboardDisplayModelTests: XCTestCase {
    func testDashboardDisplayModelUsesMockAssessmentValues() {
        let model = DashboardDisplayModel(assessment: .mock)

        XCTAssertEqual(model.score, 76)
        XCTAssertEqual(model.stateLabel, "Mixed")
        XCTAssertEqual(model.confidence, .medium)
        XCTAssertEqual(model.trendCaption, "Mock data")
        XCTAssertEqual(model.trendValues, [62, 67, 64, 72, 70, 76, 74])
    }

    func testDashboardDisplayModelMapsExpectedMetricCards() {
        let model = DashboardDisplayModel(assessment: .mock)

        XCTAssertEqual(model.metrics.count, 4)
        XCTAssertEqual(model.metrics.map(\.title), ["Recovery", "Sleep", "Fatigue Context", "Activity Load"])
        XCTAssertEqual(model.metrics.map(\.value), ["78", "82", "68", "74"])
        XCTAssertEqual(model.metrics.map(\.progress), [0.78, 0.82, 0.68, 0.74])
    }

    func testDashboardDisplayModelPreservesReasonsAndSuggestion() {
        let assessment = StateAssessment.mock
        let model = DashboardDisplayModel(assessment: assessment)

        XCTAssertEqual(model.reasons, assessment.reasons)
        XCTAssertEqual(model.suggestion, assessment.primarySuggestion)
        XCTAssertFalse(model.reasons.isEmpty)
        XCTAssertFalse(model.suggestion.isEmpty)
    }

    func testDashboardDisplayModelDisclosesMockDataSource() {
        let model = DashboardDisplayModel(assessment: .mock)

        XCTAssertTrue(model.updatedText.localizedCaseInsensitiveContains("Demo data"))
        XCTAssertEqual(model.trendCaption, "Mock data")
        XCTAssertTrue(model.searchableText.localizedCaseInsensitiveContains("Mock data"))
    }

    func testDashboardDisplayModelDoesNotImplyHealthKitDerivedProductionData() {
        let model = DashboardDisplayModel(assessment: .mock)
        let searchableText = model.searchableText

        for forbiddenSourceClaim in [
            "HealthKit",
            "Apple Health",
            "live data",
            "real data",
            "fetched",
            "synced"
        ] {
            XCTAssertFalse(
                searchableText.localizedCaseInsensitiveContains(forbiddenSourceClaim),
                "Unexpected production dashboard data-source wording: \(forbiddenSourceClaim)"
            )
        }
    }

    func testLowDataDashboardDisplayModelStaysMockBacked() {
        let model = DashboardDisplayModel(assessment: .mockLow)

        XCTAssertEqual(model.metrics.count, 4)
        XCTAssertEqual(model.trendValues, [62, 67, 64, 72, 70, 76, 74])
        XCTAssertEqual(model.trendCaption, "Mock data")
        XCTAssertTrue(model.updatedText.localizedCaseInsensitiveContains("Demo data"))
    }

    func testDashboardDisplayModelUsesCalmNonMedicalCopy() {
        let model = DashboardDisplayModel(assessment: .mockLow)
        let searchableText = model.searchableText

        for forbiddenTerm in [
            "diagnos",
            "disease",
            "illness",
            "clinical stress",
            "detect",
            "treatment",
            "prevention",
            "health risk",
            "warning"
        ] {
            XCTAssertFalse(
                searchableText.localizedCaseInsensitiveContains(forbiddenTerm),
                "Unexpected dashboard wording: \(forbiddenTerm)"
            )
        }
    }
}

final class MockDashboardSharedStatePublisherTests: XCTestCase {
    func testMockDashboardSummaryMapsCurrentDashboardAssessment() {
        let generatedAt = Date(timeIntervalSince1970: 12_000)
        let summary = MockDashboardSharedStatePublisher.summary(
            from: .mock,
            generatedAt: generatedAt
        )

        XCTAssertEqual(summary.schemaVersion, SharedReadinessSummary.currentSchemaVersion)
        XCTAssertEqual(summary.score, 76)
        XCTAssertEqual(summary.stateLabel, "Mixed")
        XCTAssertEqual(summary.confidence, "Medium")
        XCTAssertEqual(summary.shortSuggestion, StateAssessment.mock.primarySuggestion)
        XCTAssertEqual(summary.updatedText, "Demo")
        XCTAssertEqual(summary.generatedAt, generatedAt)
        XCTAssertEqual(summary.source, "iphone-mock-dashboard")
        XCTAssertTrue(summary.isMock)
    }

    func testMockDashboardPublisherSavesDashboardSummaryToSharedStore() throws {
        let suiteName = "statewatch.dashboard.publisher.tests.\(UUID().uuidString)"
        let userDefaults = UserDefaults(suiteName: suiteName)!
        userDefaults.removePersistentDomain(forName: suiteName)
        defer {
            userDefaults.removePersistentDomain(forName: suiteName)
        }
        let store = SharedReadinessStore(userDefaults: userDefaults)
        let publisher = MockDashboardSharedStatePublisher(
            userDefaults: userDefaults,
            generatedAt: { Date(timeIntervalSince1970: 12_300) }
        )

        XCTAssertTrue(publisher.publish(assessment: .mock))
        let summary = try XCTUnwrap(store.load())

        XCTAssertEqual(summary.score, 76)
        XCTAssertEqual(summary.stateLabel, "Mixed")
        XCTAssertEqual(summary.confidence, "Medium")
        XCTAssertEqual(summary.updatedText, "Demo")
        XCTAssertEqual(summary.source, "iphone-mock-dashboard")
        XCTAssertTrue(summary.isMock)
    }

    func testMockDashboardPublisherDoesNotCrashWhenSharedStoreIsUnavailable() {
        let publisher = MockDashboardSharedStatePublisher(
            userDefaults: nil,
            generatedAt: { Date(timeIntervalSince1970: 12_600) }
        )

        XCTAssertFalse(publisher.publish(assessment: .mock))
    }

    func testMockDashboardPublisherSourceDoesNotIntroduceForbiddenBehavior() throws {
        let publisherSource = try ThemeTestRepositoryFiles.contents(
            at: "StateWatchApp/App/MockDashboardSharedStatePublisher.swift"
        )
        let appSource = try ThemeTestRepositoryFiles.contents(at: "StateWatchApp/App/StateWatchApp.swift")
        let searchedSource = [publisherSource, appSource].joined(separator: "\n")

        for forbiddenTerm in [
            "import HealthKit",
            "HealthKitDataFetcher",
            "fetchRecentSnapshots",
            "requestAuthorization",
            "WatchConnectivity",
            "WCSession",
            "URLSession",
            "http://",
            "https://",
            "NSHealthUpdateUsageDescription"
        ] {
            XCTAssertFalse(
                searchedSource.localizedCaseInsensitiveContains(forbiddenTerm),
                "Unexpected mock dashboard shared-state source reference: \(forbiddenTerm)"
            )
        }
    }
}

final class WatchDashboardDisplayModelTests: XCTestCase {
    func testWatchDisplayModelUsesMockAssessmentValues() {
        let model = WatchDashboardDisplayModel(assessment: .mock)

        XCTAssertEqual(model.score, 76)
        XCTAssertEqual(model.stateLabel, "Mixed")
        XCTAssertEqual(model.confidenceText, "Medium")
        XCTAssertEqual(model.updatedText, "Demo data")
        XCTAssertEqual(model.dataSourceText, "Mock data only")
    }

    func testWatchDisplayModelMapsExpectedMetricSummaries() {
        let model = WatchDashboardDisplayModel(assessment: .mock)

        XCTAssertEqual(model.metrics.count, 4)
        XCTAssertEqual(model.metrics.map(\.title), ["Recovery", "Sleep", "Fatigue Context", "Activity Load"])
        XCTAssertEqual(model.metrics.map(\.score), [68, 81, 64, 75])
    }

    func testWatchDisplayModelUsesCalmSuggestionCopy() {
        let model = WatchDashboardDisplayModel(assessment: .mock)

        XCTAssertEqual(model.suggestion, "Consider a lighter day if that matches how you feel.")
        XCTAssertFalse(model.suggestion.isEmpty)
    }

    func testWatchDisplayModelDisclosesMockDataSource() {
        let model = WatchDashboardDisplayModel(assessment: .mock)

        XCTAssertTrue(model.updatedText.localizedCaseInsensitiveContains("Demo data"))
        XCTAssertTrue(model.dataSourceText.localizedCaseInsensitiveContains("Mock data"))
        XCTAssertTrue(model.searchableText.localizedCaseInsensitiveContains("Demo data"))
        XCTAssertTrue(model.searchableText.localizedCaseInsensitiveContains("Mock data"))
    }

    func testWatchDisplayModelDoesNotImplyLiveHealthKitData() {
        let model = WatchDashboardDisplayModel(assessment: .mock)
        let searchableText = model.searchableText

        for forbiddenSourceClaim in [
            "HealthKit",
            "Apple Health",
            "live data",
            "real data",
            "fetched",
            "synced"
        ] {
            XCTAssertFalse(
                searchableText.localizedCaseInsensitiveContains(forbiddenSourceClaim),
                "Unexpected Watch data-source wording: \(forbiddenSourceClaim)"
            )
        }
    }

    func testWatchDisplayModelUsesCalmNonMedicalCopy() {
        let model = WatchDashboardDisplayModel(assessment: .mock)
        let searchableText = model.searchableText

        for forbiddenTerm in [
            "diagnos",
            "disease",
            "illness",
            "clinical stress",
            "detect",
            "treatment",
            "prevention",
            "health risk",
            "warning"
        ] {
            XCTAssertFalse(
                searchableText.localizedCaseInsensitiveContains(forbiddenTerm),
                "Unexpected Watch wording: \(forbiddenTerm)"
            )
        }
    }
}

final class ComplicationStateSummaryTests: XCTestCase {
    func testMockComplicationSummaryUsesExpectedStaticValues() {
        let summary = ComplicationStateSummary.mock

        XCTAssertEqual(summary.score, 76)
        XCTAssertEqual(summary.stateLabel, "Mixed")
        XCTAssertEqual(summary.confidence, "Medium")
        XCTAssertEqual(summary.shortSuggestion, "Demo data")
        XCTAssertEqual(summary.updatedText, "Demo")
        XCTAssertFalse(summary.isStale)
    }

    func testMockComplicationSummaryProvidesExpectedFamilyText() {
        let summary = ComplicationStateSummary.mock

        XCTAssertEqual(summary.circularLabel, "MIX")
        XCTAssertEqual(summary.rectangularTitle, "State 76 - Mixed")
        XCTAssertEqual(summary.inlineText, "StateWatch 76 Mixed")
    }

    func testMockComplicationSummaryScoreIsDisplaySafe() {
        let summary = ComplicationStateSummary.mock

        XCTAssertTrue((0...100).contains(summary.score))
    }

    func testMockComplicationSummaryDisclosesDemoData() {
        let searchableText = ComplicationStateSummary.mock.searchableText

        XCTAssertTrue(searchableText.localizedCaseInsensitiveContains("Demo"))
        XCTAssertFalse(searchableText.localizedCaseInsensitiveContains("HealthKit"))
        XCTAssertFalse(searchableText.localizedCaseInsensitiveContains("Apple Health"))
        XCTAssertFalse(searchableText.localizedCaseInsensitiveContains("live data"))
        XCTAssertFalse(searchableText.localizedCaseInsensitiveContains("real data"))
    }

    func testMockComplicationSummaryDoesNotImplySharedOrSyncedState() {
        let searchableText = ComplicationStateSummary.mock.searchableText

        for forbiddenSharedStateClaim in [
            "App Group",
            "WatchConnectivity",
            "shared container",
            "shared state",
            "synced",
            "live",
            "fetched"
        ] {
            XCTAssertFalse(
                searchableText.localizedCaseInsensitiveContains(forbiddenSharedStateClaim),
                "Unexpected complication shared-state wording: \(forbiddenSharedStateClaim)"
            )
        }
    }

    func testMockComplicationSummaryUsesCalmNonMedicalCopy() {
        let searchableText = ComplicationStateSummary.mock.searchableText

        for forbiddenTerm in [
            "diagnos",
            "disease",
            "illness",
            "clinical stress",
            "detect",
            "treatment",
            "prevention",
            "health risk",
            "warning"
        ] {
            XCTAssertFalse(
                searchableText.localizedCaseInsensitiveContains(forbiddenTerm),
                "Unexpected complication wording: \(forbiddenTerm)"
            )
        }
    }
}

private enum ThemeTestRepositoryFiles {
    static func contents(at relativePath: String) throws -> String {
        try String(contentsOf: rootURL.appendingPathComponent(relativePath), encoding: .utf8)
    }

    private static var rootURL: URL {
        let sourceURL = URL(fileURLWithPath: #filePath)
        let candidateRoot = sourceURL.deletingLastPathComponent().deletingLastPathComponent()

        if FileManager.default.fileExists(atPath: candidateRoot.appendingPathComponent("README.md").path) {
            return candidateRoot
        }

        return URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    }
}
