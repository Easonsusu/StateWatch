import Combine
import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject {
    enum LaunchState: Equatable {
        case onboarding
        case dashboard
    }

    @Published private(set) var launchState: LaunchState

    private let onboardingCompletionStore: OnboardingCompletionStoring

    init(
        onboardingCompletionStore: OnboardingCompletionStoring = UserDefaultsOnboardingCompletionStore()
    ) {
        self.onboardingCompletionStore = onboardingCompletionStore
        launchState = onboardingCompletionStore.hasCompletedOnboarding ? .dashboard : .onboarding
    }

    func completeOnboarding() {
        onboardingCompletionStore.markOnboardingCompleted()
        launchState = .dashboard
    }

    @ViewBuilder
    var rootView: some View {
        switch launchState {
        case .onboarding:
            OnboardingView(onFinish: { [weak self] in
                self?.completeOnboarding()
            })
        case .dashboard:
            DashboardView()
        }
    }

    // TODO: Replace the mock dashboard with a locally generated StateAssessment after HealthKit wiring.
}
