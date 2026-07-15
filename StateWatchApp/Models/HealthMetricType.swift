import Foundation

enum HealthMetricType: String, CaseIterable, Codable, Identifiable, Equatable {
    case restingHeartRate
    case averageHeartRate
    case heartRateVariability
    case sleepDuration
    case activeEnergy
    case exerciseMinutes
    case standHours
    case steps
    case mindfulMinutes

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .restingHeartRate: return String(localized: "Resting Heart Rate")
        case .averageHeartRate: return String(localized: "Average Heart Rate")
        case .heartRateVariability: return String(localized: "Heart Rate Variability")
        case .sleepDuration: return String(localized: "Sleep Duration")
        case .activeEnergy: return String(localized: "Active Energy")
        case .exerciseMinutes: return String(localized: "Exercise Minutes")
        case .standHours: return String(localized: "Stand Hours")
        case .steps: return String(localized: "Steps")
        case .mindfulMinutes: return String(localized: "Mindful Minutes")
        }
    }

    var unitLabel: String {
        switch self {
        case .restingHeartRate, .averageHeartRate: return "bpm"
        case .heartRateVariability: return "ms"
        case .sleepDuration: return String(localized: "hr")
        case .activeEnergy: return String(localized: "kcal")
        case .exerciseMinutes, .mindfulMinutes: return String(localized: "min")
        case .standHours: return String(localized: "hr")
        case .steps: return String(localized: "steps")
        }
    }

    var wellnessArea: String {
        switch self {
        case .restingHeartRate, .heartRateVariability: return String(localized: "Recovery")
        case .averageHeartRate: return String(localized: "Activity Load")
        case .sleepDuration: return String(localized: "Sleep")
        case .activeEnergy, .exerciseMinutes, .standHours, .steps: return String(localized: "Activity Load")
        case .mindfulMinutes: return String(localized: "Fatigue Context")
        }
    }
}
