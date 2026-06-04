import SwiftUI

struct MetricChartView: View {
    let title: String
    let values: [Double]
    let unit: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(.headline)
            HStack(alignment: .bottom, spacing: 6) {
                ForEach(Array(values.enumerated()), id: \.offset) { _, value in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.blue.opacity(0.75))
                        .frame(height: barHeight(for: value))
                }
            }
            .frame(height: 120)
            Text("Mock data, unit: \(unit)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private func barHeight(for value: Double) -> CGFloat {
        guard let maxValue = values.max(), maxValue > 0 else { return 4 }
        return max(4, CGFloat(value / maxValue) * 110)
    }
}

#Preview {
    MetricChartView(title: "Sleep", values: [6.5, 7.1, 7.4, 6.8], unit: "hr")
}
