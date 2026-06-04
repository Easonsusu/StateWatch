import SwiftUI

final class AppCoordinator: ObservableObject {
    enum LaunchState {
        case onboarding
        case dashboard
    }

    @Published var launchState: LaunchState = .onboarding

    @ViewBuilder
    var rootView: some View {
        switch launchState {
        case .onboarding:
            OnboardingView(onFinish: { [weak self] in
                self?.launchState = .dashboard
            })
        case .dashboard:
            DashboardView(assessment: .mock)
        }
    }

    // TODO: Persist onboarding completion locally after the real app target exists.
}
