import XCTest
@testable import StateWatchApp

final class AppCoordinatorOnboardingTests: XCTestCase {
    @MainActor
    func testFreshInstallStartsOnboarding() {
        let store = InMemoryOnboardingCompletionStore()
        let coordinator = AppCoordinator(onboardingCompletionStore: store)

        XCTAssertFalse(store.hasCompletedOnboarding)
        XCTAssertEqual(coordinator.launchState, .onboarding)
    }

    @MainActor
    func testCompletionTransitionsToDashboardAndStoresCompletion() {
        let store = InMemoryOnboardingCompletionStore()
        let coordinator = AppCoordinator(onboardingCompletionStore: store)

        coordinator.completeOnboarding()

        XCTAssertTrue(store.hasCompletedOnboarding)
        XCTAssertEqual(coordinator.launchState, .dashboard)
    }

    @MainActor
    func testCompletionPersistsAcrossCoordinatorRecreation() throws {
        let context = try makeIsolatedDefaultsContext()
        defer { context.defaults.removePersistentDomain(forName: context.suiteName) }

        let store = UserDefaultsOnboardingCompletionStore(defaults: context.defaults)
        let firstCoordinator = AppCoordinator(onboardingCompletionStore: store)
        firstCoordinator.completeOnboarding()

        let relaunchedCoordinator = AppCoordinator(
            onboardingCompletionStore: UserDefaultsOnboardingCompletionStore(defaults: context.defaults)
        )

        XCTAssertEqual(relaunchedCoordinator.launchState, .dashboard)
    }

    @MainActor
    func testExistingCompletionSkipsOnboarding() {
        let store = InMemoryOnboardingCompletionStore(hasCompletedOnboarding: true)
        let coordinator = AppCoordinator(onboardingCompletionStore: store)

        XCTAssertEqual(coordinator.launchState, .dashboard)
    }

    @MainActor
    func testCompletionIsIdempotentAndDoesNotRequireHealthKit() {
        let store = InMemoryOnboardingCompletionStore()
        let coordinator = AppCoordinator(onboardingCompletionStore: store)

        coordinator.completeOnboarding()
        coordinator.completeOnboarding()

        XCTAssertTrue(store.hasCompletedOnboarding)
        XCTAssertEqual(coordinator.launchState, .dashboard)
    }

    func testUserDefaultsStoreDefaultsToFalseAndPersistsTrue() throws {
        let context = try makeIsolatedDefaultsContext()
        defer { context.defaults.removePersistentDomain(forName: context.suiteName) }

        let store = UserDefaultsOnboardingCompletionStore(defaults: context.defaults)

        XCTAssertFalse(store.hasCompletedOnboarding)

        store.markOnboardingCompleted()

        XCTAssertTrue(store.hasCompletedOnboarding)
        XCTAssertTrue(context.defaults.bool(forKey: UserDefaultsOnboardingCompletionStore.storageKey))
    }

    private func makeIsolatedDefaultsContext() throws -> (suiteName: String, defaults: UserDefaults) {
        let suiteName = "StateWatchTests.OnboardingCompletion.\(UUID().uuidString)"
        let defaults = try XCTUnwrap(UserDefaults(suiteName: suiteName))
        defaults.removePersistentDomain(forName: suiteName)
        return (suiteName, defaults)
    }
}

private final class InMemoryOnboardingCompletionStore: OnboardingCompletionStoring {
    private(set) var hasCompletedOnboarding: Bool

    init(hasCompletedOnboarding: Bool = false) {
        self.hasCompletedOnboarding = hasCompletedOnboarding
    }

    func markOnboardingCompleted() {
        hasCompletedOnboarding = true
    }
}
