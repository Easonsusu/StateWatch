import Foundation

struct StateAssessment: Identifiable, Equatable {
    let id: UUID
    let date: Date
    let overallScore: Int
    let level: StateLevel
    let recovery: ScoreComponent
    let sleep: ScoreComponent
    let stressFatigue: ScoreComponent
    let activityLoad: ScoreComponent
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
        reasons: [String],
        suggestions: [String]
    ) {
        self.id = id
        self.date = date
        self.overallScore = overallScore
        self.level = level
        self.recovery = recovery
        self.sleep = sleep
        self.stressFatigue = stressFatigue
        self.activityLoad = activityLoad
        self.reasons = reasons
        self.suggestions = suggestions
    }
}

struct ScoreComponent: Equatable {
    let title: String
    let score: Int
    let summary: String
}

enum StateLevel: String, CaseIterable {
    case steady = "Steady"
    case mixed = "Mixed"
    case low = "Low"
    case needsRest = "Needs Rest"

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
    static let mock = StateAssessment(
        date: .now,
        overallScore: 76,
        level: .mixed,
        recovery: ScoreComponent(title: "Recovery", score: 78, summary: "Recovery signals look generally steady today."),
        sleep: ScoreComponent(title: "Sleep", score: 82, summary: "Sleep duration is close to your recent pattern."),
        stressFatigue: ScoreComponent(title: "Stress/Fatigue", score: 68, summary: "A few signals may suggest taking the day a little easier."),
        activityLoad: ScoreComponent(title: "Activity Load", score: 74, summary: "Recent activity looks moderate."),
        reasons: [
            "Sleep duration is near your recent baseline.",
            "Recovery signals are mixed but not sharply different from recent mock data.",
            "Your check-in adds useful context for today's wellness reflection."
        ],
        suggestions: [
            "Consider a lighter activity day if that matches how you feel.",
            "A consistent bedtime tonight may support recovery."
        ]
    )
}
