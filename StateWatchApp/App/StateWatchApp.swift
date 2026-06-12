import SwiftUI

@main
struct StateWatchApp: App {
    @StateObject private var coordinator = AppCoordinator()

    init() {
        MockDashboardSharedStatePublisher().publish()
    }

    var body: some Scene {
        WindowGroup {
            coordinator.rootView
        }
    }
}
