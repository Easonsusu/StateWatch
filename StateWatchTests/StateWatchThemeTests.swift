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


final class WatchSharedMockStateQATests: XCTestCase {
    func testSharedSummaryInitializerPreservesWatchMockValuesAndSource() {
        let sharedSummary = MockDashboardSharedStatePublisher.summary(
            from: .mock,
            generatedAt: Date(timeIntervalSince1970: 16_000)
        )
        let model = WatchDashboardDisplayModel(sharedSummary: sharedSummary)

        XCTAssertEqual(sharedSummary.score, 76)
        XCTAssertEqual(sharedSummary.stateLabel, "Mixed")
        XCTAssertEqual(sharedSummary.confidence, "Medium")
        XCTAssertEqual(sharedSummary.updatedText, "Demo")
        XCTAssertEqual(sharedSummary.source, "iphone-mock-dashboard")
        XCTAssertTrue(sharedSummary.isMock)
        assertIphonePublishedMockModel(model)
    }

    func testSummaryBasedFallbacksStayStaticAndSafe() {
        let staleSummary = MockDashboardSharedStatePublisher.summary(
            from: .mock,
            generatedAt: Date(timeIntervalSince1970: 16_200)
        )

        let fallbackModels = [
            WatchDashboardDisplayModel.sharedMockOrStaticFallback(summary: nil),
            WatchDashboardDisplayModel.sharedMockOrStaticFallback(
                summary: staleSummary,
                now: Date(timeIntervalSince1970: 16_500),
                maxAge: 60
            )
        ]

        for model in fallbackModels {
            assertStaticWatchFallbackModel(model)
        }
    }

    func testStoreBasedFallbacksStayStaticAndSafeForMissingCorruptedAndUnavailableState() throws {
        let missingStore = try makeUserDefaults(label: "missing")
        defer {
            missingStore.userDefaults.removePersistentDomain(forName: missingStore.suiteName)
        }

        let corruptedStore = try makeUserDefaults(label: "corrupted")
        defer {
            corruptedStore.userDefaults.removePersistentDomain(forName: corruptedStore.suiteName)
        }
        corruptedStore.userDefaults.set(Data("not-json".utf8), forKey: SharedReadinessStore.storageKey)

        let fallbackModels = [
            WatchDashboardDisplayModel.sharedMockOrStaticFallback(userDefaults: missingStore.userDefaults),
            WatchDashboardDisplayModel.sharedMockOrStaticFallback(userDefaults: corruptedStore.userDefaults),
            WatchDashboardDisplayModel.sharedMockOrStaticFallback(userDefaults: nil)
        ]

        for model in fallbackModels {
            assertStaticWatchFallbackModel(model)
        }
    }

    func testIphonePublishedSummaryMapsConsistentlyToWatchAndWidgetKit() {
        let sharedSummary = MockDashboardSharedStatePublisher.summary(
            from: .mock,
            generatedAt: Date(timeIntervalSince1970: 16_800)
        )
        let watchModel = WatchDashboardDisplayModel(sharedSummary: sharedSummary)
        let complicationSharedSummary = SharedReadinessSummary(
            schemaVersion: SharedReadinessSummary.currentSchemaVersion,
            score: sharedSummary.score,
            stateLabel: sharedSummary.stateLabel,
            confidence: sharedSummary.confidence,
            shortSuggestion: sharedSummary.shortSuggestion,
            updatedText: sharedSummary.updatedText,
            generatedAt: sharedSummary.generatedAt,
            source: sharedSummary.source,
            isMock: sharedSummary.isMock
        )
        let complicationSummary = ComplicationStateSummary(sharedSummary: complicationSharedSummary)

        XCTAssertEqual(watchModel.score, complicationSummary.score)
        XCTAssertEqual(watchModel.stateLabel, complicationSummary.stateLabel)
        XCTAssertEqual(watchModel.confidenceText, complicationSummary.confidence)
        XCTAssertEqual(watchModel.updatedText, complicationSummary.updatedText)
        XCTAssertEqual(watchModel.suggestion, complicationSummary.shortSuggestion)
        XCTAssertEqual(watchModel.source, "iphone-mock-dashboard")
        XCTAssertTrue(watchModel.isMock)
        XCTAssertFalse(complicationSummary.isStale)
    }

    func testSharedStateBoundaryConstantsRemainStableForWatchQA() {
        XCTAssertEqual(SharedReadinessStore.appGroupIdentifier, "group.com.easonsusu.StateWatch")
        XCTAssertEqual(SharedReadinessStore.storageKey, "statewatch.shared.readiness.summary.v1")
        XCTAssertEqual(SharedReadinessSummary.currentSchemaVersion, 1)
    }

