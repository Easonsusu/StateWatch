import Foundation

protocol OnboardingCompletionStoring {
    var hasCompletedOnboarding: Bool { get }

    func markOnboardingCompleted()
}

struct UserDefaultsOnboardingCompletionStore: OnboardingCompletionStoring {
    static let storageKey = "statewatch.onboarding.completed.v1"

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    var hasCompletedOnboarding: Bool {
        defaults.bool(forKey: Self.storageKey)
    }

    func markOnboardingCompleted() {
        defaults.set(true, forKey: Self.storageKey)
    }
}
