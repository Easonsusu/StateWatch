import WidgetKit

struct StateWatchComplicationEntry: TimelineEntry {
    let date: Date
    let summary: ComplicationStateSummary
}

struct StateWatchComplicationProvider: TimelineProvider {
    func placeholder(in context: Context) -> StateWatchComplicationEntry {
        mockEntry()
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (StateWatchComplicationEntry) -> Void
    ) {
        completion(mockEntry())
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<StateWatchComplicationEntry>) -> Void
    ) {
        // TODO: Replace this static mock timeline only after a local shared-state design is approved.
        let entry = mockEntry()
        let nextRefresh = Calendar.current.date(byAdding: .hour, value: 6, to: entry.date) ?? entry.date
        completion(Timeline(entries: [entry], policy: .after(nextRefresh)))
    }

    private func mockEntry() -> StateWatchComplicationEntry {
        StateWatchComplicationEntry(date: Date(), summary: .mock)
    }
}
