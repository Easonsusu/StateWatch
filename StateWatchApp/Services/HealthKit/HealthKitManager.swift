import Combine
import Foundation

@MainActor
final class HealthKitManager: ObservableObject {
    enum AuthorizationState: Equatable {
        case notDetermined
        case unavailable
        case deniedOrLimited
        case readAccessRequested
    }

    @Published private(set) var authorizationState: AuthorizationState
    @Published private(set) var permissionStatuses: [HealthKitPermissionStatus]
    @Published private(set) var lastErrorMessage: String?

    private let authorizationService: HealthKitAuthorizing
    private let fetcher: HealthDataFetcher

    init(
        authorizationService: HealthKitAuthorizing = HealthKitAuthorizationService(),
        fetcher: HealthDataFetcher = MockHealthDataFetcher(),
        initialAuthorizationResult: HealthKitAuthorizationResult = .notDetermined
    ) {
        self.authorizationService = authorizationService
        self.fetcher = fetcher
        authorizationState = .notDetermined
        permissionStatuses = HealthKitTypes.permissionStatuses(access: .notDetermined)
        lastErrorMessage = nil
        apply(initialAuthorizationResult)
    }

    func requestAuthorization() async {
        let result = await authorizationService.requestReadAuthorization()
        apply(result)
    }

    func refreshAuthorizationStatus() {
        let result = authorizationService.currentAuthorizationStatus()
        apply(result)
    }

    func todaySnapshot() async -> DailyHealthSnapshot {
        // TODO: Connect this to local-only HealthKit fetching after permission-gated fetchers exist.
        await fetcher.fetchTodaySnapshot()
    }

    var shouldUseMockData: Bool {
        authorizationState != .readAccessRequested
    }

    var statusTitle: String {
        switch authorizationState {
        case .notDetermined:
            return "Health Access Not Requested"
        case .unavailable:
            return "Health Data Unavailable"
        case .deniedOrLimited:
            return "Health Access Limited"
        case .readAccessRequested:
            return "Health Access Requested"
        }
    }

    var statusMessage: String {
        switch authorizationState {
        case .notDetermined:
            return "StateWatch can request read-only Apple Health access or continue with mock data."
        case .unavailable:
            return lastErrorMessage ?? "Health data is not available in this environment. Mock data remains available."
        case .deniedOrLimited:
            return lastErrorMessage ?? "Some health access may be denied or limited. StateWatch can continue with mock data and optional values."
        case .readAccessRequested:
            return "The HealthKit request completed. Future local fetchers will use only data available on this device."
        }
    }

    static var previewReadAccessRequested: HealthKitManager {
        HealthKitManager(
            authorizationService: MockHealthKitAuthorizationService(requestResult: .mockReadAccessRequested),
            initialAuthorizationResult: .mockReadAccessRequested
        )
    }

    static var previewDenied: HealthKitManager {
        HealthKitManager(
            authorizationService: MockHealthKitAuthorizationService(requestResult: .mockDenied),
            initialAuthorizationResult: .mockDenied
        )
    }

    static var previewUnavailable: HealthKitManager {
        let unavailable = HealthKitAuthorizationResult.unavailable(reason: "HealthKit is unavailable in this preview.")
        return HealthKitManager(
            authorizationService: MockHealthKitAuthorizationService(requestResult: unavailable),
            initialAuthorizationResult: unavailable
        )
    }

    private func apply(_ result: HealthKitAuthorizationResult) {
        permissionStatuses = result.statuses
        lastErrorMessage = result.errorMessage

        if !result.isHealthDataAvailable {
            authorizationState = .unavailable
        } else if result.statuses.contains(where: { $0.access == .sharingDenied }) || result.errorMessage != nil {
            authorizationState = .deniedOrLimited
        } else if result.didRequestAuthorization {
            authorizationState = .readAccessRequested
        } else {
            authorizationState = .notDetermined
        }
    }
}
