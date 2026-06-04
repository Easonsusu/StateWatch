import SwiftUI

@main
struct StateWatchApp: App {
    @StateObject private var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            coordinator.rootView
        }
    }
}
