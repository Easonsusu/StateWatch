#if canImport(WidgetKit)
import WidgetKit
import SwiftUI

struct StateWatchComplicationEntry: TimelineEntry {
    let date: Date
    let score: Int
    let level: String
}

struct StateWatchComplicationProvider: TimelineProvider {
    func placeholder(in context: Context) -> StateWatchComplicationEntry {
        StateWatchComplicationEntry(date: .now, score: 76, level: "Mixed")
    }

    func getSnapshot(in context: Context, completion: @escaping (StateWatchComplicationEntry) -> Void) {
        completion(placeholder(in: context))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<StateWatchComplicationEntry>) -> Void) {
        let entry = placeholder(in: context)
        completion(Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60 * 30))))
    }
}

struct StateWatchWidgetView: View {
    let entry: StateWatchComplicationEntry

    var body: some View {
        VStack(spacing: 2) {
            Text("\(entry.score)")
                .font(.headline.monospacedDigit())
            Text(entry.level)
                .font(.caption2)
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}
#endif
