import Foundation
#if canImport(HealthKit)
import HealthKit
#endif

protocol HealthDataFetcher {
    func fetchTodaySnapshot() async -> DailyHealthSnapshot
    func fetchRecentSnapshots(days: Int) async -> [DailyHealthSnapshot]
}

struct HealthKitDailyQuantitySample: Equatable {
    let startDate: Date
    let value: Double
}

struct HealthKitDailyIntervalSample: Equatable {
    let startDate: Date
    let endDate: Date
}

struct HealthKitDailyMetricAccumulator: Equatable {
    var heartRateValues: [Double] = []
    var restingHeartRateValues: [Double] = []
    var hrvSDNNValues: [Double] = []
    var sleepSeconds: TimeInterval = 0
    var steps: Double = 0
    var activeEnergyKcal: Double = 0
    var workoutSeconds: TimeInterval = 0
}

enum HealthKitDailyAggregator {
    static func snapshots(
        heartRates: [HealthKitDailyQuantitySample],
        restingHeartRates: [HealthKitDailyQuantitySample],
        hrvSDNN: [HealthKitDailyQuantitySample],
        sleepIntervals: [HealthKitDailyIntervalSample],
        stepCounts: [HealthKitDailyQuantitySample],
        activeEnergy: [HealthKitDailyQuantitySample],
        workoutIntervals: [HealthKitDailyIntervalSample],
        days: Int,
        endingAt now: Date,
        calendar: Calendar
    ) -> [DailyHealthSnapshot] {
        var buckets = emptyBuckets(days: days, endingAt: now, calendar: calendar)

        addAverageSamples(heartRates, to: &buckets, calendar: calendar) { $0.heartRateValues.append($1) }
        addAverageSamples(restingHeartRates, to: &buckets, calendar: calendar) { $0.restingHeartRateValues.append($1) }
        addAverageSamples(hrvSDNN, to: &buckets, calendar: calendar) { $0.hrvSDNNValues.append($1) }
        addSumSamples(stepCounts, to: &buckets, calendar: calendar) { $0.steps += $1 }
        addSumSamples(activeEnergy, to: &buckets, calendar: calendar) { $0.activeEnergyKcal += $1 }
        addIntervalSamples(sleepIntervals, to: &buckets, calendar: calendar) { $0.sleepSeconds += $1 }
        addIntervalSamples(workoutIntervals, to: &buckets, calendar: calendar) { $0.workoutSeconds += $1 }

        return buckets.keys.sorted().map { day in
            let values = buckets[day] ?? HealthKitDailyMetricAccumulator()
            return DailyHealthSnapshot(
                date: day,
                restingHeartRate: average(values.restingHeartRateValues),
                averageHeartRate: average(values.heartRateValues),
                heartRateVariability: average(values.hrvSDNNValues),
                sleepDurationHours: optionalHours(fromSeconds: values.sleepSeconds),
                activeEnergyKcal: optionalPositive(values.activeEnergyKcal),
                exerciseMinutes: optionalMinutes(fromSeconds: values.workoutSeconds),
                stepCount: optionalPositive(values.steps)
            )
        }
    }

    static func emptyBuckets(days: Int, endingAt now: Date, calendar: Calendar) -> [Date: HealthKitDailyMetricAccumulator] {
        let safeDays = max(days, 1)
        let today = calendar.startOfDay(for: now)
        let firstDay = calendar.date(byAdding: .day, value: -(safeDays - 1), to: today) ?? today

        return (0..<safeDays).reduce(into: [:]) { buckets, offset in
            let day = calendar.date(byAdding: .day, value: offset, to: firstDay) ?? firstDay
            buckets[day] = HealthKitDailyMetricAccumulator()
        }
    }

    static func startDate(days: Int, endingAt now: Date, calendar: Calendar) -> Date {
        let safeDays = max(days, 1)
        let today = calendar.startOfDay(for: now)
        return calendar.date(byAdding: .day, value: -(safeDays - 1), to: today) ?? today
    }

    static func sleepHours(fromSeconds seconds: TimeInterval) -> Double {
        seconds / 3_600
    }

    static func workoutMinutes(fromSeconds seconds: TimeInterval) -> Double {
        seconds / 60
    }

    private static func addAverageSamples(
        _ samples: [HealthKitDailyQuantitySample],
        to buckets: inout [Date: HealthKitDailyMetricAccumulator],
        calendar: Calendar,
        append: (inout HealthKitDailyMetricAccumulator, Double) -> Void
    ) {
        for sample in samples {
            let day = calendar.startOfDay(for: sample.startDate)
            guard var accumulator = buckets[day] else { continue }
            append(&accumulator, sample.value)
            buckets[day] = accumulator
        }
    }

