import Foundation

struct ComplicationStateSummary: Equatable {
    let score: Int
    let stateLabel: String
    let shortSuggestion: String
    let confidence: String
    let updatedText: String
    let isStale: Bool

    static let mock = ComplicationStateSummary(
        score: 76,
        stateLabel: "Mixed",
        shortSuggestion: "Demo data",
        confidence: "Medium",
        updatedText: "Demo",
        isStale: false
    )

    var circularLabel: String {
        String(stateLabel.uppercased().prefix(3))
    }

    var rectangularTitle: String {
        "State \(score) - \(stateLabel)"
    }

    var inlineText: String {
        "StateWatch \(score) \(stateLabel)"
    }

    var searchableText: String {
        [
            "\(score)",
            stateLabel,
            shortSuggestion,
            confidence,
            updatedText,
            isStale ? "Stale" : "Current demo"
        ].joined(separator: " ")
    }
}
