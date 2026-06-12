import Foundation
import XCTest

final class SharedReadinessSummaryTests: XCTestCase {
    func testSchemaVersionIsStable() {
        XCTAssertEqual(SharedReadinessSummary.currentSchemaVersion, 1)
        XCTAssertEqual(SharedReadinessSummary.mockFallback.schemaVersion, 1)
    }

    func testMockSummaryUsesExpectedStaticValues() {
        let generatedAt = Date(timeIntervalSince1970: 1_800)
        let summary = SharedReadinessSummary.mock(generatedAt: generatedAt)

        XCTAssertEqual(summary.schemaVersion, 1)
        XCTAssertEqual(summary.score, 76)
        XCTAssertEqual(summary.stateLabel, "Mixed")
        XCTAssertEqual(summary.confidence, "Medium")
        XCTAssertEqual(summary.shortSuggestion, "Demo data")
        XCTAssertEqual(summary.updatedText, "Demo")
        XCTAssertEqual(summary.generatedAt, generatedAt)
        XCTAssertEqual(summary.source, "mock-app-group")
        XCTAssertTrue(summary.isMock)
    }

    func testMockSummaryScoreIsDisplaySafe() {
        let summary = SharedReadinessSummary.mock(generatedAt: Date(timeIntervalSince1970: 2_100))

        XCTAssertTrue((0...100).contains(summary.score))
    }

    func testMockSummaryDefaultGeneratedAtIsRecent() {
        let before = Date().addingTimeInterval(-1)
        let summary = SharedReadinessSummary.mock()
        let after = Date().addingTimeInterval(1)

        XCTAssertGreaterThanOrEqual(summary.generatedAt, before)
        XCTAssertLessThanOrEqual(summary.generatedAt, after)
    }

    func testSharedSummaryEncodesAndDecodes() throws {
        let summary = SharedReadinessSummary(
            schemaVersion: 1,
            score: 52,
            stateLabel: "Low data",
            confidence: "Low",
            shortSuggestion: "Demo data",
            updatedText: "Demo",
            generatedAt: Date(timeIntervalSince1970: 2_400),
            source: "mock-app-group",
            isMock: true
        )

        let data = try JSONEncoder.stateWatchSharedState.encode(summary)
        let decoded = try JSONDecoder.stateWatchSharedState.decode(SharedReadinessSummary.self, from: data)

        XCTAssertEqual(decoded, summary)
    }

    func testSharedSummaryMapsToComplicationSummary() {
        let summary = SharedReadinessSummary.mock(generatedAt: Date(timeIntervalSince1970: 3_600))
        let complicationSummary = ComplicationStateSummary(sharedSummary: summary)

        XCTAssertEqual(complicationSummary.score, 76)
        XCTAssertEqual(complicationSummary.stateLabel, "Mixed")
        XCTAssertEqual(complicationSummary.confidence, "Medium")
        XCTAssertEqual(complicationSummary.shortSuggestion, "Demo data")
        XCTAssertEqual(complicationSummary.updatedText, "Demo")
        XCTAssertFalse(complicationSummary.isStale)
    }

    func testSharedStateWordingDoesNotImplyForbiddenBehavior() {
        let searchableText = [
            SharedReadinessSummary.mock(generatedAt: Date(timeIntervalSince1970: 4_200)).searchableText,
            ComplicationStateSummary.mock.searchableText
        ].joined(separator: " ")

        for forbiddenTerm in [
            "HealthKit",
            "Apple Health",
            "diagnos",
            "disease",
            "clinical stress",
            "treatment",
            "warning",
            "network",
            "upload",
            "AI",
            "write access"
        ] {
            XCTAssertFalse(
                searchableText.localizedCaseInsensitiveContains(forbiddenTerm),
                "Unexpected shared-state wording: \(forbiddenTerm)"
            )
        }
    }
}

final class SharedReadinessStoreTests: XCTestCase {
    func testAppGroupIdentifierAndStorageKeyRemainStable() {
        XCTAssertEqual(SharedReadinessStore.appGroupIdentifier, "group.com.easonsusu.StateWatch")
        XCTAssertEqual(SharedReadinessStore.storageKey, "statewatch.shared.readiness.summary.v1")
    }

    func testStoreSavesAndLoadsMockSummary() {
        let suiteName = "statewatch.tests.\(UUID().uuidString)"
        let userDefaults = UserDefaults(suiteName: suiteName)!
        userDefaults.removePersistentDomain(forName: suiteName)
        defer {
            userDefaults.removePersistentDomain(forName: suiteName)
        }
        let store = SharedReadinessStore(userDefaults: userDefaults)
        let summary = SharedReadinessSummary.mock(generatedAt: Date(timeIntervalSince1970: 5_400))

        XCTAssertTrue(store.save(summary))
        XCTAssertEqual(store.load(), summary)
    }

