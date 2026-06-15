import Foundation

enum MockSampleData {
    static let todayCheckIn = UserCheckIn(
        id: stableUUID("10000000-0000-0000-0000-000000000001"),
        date: date(daysFromToday: 0),
        mood: .neutral,
        fatigue: .medium,
        perceivedStress: .medium,
        note: "Busy morning, planning a steadier afternoon."
    )

    static let todaySnapshot = DailyHealthSnapshot(
        id: stableUUID("20000000-0000-0000-0000-000000000001"),
        date: date(daysFromToday: 0),
        restingHeartRate: 58,
        averageHeartRate: 74,
        heartRateVariability: 62,
        sleepDurationHours: 7.4,
        activeEnergyKcal: 520,
        exerciseMinutes: 38,
        standHours: 10,
        stepCount: 8_200,
        mindfulMinutes: 6,
        checkIn: todayCheckIn
    )

    static let partialSnapshot = DailyHealthSnapshot(
        id: stableUUID("20000000-0000-0000-0000-000000000002"),
        date: date(daysFromToday: 0),
        sleepDurationHours: 6.8,
        stepCount: 4_100,
        checkIn: nil
    )

    static let weeklySnapshots: [DailyHealthSnapshot] = [
        todaySnapshot,
        DailyHealthSnapshot(
            id: stableUUID("20000000-0000-0000-0000-000000000003"),
            date: date(daysFromToday: -1),
            restingHeartRate: 60,
            averageHeartRate: 76,
            heartRateVariability: 55,
            sleepDurationHours: 6.9,
            activeEnergyKcal: 610,
            exerciseMinutes: 45,
            standHours: 11,
            stepCount: 9_100,
            mindfulMinutes: 0
        ),
        DailyHealthSnapshot(
            id: stableUUID("20000000-0000-0000-0000-000000000004"),
            date: date(daysFromToday: -2),
            restingHeartRate: 57,
            averageHeartRate: 72,
            heartRateVariability: 65,
            sleepDurationHours: 7.7,
            activeEnergyKcal: 430,
            exerciseMinutes: 24,
            standHours: 9,
            stepCount: 6_900,
            mindfulMinutes: 8
        ),
        DailyHealthSnapshot(
            id: stableUUID("20000000-0000-0000-0000-000000000005"),
            date: date(daysFromToday: -3),
            restingHeartRate: 59,
            averageHeartRate: 73,
            heartRateVariability: 60,
            sleepDurationHours: 7.2,
            activeEnergyKcal: 510,
            exerciseMinutes: 32,
            standHours: 10,
            stepCount: 8_000,
            mindfulMinutes: 4
        ),
        DailyHealthSnapshot(
            id: stableUUID("20000000-0000-0000-0000-000000000006"),
            date: date(daysFromToday: -4),
            restingHeartRate: 61,
            averageHeartRate: 82,
            heartRateVariability: 52,
            sleepDurationHours: 6.5,
            activeEnergyKcal: 760,
            exerciseMinutes: 58,
            standHours: 12,
            stepCount: 10_400,
            mindfulMinutes: 0
        ),
        DailyHealthSnapshot(
            id: stableUUID("20000000-0000-0000-0000-000000000007"),
            date: date(daysFromToday: -5),
            restingHeartRate: 58,
            averageHeartRate: 71,
            heartRateVariability: 61,
            sleepDurationHours: 7.5,
            activeEnergyKcal: 470,
            exerciseMinutes: 28,
            standHours: 9,
            stepCount: 7_500,
            mindfulMinutes: 10
        ),
        DailyHealthSnapshot(
            id: stableUUID("20000000-0000-0000-0000-000000000008"),
            date: date(daysFromToday: -6),
            restingHeartRate: 59,
            averageHeartRate: 75,
            heartRateVariability: 57,
            sleepDurationHours: 7.0,
            activeEnergyKcal: 540,
            exerciseMinutes: 36,
            standHours: 10,
            stepCount: 8_300,
            mindfulMinutes: 5
        )
    ]

    static let baseline = HealthBaseline(
        restingHeartRateAverage: 59,
        heartRateVariabilityAverage: 58,
        sleepDurationAverage: 7.2,
        activeEnergyAverage: 540,
        sampleCount: 14
    )

    static let todayAssessment = StateAssessment(
        id: stableUUID("30000000-0000-0000-0000-000000000001"),
        date: todaySnapshot.date,
        overallScore: 76,
        level: .mixed,
        recovery: ScoreComponent(id: "recovery", title: "Recovery", score: 78, summary: "Recovery signals look generally steady today."),
        sleep: ScoreComponent(id: "sleep", title: "Sleep", score: 82, summary: "Sleep duration is close to your recent pattern."),
        stressFatigue: ScoreComponent(id: "stressFatigue", title: "Fatigue Context", score: 68, summary: "A few signals may suggest taking the day a little easier."),
        activityLoad: ScoreComponent(id: "activityLoad", title: "Activity Load", score: 74, summary: "Recent activity looks moderate."),
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

    static let lowEnergyAssessment = StateAssessment(
        id: stableUUID("30000000-0000-0000-0000-000000000002"),
        date: partialSnapshot.date,
        overallScore: 52,
        level: .low,
        recovery: ScoreComponent(id: "recovery", title: "Recovery", score: 48, summary: "Some recovery signals are below the mock baseline."),
        sleep: ScoreComponent(id: "sleep", title: "Sleep", score: 58, summary: "Sleep duration is a bit shorter than the mock baseline."),
        stressFatigue: ScoreComponent(id: "stressFatigue", title: "Fatigue Context", score: 50, summary: "Available signals may support a gentler day."),
        activityLoad: ScoreComponent(id: "activityLoad", title: "Activity Load", score: 62, summary: "Activity load is moderate in the mock data."),
        reasons: [
            "Several mock signals are below the recent baseline.",
            "Optional health data may be missing, so this reflection has lower confidence."
        ],
        suggestions: [
            "Consider a lighter plan if that matches how you feel.",
            "A short check-in can add context to the available signals."
        ]
    )

    // TODO: Replace these deterministic samples with local HealthKit-backed snapshots after target setup.

    private static let calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? .current
        return calendar
    }()

    private static let baseDate = calendar.date(from: DateComponents(year: 2026, month: 6, day: 4, hour: 9)) ?? Date(timeIntervalSince1970: 1_780_560_000)

    private static func date(daysFromToday offset: Int) -> Date {
        calendar.date(byAdding: .day, value: offset, to: baseDate) ?? baseDate
    }

    private static func stableUUID(_ value: String) -> UUID {
        UUID(uuidString: value) ?? UUID()
    }
}
