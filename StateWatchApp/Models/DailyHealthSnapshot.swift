import Foundation

struct DailyHealthSnapshot: Identifiable, Equatable {
    let id: UUID
    let date: Date
    let restingHeartRate: Double?
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
        self.heartRateVariability = heartRateVariability
        self.sleepDurationHours = sleepDurationHours
        self.activeEnergyKcal = activeEnergyKcal
        self.exerciseMinutes = exerciseMinutes
        self.standHours = standHours
        self.stepCount = stepCount
        self.mindfulMinutes = mindfulMinutes
        self.checkIn = checkIn
    }
}

extension DailyHealthSnapshot {
    static let mockToday = DailyHealthSnapshot(
        date: .now,
        restingHeartRate: 58,
        heartRateVariability: 62,
        sleepDurationHours: 7.4,
        activeEnergyKcal: 520,
        exerciseMinutes: 38,
        standHours: 10,
        stepCount: 8200,
        mindfulMinutes: 6,
        checkIn: .mock
    )

    static let mockWeek: [DailyHealthSnapshot] = (0..<7).map { offset in
        DailyHealthSnapshot(
            date: Calendar.current.date(byAdding: .day, value: -offset, to: .now) ?? .now,
            restingHeartRate: 58 + Double(offset % 3),
            heartRateVariability: 62 - Double(offset * 2),
            sleepDurationHours: 7.4 - Double(offset % 2) * 0.6,
            activeEnergyKcal: 480 + Double(offset * 20),
            exerciseMinutes: 30 + Double(offset % 4) * 5,
            standHours: 9 + Double(offset % 3),
            stepCount: 7000 + Double(offset * 350),
            mindfulMinutes: Double(offset % 2) * 5,
            checkIn: offset == 0 ? .mock : nil
        )
    }
}