    func testStoreSaveMockSummaryWritesExpectedMockValues() throws {
        let suiteName = "statewatch.tests.\(UUID().uuidString)"
        let userDefaults = UserDefaults(suiteName: suiteName)!
        userDefaults.removePersistentDomain(forName: suiteName)
        defer {
            userDefaults.removePersistentDomain(forName: suiteName)
        }
        let store = SharedReadinessStore(userDefaults: userDefaults)

        XCTAssertTrue(store.saveMockSummary(generatedAt: Date(timeIntervalSince1970: 5_700)))
        let summary = try XCTUnwrap(store.load())

        XCTAssertEqual(summary.score, 76)
        XCTAssertEqual(summary.stateLabel, "Mixed")
        XCTAssertEqual(summary.confidence, "Medium")
        XCTAssertEqual(summary.updatedText, "Demo")
        XCTAssertEqual(summary.source, "mock-app-group")
        XCTAssertTrue(summary.isMock)
    }

    func testStoreReturnsFreshSavedSummaryBeforeFallback() {
        let suiteName = "statewatch.tests.\(UUID().uuidString)"
        let userDefaults = UserDefaults(suiteName: suiteName)!
        userDefaults.removePersistentDomain(forName: suiteName)
        defer {
            userDefaults.removePersistentDomain(forName: suiteName)
        }
        let store = SharedReadinessStore(userDefaults: userDefaults)
        let summary = SharedReadinessSummary.mock(generatedAt: Date(timeIntervalSince1970: 6_100))

        XCTAssertTrue(store.save(summary))
        XCTAssertEqual(
            store.loadOrFallback(now: Date(timeIntervalSince1970: 6_130), maxAge: 60),
            summary
        )
    }

    func testStoreReturnsNilWhenAppGroupUnavailable() {
        let store = SharedReadinessStore(userDefaults: nil)

        XCTAssertFalse(store.save(.mock(generatedAt: Date(timeIntervalSince1970: 6_000))))
        XCTAssertNil(store.load())
        XCTAssertEqual(store.loadOrFallback(), .mockFallback)
    }

    func testStoreFallsBackSafelyForMissingData() {
        let suiteName = "statewatch.tests.\(UUID().uuidString)"
        let userDefaults = UserDefaults(suiteName: suiteName)!
        userDefaults.removePersistentDomain(forName: suiteName)
        defer {
            userDefaults.removePersistentDomain(forName: suiteName)
        }
        let store = SharedReadinessStore(userDefaults: userDefaults)

        XCTAssertNil(store.load())
        XCTAssertEqual(store.loadOrFallback(), .mockFallback)
    }

    func testStoreFallsBackSafelyForInvalidData() {
        let suiteName = "statewatch.tests.\(UUID().uuidString)"
        let userDefaults = UserDefaults(suiteName: suiteName)!
        userDefaults.removePersistentDomain(forName: suiteName)
        defer {
            userDefaults.removePersistentDomain(forName: suiteName)
        }
        userDefaults.set(Data("not-json".utf8), forKey: SharedReadinessStore.storageKey)
        let store = SharedReadinessStore(userDefaults: userDefaults)

        XCTAssertNil(store.load())
        XCTAssertEqual(store.loadOrFallback(), .mockFallback)
    }

    func testStoreFallsBackSafelyForStaleData() {
        let suiteName = "statewatch.tests.\(UUID().uuidString)"
        let userDefaults = UserDefaults(suiteName: suiteName)!
        userDefaults.removePersistentDomain(forName: suiteName)
        defer {
            userDefaults.removePersistentDomain(forName: suiteName)
        }
        let store = SharedReadinessStore(userDefaults: userDefaults)
        let staleSummary = SharedReadinessSummary.mock(generatedAt: Date(timeIntervalSince1970: 7_200))

        XCTAssertTrue(store.save(staleSummary))
        XCTAssertEqual(
            store.loadOrFallback(now: Date(timeIntervalSince1970: 10_800), maxAge: 60),
            .mockFallback
        )
    }

