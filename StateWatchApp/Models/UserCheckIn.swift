import Foundation

struct UserCheckIn: Identifiable, Equatable {
    enum Mood: String, CaseIterable {
        case low = "Low"
        case neutral = "Neutral"
        case good = "Good"
    }

    enum Intensity: String, CaseIterable {
        case low = "Low"
        case medium = "Medium"
        case high = "High"
    }

    let id: UUID
    let date: Date
    var mood: Mood
    var fatigue: Intensity
    var perceivedStress: Intensity
    var note: String

    init(
        id: UUID = UUID(),
        date: Date = .now,
        mood: Mood,
        fatigue: Intensity,
        perceivedStress: Intensity,
        note: String = ""
    ) {
        self.id = id
        self.date = date
        self.mood = mood
        self.fatigue = fatigue
        self.perceivedStress = perceivedStress
        self.note = note
    }
}

extension UserCheckIn {
    static let mock = UserCheckIn(
        mood: .neutral,
        fatigue: .medium,
        perceivedStress: .medium,
        note: "Felt okay after a busy morning."
    )
}
