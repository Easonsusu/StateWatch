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
        case .restingHeartRate: return "Resting Heart Rate"
        case .averageHeartRate: return "Average Heart Rate"
        case .heartRateVariability: return "Heart Rate Variability"
        case .sleepDuration: return "Sleep Duration"
        case .activeEnergy: return "Active Energy"
        case .exerciseMinutes: return "Exercise Minutes"
        case .standHours: return "Stand Hours"
        case .steps: return "Steps"
        case .mindfulMinutes: return "Mindful Minutes"
        }
    }

    var unitLabel: String {
        switch self {
        case .restingHeartRate, .averageHeartRate: return "bpm"
        case .heartRateVariability: return "ms"
        case .sleepDuration: return "hr"
        case .activeEnergy: return "kcal"
        case .exerciseMinutes, .mindfulMinutes: return "min"
        case .standHours: return "hr"
        case .steps: return "steps"
        }
    }

    var wellnessArea: String {
        switch self {
        case .restingHeartRate, .heartRateVariability: return "Recovery"
        case .averageHeartRate: return "Activity Load"
        case .sleepDuration: return "Sleep"
        case .activeEnergy, .exerciseMinutes, .standHours, .steps: return "Activity Load"
        case .mindfulMinutes: return "Fatigue Context"
        }
    }
}
