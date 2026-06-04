import Combine
import Foundation

@MainActor
final class HealthKitManager: ObservableObject {
    enum AuthorizationState: Equatable {
        case notDetermined
        case unavailable
        case deniedOrLimited
        case authorized
    }

    @Published private(set) var authorizationState: AuthorizationState = .notDetermined

    private let authorizationService: HealthKitAuthorizationService
    private let fetcher: HealthDataFetcher

    init(
        authorizationService: HealthKitAuthorizationService = HealthKitAuthorizationService(),
        fetcher: HealthDataFetcher = MockHealthDataFetcher()
    ) {
        self.authorizationService = authorizationService
        self.fetcher = fetcher
    }

    func requestAuthorization() async {
        // TODO: Replace placeholder authorization with real HealthKit request flow.
        do {
            authorizationState = try await authorizationService.requestReadAuthorization() ? .authorized : .deniedOrLimited
        } catch {
            authorizationState = .unavailable
        }
    }

    func todaySnapshot() async -> DailyHealthSnapshot {
        // MVP rule: this must fetch local device data only once HealthKit is implemented.
        await fetcher.fetchTodaySnapshot()
    }
}
