import SwiftUI

@main
struct StateWatchWatchApp: App {
    var body: some Scene {
        WindowGroup {
            WatchDashboardView(displayModel: .sharedMockOrStaticFallback())
        }
    }
}