    private static func addSumSamples(
        _ samples: [HealthKitDailyQuantitySample],
        to buckets: inout [Date: HealthKitDailyMetricAccumulator],
        calendar: Calendar,
        add: (inout HealthKitDailyMetricAccumulator, Double) -> Void
    ) {
        for sample in samples where sample.value > 0 {
            let day = calendar.startOfDay(for: sample.startDate)
            guard var accumulator = buckets[day] else { continue }
            add(&accumulator, sample.value)
            buckets[day] = accumulator
        }
    }

    private static func addIntervalSamples(
        _ samples: [HealthKitDailyIntervalSample],
        to buckets: inout [Date: HealthKitDailyMetricAccumulator],
        calendar: Calendar,
        add: (inout HealthKitDailyMetricAccumulator, TimeInterval) -> Void
    ) {
        for sample in samples {
            for segment in splitByDay(sample, calendar: calendar) {
                guard var accumulator = buckets[segment.day] else { continue }
                add(&accumulator, segment.seconds)
                buckets[segment.day] = accumulator
            }
        }
    }

    private static func splitByDay(
        _ sample: HealthKitDailyIntervalSample,
        calendar: Calendar
    ) -> [(day: Date, seconds: TimeInterval)] {
        guard sample.endDate > sample.startDate else { return [] }

        var segments: [(day: Date, seconds: TimeInterval)] = []
        var cursor = sample.startDate

        while cursor < sample.endDate {
            let day = calendar.startOfDay(for: cursor)
            let nextDay = calendar.date(byAdding: .day, value: 1, to: day) ?? sample.endDate
            let segmentEnd = min(sample.endDate, nextDay)
            let seconds = segmentEnd.timeIntervalSince(cursor)

            if seconds > 0 {
                segments.append((day: day, seconds: seconds))
            }

            cursor = segmentEnd
        }

        return segments
    }

    private static func average(_ values: [Double]) -> Double? {
        guard !values.isEmpty else { return nil }
        return values.reduce(0, +) / Double(values.count)
    }

    private static func optionalPositive(_ value: Double) -> Double? {
        value > 0 ? value : nil
    }

    private static func optionalHours(fromSeconds seconds: TimeInterval) -> Double? {
        seconds > 0 ? sleepHours(fromSeconds: seconds) : nil
    }

    private static func optionalMinutes(fromSeconds seconds: TimeInterval) -> Double? {
        seconds > 0 ? workoutMinutes(fromSeconds: seconds) : nil
    }
}

struct HealthKitDataFetcher: HealthDataFetcher {
    static let defaultLookbackDays = 30

    private let calendar: Calendar
    private let now: () -> Date

    #if canImport(HealthKit)
    private let healthStore: HKHealthStore

    init(
        healthStore: HKHealthStore = HKHealthStore(),
        calendar: Calendar = .current,
        now: @escaping () -> Date = Date.init
    ) {
        self.healthStore = healthStore
        self.calendar = calendar
        self.now = now
    }
    #else
    init(
        calendar: Calendar = .current,
        now: @escaping () -> Date = Date.init
    ) {
        self.calendar = calendar
        self.now = now
    }
    #endif

    func fetchTodaySnapshot() async -> DailyHealthSnapshot {
        await fetchRecentSnapshots(days: 1).last ?? DailyHealthSnapshot(date: calendar.startOfDay(for: now()))
    }

