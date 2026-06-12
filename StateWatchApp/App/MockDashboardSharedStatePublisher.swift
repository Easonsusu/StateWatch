import Foundation

struct MockDashboardSharedStatePublisher {
    static let source = "iphone-mock-dashboard"

    private let store: SharedReadinessStore
    private let generatedAt: () -> Date

    init(
        store: SharedReadinessStore = SharedReadinessStore(),
        generatedAt: @escaping () -> Date = { Date() }
    ) {
        self.store = store
        self.generatedAt = generatedAt
    }

    init(
        userDefaults: UserDefaults?,
        generatedAt: @escaping () -> Date = { Date() }
    ) {
        self.store = SharedReadinessStore(userDefaults: userDefaults)
        self.generatedAt = generatedAt
    }

    @discardableResult
    func publish(assessment: StateAssessment = .mock) -> Bool {
        store.save(Self.summary(from: assessment, generatedAt: generatedAt()))
    }

    static func summary(
        from assessment: StateAssessment = .mock,
        generatedAt: Date = Date()
    ) -> SharedReadinessSummary {
        SharedReadinessSummary(
            schemaVersion: SharedReadinessSummary.currentSchemaVersion,
            score: assessment.overallScore,
            stateLabel: assessment.level.rawValue,
            confidence: confidenceText(for: assessment.confidence),
            shortSuggestion: assessment.primarySuggestion,
            updatedText: "Demo",
            generatedAt: generatedAt,
            source: source,
            isMock: true
        )
    }

    private static func confidenceText(for confidence: ScoreConfidence) -> String {
        switch confidence {
        case .high:
            return "High"
        case .medium:
            return "Medium"
        case .low:
            return "Low data"
        case .unavailable:
            return "Unavailable"
        }
    }
}
