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
}
