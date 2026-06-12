import SwiftUI
import WidgetKit

struct StateWatchComplication: Widget {
    private let kind = "StateWatchComplication"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: StateWatchComplicationProvider()) { entry in
            StateWatchComplicationView(entry: entry)
        }
        .configurationDisplayName("StateWatch")
        .description("Shows a static mock wellness summary.")
        .supportedFamilies([
            .accessoryCircular,
            .accessoryRectangular,
            .accessoryInline,
            .accessoryCorner
        ])
    }
}

struct StateWatchComplicationView: View {
    @Environment(\.widgetFamily) private var family

    let entry: StateWatchComplicationEntry

    var body: some View {
        switch family {
        case .accessoryCircular:
            circularView
                .containerBackground(for: .widget) {
                    Color.stateWatchBackground
                }
        case .accessoryRectangular:
            rectangularView
                .containerBackground(for: .widget) {
                    Color.stateWatchBackground
                }
        case .accessoryInline:
            Text(entry.summary.inlineText)
        case .accessoryCorner:
            cornerView
                .containerBackground(for: .widget) {
                    Color.stateWatchBackground
                }
        default:
            circularView
                .containerBackground(for: .widget) {
                    Color.stateWatchBackground
                }
        }
    }

    private var circularView: some View {
        Gauge(value: Double(entry.summary.score), in: 0...100) {
            Text("SW")
        } currentValueLabel: {
            Text("\(entry.summary.score)")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.stateWatchPrimary)
                .minimumScaleFactor(0.7)
        } minimumValueLabel: {
            Text(entry.summary.circularLabel)
                .font(.system(size: 8, weight: .medium, design: .rounded))
                .foregroundStyle(Color.stateWatchSecondary)
        } maximumValueLabel: {
            EmptyView()
        }
        .gaugeStyle(.accessoryCircularCapacity)
        .tint(Color.stateWatchAccent)
    }

    private var rectangularView: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("StateWatch")
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundStyle(Color.stateWatchSecondary)

            Text(entry.summary.rectangularTitle)
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.stateWatchPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            Text(entry.summary.shortSuggestion)
                .font(.system(size: 10, weight: .regular, design: .rounded))
                .foregroundStyle(Color.stateWatchSecondary)
                .lineLimit(1)
        }
    }

    private var cornerView: some View {
        Gauge(value: Double(entry.summary.score), in: 0...100) {
            Text("State")
        } currentValueLabel: {
            Text("\(entry.summary.score)")
                .font(.system(size: 11, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.stateWatchPrimary)
        }
        .gaugeStyle(.accessoryCircularCapacity)
        .tint(Color.stateWatchAccent)
    }
}

private extension Color {
    static let stateWatchBackground = Color(red: 0.03, green: 0.04, blue: 0.07)
    static let stateWatchPrimary = Color(red: 0.96, green: 0.97, blue: 1.0)
    static let stateWatchSecondary = Color(red: 0.67, green: 0.72, blue: 0.80)
    static let stateWatchAccent = Color(red: 0.21, green: 0.91, blue: 1.0)
}
