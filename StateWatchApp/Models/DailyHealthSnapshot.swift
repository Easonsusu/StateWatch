import Foundation

struct DailyHealthSnapshot: Identifiable, Codable, Equatable {
    let id: UUID
    let date: Date
    let restingHeartRate: Double?
    let averageHeartRate: Double?
    let heartRateVariability: Double?
    let sleepDurationHours: Double?
    let activeEnergyKcal: Double?
    let exerciseMinutes: Double?
    let standHours: Double?
    let stepCount: Double?
    let mindfulMinutes: Double?
    let checkIn: UserCheckIn?

    init(
        id: UUID = UUID(),
        date: Date,
        restingHeartRate: Double? = nil,
        averageHeartRate: Double? = nil,
        heartRateVariability: Double? = nil,
        sleepDurationHours: Double? = nil,
        activeEnergyKcal: Double? = nil,
        exerciseMinutes: Double? = nil,
        standHours: Double? = nil,
        stepCount: Double? = nil,
        mindfulMinutes: Double? = nil,
        checkIn: UserCheckIn? = nil
    ) {
        self.id = id
        self.date = date
        self.restingHeartRate = restingHeartRate
        self.averageHeartRate = averageHeartRate
        self.heartRateVariability = heartRateVariability
        self.sleepDurationHours = sleepDurationHours
        self.activeEnergyKcal = activeEnergyKcal
        self.exerciseMinutes = exerciseMinutes
        self.standHours = standHours
        self.stepCount = stepCount
        self.mindfulMinutes = mindfulMinutes
        self.checkIn = checkIn
    }

    var availableMetrics: [HealthMetricType] {
        HealthMetricType.allCases.filter { value(for: $0) != nil }
    }

    func value(for metric: HealthMetricType) -> Double? {
        switch metric {
        case .restingHeartRate: return restingHeartRate
        case .averageHeartRate: return averageHeartRate
        case .heartRateVariability: return heartRateVariability
        case .sleepDuration: return sleepDurationHours
        case .activeEnergy: return activeEnergyKcal
        case .exerciseMinutes: return exerciseMinutes
        case .standHours: return standHours
        case .steps: return stepCount
        case .mindfulMinutes: return mindfulMinutes
        }
    }

    // TODO: Connect these local-only values to baseline and scoring after HealthKit fetching is manually validated.
}

extension DailyHealthSnapshot {
    static let mockToday = MockSampleData.todaySnapshot
    static let mockWeek = MockSampleData.weeklySnapshots
    static let mockPartial = MockSampleData.partialSnapshot
}
