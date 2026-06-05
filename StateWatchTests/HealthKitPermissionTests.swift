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
}
