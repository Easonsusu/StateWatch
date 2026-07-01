import Foundation

protocol StateCheckInStoring {
    func save(_ record: StateCheckInRecord) throws
    func loadRecent(limit: Int) -> [StateCheckInRecord]
    func loadAll() -> [StateCheckInRecord]
    func delete(id: UUID) throws
    func clearAll() throws
}

struct LocalStateCheckInStore: StateCheckInStoring {
    static let storageFileName = "statewatch-watch-checkins-v1.json"

    private let fileManager: FileManager
    private let directoryURL: URL
    private let fileName: String

    init(
        fileManager: FileManager = .default,
        directoryURL: URL? = nil,
        fileName: String = LocalStateCheckInStore.storageFileName
    ) {
        self.fileManager = fileManager
        self.directoryURL = directoryURL ?? Self.defaultDirectoryURL(fileManager: fileManager)
        self.fileName = fileName
    }

    var storageFileURLForTests: URL {
        storageFileURL
    }

    func save(_ record: StateCheckInRecord) throws {
        var records = loadAll()
        records.removeAll { $0.id == record.id }
        records.append(record)
        try write(records)
    }

    func loadRecent(limit: Int) -> [StateCheckInRecord] {
        guard limit > 0 else {
            return []
        }

        return Array(loadAll().prefix(limit))
    }

    func loadAll() -> [StateCheckInRecord] {
        guard fileManager.fileExists(atPath: storageFileURL.path) else {
            return []
        }

        do {
            let data = try Data(contentsOf: storageFileURL)
            let records = try JSONDecoder.stateWatchCheckIn.decode([StateCheckInRecord].self, from: data)
            return normalized(records)
        } catch {
            return []
        }
    }

    func delete(id: UUID) throws {
        var records = loadAll()
        let originalCount = records.count
        records.removeAll { $0.id == id }

        guard records.count != originalCount else {
            return
        }

        try write(records)
    }

    func clearAll() throws {
        guard fileManager.fileExists(atPath: storageFileURL.path) else {
            return
        }

        try fileManager.removeItem(at: storageFileURL)
    }

    private var storageFileURL: URL {
        directoryURL.appendingPathComponent(fileName, isDirectory: false)
    }

    private static func defaultDirectoryURL(fileManager: FileManager) -> URL {
        if let applicationSupportDirectory = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
            return applicationSupportDirectory.appendingPathComponent("StateWatchCheckIns", isDirectory: true)
        }

        return fileManager.temporaryDirectory.appendingPathComponent("StateWatchCheckIns", isDirectory: true)
    }

    private func write(_ records: [StateCheckInRecord]) throws {
        try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true)
        let data = try JSONEncoder.stateWatchCheckIn.encode(normalized(records))
        try data.write(to: storageFileURL, options: [.atomic])
    }

    private func normalized(_ records: [StateCheckInRecord]) -> [StateCheckInRecord] {
        records
            .filter { $0.hasSupportedSchema && $0.sourceSurface == .watch }
            .sorted { lhs, rhs in
                if lhs.createdAt == rhs.createdAt {
                    return lhs.id.uuidString < rhs.id.uuidString
                }

                return lhs.createdAt > rhs.createdAt
            }
    }
}
