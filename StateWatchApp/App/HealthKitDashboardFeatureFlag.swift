import Foundation

struct HealthKitDashboardFeatureFlag {
    static let storageKey = "statewatch.feature.healthkitDashboard.enabled"

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    var isEnabled: Bool {
        userDefaults.bool(forKey: Self.storageKey)
    }

    func setEnabled(_ enabled: Bool) {
        userDefaults.set(enabled, forKey: Self.storageKey)
    }

    func enable() {
        setEnabled(true)
    }

    func disable() {
        setEnabled(false)
    }

    func reset() {
        userDefaults.removeObject(forKey: Self.storageKey)
    }
}
