import Foundation
#if canImport(HealthKit)
import HealthKit
#endif

protocol HealthKitAuthorizing {
    func requestReadAuthorization() async -> HealthKitAuthorizationResult
    func currentAuthorizationStatus() -> HealthKitAuthorizationResult
}

struct HealthKitAuthorizationService: HealthKitAuthorizing {
    #if canImport(HealthKit)
    private let healthStore: HKHealthStore

    init(healthStore: HKHealthStore = HKHealthStore()) {
        self.healthStore = healthStore
    }
    #else
    init() {}
    #endif

    func requestReadAuthorization() async -> HealthKitAuthorizationResult {
        #if canImport(HealthKit)
        guard HKHealthStore.isHealthDataAvailable() else {
            return .unavailable(reason: String(localized: "Health data is not available on this device."))
        }

        let readTypes = HealthKitTypes.readTypes
        guard !readTypes.isEmpty else {
            return .unavailable(reason: String(localized: "No HealthKit read types are configured yet."))
        }

        do {
            let didCompleteRequest = try await requestAuthorization(readTypes: readTypes)
            guard didCompleteRequest else {
                return HealthKitAuthorizationResult(
                    isHealthDataAvailable: true,
                    didRequestAuthorization: false,
                    statuses: HealthKitTypes.permissionStatuses(access: .unknown),
                    errorMessage: String(localized: "Health access was not completed. StateWatch can continue with mock data.")
                )
            }

            // HealthKit does not expose exact read permission status after a request.
            // Future HealthKit fetchers must treat missing samples as optional data, not as a wellness conclusion.
            return .requestCompleted()
        } catch {
            return .failed(
                errorMessage: String.localizedStringWithFormat(
                    String(localized: "Health access could not be requested. StateWatch can continue with mock data. %@"),
                    error.localizedDescription
                )
            )
        }
        #else
        return .unavailable(reason: String(localized: "HealthKit is not available in this build environment."))
        #endif
    }

    func currentAuthorizationStatus() -> HealthKitAuthorizationResult {
        #if canImport(HealthKit)
        guard HKHealthStore.isHealthDataAvailable() else {
            return .unavailable(reason: String(localized: "Health data is not available on this device."))
        }

        // Apple does not provide a reliable per-type read authorization status.
        // Keep the UI graceful and let the future local fetch layer handle empty or missing data.
        return .notDetermined
        #else
        return .unavailable(reason: String(localized: "HealthKit is not available in this build environment."))
        #endif
    }

    #if canImport(HealthKit)
    private func requestAuthorization(readTypes: Set<HKObjectType>) async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            healthStore.requestAuthorization(toShare: Set<HKSampleType>(), read: readTypes) { success, error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: success)
                }
            }
        }
    }
    #endif
}

struct MockHealthKitAuthorizationService: HealthKitAuthorizing {
    let requestResult: HealthKitAuthorizationResult
    let statusResult: HealthKitAuthorizationResult

    init(
        requestResult: HealthKitAuthorizationResult = .mockReadAccessRequested,
        statusResult: HealthKitAuthorizationResult? = nil
    ) {
        self.requestResult = requestResult
        self.statusResult = statusResult ?? requestResult
    }

    func requestReadAuthorization() async -> HealthKitAuthorizationResult {
        requestResult
    }

    func currentAuthorizationStatus() -> HealthKitAuthorizationResult {
        statusResult
    }
}
