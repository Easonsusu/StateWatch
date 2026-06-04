#if canImport(WidgetKit)
import WidgetKit
import SwiftUI

struct StateWatchComplicationBundle: WidgetBundle {
    var body: some Widget {
        StateWatchComplication()
    }
}

struct StateWatchComplication: Widget {
    let kind = "StateWatchComplication"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: StateWatchComplicationProvider()) { entry in
            StateWatchWidgetView(entry: entry)
        }
        .configurationDisplayName("StateWatch")
        .description("Shows a cautious daily wellness score from local app data.")
    }
}

// TODO: Move this bundle into a dedicated Widget Extension target and add @main there.
#endif
