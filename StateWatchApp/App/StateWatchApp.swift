import SwiftUI

@main
struct StateWatchApp: App {
    @StateObject private var coordinator = AppCoordinator()

    init() {
        SharedReadinessStore().saveMockSummary()
    }

    var body: some Scene {
        WindowGroup {
            coordinator.rootView
        }
    }
}
