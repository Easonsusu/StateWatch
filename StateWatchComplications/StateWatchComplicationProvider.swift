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
        // TODO: Replace this mock-only timeline after production shared-state rollout is approved.
        let entry = mockEntry()
        let nextRefresh = Calendar.current.date(byAdding: .hour, value: 6, to: entry.date) ?? entry.date
        completion(Timeline(entries: [entry], policy: .after(nextRefresh)))
    }

    private func mockEntry() -> StateWatchComplicationEntry {
        let sharedSummary = SharedReadinessStore().load()
        let complicationSummary: ComplicationStateSummary
        if let sharedSummary, !sharedSummary.isStale() {
            complicationSummary = ComplicationStateSummary(sharedSummary: sharedSummary)
        } else {
            complicationSummary = .mock
        }

        return StateWatchComplicationEntry(
            date: Date(),
            summary: complicationSummary
        )
    }
}
