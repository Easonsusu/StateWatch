import Foundation

enum StateCheckInSourceSurface: String, Codable, Equatable {
    case watch
}

enum StateCheckInNoteStatus: String, Codable, Equatable {
    case none
}

struct StateCheckInRecord: Codable, Equatable, Identifiable {
    static let currentSchemaVersion = 1

    let id: UUID
    let option: StateCheckInOption
    let createdAt: Date
    let updatedAt: Date?
    let sourceSurface: StateCheckInSourceSurface
    let schemaVersion: Int
    let noteStatus: StateCheckInNoteStatus

    init(
        id: UUID = UUID(),
        option: StateCheckInOption,
        createdAt: Date = Date(),
        updatedAt: Date? = nil,
        sourceSurface: StateCheckInSourceSurface = .watch,
        schemaVersion: Int = StateCheckInRecord.currentSchemaVersion,
        noteStatus: StateCheckInNoteStatus = .none
    ) {
        self.id = id
        self.option = option
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.sourceSurface = sourceSurface
        self.schemaVersion = schemaVersion
        self.noteStatus = noteStatus
    }

    var hasSupportedSchema: Bool {
        schemaVersion == Self.currentSchemaVersion
    }
}

extension JSONEncoder {
    static var stateWatchCheckIn: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]
        return encoder
    }
}

extension JSONDecoder {
    static var stateWatchCheckIn: JSONDecoder {
        JSONDecoder()
    }
}
