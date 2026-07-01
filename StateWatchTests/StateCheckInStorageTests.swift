import Foundation
import XCTest

final class StateCheckInRecordTests: XCTestCase {
    func testRecordEncodesAndDecodesOneWatchRecord() throws {
        let record = StateCheckInRecord(
            id: try XCTUnwrap(UUID(uuidString: "11111111-1111-1111-1111-111111111111")),
            option: .energized,
            createdAt: Date(timeIntervalSince1970: 1_000),
            sourceSurface: .watch
        )

        let data = try JSONEncoder.stateWatchCheckIn.encode(record)
        let json = try XCTUnwrap(String(data: data, encoding: .utf8))
        let decoded = try JSONDecoder.stateWatchCheckIn.decode(StateCheckInRecord.self, from: data)

        XCTAssertEqual(decoded, record)
        XCTAssertTrue(json.contains(#""option":"energized""#))
        XCTAssertFalse(json.contains("Energized"))
        XCTAssertEqual(record.schemaVersion, StateCheckInRecord.currentSchemaVersion)
        XCTAssertEqual(record.sourceSurface, .watch)
        XCTAssertEqual(record.noteStatus, .none)
    }

    func testRecordUsesApprovedOptionRawValuesOnly() throws {
        XCTAssertEqual(StateCheckInOption.allCases.map(\.rawValue), ["energized", "stable", "tired", "low"])
        XCTAssertEqual(StateCheckInOption.allCases.map(\.label), ["Energized", "Stable", "Tired", "Low"])
        XCTAssertEqual(StateCheckInOption.allCases.map(\.traditionalChineseReferenceLabel), ["有活力", "穩定", "疲累", "低狀態"])
    }

    func testRecordSchemaVersionIsStable() {
        XCTAssertEqual(StateCheckInRecord.currentSchemaVersion, 1)
    }

    func testRecordSchemaExcludesHealthMedicalCloudAndProfileFields() throws {
        let record = StateCheckInRecord(option: .low, createdAt: Date(timeIntervalSince1970: 1_200))
        let data = try JSONEncoder.stateWatchCheckIn.encode(record)
        let json = try XCTUnwrap(String(data: data, encoding: .utf8))

        for forbiddenTerm in [
            "HealthKit",
            "heartRate",
            "sample",
            "diagnosis",
            "clinical",
            "treatment",
            "anxiety",
            "depression",
            "symptom",
            "cloud",
            "account",
            "advertising",
            "analytics",
            "remoteConfig",
            "location",
            "deviceIdentifier",
            "AI"
        ] {
            XCTAssertFalse(
                json.localizedCaseInsensitiveContains(forbiddenTerm),
                "Unexpected check-in record field or value: \(forbiddenTerm)"
            )
        }
    }
}

final class LocalStateCheckInStoreTests: XCTestCase {
    func testEmptyLocalHistoryLoadsSafely() throws {
        let store = try makeStore()

        XCTAssertEqual(store.loadAll(), [])
        XCTAssertEqual(store.loadRecent(limit: 10), [])
    }

    func testSavingOneRecordAndLoadingRecentReturnsIt() throws {
        let store = try makeStore()
        let record = StateCheckInRecord(
            id: try XCTUnwrap(UUID(uuidString: "22222222-2222-2222-2222-222222222222")),
            option: .stable,
            createdAt: Date(timeIntervalSince1970: 1_400),
            sourceSurface: .watch
        )

        try store.save(record)

        XCTAssertEqual(store.loadAll(), [record])
        XCTAssertEqual(store.loadRecent(limit: 1), [record])
    }

    func testRecentHistoryUsesNewestRecordsFirstAndHonorsLimit() throws {
        let store = try makeStore()
        let oldRecord = StateCheckInRecord(
            id: try XCTUnwrap(UUID(uuidString: "33333333-3333-3333-3333-333333333333")),
            option: .tired,
            createdAt: Date(timeIntervalSince1970: 1_000),
            sourceSurface: .watch
        )
        let newRecord = StateCheckInRecord(
            id: try XCTUnwrap(UUID(uuidString: "44444444-4444-4444-4444-444444444444")),
            option: .energized,
            createdAt: Date(timeIntervalSince1970: 2_000),
            sourceSurface: .watch
        )

        try store.save(oldRecord)
        try store.save(newRecord)

        XCTAssertEqual(store.loadRecent(limit: 1), [newRecord])
        XCTAssertEqual(store.loadRecent(limit: 10), [newRecord, oldRecord])
    }

    func testRecentHistoryReturnsLatestThreeNewestFirst() throws {
        let store = try makeStore()
        let oldestRecord = try makeRecord(id: "55555555-5555-5555-5555-555555555551", option: .energized, timestamp: 1_000)
        let thirdNewestRecord = try makeRecord(id: "55555555-5555-5555-5555-555555555552", option: .stable, timestamp: 2_000)
        let secondNewestRecord = try makeRecord(id: "55555555-5555-5555-5555-555555555553", option: .tired, timestamp: 3_000)
        let newestRecord = try makeRecord(id: "55555555-5555-5555-5555-555555555554", option: .low, timestamp: 4_000)

        try store.save(oldestRecord)
        try store.save(secondNewestRecord)
        try store.save(newestRecord)
        try store.save(thirdNewestRecord)

        XCTAssertEqual(store.loadRecent(limit: 3), [newestRecord, secondNewestRecord, thirdNewestRecord])
    }

    func testDeleteRemovesOnlyMatchingRecordAndPreservesRemainingRecords() throws {
        let store = try makeStore()
        let oldRecord = try makeRecord(id: "66666666-6666-6666-6666-666666666661", option: .energized, timestamp: 1_000)
        let deletedRecord = try makeRecord(id: "66666666-6666-6666-6666-666666666662", option: .stable, timestamp: 2_000)
        let newRecord = try makeRecord(id: "66666666-6666-6666-6666-666666666663", option: .tired, timestamp: 3_000)

        try store.save(oldRecord)
        try store.save(deletedRecord)
        try store.save(newRecord)

        try store.delete(id: deletedRecord.id)

        XCTAssertEqual(store.loadAll(), [newRecord, oldRecord])
        XCTAssertEqual(store.loadRecent(limit: 3), [newRecord, oldRecord])
    }

    func testDeleteMissingRecordIsSafeNoOp() throws {
        let store = try makeStore()
        let record = try makeRecord(id: "77777777-7777-7777-7777-777777777771", option: .low, timestamp: 1_000)
        let missingID = try XCTUnwrap(UUID(uuidString: "77777777-7777-7777-7777-777777777772"))

        try store.save(record)
        try store.delete(id: missingID)

        XCTAssertEqual(store.loadAll(), [record])
    }

    func testDeletingThenLoadingRecentReturnsUpdatedNewestFirstHistory() throws {
        let store = try makeStore()
        let oldestRecord = try makeRecord(id: "88888888-8888-8888-8888-888888888881", option: .energized, timestamp: 1_000)
        let thirdNewestRecord = try makeRecord(id: "88888888-8888-8888-8888-888888888882", option: .stable, timestamp: 2_000)
        let deletedRecord = try makeRecord(id: "88888888-8888-8888-8888-888888888883", option: .tired, timestamp: 3_000)
        let newestRecord = try makeRecord(id: "88888888-8888-8888-8888-888888888884", option: .low, timestamp: 4_000)

        try store.save(oldestRecord)
        try store.save(thirdNewestRecord)
        try store.save(deletedRecord)
        try store.save(newestRecord)

        XCTAssertEqual(store.loadRecent(limit: 3), [newestRecord, deletedRecord, thirdNewestRecord])

        try store.delete(id: deletedRecord.id)

        XCTAssertEqual(store.loadRecent(limit: 3), [newestRecord, thirdNewestRecord, oldestRecord])
    }

    func testClearAllRemovesRecords() throws {
        let store = try makeStore()
        try store.save(StateCheckInRecord(option: .stable, createdAt: Date(timeIntervalSince1970: 1_600)))

        XCTAssertFalse(store.loadAll().isEmpty)

        try store.clearAll()

        XCTAssertEqual(store.loadAll(), [])
    }

    func testCorruptedJSONDoesNotCrashAndReturnsEmptyHistory() throws {
        let store = try makeStore()
        try Data("not-json".utf8).write(to: store.storageFileURLForTests, options: .atomic)

        XCTAssertEqual(store.loadAll(), [])
        XCTAssertEqual(store.loadRecent(limit: 5), [])
    }

    func testUnknownFutureSchemaVersionIsIgnoredSafely() throws {
        let store = try makeStore()
        let futureSchemaRecord = """
        [
          {
            "id": "55555555-5555-5555-5555-555555555555",
            "option": "stable",
            "createdAt": 1800,
            "updatedAt": null,
            "sourceSurface": "watch",
            "schemaVersion": 99,
            "noteStatus": "none"
          }
        ]
        """

        try Data(futureSchemaRecord.utf8).write(to: store.storageFileURLForTests, options: .atomic)

        XCTAssertEqual(store.loadAll(), [])
    }

    func testStoreSourceDoesNotUseForbiddenPropagationOrUploadMechanisms() throws {
        let root = repositoryRoot()
        let sourceFiles = [
            root.appendingPathComponent("StateWatchWatchApp/Services/CheckIn/StateCheckInRecord.swift"),
            root.appendingPathComponent("StateWatchWatchApp/Services/CheckIn/LocalStateCheckInStore.swift")
        ]
        let source = try sourceFiles
            .map { try String(contentsOf: $0, encoding: .utf8) }
            .joined(separator: "\n")

        for forbiddenTerm in [
            "App Group",
            "group.",
            "WidgetKit",
            "TimelineProvider",
            "WCSession",
            "WatchConnectivity",
            "URLSession",
            "HKHealthStore.save",
            "requestAuthorization(toShare",
            "analytics",
            "remote config",
            "iCloud",
            "cloud sync",
            "AI cloud",
            "account"
        ] {
            XCTAssertFalse(
                source.localizedCaseInsensitiveContains(forbiddenTerm),
                "Unexpected storage implementation boundary term: \(forbiddenTerm)"
            )
        }
    }

    private func makeStore(file: StaticString = #filePath, line: UInt = #line) throws -> LocalStateCheckInStore {
        let directory = FileManager.default.temporaryDirectory
            .appendingPathComponent("statewatch-checkin-tests-\(UUID().uuidString)", isDirectory: true)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        return LocalStateCheckInStore(directoryURL: directory)
    }

    private func makeRecord(id: String, option: StateCheckInOption, timestamp: TimeInterval, file: StaticString = #filePath, line: UInt = #line) throws -> StateCheckInRecord {
        StateCheckInRecord(
            id: try XCTUnwrap(UUID(uuidString: id), file: file, line: line),
            option: option,
            createdAt: Date(timeIntervalSince1970: timestamp),
            sourceSurface: .watch
        )
    }

    private func repositoryRoot(filePath: String = #filePath) -> URL {
        URL(fileURLWithPath: filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
    }
}

final class StateCheckInDisplayPreferenceTests: XCTestCase {
    func testDisplayModesUseStableRawValuesAndLabels() {
        XCTAssertEqual(StateCheckInDisplayMode.allCases.map(\.rawValue), ["iconAndText", "iconOnly", "textOnly"])
        XCTAssertEqual(StateCheckInDisplayMode.allCases.map(\.label), ["Icon + Text", "Icon Only", "Text Only"])
        XCTAssertEqual(StateCheckInDisplayMode.allCases.map(\.id), ["iconAndText", "iconOnly", "textOnly"])
    }

    func testDefaultDisplayModeIsIconAndText() throws {
        let store = try makePreferenceStore()

        XCTAssertEqual(store.load(), .iconAndText)
    }

    func testInvalidStoredDisplayModeFallsBackToIconAndText() throws {
        let store = try makePreferenceStore()
        store.userDefaultsForTests.set("gridWithVitals", forKey: store.storageKeyForTests)

        XCTAssertEqual(store.load(), .iconAndText)
    }

    func testSavingAndLoadingDisplayModeStoresOnlyRawValue() throws {
        let store = try makePreferenceStore()

        store.save(.textOnly)

        XCTAssertEqual(store.load(), .textOnly)
        XCTAssertEqual(store.userDefaultsForTests.string(forKey: store.storageKeyForTests), "textOnly")
    }

    func testDisplayPreferenceStoreDoesNotStoreCheckInRecords() throws {
        let store = try makePreferenceStore()

        store.save(.iconOnly)

        let persistedValue = try XCTUnwrap(store.userDefaultsForTests.string(forKey: store.storageKeyForTests))
        XCTAssertEqual(store.userDefaultsForTests.dictionaryRepresentation().keys.filter { $0 == store.storageKeyForTests }, [store.storageKeyForTests])

        for forbiddenValue in StateCheckInOption.allCases.map(\.rawValue) + ["StateCheckInRecord", "createdAt", "sourceSurface", "schemaVersion"] {
            XCTAssertFalse(
                persistedValue.localizedCaseInsensitiveContains(forbiddenValue),
                "Display preference unexpectedly stores check-in record data: \(forbiddenValue)"
            )
        }
    }

    func testDisplayPreferenceStoreSourceDoesNotUseForbiddenMechanisms() throws {
        let source = try String(
            contentsOf: repositoryRoot().appendingPathComponent("StateWatchWatchApp/Services/CheckIn/StateCheckInDisplayPreference.swift"),
            encoding: .utf8
        )

        for forbiddenTerm in [
            "UserDefaults(suiteName",
            "group.",
            "App Group",
            "WidgetKit",
            "TimelineProvider",
            "WCSession",
            "WatchConnectivity",
            "URLSession",
            "HKHealthStore.save",
            "requestAuthorization(toShare",
            "analytics",
            "remote config",
            "iCloud",
            "cloud sync",
            "AI cloud",
            "account",
            "StateCheckInRecord"
        ] {
            XCTAssertFalse(
                source.localizedCaseInsensitiveContains(forbiddenTerm),
                "Unexpected display preference implementation boundary term: \(forbiddenTerm)"
            )
        }
    }

    func testDisplayModeCopyDoesNotUseMedicalOrWarningWording() {
        let searchableCopy = StateCheckInDisplayMode.allCases
            .map(\.label)
            .joined(separator: " ")

        for forbiddenTerm in [
            "diagnos",
            "clinical",
            "medical advice",
            "treatment",
            "therapy",
            "emergency",
            "warning",
            "abnormal",
            "health risk",
            "anxiety",
            "depression"
        ] {
            XCTAssertFalse(
                searchableCopy.localizedCaseInsensitiveContains(forbiddenTerm),
                "Display preference copy should stay non-medical: \(forbiddenTerm)"
            )
        }
    }

    private func makePreferenceStore(file: StaticString = #filePath, line: UInt = #line) throws -> LocalStateCheckInDisplayPreferenceStore {
        let suiteName = "statewatch-display-preference-tests-\(UUID().uuidString)"
        let userDefaults = try XCTUnwrap(UserDefaults(suiteName: suiteName), file: file, line: line)
        userDefaults.removePersistentDomain(forName: suiteName)
        return LocalStateCheckInDisplayPreferenceStore(userDefaults: userDefaults)
    }

    private func repositoryRoot(filePath: String = #filePath) -> URL {
        URL(fileURLWithPath: filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
    }
}
