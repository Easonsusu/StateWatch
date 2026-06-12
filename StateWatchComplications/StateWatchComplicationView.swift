import SwiftUI
import WidgetKit

struct StateWatchComplication: Widget {
    private let kind = "StateWatchComplication"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: StateWatchComplicationProvider()) { entry in
            StateWatchComplicationView(entry: entry)
        }
        .configurationDisplayName("StateWatch")
        .description("Shows a mock readiness summary.")
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
        case .accessoryRectangular:
            rectangularView
        case .accessoryInline:
            Text(entry.summary.inlineText)
        case .accessoryCorner:
            cornerView
        default:
            circularView
        }
    }

    private var circularView: some View {
        ZStack {
            Circle()
                .stroke(Color.stateWatchSecondary.opacity(0.28), lineWidth: 4)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.stateWatchAccent, lineWidth: 4)
                .rotationEffect(.degrees(-90))

            VStack(spacing: 0) {
                Text("\(entry.summary.score)")
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.stateWatchPrimary)
                    .minimumScaleFactor(0.7)

                Text(entry.summary.circularLabel)
                    .font(.system(size: 7, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.stateWatchSecondary)
                    .lineLimit(1)
            }
        }
        .padding(2)
        .background(Color.stateWatchBackground)
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
        .padding(.vertical, 2)
        .background(Color.stateWatchBackground)
    }

    private var cornerView: some View {
        Text("\(entry.summary.score)")
            .font(.system(size: 12, weight: .semibold, design: .rounded))
            .foregroundStyle(Color.stateWatchPrimary)
            .background(Color.stateWatchBackground)
    }

    private var progress: Double {
        min(max(Double(entry.summary.score) / 100.0, 0), 1)
    }
}

private extension Color {
    static let stateWatchBackground = Color(red: 0.03, green: 0.04, blue: 0.07)
    static let stateWatchPrimary = Color(red: 0.96, green: 0.97, blue: 1.0)
    static let stateWatchSecondary = Color(red: 0.67, green: 0.72, blue: 0.80)
    static let stateWatchAccent = Color(red: 0.21, green: 0.91, blue: 1.0)
}