    func testComplicationFallbackDisplaysStaticMockValues() {
        let store = SharedReadinessStore(userDefaults: nil)
        let complicationSummary = ComplicationStateSummary(sharedSummary: store.loadOrFallback())

        XCTAssertEqual(complicationSummary.score, 76)
        XCTAssertEqual(complicationSummary.stateLabel, "Mixed")
        XCTAssertEqual(complicationSummary.confidence, "Medium")
        XCTAssertEqual(complicationSummary.shortSuggestion, "Demo data")
        XCTAssertEqual(complicationSummary.updatedText, "Demo")
    }
}

final class SharedReadinessComplicationQATests: XCTestCase {
    func testComplicationCanUseSharedMockSummary() {
        let sharedSummary = SharedReadinessSummary.mock(generatedAt: Date(timeIntervalSince1970: 8_400))
        let complicationSummary = ComplicationStateSummary(sharedSummary: sharedSummary)

        XCTAssertEqual(complicationSummary.score, 76)
        XCTAssertEqual(complicationSummary.stateLabel, "Mixed")
        XCTAssertEqual(complicationSummary.confidence, "Medium")
        XCTAssertEqual(complicationSummary.shortSuggestion, "Demo data")
        XCTAssertEqual(complicationSummary.updatedText, "Demo")
        XCTAssertFalse(complicationSummary.isStale)
    }

    func testComplicationCanUseIphonePublishedMockDashboardSummary() {
        let sharedSummary = SharedReadinessSummary(
            schemaVersion: SharedReadinessSummary.currentSchemaVersion,
            score: 76,
            stateLabel: "Mixed",
            confidence: "Medium",
            shortSuggestion: "Consider a lighter day if that matches how you feel.",
            updatedText: "Demo",
            generatedAt: Date(timeIntervalSince1970: 8_500),
            source: "iphone-mock-dashboard",
            isMock: true
        )
        let complicationSummary = ComplicationStateSummary(sharedSummary: sharedSummary)

        XCTAssertEqual(complicationSummary.score, 76)
        XCTAssertEqual(complicationSummary.stateLabel, "Mixed")
        XCTAssertEqual(complicationSummary.confidence, "Medium")
        XCTAssertEqual(complicationSummary.shortSuggestion, "Consider a lighter day if that matches how you feel.")
        XCTAssertEqual(complicationSummary.updatedText, "Demo")
        XCTAssertFalse(complicationSummary.isStale)
    }

    func testComplicationFallbackUsesSafeStaticMockSummary() {
        let summary = ComplicationStateSummary.mock

        XCTAssertEqual(summary.score, 76)
        XCTAssertEqual(summary.stateLabel, "Mixed")
        XCTAssertEqual(summary.confidence, "Medium")
        XCTAssertEqual(summary.shortSuggestion, "Demo data")
        XCTAssertEqual(summary.updatedText, "Demo")
        XCTAssertFalse(summary.isStale)
    }

    func testComplicationFallbackStaysSafeForMissingCorruptedStaleAndUnavailableSharedState() {
        let missingSuite = "statewatch.complication.missing.tests.\(UUID().uuidString)"
        let missingDefaults = UserDefaults(suiteName: missingSuite)!
        missingDefaults.removePersistentDomain(forName: missingSuite)
        defer {
            missingDefaults.removePersistentDomain(forName: missingSuite)
        }
        let missingStore = SharedReadinessStore(userDefaults: missingDefaults)

        let corruptedSuite = "statewatch.complication.corrupt.tests.\(UUID().uuidString)"
        let corruptedDefaults = UserDefaults(suiteName: corruptedSuite)!
        corruptedDefaults.removePersistentDomain(forName: corruptedSuite)
        defer {
            corruptedDefaults.removePersistentDomain(forName: corruptedSuite)
        }
        corruptedDefaults.set(Data("not-json".utf8), forKey: SharedReadinessStore.storageKey)
        let corruptedStore = SharedReadinessStore(userDefaults: corruptedDefaults)

        let staleSuite = "statewatch.complication.stale.tests.\(UUID().uuidString)"
        let staleDefaults = UserDefaults(suiteName: staleSuite)!
        staleDefaults.removePersistentDomain(forName: staleSuite)
        defer {
            staleDefaults.removePersistentDomain(forName: staleSuite)
        }
        let staleStore = SharedReadinessStore(userDefaults: staleDefaults)
        XCTAssertTrue(staleStore.save(.mock(generatedAt: Date(timeIntervalSince1970: 8_600))))

        let fallbackSummaries = [
            SharedReadinessStore(userDefaults: nil).loadOrFallback(),
            missingStore.loadOrFallback(),
            corruptedStore.loadOrFallback(),
            staleStore.loadOrFallback(now: Date(timeIntervalSince1970: 12_600), maxAge: 60)
        ]

        for fallbackSummary in fallbackSummaries {
            let complicationSummary = ComplicationStateSummary(sharedSummary: fallbackSummary)

            XCTAssertEqual(complicationSummary.score, 76)
            XCTAssertEqual(complicationSummary.stateLabel, "Mixed")
            XCTAssertEqual(complicationSummary.confidence, "Medium")
            XCTAssertEqual(complicationSummary.shortSuggestion, "Demo data")
            XCTAssertEqual(complicationSummary.updatedText, "Demo")
            XCTAssertFalse(complicationSummary.isStale)
        }
    }

