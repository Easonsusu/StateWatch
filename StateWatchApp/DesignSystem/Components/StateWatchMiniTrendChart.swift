import SwiftUI

struct StateWatchMiniTrendChart: View {
    let values: [Double]
    let accentColor: Color

    var body: some View {
        let normalized = Self.normalizedValues(values)

        Group {
            if normalized.isEmpty {
                emptyState
            } else {
                GeometryReader { proxy in
                    chartPath(in: proxy.size, values: normalized)
                        .stroke(accentColor, style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                        .shadow(color: accentColor.opacity(0.22), radius: 8, x: 0, y: 0)
                }
                .frame(height: 72)
                .accessibilityLabel("Seven day trend")
                .accessibilityValue("\(normalized.count) values")
            }
        }
    }

    static func normalizedValues(_ values: [Double]) -> [Double] {
        let finiteValues = values.filter { $0.isFinite }
        guard !finiteValues.isEmpty else { return [] }

        guard let minValue = finiteValues.min(), let maxValue = finiteValues.max() else {
            return []
        }

        let range = maxValue - minValue
        guard range > .ulpOfOne else {
            return Array(repeating: 0.5, count: finiteValues.count)
        }

        return finiteValues.map { ($0 - minValue) / range }
    }

    private var emptyState: some View {
        RoundedRectangle(cornerRadius: StateWatchRadius.medium, style: .continuous)
            .fill(StateWatchColors.panel.opacity(0.5))
            .overlay {
                Text("No trend data")
                    .font(StateWatchTypography.caption)
                    .foregroundStyle(StateWatchColors.textMuted)
            }
            .frame(height: 72)
            .accessibilityLabel("No trend data available")
    }

    private func chartPath(in size: CGSize, values: [Double]) -> Path {
        Path { path in
            guard values.count > 1 else {
                let y = size.height * (1 - CGFloat(values.first ?? 0.5))
                path.move(to: CGPoint(x: 0, y: y))
                path.addLine(to: CGPoint(x: size.width, y: y))
                return
            }

            for (index, value) in values.enumerated() {
                let x = size.width * CGFloat(index) / CGFloat(values.count - 1)
                let y = size.height * (1 - CGFloat(value))
                let point = CGPoint(x: x, y: y)

                if index == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
        }
    }
}

#Preview("Mini Trend Chart") {
    ZStack {
        StateWatchColors.backgroundPrimary.ignoresSafeArea()
        VStack(spacing: StateWatchSpacing.xl) {
            StateWatchGlassCard {
                StateWatchMiniTrendChart(
                    values: [62, 67, 64, 72, 70, 76, 74],
                    accentColor: StateWatchColors.accentCyan
                )
            }

            StateWatchGlassCard {
                StateWatchMiniTrendChart(values: [], accentColor: StateWatchColors.textMuted)
            }
        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
