import Foundation
import SwiftUI

struct MetricChartView: View {
    let title: String
    let points: [Double]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Text("Data points: \(points.map { String(format: "%.1f", $0) }.joined(separator: ", "))")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    MetricChartView(title: "Recovery", points: [70, 74, 76, 73])
        .padding()
}
