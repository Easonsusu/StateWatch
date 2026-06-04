import Foundation

struct HealthKitManager {
    var authorizationService = HealthKitAuthorizationService()
    var fetcher: HealthDataFetcher = MockHealthDataFetcher()

    // TODO: Replace default mock fetcher with HealthKit-backed implementation.
}
