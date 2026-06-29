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

    private func repositoryRoot(filePath: String = #filePath) -> URL {
        URL(fileURLWithPath: filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
    }
}
