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

    func testMockDashboardSummaryIsClearlyMockOnly() {
        let summary = MockDashboardSharedStatePublisher.summary(
            from: .mock,
            generatedAt: Date(timeIntervalSince1970: 12_100)
        )

        XCTAssertTrue(summary.searchableText.localizedCaseInsensitiveContains("mock"))
        XCTAssertFalse(summary.source.localizedCaseInsensitiveContains("HealthKit"))
        XCTAssertFalse(summary.source.localizedCaseInsensitiveContains("Apple Health"))

        for forbiddenClaim in [
            "HealthKit-derived",
            "Apple Health",
            "live data",
            "real data",
            "synced",
            "diagnos",
            "disease",
            "clinical stress",
            "treatment",
            "warning",
            "alert",
            "emergency",
            "upload",
            "network",
            "AI"
        ] {
            XCTAssertFalse(
                summary.searchableText.localizedCaseInsensitiveContains(forbiddenClaim),
                "Unexpected mock dashboard shared-state wording: \(forbiddenClaim)"
            )
        }
    }

    func testMockDashboardPublisherSavesDashboardSummaryToSharedStore() throws {
        let suiteName = "statewatch.dashboard.publisher.tests.\(UUID().uuidString)"
        let userDefaults = try XCTUnwrap(UserDefaults(suiteName: suiteName))
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

    func testMockDashboardPublisherUsesStableSharedStateBoundary() {
        XCTAssertEqual(SharedReadinessStore.appGroupIdentifier, "group.com.easonsusu.StateWatch")
        XCTAssertEqual(SharedReadinessStore.storageKey, "statewatch.shared.readiness.summary.v1")
        XCTAssertEqual(MockDashboardSharedStatePublisher.source, "iphone-mock-dashboard")
    }

    func testRepeatedMockDashboardPublishingSafelyOverwritesSameMockSummary() throws {
        let suiteName = "statewatch.dashboard.publisher.repeat.tests.\(UUID().uuidString)"
        let userDefaults = try XCTUnwrap(UserDefaults(suiteName: suiteName))
        userDefaults.removePersistentDomain(forName: suiteName)
        defer {
            userDefaults.removePersistentDomain(forName: suiteName)
        }
        let store = SharedReadinessStore(userDefaults: userDefaults)
        let firstPublisher = MockDashboardSharedStatePublisher(
            userDefaults: userDefaults,
            generatedAt: { Date(timeIntervalSince1970: 12_400) }
        )
        let secondPublisher = MockDashboardSharedStatePublisher(
            userDefaults: userDefaults,
            generatedAt: { Date(timeIntervalSince1970: 12_500) }
        )

        XCTAssertTrue(firstPublisher.publish(assessment: .mock))
        XCTAssertTrue(secondPublisher.publish(assessment: .mock))
        let summary = try XCTUnwrap(store.load())

        XCTAssertEqual(summary.score, 76)
        XCTAssertEqual(summary.stateLabel, "Mixed")
        XCTAssertEqual(summary.confidence, "Medium")
        XCTAssertEqual(summary.updatedText, "Demo")
        XCTAssertEqual(summary.generatedAt, Date(timeIntervalSince1970: 12_500))
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

    func testFailedMockDashboardPublishingDoesNotAlterDashboardDisplayModel() {
        let publisher = MockDashboardSharedStatePublisher(
            userDefaults: nil,
            generatedAt: { Date(timeIntervalSince1970: 12_700) }
        )
        let before = DashboardDisplayModel(assessment: .mock)

        XCTAssertFalse(publisher.publish(assessment: .mock))
        let after = DashboardDisplayModel(assessment: .mock)

        XCTAssertEqual(after.score, before.score)
        XCTAssertEqual(after.stateLabel, before.stateLabel)
        XCTAssertEqual(after.confidence, before.confidence)
        XCTAssertEqual(after.updatedText, before.updatedText)
        XCTAssertEqual(after.trendCaption, before.trendCaption)
        XCTAssertEqual(after.trendValues, before.trendValues)
    }
}

final class WatchDashboardDisplayModelTests: XCTestCase {
    func testWatchDisplayModelUsesMockAssessmentValues() {
        let model = WatchDashboardDisplayModel(assessment: .mock)

        XCTAssertEqual(model.score, 76)
        XCTAssertEqual(model.stateLabel, "Mixed")
        XCTAssertEqual(model.confidenceText, "Medium")
        XCTAssertEqual(model.updatedText, "Demo")
        XCTAssertEqual(model.dataSourceText, "Mock data only")
        XCTAssertEqual(model.source, "static-watch-mock")
        XCTAssertTrue(model.isMock)
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

        XCTAssertTrue(model.updatedText.localizedCaseInsensitiveContains("Demo"))
        XCTAssertTrue(model.dataSourceText.localizedCaseInsensitiveContains("Mock data"))
        XCTAssertTrue(model.searchableText.localizedCaseInsensitiveContains("Demo"))
        XCTAssertTrue(model.searchableText.localizedCaseInsensitiveContains("Mock data"))
    }

    func testWatchDisplayModelMapsIphonePublishedSharedMockSummary() {
        let sharedSummary = MockDashboardSharedStatePublisher.summary(
            from: .mock,
            generatedAt: Date(timeIntervalSince1970: 14_000)
        )
        let model = WatchDashboardDisplayModel(sharedSummary: sharedSummary)

        XCTAssertEqual(model.score, 76)
        XCTAssertEqual(model.stateLabel, "Mixed")
        XCTAssertEqual(model.confidenceText, "Medium")
        XCTAssertEqual(model.updatedText, "Demo")
        XCTAssertEqual(model.suggestion, StateAssessment.mock.primarySuggestion)
        XCTAssertEqual(model.dataSourceText, "Mock data only")
        XCTAssertEqual(model.source, "iphone-mock-dashboard")
        XCTAssertTrue(model.isMock)
    }

    func testWatchDisplayModelLoadsSharedMockSummaryWhenAvailable() throws {
        let suiteName = "statewatch.watch.shared.tests.\(UUID().uuidString)"
        let userDefaults = try XCTUnwrap(UserDefaults(suiteName: suiteName))
        userDefaults.removePersistentDomain(forName: suiteName)
        defer {
            userDefaults.removePersistentDomain(forName: suiteName)
        }
        let publisher = MockDashboardSharedStatePublisher(
            userDefaults: userDefaults,
            generatedAt: { Date(timeIntervalSince1970: 14_400) }
        )

        XCTAssertTrue(publisher.publish(assessment: .mock))
        let model = WatchDashboardDisplayModel.sharedMockOrStaticFallback(
            userDefaults: userDefaults,
            now: Date(timeIntervalSince1970: 14_430),
            maxAge: 60
        )

        XCTAssertEqual(model.score, 76)
        XCTAssertEqual(model.stateLabel, "Mixed")
        XCTAssertEqual(model.confidenceText, "Medium")
        XCTAssertEqual(model.updatedText, "Demo")
        XCTAssertEqual(model.source, "iphone-mock-dashboard")
        XCTAssertTrue(model.isMock)
    }

    func testWatchDisplayModelFallsBackSafelyWhenSharedStateIsMissingCorruptedStaleOrUnavailable() throws {
        let missingSuite = "statewatch.watch.missing.tests.\(UUID().uuidString)"
        let missingDefaults = try XCTUnwrap(UserDefaults(suiteName: missingSuite))
        missingDefaults.removePersistentDomain(forName: missingSuite)
        defer {
            missingDefaults.removePersistentDomain(forName: missingSuite)
        }

        let corruptedSuite = "statewatch.watch.corrupt.tests.\(UUID().uuidString)"
        let corruptedDefaults = try XCTUnwrap(UserDefaults(suiteName: corruptedSuite))
        corruptedDefaults.removePersistentDomain(forName: corruptedSuite)
        defer {
            corruptedDefaults.removePersistentDomain(forName: corruptedSuite)
        }
        corruptedDefaults.set(Data("not-json".utf8), forKey: SharedReadinessStore.storageKey)

        let staleSuite = "statewatch.watch.stale.tests.\(UUID().uuidString)"
        let staleDefaults = try XCTUnwrap(UserDefaults(suiteName: staleSuite))
        staleDefaults.removePersistentDomain(forName: staleSuite)
        defer {
            staleDefaults.removePersistentDomain(forName: staleSuite)
        }
        let stalePublisher = MockDashboardSharedStatePublisher(
            userDefaults: staleDefaults,
            generatedAt: { Date(timeIntervalSince1970: 14_700) }
        )
        XCTAssertTrue(stalePublisher.publish(assessment: .mock))

        let fallbackModels = [
            WatchDashboardDisplayModel.sharedMockOrStaticFallback(userDefaults: nil),
            WatchDashboardDisplayModel.sharedMockOrStaticFallback(userDefaults: missingDefaults),
            WatchDashboardDisplayModel.sharedMockOrStaticFallback(userDefaults: corruptedDefaults),
            WatchDashboardDisplayModel.sharedMockOrStaticFallback(
                userDefaults: staleDefaults,
                now: Date(timeIntervalSince1970: 15_000),
                maxAge: 60
            )
        ]

        for model in fallbackModels {
            XCTAssertEqual(model.score, 76)
            XCTAssertEqual(model.stateLabel, "Mixed")
            XCTAssertEqual(model.confidenceText, "Medium")
            XCTAssertEqual(model.updatedText, "Demo")
            XCTAssertEqual(model.dataSourceText, "Mock data only")
            XCTAssertEqual(model.source, "static-watch-mock")
            XCTAssertTrue(model.isMock)
        }
    }

    func testWatchDisplayModelFallsBackWhenSharedSummaryIsNotMock() throws {
        let suiteName = "statewatch.watch.nonmock.tests.\(UUID().uuidString)"
        let userDefaults = try XCTUnwrap(UserDefaults(suiteName: suiteName))
        userDefaults.removePersistentDomain(forName: suiteName)
        defer {
            userDefaults.removePersistentDomain(forName: suiteName)
        }
        let sharedSummary = SharedReadinessSummary(
            schemaVersion: SharedReadinessSummary.currentSchemaVersion,
            score: 88,
            stateLabel: "Steady",
            confidence: "High",
            shortSuggestion: "Demo data",
            updatedText: "Demo",
            generatedAt: Date(timeIntervalSince1970: 15_200),
            source: "unexpected-production-source",
            isMock: false
        )
        let encodedSummary = try JSONEncoder.stateWatchSharedState.encode(sharedSummary)
        userDefaults.set(encodedSummary, forKey: SharedReadinessStore.storageKey)
        let model = WatchDashboardDisplayModel.sharedMockOrStaticFallback(
            userDefaults: userDefaults,
            now: Date(timeIntervalSince1970: 15_230),
            maxAge: 60
        )

        XCTAssertEqual(model.score, 76)
        XCTAssertEqual(model.stateLabel, "Mixed")
        XCTAssertEqual(model.confidenceText, "Medium")
        XCTAssertEqual(model.source, "static-watch-mock")
        XCTAssertTrue(model.isMock)
    }

    func testWatchSharedStateStringsAvoidForbiddenClaims() {
        let sharedSummary = MockDashboardSharedStatePublisher.summary(
            from: .mock,
            generatedAt: Date(timeIntervalSince1970: 15_400)
        )
        let searchableText = [
            WatchDashboardDisplayModel(sharedSummary: sharedSummary).searchableText,
            WatchDashboardDisplayModel(assessment: .mock).searchableText
        ].joined(separator: " ")

        for forbiddenTerm in [
            "HealthKit",
            "Apple Health",
            "diagnos",
            "disease",
            "clinical stress",
            "treatment",
            "warning",
            "alert",
            "emergency",
            "upload",
            "network",
            "AI",
            "write access",
            "live data",
            "real data",
            "WatchConnectivity"
        ] {
            XCTAssertFalse(
                searchableText.localizedCaseInsensitiveContains(forbiddenTerm),
                "Unexpected Watch shared-state wording: \(forbiddenTerm)"
            )
        }
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
