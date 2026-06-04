import Foundation
#if canImport(HealthKit)
import HealthKit
#endif

struct HealthKitAuthorizationService {
    func requestReadAuthorization() async throws -> Bool {
        #if canImport(HealthKit)
        // TODO: Define the minimum read-only HealthKit types and request authorization.
        // Do not request write access for the MVP unless a future feature explicitly needs it.
        // Do not upload HealthKit data to any server.
        return HKHealthStore.isHealthDataAvailable()
        #else
        return false
        #endif
    }
}
