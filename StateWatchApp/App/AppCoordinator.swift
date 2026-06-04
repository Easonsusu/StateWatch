import Foundation
import Combine

final class AppCoordinator: ObservableObject {
    @Published var currentAssessment: StateAssessment = .mock

    // TODO: Wire onboarding state and HealthKit authorization flow.
}
