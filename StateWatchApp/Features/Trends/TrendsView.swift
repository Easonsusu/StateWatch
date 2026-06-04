import SwiftUI

struct TrendsView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Trends")
                .font(.title2)
            MetricChartView(title: "Sleep", points: [6.8, 7.1, 7.4, 7.0])
        }
        .padding()
    }
}

#Preview {
    TrendsView()
}
