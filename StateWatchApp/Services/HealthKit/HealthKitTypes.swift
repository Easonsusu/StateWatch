import Foundation
#if canImport(HealthKit)
import HealthKit
#endif

enum HealthKitPermissionID: String, CaseIterable, Codable, Identifiable, Equatable {
    case heartRate
    case restingHeartRate
    case heartRateVariabilitySDNN
    case sleepAnalysis
    case stepCount
    case activeEnergyBurned
    case workouts

    var id: String { rawValue }
}

struct HealthKitPermission: Identifiable, Codable, Equatable {
    let id: HealthKitPermissionID
    let displayName: String
    let wellnessReason: String
    let exampleUse: String
}

enum HealthKitPermissionAccess: String, Codable, Equatable {
    case notDetermined
    case requestCompleted
    case sharingDenied
    case sharingAuthorized
    case unavailable
    case unknown

    var displayName: String {
        switch self {
        case .notDetermined:
            return "Not Requested"
        case .requestCompleted:
            return "Requested"
        case .sharingDenied:
            return "Denied or Limited"
        case .sharingAuthorized:
            return "Available"
        case .unavailable:
            return "Unavailable"
        case .unknown:
            return "Unknown"
        }
    }
}

struct HealthKitPermissionStatus: Identifiable, Codable, Equatable {
    let permission: HealthKitPermission
    let access: HealthKitPermissionAccess

    var id: HealthKitPermissionID { permission.id }
}

struct HealthKitAuthorizationResult: Codable, Equatable {
    let isHealthDataAvailable: Bool
    let didRequestAuthorization: Bool
    let statuses: [HealthKitPermissionStatus]
    let errorMessage: String?

    static let notDetermined = HealthKitAuthorizationResult(
        isHealthDataAvailable: true,
        didRequestAuthorization: false,
        statuses: HealthKitTypes.permissionStatuses(access: .notDetermined),
        errorMessage: nil
    )

    static let mockReadAccessRequested = HealthKitAuthorizationResult(
        isHealthDataAvailable: true,
        didRequestAuthorization: true,
        statuses: HealthKitTypes.permissionStatuses(access: .requestCompleted),
        errorMessage: nil
    )

    static let mockDenied = HealthKitAuthorizationResult(
        isHealthDataAvailable: true,
        didRequestAuthorization: false,
        statuses: HealthKitTypes.permissionStatuses(access: .sharingDenied),
        errorMessage: "Health access is denied or limited. StateWatch can continue with mock data until access is changed in Settings."
    )

    static func unavailable(reason: String) -> HealthKitAuthorizationResult {
        HealthKitAuthorizationResult(
            isHealthDataAvailable: false,
            didRequestAuthorization: false,
            statuses: HealthKitTypes.permissionStatuses(access: .unavailable),
            errorMessage: reason
        )
    }

    static func requestCompleted() -> HealthKitAuthorizationResult {
        HealthKitAuthorizationResult(
            isHealthDataAvailable: true,
            didRequestAuthorization: true,
            statuses: HealthKitTypes.permissionStatuses(access: .requestCompleted),
            errorMessage: nil
        )
    }

    static func failed(errorMessage: String) -> HealthKitAuthorizationResult {
        HealthKitAuthorizationResult(
            isHealthDataAvailable: true,
            didRequestAuthorization: false,
            statuses: HealthKitTypes.permissionStatuses(access: .unknown),
            errorMessage: errorMessage
        )
    }
}

enum HealthKitTypes {
    static let readPermissions: [HealthKitPermission] = [
        HealthKitPermission(
            id: .heartRate,
            displayName: "Heart Rate",
            wellnessReason: "Helps describe daily effort and recovery context in cautious wellness terms.",
            exampleUse: "Shown as one signal in the daily state summary."
        ),
        HealthKitPermission(
            id: .restingHeartRate,
            displayName: "Resting Heart Rate",
            wellnessReason: "Helps compare today with a personal baseline when data is available.",
            exampleUse: "Used to explain when recovery may look lower than usual."
        ),
        HealthKitPermission(
            id: .heartRateVariabilitySDNN,
            displayName: "Heart Rate Variability",
            wellnessReason: "Supports a local wellness estimate of recovery and strain when available.",
            exampleUse: "Used as an optional signal, never as a diagnosis."
        ),
        HealthKitPermission(
            id: .sleepAnalysis,
            displayName: "Sleep Analysis",
            wellnessReason: "Helps summarize recent rest and consistency.",
            exampleUse: "Used for sleep score context and gentle suggestions."
        ),
        HealthKitPermission(
            id: .stepCount,
            displayName: "Step Count",
            wellnessReason: "Helps estimate daily activity load in a simple local model.",
            exampleUse: "Used to balance recovery suggestions with movement."
        ),
        HealthKitPermission(
            id: .activeEnergyBurned,
            displayName: "Active Energy",
            wellnessReason: "Helps describe physical effort for the day.",
            exampleUse: "Used with activity and recovery context when present."
        ),
        HealthKitPermission(
            id: .workouts,
            displayName: "Workouts",
            wellnessReason: "Helps account for structured activity without uploading workout details.",
            exampleUse: "Used to explain activity load and trend context."
        )
    ]

    static let infoPlistPrivacyNotes: [String] = [
        "Add NSHealthShareUsageDescription before enabling HealthKit in a real Xcode target.",
        "Do not add NSHealthUpdateUsageDescription for the MVP because StateWatch requests read access only.",
        "The share usage string should say Health data stays local and supports wellness summaries, not diagnosis."
    ]

    static func permissionStatuses(access: HealthKitPermissionAccess) -> [HealthKitPermissionStatus] {
        readPermissions.map { permission in
            HealthKitPermissionStatus(permission: permission, access: access)
        }
    }
}

#if canImport(HealthKit)
extension HealthKitPermissionID {
    var healthKitObjectType: HKObjectType? {
        switch self {
        case .heartRate:
            return HKObjectType.quantityType(forIdentifier: .heartRate)
        case .restingHeartRate:
            return HKObjectType.quantityType(forIdentifier: .restingHeartRate)
        case .heartRateVariabilitySDNN:
            return HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)
        case .sleepAnalysis:
            return HKObjectType.categoryType(forIdentifier: .sleepAnalysis)
        case .stepCount:
            return HKObjectType.quantityType(forIdentifier: .stepCount)
        case .activeEnergyBurned:
            return HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)
        case .workouts:
            return HKObjectType.workoutType()
        }
    }
}

extension HealthKitTypes {
    static var readTypes: Set<HKObjectType> {
        Set(readPermissions.compactMap { $0.id.healthKitObjectType })
    }
}
#endif
