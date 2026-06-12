import Foundation

struct SharedReadinessSummary: Codable, Equatable {
    static let currentSchemaVersion = 1
    static let mockFallback = SharedReadinessSummary.mock(generatedAt: Date(timeIntervalSince1970: 0))

    let schemaVersion: Int
    let score: Int
    let stateLabel: String
    let confidence: String
    let shortSuggestion: String
    let updatedText: String
    let generatedAt: Date
    let source: String
    let isMock: Bool

    static func mock(generatedAt: Date = Date()) -> SharedReadinessSummary {
        SharedReadinessSummary(
            schemaVersion: currentSchemaVersion,
            score: 76,
            stateLabel: "Mixed",
            confidence: "Medium",
            shortSuggestion: "Demo data",
            updatedText: "Demo",
            generatedAt: generatedAt,
            source: "mock-app-group",
            isMock: true
        )
    }

    func isStale(relativeTo now: Date = Date(), maxAge: TimeInterval = 12 * 60 * 60) -> Bool {
        now.timeIntervalSince(generatedAt) > maxAge
    }

    var searchableText: String {
        [
            "\(schemaVersion)",
            "\(score)",
            stateLabel,
            confidence,
            shortSuggestion,
            updatedText,
            source,
            isMock ? "mock" : "summary",
            "\(generatedAt.timeIntervalSince1970)"
        ].joined(separator: " ")
    }
}

extension JSONEncoder {
    static var stateWatchSharedState: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }
}

extension JSONDecoder {
    static var stateWatchSharedState: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
