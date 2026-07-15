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
        suggestions.first ?? String(localized: "Check in with how you feel before adjusting your day.")
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

    var displayName: String {
        switch self {
        case .steady: return String(localized: "Steady")
        case .mixed: return String(localized: "Mixed")
        case .low: return String(localized: "Low")
        case .needsRest: return String(localized: "Needs Rest")
        }
    }

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
    let confidence: ScoreConfidence
    let confidenceText: String
    let updatedText: String
    let metrics: [WatchMetricSummary]
    let suggestion: String
    let dataSourceText: String
    let source: String
    let isMock: Bool

    init(assessment: StateAssessment = .mock) {
        score = min(100, max(0, assessment.overallScore))
        stateLabel = assessment.level.rawValue
        confidence = assessment.confidence
        confidenceText = Self.confidenceText(for: assessment.confidence)
        updatedText = "Demo"
        metrics = Self.staticMockMetrics
        suggestion = "Consider a lighter day if that matches how you feel."
        dataSourceText = "Mock data only"
        source = "static-watch-mock"
        isMock = true
    }

    init(sharedSummary: SharedReadinessSummary) {
        score = min(100, max(0, sharedSummary.score))
        stateLabel = sharedSummary.stateLabel
        confidence = Self.confidenceValue(for: sharedSummary.confidence)
        confidenceText = sharedSummary.confidence
        updatedText = sharedSummary.updatedText
        metrics = Self.staticMockMetrics
        suggestion = sharedSummary.shortSuggestion
        dataSourceText = "Mock data only"
        source = sharedSummary.source
        isMock = sharedSummary.isMock
    }

    static func sharedMockOrStaticFallback(
        store: SharedReadinessStore = SharedReadinessStore(),
        now: Date = Date(),
        maxAge: TimeInterval = 12 * 60 * 60
    ) -> WatchDashboardDisplayModel {
        sharedMockOrStaticFallback(
            summary: store.load(),
            now: now,
            maxAge: maxAge
        )
    }

    static func sharedMockOrStaticFallback(
        userDefaults: UserDefaults?,
        now: Date = Date(),
        maxAge: TimeInterval = 12 * 60 * 60
    ) -> WatchDashboardDisplayModel {
        sharedMockOrStaticFallback(
            store: SharedReadinessStore(userDefaults: userDefaults),
            now: now,
            maxAge: maxAge
        )
    }

    static func sharedMockOrStaticFallback(
        summary: SharedReadinessSummary?,
        now: Date = Date(),
        maxAge: TimeInterval = 12 * 60 * 60
    ) -> WatchDashboardDisplayModel {
        guard let summary,
              summary.isMock,
              !summary.isStale(relativeTo: now, maxAge: maxAge)
        else {
            return WatchDashboardDisplayModel(assessment: .mock)
        }

        return WatchDashboardDisplayModel(sharedSummary: summary)
    }

    var searchableText: String {
        (
            [stateLabel, confidenceText, updatedText, suggestion, dataSourceText, source, isMock ? "mock" : "summary"]
                + metrics.flatMap { [$0.title, "\($0.score)"] }
        ).joined(separator: " ")
    }

    private static let staticMockMetrics = [
        WatchMetricSummary(id: "recovery", title: "Recovery", score: 68),
        WatchMetricSummary(id: "sleep", title: "Sleep", score: 81),
        WatchMetricSummary(id: "stressFatigue", title: "Fatigue Context", score: 64),
        WatchMetricSummary(id: "activityLoad", title: "Activity Load", score: 75)
    ]

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

    private static func confidenceValue(for text: String) -> ScoreConfidence {
        switch text.lowercased() {
        case "high":
            return .high
        case "medium":
            return .medium
        case "low", "low data":
            return .low
        default:
            return .unavailable
        }
    }
}

struct WatchMetricSummary: Identifiable, Equatable {
    let id: String
    let title: String
    let score: Int
}
