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
    private let healthKitFetcher: HealthDataFetcher
    private let fallbackFetcher: HealthDataFetcher

    init(
        authorizationService: HealthKitAuthorizing = HealthKitAuthorizationService(),
        fetcher: HealthDataFetcher = HealthKitDataFetcher(),
        fallbackFetcher: HealthDataFetcher = MockHealthDataFetcher(),
        initialAuthorizationResult: HealthKitAuthorizationResult = .notDetermined
    ) {
        self.authorizationService = authorizationService
        self.healthKitFetcher = fetcher
        self.fallbackFetcher = fallbackFetcher
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
        // TODO: Connect fetched snapshots to baseline and scoring in the next phase.
        await activeFetcher.fetchTodaySnapshot()
    }

    func recentSnapshots(days: Int = HealthKitDataFetcher.defaultLookbackDays) async -> [DailyHealthSnapshot] {
        // TODO: Feed these local-only snapshots into baseline and scoring in the next phase.
        await activeFetcher.fetchRecentSnapshots(days: days)
    }

    var shouldUseMockData: Bool {
        authorizationState != .readAccessRequested
    }

    private var activeFetcher: HealthDataFetcher {
        shouldUseMockData ? fallbackFetcher : healthKitFetcher
    }

    var statusTitle: String {
        switch authorizationState {
        case .notDetermined:
            return String(localized: "Health Access Not Requested")
        case .unavailable:
            return String(localized: "Health Data Unavailable")
        case .deniedOrLimited:
            return String(localized: "Health Access Limited")
        case .readAccessRequested:
            return String(localized: "Health Access Requested")
        }
    }

    var statusMessage: String {
        switch authorizationState {
        case .notDetermined:
            return String(localized: "StateWatch can request read-only Apple Health access or continue with mock data.")
        case .unavailable:
            return lastErrorMessage ?? String(localized: "Health data is not available in this environment. Mock data remains available.")
        case .deniedOrLimited:
            return lastErrorMessage ?? String(localized: "Some health access may be denied or limited. StateWatch can continue with mock data and optional values.")
        case .readAccessRequested:
            return String(localized: "The HealthKit request completed. Future local fetchers will use only data available on this device.")
        }
    }

    static var previewReadAccessRequested: HealthKitManager {
        HealthKitManager(
            authorizationService: MockHealthKitAuthorizationService(requestResult: .mockReadAccessRequested),
            fetcher: MockHealthDataFetcher(),
            initialAuthorizationResult: .mockReadAccessRequested
        )
    }

    static var previewDenied: HealthKitManager {
        HealthKitManager(
            authorizationService: MockHealthKitAuthorizationService(requestResult: .mockDenied),
            fetcher: MockHealthDataFetcher(),
            initialAuthorizationResult: .mockDenied
        )
    }

    static var previewUnavailable: HealthKitManager {
        let unavailable = HealthKitAuthorizationResult.unavailable(reason: "HealthKit is unavailable in this preview.")
        return HealthKitManager(
            authorizationService: MockHealthKitAuthorizationService(requestResult: unavailable),
            fetcher: MockHealthDataFetcher(),
            initialAuthorizationResult: unavailable
        )
    }

    private func apply(_ result: HealthKitAuthorizationResult) {
        permissionStatuses = result.statuses
        lastErrorMessage = result.errorMessage

        if !result.isHealthDataAvailable {
            authorizationState = .unavailable
        } else if result.statuses.contains(where: { $0.access == .deniedOrLimited }) || result.errorMessage != nil {
            authorizationState = .deniedOrLimited
        } else if result.didRequestAuthorization {
            authorizationState = .readAccessRequested
        } else {
            authorizationState = .notDetermined
        }
    }
}