    func testWatchSharedStateStringsRemainMockOnlyAndNonMedical() {
        let sharedSummary = MockDashboardSharedStatePublisher.summary(
            from: .mock,
            generatedAt: Date(timeIntervalSince1970: 17_000)
        )
        let complicationSharedSummary = SharedReadinessSummary(
            schemaVersion: SharedReadinessSummary.currentSchemaVersion,
            score: sharedSummary.score,
            stateLabel: sharedSummary.stateLabel,
            confidence: sharedSummary.confidence,
            shortSuggestion: sharedSummary.shortSuggestion,
            updatedText: sharedSummary.updatedText,
            generatedAt: sharedSummary.generatedAt,
            source: sharedSummary.source,
            isMock: sharedSummary.isMock
        )
        let searchableText = [
            sharedSummary.searchableText,
            WatchDashboardDisplayModel(sharedSummary: sharedSummary).searchableText,
            WatchDashboardDisplayModel(assessment: .mock).searchableText,
            ComplicationStateSummary(sharedSummary: complicationSharedSummary).searchableText,
            ComplicationStateSummary.mock.searchableText
        ].joined(separator: " ")

        XCTAssertTrue(searchableText.localizedCaseInsensitiveContains("mock"))
        XCTAssertTrue(searchableText.localizedCaseInsensitiveContains("Demo"))

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
            "cloud upload",
            "networking",
            "AI analysis",
            "live HealthKit",
            "HealthKit-backed",
            "WatchConnectivity",
            "production rollout",
            "write access"
        ] {
            XCTAssertFalse(
                searchableText.localizedCaseInsensitiveContains(forbiddenTerm),
                "Unexpected Watch shared mock-state wording: \(forbiddenTerm)"
            )
        }
    }

    func testWatchAppSourceDoesNotUseDisallowedProductionStateMechanisms() throws {
        let watchFiles = try swiftFiles(in: repositoryRoot().appendingPathComponent("StateWatchWatchApp"))
        XCTAssertFalse(watchFiles.isEmpty)

        for fileURL in watchFiles {
            let source = try String(contentsOf: fileURL, encoding: .utf8)
            for forbiddenSnippet in [
                "import HealthKit",
                "import WatchConnectivity",
                "WCSession",
                "URLSession",
                "requestAuthorization(toShare",
                "NSHealthUpdateUsageDescription",
                "HealthKitDataFetcher",
                "HealthKitManager",
                "fetchRecentSnapshots"
            ] {
                XCTAssertFalse(
                    source.localizedCaseInsensitiveContains(forbiddenSnippet),
                    "Unexpected disallowed Watch app mechanism in \(fileURL.lastPathComponent): \(forbiddenSnippet)"
                )
            }
        }
    }

    private func assertIphonePublishedMockModel(
        _ model: WatchDashboardDisplayModel,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertEqual(model.score, 76, file: file, line: line)
        XCTAssertEqual(model.stateLabel, "Mixed", file: file, line: line)
        XCTAssertEqual(model.confidenceText, "Medium", file: file, line: line)
        XCTAssertEqual(model.updatedText, "Demo", file: file, line: line)
        XCTAssertEqual(model.dataSourceText, "Mock data only", file: file, line: line)
        XCTAssertEqual(model.source, "iphone-mock-dashboard", file: file, line: line)
        XCTAssertTrue(model.isMock, file: file, line: line)
    }

    private func assertStaticWatchFallbackModel(
        _ model: WatchDashboardDisplayModel,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertEqual(model.score, 76, file: file, line: line)
        XCTAssertEqual(model.stateLabel, "Mixed", file: file, line: line)
        XCTAssertEqual(model.confidenceText, "Medium", file: file, line: line)
        XCTAssertEqual(model.updatedText, "Demo", file: file, line: line)
        XCTAssertEqual(model.dataSourceText, "Mock data only", file: file, line: line)
        XCTAssertEqual(model.source, "static-watch-mock", file: file, line: line)
        XCTAssertTrue(model.isMock, file: file, line: line)
        XCTAssertEqual(model.metrics.map(\.title), ["Recovery", "Sleep", "Fatigue Context", "Activity Load"], file: file, line: line)
        XCTAssertEqual(model.metrics.map(\.score), [68, 81, 64, 75], file: file, line: line)
    }

    private func makeUserDefaults(label: String) throws -> (suiteName: String, userDefaults: UserDefaults) {
        let suiteName = "statewatch.watch.phase73.\(label).\(UUID().uuidString)"
        let userDefaults = try XCTUnwrap(UserDefaults(suiteName: suiteName))
        userDefaults.removePersistentDomain(forName: suiteName)
        return (suiteName, userDefaults)
    }

    private func repositoryRoot(filePath: String = #filePath) -> URL {
        URL(fileURLWithPath: filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
    }

    private func swiftFiles(in directory: URL) throws -> [URL] {
        guard let enumerator = FileManager.default.enumerator(
            at: directory,
            includingPropertiesForKeys: [.isRegularFileKey],
            options: [.skipsHiddenFiles]
        ) else {
            return []
        }

        return try enumerator.compactMap { item in
            guard let fileURL = item as? URL, fileURL.pathExtension == "swift" else {
                return nil
            }

            let values = try fileURL.resourceValues(forKeys: [.isRegularFileKey])
            return values.isRegularFile == true ? fileURL : nil
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


final class HealthKitDashboardFeatureFlagTests: XCTestCase {
    func testFeatureFlagDefaultsOffWhenNoLocalValueExists() throws {
        let context = try makeUserDefaults(label: "default-off")
        defer { context.userDefaults.removePersistentDomain(forName: context.suiteName) }
        let flag = HealthKitDashboardFeatureFlag(userDefaults: context.userDefaults)

        XCTAssertFalse(flag.isEnabled)
    }

    func testFeatureFlagCanBeEnabledLocally() throws {
        let context = try makeUserDefaults(label: "enable")
        defer { context.userDefaults.removePersistentDomain(forName: context.suiteName) }
        let flag = HealthKitDashboardFeatureFlag(userDefaults: context.userDefaults)

        flag.setEnabled(true)

        XCTAssertTrue(flag.isEnabled)
    }

    func testFeatureFlagCanBeDisabledLocally() throws {
        let context = try makeUserDefaults(label: "disable")
        defer { context.userDefaults.removePersistentDomain(forName: context.suiteName) }
        let flag = HealthKitDashboardFeatureFlag(userDefaults: context.userDefaults)

        flag.setEnabled(true)
        flag.setEnabled(false)

        XCTAssertFalse(flag.isEnabled)
    }

    func testFeatureFlagResetReturnsToDefaultOff() throws {
        let context = try makeUserDefaults(label: "reset")
        defer { context.userDefaults.removePersistentDomain(forName: context.suiteName) }
        let flag = HealthKitDashboardFeatureFlag(userDefaults: context.userDefaults)

        flag.setEnabled(true)
        flag.reset()

        XCTAssertFalse(flag.isEnabled)
        XCTAssertNil(context.userDefaults.object(forKey: HealthKitDashboardFeatureFlag.storageKey))
    }

    func testFeatureFlagStorageKeyRemainsStable() {
        XCTAssertEqual(HealthKitDashboardFeatureFlag.storageKey, "statewatch.feature.healthkitDashboard.enabled")
    }

    func testDefaultOffStatePreservesMockDashboardSummaryBehavior() throws {
        let context = try makeUserDefaults(label: "mock-dashboard")
        defer { context.userDefaults.removePersistentDomain(forName: context.suiteName) }
        let flag = HealthKitDashboardFeatureFlag(userDefaults: context.userDefaults)
        let summary = MockDashboardSharedStatePublisher.summary(
            from: .mock,
            generatedAt: Date(timeIntervalSince1970: 18_000)
        )

        XCTAssertFalse(flag.isEnabled)
        XCTAssertEqual(summary.score, 76)
        XCTAssertEqual(summary.stateLabel, "Mixed")
        XCTAssertEqual(summary.confidence, "Medium")
        XCTAssertEqual(summary.updatedText, "Demo")
        XCTAssertEqual(summary.source, "iphone-mock-dashboard")
        XCTAssertTrue(summary.isMock)
    }

    func testFeatureFlagSourceDoesNotUseDisallowedRolloutMechanisms() throws {
        let sourceURL = repositoryRoot()
            .appendingPathComponent("StateWatchApp")
            .appendingPathComponent("App")
            .appendingPathComponent("HealthKitDashboardFeatureFlag.swift")
        let source = try String(contentsOf: sourceURL, encoding: .utf8)

        for forbiddenToken in [
            "URLSession",
            "WatchConnectivity",
            "WCSession",
            "remoteConfig",
            "analytics rollout",
            "cloud sync",
            "HealthKit write",
            "HKQuantitySample",
            "diagnosis"
        ] {
            XCTAssertFalse(
                source.localizedCaseInsensitiveContains(forbiddenToken),
                "Unexpected feature flag rollout mechanism: \(forbiddenToken)"
            )
        }
    }

    private func makeUserDefaults(label: String) throws -> (suiteName: String, userDefaults: UserDefaults) {
        let suiteName = "statewatch.featureflag.phase82.\(label).\(UUID().uuidString)"
        let userDefaults = try XCTUnwrap(UserDefaults(suiteName: suiteName))
        userDefaults.removePersistentDomain(forName: suiteName)
        return (suiteName, userDefaults)
    }

    private func repositoryRoot(filePath: String = #filePath) -> URL {
        URL(fileURLWithPath: filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
    }
}


final class HealthKitDashboardAssessmentProviderTests: XCTestCase {
    func testDefaultOffDashboardProviderReturnsMockAssessment() async throws {
        let context = try makeUserDefaults(label: "default-off")
        defer { context.userDefaults.removePersistentDomain(forName: context.suiteName) }
        let flag = HealthKitDashboardFeatureFlag(userDefaults: context.userDefaults)
        let provider = DashboardAssessmentProvider(
            isFeatureEnabled: { flag.isEnabled },
            snapshotLoader: { _ in
                XCTFail("Default-off dashboard should not load HealthKit snapshots")
                return Self.sufficientSnapshotHistory()
            }
        )

        let result = await provider.loadAssessment()

        XCTAssertEqual(result.source, .mock)
        XCTAssertEqual(result.assessment, .mock)
        XCTAssertFalse(result.usesHealthKitDerivedData)
    }

    func testEnabledDashboardProviderRoutesToHealthKitDerivedAssessment() async throws {
        let context = try makeUserDefaults(label: "enabled")
        defer { context.userDefaults.removePersistentDomain(forName: context.suiteName) }
        let flag = HealthKitDashboardFeatureFlag(userDefaults: context.userDefaults)
        flag.enable()
        let provider = DashboardAssessmentProvider(
            isFeatureEnabled: { flag.isEnabled },
            snapshotLoader: { days in
                XCTAssertEqual(days, DashboardAssessmentProvider.lookbackDays)
                return Self.sufficientSnapshotHistory()
            }
        )

        let result = await provider.loadAssessment()

        XCTAssertEqual(result.source, .healthKitDerived)
        XCTAssertTrue(result.usesHealthKitDerivedData)
        XCTAssertTrue((0...100).contains(result.assessment.overallScore))
        XCTAssertNotEqual(result.assessment, StateAssessment.mock)
    }

    func testResettingFeatureFlagReturnsDashboardProviderToMockPath() async throws {
        let context = try makeUserDefaults(label: "reset")
        defer { context.userDefaults.removePersistentDomain(forName: context.suiteName) }
        let flag = HealthKitDashboardFeatureFlag(userDefaults: context.userDefaults)
        flag.enable()
        flag.reset()
        let provider = DashboardAssessmentProvider(
            isFeatureEnabled: { flag.isEnabled },
            snapshotLoader: { _ in
                XCTFail("Reset flag should return to mock path without loading snapshots")
                return Self.sufficientSnapshotHistory()
            }
        )

        let result = await provider.loadAssessment()

        XCTAssertEqual(result.source, .mock)
        XCTAssertEqual(result.assessment, .mock)
        XCTAssertFalse(result.usesHealthKitDerivedData)
    }

    func testDashboardProviderFallsBackSafelyWhenHealthKitIsUnavailableOrEmpty() async throws {
        let context = try makeUserDefaults(label: "empty")
        defer { context.userDefaults.removePersistentDomain(forName: context.suiteName) }
        let flag = HealthKitDashboardFeatureFlag(userDefaults: context.userDefaults)
        flag.enable()
        let provider = DashboardAssessmentProvider(
            isFeatureEnabled: { flag.isEnabled },
            snapshotLoader: { _ in [] }
        )

        let result = await provider.loadAssessment()

        XCTAssertEqual(result.source, .fallback)
        XCTAssertEqual(result.assessment, .mock)
        XCTAssertEqual(result.notice, "HealthKit data was unavailable, so the dashboard is showing mock data.")
        XCTAssertFalse(result.usesHealthKitDerivedData)
    }

    func testDashboardProviderHandlesSparseAllNilHistoryWithoutNegativeConclusion() async throws {
        let context = try makeUserDefaults(label: "sparse")
        defer { context.userDefaults.removePersistentDomain(forName: context.suiteName) }
        let flag = HealthKitDashboardFeatureFlag(userDefaults: context.userDefaults)
        flag.enable()
        let provider = DashboardAssessmentProvider(
            isFeatureEnabled: { flag.isEnabled },
            snapshotLoader: { _ in
                [
                    DailyHealthSnapshot(date: Date(timeIntervalSince1970: 20_000)),
                    DailyHealthSnapshot(date: Date(timeIntervalSince1970: 106_400))
                ]
            }
        )

        let result = await provider.loadAssessment()

        XCTAssertEqual(result.source, .lowDataFallback)
        XCTAssertEqual(result.assessment, .mock)
        XCTAssertEqual(result.notice, "Recent data is limited, so the dashboard is showing mock data.")
        XCTAssertFalse(result.usesHealthKitDerivedData)
    }

    func testDashboardProviderFallsBackSafelyWhenSnapshotLoadingFails() async throws {
        struct LoaderError: Error {}
        let context = try makeUserDefaults(label: "failure")
        defer { context.userDefaults.removePersistentDomain(forName: context.suiteName) }
        let flag = HealthKitDashboardFeatureFlag(userDefaults: context.userDefaults)
        flag.enable()
        let provider = DashboardAssessmentProvider(
            isFeatureEnabled: { flag.isEnabled },
            snapshotLoader: { _ in throw LoaderError() }
        )

        let result = await provider.loadAssessment()

        XCTAssertEqual(result.source, .fallback)
        XCTAssertEqual(result.assessment, .mock)
        XCTAssertFalse(result.usesHealthKitDerivedData)
    }

    func testDashboardProviderStorageKeyRemainsStable() {
        XCTAssertEqual(HealthKitDashboardFeatureFlag.storageKey, "statewatch.feature.healthkitDashboard.enabled")
    }

    func testDashboardProviderResultCopyAvoidsForbiddenClaims() async throws {
        let context = try makeUserDefaults(label: "copy-safety")
        defer { context.userDefaults.removePersistentDomain(forName: context.suiteName) }
        let flag = HealthKitDashboardFeatureFlag(userDefaults: context.userDefaults)
        flag.enable()
        let provider = DashboardAssessmentProvider(
            isFeatureEnabled: { flag.isEnabled },
            snapshotLoader: { _ in [] }
        )

        let result = await provider.loadAssessment()
        let searchableText = [
            result.notice ?? "",
            result.assessment.primarySuggestion,
            result.assessment.reasons.joined(separator: " ")
        ].joined(separator: " ")

        for forbiddenTerm in [
            "diagnos",
            "disease",
            "clinical stress",
            "treatment",
            "warning",
            "alert",
            "emergency",
            "abnormal health",
            "HealthKit write",
            "cloud upload",
            "AI health analysis",
            "live HealthKit-backed Watch",
            "live HealthKit-backed WidgetKit"
        ] {
            XCTAssertFalse(
                searchableText.localizedCaseInsensitiveContains(forbiddenTerm),
                "Unexpected flagged dashboard wording: \(forbiddenTerm)"
            )
        }
    }

    private func makeUserDefaults(label: String) throws -> (suiteName: String, userDefaults: UserDefaults) {
        let suiteName = "statewatch.dashboard.provider.phase83.\(label).\(UUID().uuidString)"
        let userDefaults = try XCTUnwrap(UserDefaults(suiteName: suiteName))
        userDefaults.removePersistentDomain(forName: suiteName)
        return (suiteName, userDefaults)
    }

    private static func sufficientSnapshotHistory() -> [DailyHealthSnapshot] {
        let calendar = Calendar(identifier: .gregorian)
        let start = Date(timeIntervalSince1970: 30_000)

        return (0..<14).compactMap { offset in
            guard let date = calendar.date(byAdding: .day, value: offset, to: start) else {
                return nil
            }

            return DailyHealthSnapshot(
                date: date,
                restingHeartRate: offset == 13 ? 66 : 62,
                averageHeartRate: offset == 13 ? 83 : 78,
                heartRateVariability: offset == 13 ? 48 : 42,
                sleepDurationHours: offset == 13 ? 7.4 : 7.1,
                activeEnergyKcal: offset == 13 ? 510 : 460,
                exerciseMinutes: offset == 13 ? 34 : 28,
                stepCount: offset == 13 ? 8_800 : 7_600
            )
        }
    }
}


final class HealthKitDashboardPhase84QATests: XCTestCase {
    func testDefaultOffProviderKeepsDashboardMockBackedAndDoesNotLoadSnapshots() async {
        let provider = DashboardAssessmentProvider(
            isFeatureEnabled: { false },
            snapshotLoader: { _ in
                XCTFail("Default-off dashboard must not attempt the HealthKit snapshot path")
                return Self.healthKitLikeSnapshotHistory()
            }
        )

        let result = await provider.loadAssessment()
        let model = DashboardDisplayModel(assessment: result.assessment)

        XCTAssertEqual(result.source, .mock)
        XCTAssertFalse(result.usesHealthKitDerivedData)
        XCTAssertNil(result.notice)
        assertMockDashboardModel(model)
    }

    func testEnabledProviderUsesExistingScoringEngineOutputWithoutChangingSharedState() async throws {
        let history = Self.healthKitLikeSnapshotHistory()
        let expectedAssessment = try XCTUnwrap(OverallStateEngine().assess(history: history, window: .thirtyDays))
        let context = try makeUserDefaults(label: "shared-state-isolation")
        defer { context.userDefaults.removePersistentDomain(forName: context.suiteName) }
        let sharedStore = SharedReadinessStore(userDefaults: context.userDefaults)
        let provider = DashboardAssessmentProvider(
            isFeatureEnabled: { true },
            snapshotLoader: { days in
                XCTAssertEqual(days, DashboardAssessmentProvider.lookbackDays)
                return history
            }
        )

        let result = await provider.loadAssessment()

        XCTAssertEqual(result.source, .healthKitDerived)
        XCTAssertTrue(result.usesHealthKitDerivedData)
        XCTAssertNil(result.notice)
        XCTAssertTrue((0...100).contains(result.assessment.overallScore))
        XCTAssertNotEqual(result.assessment.confidence, .low)
        XCTAssertNotEqual(result.assessment.confidence, .unavailable)
        XCTAssertEqual(result.assessment.overallScore, expectedAssessment.overallScore)
        XCTAssertEqual(result.assessment.recovery, expectedAssessment.recovery)
        XCTAssertEqual(result.assessment.sleep, expectedAssessment.sleep)
        XCTAssertEqual(result.assessment.stressFatigue, expectedAssessment.stressFatigue)
        XCTAssertEqual(result.assessment.activityLoad, expectedAssessment.activityLoad)
        XCTAssertNil(sharedStore.load(), "HealthKit-derived Dashboard output must not be written to App Group shared state in Phase 8.4")
    }

    func testUnavailableUnauthorizedEmptySparseAndLowConfidenceInputsFallBackSafely() async {
        struct AuthorizationMissing: Error {}
        struct ScoringUnavailable: Error {}

        let cases: [(label: String, loader: DashboardAssessmentProvider.SnapshotLoader)] = [
            ("unavailable", { _ in throw ScoringUnavailable() }),
            ("authorization-missing", { _ in throw AuthorizationMissing() }),
            ("empty", { _ in [] }),
            ("all-nil", { _ in Self.allNilSnapshotHistory() }),
            ("partial-low-confidence", { _ in Self.partialLowConfidenceHistory() })
        ]

        for testCase in cases {
            let provider = DashboardAssessmentProvider(
                isFeatureEnabled: { true },
                snapshotLoader: testCase.loader
            )

            let result = await provider.loadAssessment()
            let searchableText = [
                result.notice ?? "",
                result.assessment.level.rawValue,
                result.assessment.primarySuggestion,
                result.assessment.reasons.joined(separator: " ")
            ].joined(separator: " ")

            XCTAssertNotEqual(result.source, .healthKitDerived, "Unexpected HealthKit-derived source for \(testCase.label)")
            XCTAssertEqual(result.assessment, .mock, "Fallback should preserve the safe mock Dashboard for \(testCase.label)")
            XCTAssertFalse(result.usesHealthKitDerivedData)
            XCTAssertTrue((0...100).contains(result.assessment.overallScore))
            XCTAssertEqual(result.assessment.level, .mixed, "Missing data should not create a negative wellness conclusion for \(testCase.label)")
            assertNoForbiddenHealthWording(in: searchableText, context: testCase.label)
        }
    }

    func testWatchWidgetKitAndAppGroupRemainMockOnlyWhenDashboardUsesHealthKitPath() async throws {
        let context = try makeUserDefaults(label: "surface-isolation")
        defer { context.userDefaults.removePersistentDomain(forName: context.suiteName) }
        let sharedStore = SharedReadinessStore(userDefaults: context.userDefaults)
        let provider = DashboardAssessmentProvider(
            isFeatureEnabled: { true },
            snapshotLoader: { _ in Self.healthKitLikeSnapshotHistory() }
        )

        let result = await provider.loadAssessment()
        let watchModel = WatchDashboardDisplayModel.sharedMockOrStaticFallback(
            userDefaults: context.userDefaults,
            now: Date(timeIntervalSince1970: 91_000)
        )
        let complicationSummary = ComplicationStateSummary.mock

        XCTAssertEqual(result.source, .healthKitDerived)
        XCTAssertNil(sharedStore.load())
        XCTAssertEqual(watchModel.score, 76)
        XCTAssertEqual(watchModel.stateLabel, "Mixed")
        XCTAssertEqual(watchModel.confidenceText, "Medium")
        XCTAssertEqual(watchModel.updatedText, "Demo")
        XCTAssertEqual(watchModel.source, "static-watch-mock")
        XCTAssertTrue(watchModel.isMock)
        XCTAssertEqual(complicationSummary.score, 76)
        XCTAssertEqual(complicationSummary.stateLabel, "Mixed")
        XCTAssertEqual(complicationSummary.confidence, "Medium")
        XCTAssertEqual(complicationSummary.updatedText, "Demo")
    }

    func testPhase84ProductionSurfaceSourcesDoNotIntroduceDisallowedMechanisms() throws {
        let repositoryRoot = repositoryRoot()
        let filesToScan = [
            repositoryRoot.appendingPathComponent("StateWatchApp/Features/Dashboard/DashboardView.swift"),
            repositoryRoot.appendingPathComponent("StateWatchApp/App/HealthKitDashboardFeatureFlag.swift"),
            repositoryRoot.appendingPathComponent("StateWatchWatchApp/Features/WatchDashboardView.swift"),
            repositoryRoot.appendingPathComponent("StateWatchComplications/StateWatchComplicationProvider.swift"),
            repositoryRoot.appendingPathComponent("StateWatchComplications/ComplicationStateSummary.swift"),
            repositoryRoot.appendingPathComponent("StateWatchShared/SharedReadinessStore.swift"),
            repositoryRoot.appendingPathComponent("StateWatchShared/SharedReadinessSummary.swift")
        ]

        let disallowedTokensByPath: [(fileURL: URL, tokens: [String])] = filesToScan.map { fileURL in
            if fileURL.path.contains("StateWatchComplications") || fileURL.path.contains("StateWatchWatchApp") {
                return (
                    fileURL,
                    [
                        "import HealthKit",
                        "HealthKitDataFetcher",
                        "fetchRecentSnapshots",
                        "HKHealthStore",
                        "HKQuantitySample",
                        "requestAuthorization(toShare",
                        "URLSession",
                        "WatchConnectivity",
                        "WCSession",
                        "remoteConfig",
                        "cloud sync"
                    ]
                )
            }

            return (
                fileURL,
                [
                    "HKHealthStore.save",
                    "HKQuantitySample(",
                    "requestAuthorization(toShare",
                    "NSHealthUpdateUsageDescription",
                    "URLSession",
                    "WatchConnectivity",
                    "WCSession",
                    "remoteConfig",
                    "cloud sync",
                    "developer upload",
                    "backend upload"
                ]
            )
        }

        for (fileURL, disallowedTokens) in disallowedTokensByPath {
            let source = try String(contentsOf: fileURL, encoding: .utf8)
            for token in disallowedTokens {
                XCTAssertFalse(
                    source.localizedCaseInsensitiveContains(token),
                    "Unexpected disallowed Phase 8.4 mechanism in \(fileURL.lastPathComponent): \(token)"
                )
            }
        }
    }

    func testFeatureFlaggedDashboardStringsAvoidMedicalAndRolloutOverclaims() async {
        let providers = [
            DashboardAssessmentProvider(isFeatureEnabled: { false }),
            DashboardAssessmentProvider(isFeatureEnabled: { true }, snapshotLoader: { _ in [] }),
            DashboardAssessmentProvider(isFeatureEnabled: { true }, snapshotLoader: { _ in Self.healthKitLikeSnapshotHistory() })
        ]

        for provider in providers {
            let result = await provider.loadAssessment()
            let model = DashboardDisplayModel(assessment: result.assessment)
            let searchableText = [
                result.notice ?? "",
                model.searchableText,
                result.assessment.primarySuggestion,
                result.assessment.reasons.joined(separator: " ")
            ].joined(separator: " ")

            assertNoForbiddenHealthWording(in: searchableText, context: "\(result.source)")
            for forbiddenRolloutClaim in [
                "live HealthKit-backed Watch",
                "live HealthKit-backed WidgetKit",
                "AI health analysis",
                "medical recommendation",
                "mental health diagnosis",
                "abnormal health alert"
            ] {
                XCTAssertFalse(
                    searchableText.localizedCaseInsensitiveContains(forbiddenRolloutClaim),
                    "Unexpected rollout wording in \(result.source): \(forbiddenRolloutClaim)"
                )
            }
        }
    }

    private func assertMockDashboardModel(
        _ model: DashboardDisplayModel,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertEqual(model.score, 76, file: file, line: line)
        XCTAssertEqual(model.stateLabel, "Mixed", file: file, line: line)
        XCTAssertEqual(model.confidence, .medium, file: file, line: line)
        XCTAssertTrue(model.updatedText.localizedCaseInsensitiveContains("Demo data"), file: file, line: line)
        XCTAssertEqual(model.trendCaption, "Mock data", file: file, line: line)
    }

    private func assertNoForbiddenHealthWording(
        in searchableText: String,
        context: String,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        for forbiddenTerm in [
            "diagnos",
            "disease",
            "clinical stress",
            "treatment",
            "warning",
            "alert",
            "emergency",
            "health risk",
            "medical advice"
        ] {
            XCTAssertFalse(
                searchableText.localizedCaseInsensitiveContains(forbiddenTerm),
                "Unexpected health wording in \(context): \(forbiddenTerm)",
                file: file,
                line: line
            )
        }
    }

    private func makeUserDefaults(label: String) throws -> (suiteName: String, userDefaults: UserDefaults) {
        let suiteName = "statewatch.dashboard.phase84.\(label).\(UUID().uuidString)"
        let userDefaults = try XCTUnwrap(UserDefaults(suiteName: suiteName))
        userDefaults.removePersistentDomain(forName: suiteName)
        return (suiteName, userDefaults)
    }

    private static func healthKitLikeSnapshotHistory() -> [DailyHealthSnapshot] {
        let calendar = Calendar(identifier: .gregorian)
        let start = Date(timeIntervalSince1970: 80_000)

        return (0..<14).compactMap { offset in
            guard let date = calendar.date(byAdding: .day, value: offset, to: start) else {
                return nil
            }

            return DailyHealthSnapshot(
                date: date,
                restingHeartRate: offset == 13 ? 64 : 63,
                averageHeartRate: offset == 13 ? 79 : 78,
                heartRateVariability: offset == 13 ? 46 : 44,
                sleepDurationHours: offset == 13 ? 7.3 : 7.1,
                activeEnergyKcal: offset == 13 ? 495 : 470,
                exerciseMinutes: offset == 13 ? 31 : 28,
                stepCount: offset == 13 ? 8_500 : 7_900
            )
        }
    }

    private static func allNilSnapshotHistory() -> [DailyHealthSnapshot] {
        [
            DailyHealthSnapshot(date: Date(timeIntervalSince1970: 82_000)),
            DailyHealthSnapshot(date: Date(timeIntervalSince1970: 168_400))
        ]
    }

    private static func partialLowConfidenceHistory() -> [DailyHealthSnapshot] {
        [
            DailyHealthSnapshot(date: Date(timeIntervalSince1970: 84_000), stepCount: 4_000),
            DailyHealthSnapshot(date: Date(timeIntervalSince1970: 170_400), stepCount: 4_200)
        ]
    }

    private func repositoryRoot(filePath: String = #filePath) -> URL {
        URL(fileURLWithPath: filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
    }
}


final class HealthKitDashboardLowDataSafetyTests: XCTestCase {
    func testMissingAuthorizationFallsBackWithoutNegativeHealthStatus() async {
        struct MissingAuthorization: Error {}
        let provider = DashboardAssessmentProvider(
            isFeatureEnabled: { true },
            snapshotLoader: { _ in throw MissingAuthorization() }
        )

        let result = await provider.loadAssessment()

        assertSafeFallback(result, context: "missing authorization")
    }

    func testEmptyMetricSpecificSnapshotHistoriesRemainSafe() async {
        let cases: [(label: String, history: [DailyHealthSnapshot])] = [
            ("empty sleep data", Self.historyWithoutSleep()),
            ("empty HRV data", Self.historyWithoutHRV()),
            ("empty resting heart rate data", Self.historyWithoutRestingHeartRate()),
            ("empty activity load data", Self.historyWithoutActivityLoad()),
            ("fully empty snapshots", Self.emptyMetricHistory())
        ]

        for testCase in cases {
            let provider = DashboardAssessmentProvider(
                isFeatureEnabled: { true },
                snapshotLoader: { _ in testCase.history }
            )

            let result = await provider.loadAssessment()

            assertSafeResult(result, context: testCase.label)
            if result.source != .healthKitDerived {
                XCTAssertEqual(result.assessment.level, .mixed, "Empty data should not lower health state by itself for \(testCase.label)")
            }
        }
    }

    func testSparsePartialDataFallsBackInsteadOfProducingStrongAdvice() async {
        let cases: [(label: String, history: [DailyHealthSnapshot])] = [
            ("only sleep data", Self.sparseOnlySleepHistory()),
            ("only activity data", Self.sparseOnlyActivityHistory()),
            ("only HRV and resting heart rate data", Self.sparseOnlyRecoverySignalHistory())
        ]

        for testCase in cases {
            let provider = DashboardAssessmentProvider(
                isFeatureEnabled: { true },
                snapshotLoader: { _ in testCase.history }
            )

            let result = await provider.loadAssessment()

            XCTAssertNotEqual(result.source, .healthKitDerived, "Sparse partial data should not produce an overconfident HealthKit-derived result for \(testCase.label)")
            assertSafeFallback(result, context: testCase.label)
            assertNoStrongAdvice(in: result.assessment.primarySuggestion, context: testCase.label)
        }
    }

    func testStaleSparseDataFallsBackAndDoesNotLookCurrent() async {
        let provider = DashboardAssessmentProvider(
            isFeatureEnabled: { true },
            snapshotLoader: { _ in Self.staleSparseHistory() }
        )

        let result = await provider.loadAssessment()

        XCTAssertEqual(result.source, .lowDataFallback)
        assertSafeFallback(result, context: "stale sparse data")
        XCTAssertFalse(result.usesHealthKitDerivedData)
        XCTAssertNotNil(result.notice)
    }

    func testImpossibleFiniteInputsDoNotCrashAndStayDisplaySafe() async {
        let provider = DashboardAssessmentProvider(
            isFeatureEnabled: { true },
            snapshotLoader: { _ in Self.impossibleButFiniteHistory() }
        )

        let result = await provider.loadAssessment()

        assertSafeResult(result, context: "impossible finite inputs")
        XCTAssertTrue((0...100).contains(result.assessment.overallScore))
        for component in result.assessment.components {
            XCTAssertTrue((0...100).contains(component.score), "Component score escaped display range for \(component.title)")
        }
    }

    func testLowConfidenceAndUnavailableInputsDoNotReadAsBadHealth() async {
        let cases: [(label: String, history: [DailyHealthSnapshot])] = [
            ("low confidence", Self.sparseOnlySleepHistory()),
            ("unavailable confidence", Self.emptyMetricHistory())
        ]

        for testCase in cases {
            let provider = DashboardAssessmentProvider(
                isFeatureEnabled: { true },
                snapshotLoader: { _ in testCase.history }
            )

            let result = await provider.loadAssessment()
            let searchableText = searchableText(for: result)

            XCTAssertNotEqual(result.source, .healthKitDerived)
            assertNoNegativeHealthConclusion(in: searchableText, context: testCase.label)
            assertNoStrongAdvice(in: result.assessment.primarySuggestion, context: testCase.label)
        }
    }

    func testDefaultOffStillDoesNotLoadLowDataHealthKitFixtures() async {
        let provider = DashboardAssessmentProvider(
            isFeatureEnabled: { false },
            snapshotLoader: { _ in
                XCTFail("Default-off Dashboard must not inspect low-data HealthKit fixtures")
                return Self.sparseOnlyActivityHistory()
            }
        )

        let result = await provider.loadAssessment()

        XCTAssertEqual(result.source, .mock)
        XCTAssertEqual(result.assessment, .mock)
        XCTAssertFalse(result.usesHealthKitDerivedData)
    }

    func testLowDataHealthKitPathStillDoesNotWriteAppGroupSharedState() async throws {
        let context = try makeUserDefaults(label: "app-group-isolation")
        defer { context.userDefaults.removePersistentDomain(forName: context.suiteName) }
        let sharedStore = SharedReadinessStore(userDefaults: context.userDefaults)
        let provider = DashboardAssessmentProvider(
            isFeatureEnabled: { true },
            snapshotLoader: { _ in Self.sparseOnlyActivityHistory() }
        )

        let result = await provider.loadAssessment()

        XCTAssertNotEqual(result.source, .healthKitDerived)
        XCTAssertNil(sharedStore.load())
    }

    func testLowDataSafetySourcesDoNotIntroduceDisallowedMechanisms() throws {
        let root = repositoryRoot()
        let filesToScan = [
            root.appendingPathComponent("StateWatchApp/Features/Dashboard/DashboardView.swift"),
            root.appendingPathComponent("StateWatchApp/App/HealthKitDashboardFeatureFlag.swift"),
            root.appendingPathComponent("StateWatchWatchApp/Features/WatchDashboardView.swift"),
            root.appendingPathComponent("StateWatchComplications/StateWatchComplicationProvider.swift"),
            root.appendingPathComponent("StateWatchShared/SharedReadinessStore.swift"),
            root.appendingPathComponent("StateWatchShared/SharedReadinessSummary.swift")
        ]

        for fileURL in filesToScan {
            let source = try String(contentsOf: fileURL, encoding: .utf8)
            let tokens = disallowedTokens(for: fileURL)
            for token in tokens {
                XCTAssertFalse(
                    source.localizedCaseInsensitiveContains(token),
                    "Unexpected disallowed low-data mechanism in \(fileURL.lastPathComponent): \(token)"
                )
            }
        }
    }

    private func assertSafeFallback(
        _ result: DashboardAssessmentResult,
        context: String,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertNotEqual(result.source, .healthKitDerived, file: file, line: line)
        XCTAssertEqual(result.assessment, .mock, file: file, line: line)
        XCTAssertFalse(result.usesHealthKitDerivedData, file: file, line: line)
        assertSafeResult(result, context: context, file: file, line: line)
    }

    private func assertSafeResult(
        _ result: DashboardAssessmentResult,
        context: String,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertTrue((0...100).contains(result.assessment.overallScore), file: file, line: line)
        assertNoNegativeHealthConclusion(in: searchableText(for: result), context: context, file: file, line: line)
    }

    private func assertNoNegativeHealthConclusion(
        in searchableText: String,
        context: String,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        for forbiddenTerm in [
            "diagnos",
            "disease",
            "clinical stress",
            "treatment",
            "warning",
            "alert",
            "emergency",
            "abnormal health",
            "bad health",
            "health risk",
            "medical advice",
            "mental health diagnosis"
        ] {
            XCTAssertFalse(
                searchableText.localizedCaseInsensitiveContains(forbiddenTerm),
                "Unexpected low-data health wording in \(context): \(forbiddenTerm)",
                file: file,
                line: line
            )
        }
    }

    private func assertNoStrongAdvice(
        in text: String,
        context: String,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        for forbiddenAdvice in [
            "must",
            "need to",
            "required",
            "urgent",
            "immediately",
            "avoid exercise",
            "seek treatment"
        ] {
            XCTAssertFalse(
                text.localizedCaseInsensitiveContains(forbiddenAdvice),
                "Unexpected strong advice in \(context): \(forbiddenAdvice)",
                file: file,
                line: line
            )
        }
    }

    private func searchableText(for result: DashboardAssessmentResult) -> String {
        let model = DashboardDisplayModel(assessment: result.assessment)
        return [
            result.notice ?? "",
            model.searchableText,
            result.assessment.level.rawValue,
            result.assessment.confidence.rawValue,
            result.assessment.primarySuggestion,
            result.assessment.reasons.joined(separator: " "),
            result.assessment.components.map { "\($0.title) \($0.summary) \($0.confidence.rawValue)" }.joined(separator: " ")
        ].joined(separator: " ")
    }

    private func disallowedTokens(for fileURL: URL) -> [String] {
        if fileURL.path.contains("StateWatchComplications") || fileURL.path.contains("StateWatchWatchApp") {
            return [
                "import HealthKit",
                "HealthKitDataFetcher",
                "fetchRecentSnapshots",
                "HKHealthStore",
                "HKQuantitySample",
                "URLSession",
                "WatchConnectivity",
                "WCSession",
                "raw HealthKit",
                "developer upload",
                "backend upload"
            ]
        }

        if fileURL.path.contains("StateWatchShared") {
            return [
                "DailyHealthSnapshot",
                "HealthBaseline",
                "HealthKitDataFetcher",
                "HKHealthStore",
                "HKQuantitySample",
                "URLSession",
                "WatchConnectivity",
                "WCSession",
                "raw HealthKit"
            ]
        }

        return [
            "HKHealthStore.save",
            "HKQuantitySample(",
            "requestAuthorization(toShare",
            "NSHealthUpdateUsageDescription",
            "URLSession",
            "WatchConnectivity",
            "WCSession",
            "remoteConfig",
            "cloud sync",
            "analytics rollout",
            "developer upload",
            "backend upload"
        ]
    }

    private func makeUserDefaults(label: String) throws -> (suiteName: String, userDefaults: UserDefaults) {
        let suiteName = "statewatch.dashboard.phase85.\(label).\(UUID().uuidString)"
        let userDefaults = try XCTUnwrap(UserDefaults(suiteName: suiteName))
        userDefaults.removePersistentDomain(forName: suiteName)
        return (suiteName, userDefaults)
    }

    private static func historyWithoutSleep() -> [DailyHealthSnapshot] {
        metricHistory { offset, date in
            DailyHealthSnapshot(
                date: date,
                restingHeartRate: offset == 13 ? 65 : 63,
                averageHeartRate: offset == 13 ? 80 : 78,
                heartRateVariability: offset == 13 ? 47 : 44,
                activeEnergyKcal: offset == 13 ? 505 : 470,
                exerciseMinutes: offset == 13 ? 32 : 28,
                stepCount: offset == 13 ? 8_400 : 7_800
            )
        }
    }

    private static func historyWithoutHRV() -> [DailyHealthSnapshot] {
        metricHistory { offset, date in
            DailyHealthSnapshot(
                date: date,
                restingHeartRate: offset == 13 ? 65 : 63,
                averageHeartRate: offset == 13 ? 80 : 78,
                sleepDurationHours: offset == 13 ? 7.2 : 7.0,
                activeEnergyKcal: offset == 13 ? 505 : 470,
                exerciseMinutes: offset == 13 ? 32 : 28,
                stepCount: offset == 13 ? 8_400 : 7_800
            )
        }
    }

    private static func historyWithoutRestingHeartRate() -> [DailyHealthSnapshot] {
        metricHistory { offset, date in
            DailyHealthSnapshot(
                date: date,
                averageHeartRate: offset == 13 ? 80 : 78,
                heartRateVariability: offset == 13 ? 47 : 44,
                sleepDurationHours: offset == 13 ? 7.2 : 7.0,
                activeEnergyKcal: offset == 13 ? 505 : 470,
                exerciseMinutes: offset == 13 ? 32 : 28,
                stepCount: offset == 13 ? 8_400 : 7_800
            )
        }
    }

    private static func historyWithoutActivityLoad() -> [DailyHealthSnapshot] {
        metricHistory { offset, date in
            DailyHealthSnapshot(
                date: date,
                restingHeartRate: offset == 13 ? 65 : 63,
                averageHeartRate: offset == 13 ? 80 : 78,
                heartRateVariability: offset == 13 ? 47 : 44,
                sleepDurationHours: offset == 13 ? 7.2 : 7.0
            )
        }
    }

    private static func emptyMetricHistory() -> [DailyHealthSnapshot] {
        metricHistory { _, date in DailyHealthSnapshot(date: date) }
    }

    private static func sparseOnlySleepHistory() -> [DailyHealthSnapshot] {
        [
            DailyHealthSnapshot(date: Date(timeIntervalSince1970: 150_000), sleepDurationHours: 6.8),
            DailyHealthSnapshot(date: Date(timeIntervalSince1970: 236_400), sleepDurationHours: 7.0)
        ]
    }

    private static func sparseOnlyActivityHistory() -> [DailyHealthSnapshot] {
        [
            DailyHealthSnapshot(date: Date(timeIntervalSince1970: 152_000), activeEnergyKcal: 300, exerciseMinutes: 12, stepCount: 4_200),
            DailyHealthSnapshot(date: Date(timeIntervalSince1970: 238_400), activeEnergyKcal: 320, exerciseMinutes: 14, stepCount: 4_500)
        ]
    }

    private static func sparseOnlyRecoverySignalHistory() -> [DailyHealthSnapshot] {
        [
            DailyHealthSnapshot(date: Date(timeIntervalSince1970: 154_000), restingHeartRate: 65, heartRateVariability: 42),
            DailyHealthSnapshot(date: Date(timeIntervalSince1970: 240_400), restingHeartRate: 66, heartRateVariability: 41)
        ]
    }

    private static func staleSparseHistory() -> [DailyHealthSnapshot] {
        [
            DailyHealthSnapshot(date: Date(timeIntervalSince1970: 10_000), stepCount: 5_000),
            DailyHealthSnapshot(date: Date(timeIntervalSince1970: 96_400), stepCount: 5_200)
        ]
    }

    private static func impossibleButFiniteHistory() -> [DailyHealthSnapshot] {
        metricHistory { offset, date in
            DailyHealthSnapshot(
                date: date,
                restingHeartRate: offset == 13 ? -20 : 300,
                averageHeartRate: offset == 13 ? 400 : -10,
                heartRateVariability: offset == 13 ? -50 : 1_000,
                sleepDurationHours: offset == 13 ? -3 : 30,
                activeEnergyKcal: offset == 13 ? -200 : 10_000,
                exerciseMinutes: offset == 13 ? -15 : 900,
                stepCount: offset == 13 ? -1_000 : 100_000
            )
        }
    }

    private static func metricHistory(
        build: (_ offset: Int, _ date: Date) -> DailyHealthSnapshot
    ) -> [DailyHealthSnapshot] {
        let calendar = Calendar(identifier: .gregorian)
        let start = Date(timeIntervalSince1970: 120_000)

        return (0..<14).compactMap { offset in
            guard let date = calendar.date(byAdding: .day, value: offset, to: start) else {
                return nil
            }

            return build(offset, date)
        }
    }

    private func repositoryRoot(filePath: String = #filePath) -> URL {
        URL(fileURLWithPath: filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
    }
}
