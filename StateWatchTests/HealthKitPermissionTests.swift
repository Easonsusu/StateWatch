import XCTest
@testable import StateWatchApp

final class HealthKitPermissionTests: XCTestCase {
    func testReadPermissionIDsMatchMVPHealthKitScope() {
        let permissionIDs = HealthKitTypes.readPermissions.map(\.id)

        XCTAssertEqual(permissionIDs, [
            .heartRate,
            .restingHeartRate,
            .heartRateVariabilitySDNN,
            .sleepAnalysis,
            .stepCount,
            .activeEnergyBurned,
            .workouts
        ])
    }

    func testReadPermissionsHaveUserFacingWellnessReasons() {
        for permission in HealthKitTypes.readPermissions {
            XCTAssertFalse(permission.displayName.isEmpty)
            XCTAssertFalse(permission.wellnessReason.isEmpty)
            XCTAssertFalse(permission.exampleUse.isEmpty)
        }
    }

    func testMockAuthorizationResultsRepresentRequestedAndDeniedFlows() {
        let requested = HealthKitAuthorizationResult.mockReadAccessRequested
        let denied = HealthKitAuthorizationResult.mockDenied

        XCTAssertTrue(requested.isHealthDataAvailable)
        XCTAssertTrue(requested.didRequestAuthorization)
        XCTAssertTrue(requested.statuses.allSatisfy { $0.access == .requestCompleted })

        XCTAssertTrue(denied.isHealthDataAvailable)
        XCTAssertFalse(denied.didRequestAuthorization)
        XCTAssertTrue(denied.statuses.allSatisfy { $0.access == .deniedOrLimited })
        XCTAssertNotNil(denied.errorMessage)
    }

    func testUnavailableAuthorizationResultMarksEveryPermissionUnavailable() {
        let result = HealthKitAuthorizationResult.unavailable(reason: "Health data is not available on this device.")

        XCTAssertFalse(result.isHealthDataAvailable)
        XCTAssertFalse(result.didRequestAuthorization)
        XCTAssertEqual(result.errorMessage, "Health data is not available on this device.")
        XCTAssertEqual(result.statuses.count, HealthKitTypes.readPermissions.count)
        XCTAssertTrue(result.statuses.allSatisfy { $0.access == .unavailable })
    }

    func testFailedAuthorizationResultDoesNotGrantReadAccess() {
        let result = HealthKitAuthorizationResult.failed(
            errorMessage: "Health access could not be requested. StateWatch can continue with mock data."
        )

        XCTAssertTrue(result.isHealthDataAvailable)
        XCTAssertFalse(result.didRequestAuthorization)
        XCTAssertEqual(result.errorMessage, "Health access could not be requested. StateWatch can continue with mock data.")
        XCTAssertTrue(result.statuses.allSatisfy { $0.access == .unknown })
    }

    @MainActor
    func testManagerUsesFallbackFetcherWhenAuthorizationIsDenied() async {
        let healthCounter = FetchCallCounter()
        let fallbackCounter = FetchCallCounter()
        let healthSnapshot = snapshot(day: 1, stepCount: 9_000)
        let fallbackSnapshot = snapshot(day: 2, stepCount: 3_200)
        let manager = HealthKitManager(
            authorizationService: MockHealthKitAuthorizationService(requestResult: .mockDenied),
            fetcher: RecordingHealthDataFetcher(
                todaySnapshot: healthSnapshot,
                recentSnapshots: [healthSnapshot],
                counter: healthCounter
            ),
            fallbackFetcher: RecordingHealthDataFetcher(
                todaySnapshot: fallbackSnapshot,
                recentSnapshots: [fallbackSnapshot],
                counter: fallbackCounter
            ),
            initialAuthorizationResult: .mockDenied
        )

        let today = await manager.todaySnapshot()
        let recent = await manager.recentSnapshots(days: 5)
        let healthTodayCalls = await healthCounter.todayCalls
        let healthRecentCalls = await healthCounter.recentCalls
        let fallbackTodayCalls = await fallbackCounter.todayCalls
        let fallbackRecentCalls = await fallbackCounter.recentCalls
        let fallbackRecentDays = await fallbackCounter.recentDays

        XCTAssertEqual(manager.authorizationState, .deniedOrLimited)
        XCTAssertTrue(manager.shouldUseMockData)
        XCTAssertEqual(today, fallbackSnapshot)
        XCTAssertEqual(recent, [fallbackSnapshot])
        XCTAssertEqual(healthTodayCalls, 0)
        XCTAssertEqual(healthRecentCalls, 0)
        XCTAssertEqual(fallbackTodayCalls, 1)
        XCTAssertEqual(fallbackRecentCalls, 1)
        XCTAssertEqual(fallbackRecentDays, [5])
    }

