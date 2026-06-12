import Foundation

struct StateAssessment: Identifiable, Codable, Equatable {
    let id: UUID
    let date: Date
    let overallScore: Int
    let level: StateLevel
    let recovery: ScoreComponent
    let sleep: ScoreComponent
    let stressFatigue: ScoreComponent
    let activityLoad: ScoreComponent
    let confidence: ScoreConfidence
    let reasons: [String]
    let suggestions: [String]

    init(
        id: UUID = UUID(),
        date: Date,
        overallScore: Int,
        level: StateLevel,
        recovery: ScoreComponent,
        sleep: ScoreComponent,
        stressFatigue: ScoreComponent,
        activityLoad: ScoreComponent,
        confidence: ScoreConfidence? = nil,
        reasons: [String],
        suggestions: [String]
    ) {
        self.id = id
        self.date = date
        self.overallScore = min(100, max(0, overallScore))
        self.level = level
        self.recovery = recovery
        self.sleep = sleep
        self.stressFatigue = stressFatigue
        self.activityLoad = activityLoad
        self.confidence = confidence ?? ScoreConfidence.combined([recovery.confidence, sleep.confidence, stressFatigue.confidence, activityLoad.confidence])
        self.reasons = reasons
        self.suggestions = suggestions
    }

    var components: [ScoreComponent] {
        [recovery, sleep, stressFatigue, activityLoad]
    }

    var primarySuggestion: String {
        suggestions.first ?? "Check in with how you feel before adjusting your day."
    }

    // TODO: Add data-quality metadata once real local HealthKit reads can be partial or unavailable.
}

struct ScoreComponent: Identifiable, Codable, Equatable {
    let id: String
    let title: String
    let score: Int
    let confidence: ScoreConfidence
    let summary: String

    init(id: String? = nil, title: String, score: Int, confidence: ScoreConfidence = .medium, summary: String) {
        self.id = id ?? title
        self.title = title
        self.score = min(100, max(0, score))
        self.confidence = confidence
        self.summary = summary
    }
}

enum StateLevel: String, CaseIterable, Codable, Identifiable {
    case steady = "Steady"
    case mixed = "Mixed"
    case low = "Low"
    case needsRest = "Needs Rest"

    var id: String { rawValue }

    static func level(for score: Int) -> StateLevel {
        switch score {
        case 80...100: return .steady
        case 60..<80: return .mixed
        case 40..<60: return .low
        default: return .needsRest
        }
    }
}

extension StateAssessment {
    static let mock = MockSampleData.todayAssessment
    static let mockLow = MockSampleData.lowEnergyAssessment
}

struct WatchDashboardDisplayModel: Equatable {
    let score: Int
    let stateLabel: String
    let confidenceText: String
    let updatedText: String
    let metrics: [WatchMetricSummary]
    let suggestion: String
    let dataSourceText: String

    init(assessment: StateAssessment = .mock) {
        score = min(100, max(0, assessment.overallScore))
        stateLabel = assessment.level.rawValue
        confidenceText = Self.confidenceText(for: assessment.confidence)
        updatedText = "Demo data"
        metrics = [
            WatchMetricSummary(id: "recovery", title: "Recovery", score: 68),
            WatchMetricSummary(id: "sleep", title: "Sleep", score: 81),
            WatchMetricSummary(id: "stressFatigue", title: "Fatigue Context", score: 64),
            WatchMetricSummary(id: "activityLoad", title: "Activity Load", score: 75)
        ]
        suggestion = "Consider a lighter day if that matches how you feel."
        dataSourceText = "Mock data only"
    }

    var searchableText: String {
        (
            [stateLabel, confidenceText, updatedText, suggestion, dataSourceText]
                + metrics.flatMap { [$0.title, "\($0.score)"] }
        ).joined(separator: " ")
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

struct WatchMetricSummary: Identifiable, Equatable {
    let id: String
    let title: String
    let score: Int
}
