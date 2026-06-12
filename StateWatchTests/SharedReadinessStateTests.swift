import Foundation
import XCTest

final class SharedReadinessSummaryTests: XCTestCase {
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

    func testSharedSummaryEncodesAndDecodes() throws {
        let summary = SharedReadinessSummary.mock(generatedAt: Date(timeIntervalSince1970: 2_400))

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
