import Foundation

enum HealthMetricType: String, CaseIterable, Codable {
    case recovery
    case sleep
    case stressFatigue
    case activityLoad
}
