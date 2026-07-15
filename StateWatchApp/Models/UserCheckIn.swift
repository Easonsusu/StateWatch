import Foundation

struct UserCheckIn: Identifiable, Codable, Equatable {
    enum Mood: String, CaseIterable, Codable, Identifiable {
        case low = "Low"
        case neutral = "Neutral"
        case good = "Good"

        var id: String { rawValue }

        var displayName: String {
            switch self {
            case .low: return String(localized: "Low")
            case .neutral: return String(localized: "Neutral")
            case .good: return String(localized: "Good")
            }
        }
    }

    enum Intensity: String, CaseIterable, Codable, Identifiable {
        case low = "Low"
        case medium = "Medium"
        case high = "High"

        var id: String { rawValue }

        var displayName: String {
            switch self {
            case .low: return String(localized: "Low")
            case .medium: return String(localized: "Medium")
            case .high: return String(localized: "High")
            }
        }
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

    var hasNote: Bool {
        !note.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    // TODO: Store check-ins locally and combine them with same-day HealthKit summaries.
}

extension UserCheckIn {
    static let mock = MockSampleData.todayCheckIn
}