    @MainActor
    func testManagerUsesHealthFetcherOnlyAfterReadAccessRequestCompletes() async {
        let healthCounter = FetchCallCounter()
        let fallbackCounter = FetchCallCounter()
        let healthSnapshot = snapshot(day: 3, stepCount: 8_100)
        let fallbackSnapshot = snapshot(day: 4, stepCount: 2_400)
        let manager = HealthKitManager(
            authorizationService: MockHealthKitAuthorizationService(requestResult: .mockReadAccessRequested),
            fetcher: RecordingHealthDataFetcher(
                todaySnapshot: healthSnapshot,
                recentSnapshots: [healthSnapshot],
                counter: healthCounter
            ),
            fallbackFetcher: RecordingHealthDataFetcher(
                todaySnapshot: fallbackSnapshot,
                recentSnapshots: [fallbackSnapshot],
                counter: fallbackCounter
            ),
            initialAuthorizationResult: .notDetermined
        )

        await manager.requestAuthorization()
        let today = await manager.todaySnapshot()
        let healthTodayCalls = await healthCounter.todayCalls
        let fallbackTodayCalls = await fallbackCounter.todayCalls

        XCTAssertEqual(manager.authorizationState, .readAccessRequested)
        XCTAssertFalse(manager.shouldUseMockData)
        XCTAssertEqual(today, healthSnapshot)
        XCTAssertEqual(healthTodayCalls, 1)
        XCTAssertEqual(fallbackTodayCalls, 0)
    }

    func testDailyAggregatorGroupsHeartRateSamplesByCalendarDay() {
        let snapshots = HealthKitDailyAggregator.snapshots(
            heartRates: [
                HealthKitDailyQuantitySample(startDate: date(year: 2026, month: 1, day: 1, hour: 9), value: 70),
                HealthKitDailyQuantitySample(startDate: date(year: 2026, month: 1, day: 1, hour: 10), value: 90),
                HealthKitDailyQuantitySample(startDate: date(year: 2026, month: 1, day: 2, hour: 8), value: 80)
            ],
            restingHeartRates: [],
            hrvSDNN: [],
            sleepIntervals: [],
            stepCounts: [],
            activeEnergy: [],
            workoutIntervals: [],
            days: 3,
            endingAt: date(year: 2026, month: 1, day: 3, hour: 12),
            calendar: testCalendar
        )

        XCTAssertEqual(snapshots.count, 3)
        XCTAssertEqual(snapshots[0].date, testCalendar.startOfDay(for: date(year: 2026, month: 1, day: 1)))
        XCTAssertEqual(snapshots[0].averageHeartRate, 80)
        XCTAssertEqual(snapshots[1].averageHeartRate, 80)
        XCTAssertNil(snapshots[2].averageHeartRate)
    }

    func testDailyAggregatorConvertsSleepSecondsToHoursAndSplitsAcrossMidnight() {
        let snapshots = HealthKitDailyAggregator.snapshots(
            heartRates: [],
            restingHeartRates: [],
            hrvSDNN: [],
            sleepIntervals: [
                HealthKitDailyIntervalSample(
                    startDate: date(year: 2026, month: 1, day: 1, hour: 23),
                    endDate: date(year: 2026, month: 1, day: 2, hour: 1)
                )
            ],
            stepCounts: [],
            activeEnergy: [],
            workoutIntervals: [],
            days: 2,
            endingAt: date(year: 2026, month: 1, day: 2, hour: 12),
            calendar: testCalendar
        )

        XCTAssertEqual(HealthKitDailyAggregator.sleepHours(fromSeconds: 7_200), 2)
        XCTAssertEqual(snapshots[0].sleepDurationHours ?? 0, 1, accuracy: 0.001)
        XCTAssertEqual(snapshots[1].sleepDurationHours ?? 0, 1, accuracy: 0.001)
    }

