import SwiftUI
import WidgetKit

struct StateWatchWidgetView: Widget {
    let kind = "StateWatchWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Text("Readiness \(entry.score)")
        }
        .configurationDisplayName("StateWatch Readiness")
        .description("Shows today's wellness readiness estimate.")
    }
}

private struct Entry: TimelineEntry {
    let date: Date
    let score: Int
}

private struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> Entry {
        Entry(date: Date(), score: 76)
    }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        completion(Entry(date: Date(), score: 76))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let entry = Entry(date: Date(), score: 76)
        let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60 * 30)))
        completion(timeline)
    }
}
