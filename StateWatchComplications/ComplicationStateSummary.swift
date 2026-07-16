import Foundation

struct ComplicationStateSummary: Equatable {
    let score: Int
    let stateLabel: String
    let shortSuggestion: String
    let confidence: String
    let updatedText: String
    let isStale: Bool

    init(
        score: Int,
        stateLabel: String,
        shortSuggestion: String,
        confidence: String,
        updatedText: String,
        isStale: Bool
    ) {
        self.score = score
        self.stateLabel = stateLabel
        self.shortSuggestion = shortSuggestion
        self.confidence = confidence
        self.updatedText = updatedText
        self.isStale = isStale
    }

    init(sharedSummary: SharedReadinessSummary, isStale: Bool = false) {
        self.init(
            score: sharedSummary.score,
            stateLabel: sharedSummary.stateLabel,
            shortSuggestion: sharedSummary.shortSuggestion,
            confidence: sharedSummary.confidence,
            updatedText: sharedSummary.updatedText,
            isStale: isStale
        )
    }

    static let mock = ComplicationStateSummary(
        score: 76,
        stateLabel: "Mixed",
        shortSuggestion: "Demo data",
        confidence: "Medium",
        updatedText: "Demo",
        isStale: false
    )

    var localizedStateLabel: String {
        localized(stateLabel)
    }

    var localizedShortSuggestion: String {
        localized(shortSuggestion)
    }

    var localizedConfidence: String {
        localized(confidence)
    }

    var localizedUpdatedText: String {
        localized(updatedText)
    }

    var circularLabel: String {
        String(localizedStateLabel.uppercased().prefix(3))
    }

    var rectangularTitle: String {
        formatted("State %d - %@", score, localizedStateLabel)
    }

    var inlineText: String {
        formatted("StateWatch %d %@", score, localizedStateLabel)
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

    private func localized(_ key: String) -> String {
        Bundle.main.localizedString(forKey: key, value: key, table: nil)
    }

    private func formatted(_ key: String, _ arguments: CVarArg...) -> String {
        String(
            format: localized(key),
            locale: Locale.current,
            arguments: arguments
        )
    }
}