    func testDailyAggregatorSumsStepsActiveEnergyAndWorkoutMinutes() {
        let snapshots = HealthKitDailyAggregator.snapshots(
            heartRates: [],
            restingHeartRates: [],
            hrvSDNN: [],
            sleepIntervals: [],
            stepCounts: [
                HealthKitDailyQuantitySample(startDate: date(year: 2026, month: 1, day: 4, hour: 8), value: 1_200),
                HealthKitDailyQuantitySample(startDate: date(year: 2026, month: 1, day: 4, hour: 18), value: 2_300)
            ],
            activeEnergy: [
                HealthKitDailyQuantitySample(startDate: date(year: 2026, month: 1, day: 4, hour: 18), value: 340)
            ],
            workoutIntervals: [
                HealthKitDailyIntervalSample(
                    startDate: date(year: 2026, month: 1, day: 4, hour: 7),
                    endDate: date(year: 2026, month: 1, day: 4, hour: 7, minute: 45)
                )
            ],
            days: 1,
            endingAt: date(year: 2026, month: 1, day: 4, hour: 20),
            calendar: testCalendar
        )

        XCTAssertEqual(snapshots[0].stepCount, 3_500)
        XCTAssertEqual(snapshots[0].activeEnergyKcal, 340)
        XCTAssertEqual(snapshots[0].exerciseMinutes ?? 0, 45, accuracy: 0.001)
    }

    func testDailyAggregatorLeavesMissingMetricsNil() {
        let snapshots = HealthKitDailyAggregator.snapshots(
            heartRates: [],
            restingHeartRates: [],
            hrvSDNN: [],
            sleepIntervals: [],
            stepCounts: [],
            activeEnergy: [],
            workoutIntervals: [],
            days: 2,
            endingAt: date(year: 2026, month: 1, day: 2, hour: 12),
            calendar: testCalendar
        )

        XCTAssertEqual(snapshots.count, 2)
        for snapshot in snapshots {
            XCTAssertNil(snapshot.restingHeartRate)
            XCTAssertNil(snapshot.averageHeartRate)
            XCTAssertNil(snapshot.heartRateVariability)
            XCTAssertNil(snapshot.sleepDurationHours)
            XCTAssertNil(snapshot.stepCount)
            XCTAssertNil(snapshot.activeEnergyKcal)
            XCTAssertNil(snapshot.exerciseMinutes)
        }
    }

    private var testCalendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? .current
        return calendar
    }

    private func date(
        year: Int,
        month: Int,
        day: Int,
        hour: Int = 0,
        minute: Int = 0
    ) -> Date {
        let components = DateComponents(
            timeZone: testCalendar.timeZone,
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute: minute
        )
        return testCalendar.date(from: components) ?? Date(timeIntervalSince1970: 0)
    }

    private func snapshot(day: Int, stepCount: Double) -> DailyHealthSnapshot {
        DailyHealthSnapshot(
            id: UUID(uuidString: "00000000-0000-0000-0000-\(String(format: "%012d", day))") ?? UUID(),
            date: date(year: 2026, month: 1, day: day),
            stepCount: stepCount
        )
    }
}

private actor FetchCallCounter {
    private(set) var todayCalls = 0
    private(set) var recentCalls = 0
    private(set) var recentDays: [Int] = []

    func recordToday() {
        todayCalls += 1
    }

    func recordRecent(days: Int) {
        recentCalls += 1
        recentDays.append(days)
    }
}

private struct RecordingHealthDataFetcher: HealthDataFetcher {
    let todaySnapshot: DailyHealthSnapshot
    let recentSnapshots: [DailyHealthSnapshot]
    let counter: FetchCallCounter

    func fetchTodaySnapshot() async -> DailyHealthSnapshot {
        await counter.recordToday()
        return todaySnapshot
    }

    func fetchRecentSnapshots(days: Int) async -> [DailyHealthSnapshot] {
        await counter.recordRecent(days: days)
        return recentSnapshots
    }
}