    func testComplicationProviderDoesNotUseHealthKitWatchConnectivityOrNetworking() throws {
        let providerSource = try RepositoryFiles.contents(
            at: "StateWatchComplications/StateWatchComplicationProvider.swift"
        )
        let sharedStoreSource = try RepositoryFiles.contents(at: "StateWatchShared/SharedReadinessStore.swift")
        let searchedSource = [providerSource, sharedStoreSource].joined(separator: "\n")

        XCTAssertTrue(providerSource.contains("SharedReadinessStore().load()"))
        XCTAssertTrue(providerSource.contains("complicationSummary = .mock"))
        XCTAssertFalse(providerSource.contains("HealthKitDataFetcher"))
        XCTAssertFalse(providerSource.contains("WatchConnectivity"))

        for forbiddenTerm in [
            "import HealthKit",
            "HealthKitDataFetcher",
            "fetchRecentSnapshots",
            "HKSample",
            "requestAuthorization",
            "WatchConnectivity",
            "WCSession",
            "URLSession",
            "http://",
            "https://"
        ] {
            XCTAssertFalse(
                searchedSource.localizedCaseInsensitiveContains(forbiddenTerm),
                "Unexpected shared-state implementation reference: \(forbiddenTerm)"
            )
        }
    }

}

final class SharedReadinessDocumentationQATests: XCTestCase {
    func testReadmeAndTestPlanDescribeMockOnlyDeferredRollout() throws {
        let readme = try RepositoryFiles.contents(at: "README.md")
        let testPlan = try RepositoryFiles.contents(at: "TEST_PLAN.md")
        let documentation = [readme, testPlan].joined(separator: "\n")

        XCTAssertTrue(documentation.localizedCaseInsensitiveContains("mock-only"))
        XCTAssertTrue(documentation.localizedCaseInsensitiveContains("HealthKit-derived scoring is not wired"))
        XCTAssertTrue(documentation.localizedCaseInsensitiveContains("WatchConnectivity remains deferred"))
    }

    func testPhaseSevenOneDocumentationChecklistExists() throws {
        let testPlan = try RepositoryFiles.contents(at: "TEST_PLAN.md")
        let architecture = try RepositoryFiles.contents(at: "Docs/shared-local-state-architecture.md")

        XCTAssertTrue(testPlan.localizedCaseInsensitiveContains("Phase 7.1"))
        XCTAssertTrue(testPlan.localizedCaseInsensitiveContains("iPhone mock dashboard publisher is tested"))
        XCTAssertTrue(testPlan.localizedCaseInsensitiveContains("WidgetKit fallback remains safe"))
        XCTAssertTrue(architecture.localizedCaseInsensitiveContains("Phase 7.1"))
        XCTAssertTrue(architecture.localizedCaseInsensitiveContains("QA audit"))
    }

    func testDocumentationDoesNotMakeUnsafeAffirmativeClaims() throws {
        let readme = try RepositoryFiles.contents(at: "README.md")
        let testPlan = try RepositoryFiles.contents(at: "TEST_PLAN.md")
        let sharedArchitecture = try RepositoryFiles.contents(at: "Docs/shared-local-state-architecture.md")
        let documentation = [readme, testPlan, sharedArchitecture].joined(separator: "\n")

        for forbiddenClaim in [
            "diagnoses",
            "detects disease",
            "detects illness",
            "detects clinical stress",
            "provides treatment",
            "emergency alert",
            "emergency response",
            "HealthKit write access is enabled",
            "HealthKit write access is requested",
            "uploads HealthKit",
            "cloud upload is enabled",
            "networking is enabled",
            "AI analysis is enabled",
            "live HealthKit-backed complications are enabled",
            "WatchConnectivity syncing is implemented",
            "production HealthKit rollout is enabled"
        ] {
            XCTAssertFalse(
                documentation.localizedCaseInsensitiveContains(forbiddenClaim),
                "Unexpected unsafe documentation claim: \(forbiddenClaim)"
            )
        }
    }
}

private enum RepositoryFiles {
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