    func fetchRecentSnapshots(days: Int = defaultLookbackDays) async -> [DailyHealthSnapshot] {
        #if canImport(HealthKit)
        guard HKHealthStore.isHealthDataAvailable() else {
            return HealthKitDailyAggregator.snapshots(
                heartRates: [],
                restingHeartRates: [],
                hrvSDNN: [],
                sleepIntervals: [],
                stepCounts: [],
                activeEnergy: [],
                workoutIntervals: [],
                days: days,
                endingAt: now(),
                calendar: calendar
            )
        }

        let currentDate = now()
        let startDate = HealthKitDailyAggregator.startDate(days: days, endingAt: currentDate, calendar: calendar)

        async let heartRates = fetchQuantitySamples(
            identifier: .heartRate,
            unit: HKUnit.count().unitDivided(by: .minute()),
            startDate: startDate,
            endDate: currentDate
        )
        async let restingHeartRates = fetchQuantitySamples(
            identifier: .restingHeartRate,
            unit: HKUnit.count().unitDivided(by: .minute()),
            startDate: startDate,
            endDate: currentDate
        )
        async let hrvSDNN = fetchQuantitySamples(
            identifier: .heartRateVariabilitySDNN,
            unit: HKUnit.secondUnit(with: .milli),
            startDate: startDate,
            endDate: currentDate
        )
        async let sleepIntervals = fetchSleepIntervals(startDate: startDate, endDate: currentDate)
        async let stepCounts = fetchQuantitySamples(
            identifier: .stepCount,
            unit: .count(),
            startDate: startDate,
            endDate: currentDate
        )
        async let activeEnergy = fetchQuantitySamples(
            identifier: .activeEnergyBurned,
            unit: .kilocalorie(),
            startDate: startDate,
            endDate: currentDate
        )
        async let workoutIntervals = fetchWorkoutIntervals(startDate: startDate, endDate: currentDate)

        let fetchedHeartRates = await heartRates
        let fetchedRestingHeartRates = await restingHeartRates
        let fetchedHRV = await hrvSDNN
        let fetchedSleepIntervals = await sleepIntervals
        let fetchedStepCounts = await stepCounts
        let fetchedActiveEnergy = await activeEnergy
        let fetchedWorkoutIntervals = await workoutIntervals

        return HealthKitDailyAggregator.snapshots(
            heartRates: fetchedHeartRates,
            restingHeartRates: fetchedRestingHeartRates,
            hrvSDNN: fetchedHRV,
            sleepIntervals: fetchedSleepIntervals,
            stepCounts: fetchedStepCounts,
            activeEnergy: fetchedActiveEnergy,
            workoutIntervals: fetchedWorkoutIntervals,
            days: days,
            endingAt: currentDate,
            calendar: calendar
        )
        #else
        return HealthKitDailyAggregator.snapshots(
            heartRates: [],
            restingHeartRates: [],
            hrvSDNN: [],
            sleepIntervals: [],
            stepCounts: [],
            activeEnergy: [],
            workoutIntervals: [],
            days: days,
            endingAt: now(),
            calendar: calendar
        )
        #endif
    }

    #if canImport(HealthKit)
    private func fetchQuantitySamples(
        identifier: HKQuantityTypeIdentifier,
        unit: HKUnit,
        startDate: Date,
        endDate: Date
    ) async -> [HealthKitDailyQuantitySample] {
        guard let quantityType = HKObjectType.quantityType(forIdentifier: identifier) else {
            return []
        }

        do {
            let samples = try await fetchSamples(of: quantityType, startDate: startDate, endDate: endDate)
            return samples.compactMap { sample in
                guard let quantitySample = sample as? HKQuantitySample else { return nil }
                let value = quantitySample.quantity.doubleValue(for: unit)
                return HealthKitDailyQuantitySample(startDate: quantitySample.startDate, value: value)
            }
        } catch {
            // Missing or denied HealthKit data should leave optional snapshot fields nil.
            return []
        }
    }

    private func fetchSleepIntervals(startDate: Date, endDate: Date) async -> [HealthKitDailyIntervalSample] {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            return []
        }

        do {
            let samples = try await fetchSamples(of: sleepType, startDate: startDate, endDate: endDate)
            return samples.compactMap { sample in
                guard let categorySample = sample as? HKCategorySample,
                      isAsleepValue(categorySample.value)
                else {
                    return nil
                }

                return HealthKitDailyIntervalSample(startDate: categorySample.startDate, endDate: categorySample.endDate)
            }
        } catch {
            return []
        }
    }

    private func fetchWorkoutIntervals(startDate: Date, endDate: Date) async -> [HealthKitDailyIntervalSample] {
        do {
            let samples = try await fetchSamples(of: HKObjectType.workoutType(), startDate: startDate, endDate: endDate)
            return samples.compactMap { sample in
                guard let workout = sample as? HKWorkout else { return nil }
                return HealthKitDailyIntervalSample(startDate: workout.startDate, endDate: workout.endDate)
            }
        } catch {
            return []
        }
    }

    private func fetchSamples(
        of sampleType: HKSampleType,
        startDate: Date,
        endDate: Date
    ) async throws -> [HKSample] {
        let predicate = HKQuery.predicateForSamples(
            withStart: startDate,
            end: endDate,
            options: []
        )
        let sortDescriptors = [
            NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)
        ]

        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: sampleType,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: sortDescriptors
            ) { _, samples, error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: samples ?? [])
                }
            }

            healthStore.execute(query)
        }
    }

    private func isAsleepValue(_ value: Int) -> Bool {
        guard let sleepValue = HKCategoryValueSleepAnalysis(rawValue: value) else {
            return false
        }

        switch sleepValue {
        case .asleepUnspecified, .asleepCore, .asleepDeep, .asleepREM:
            return true
        default:
            return false
        }
    }
    #endif
}
