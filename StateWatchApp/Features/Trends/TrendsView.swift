import SwiftUI

struct TrendsView: View {
    private let snapshots = DailyHealthSnapshot.mockWeek.reversed()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Mock trends")
                    .font(.title.bold())
                MetricChartView(
                    title: String(localized: "Sleep Duration"),
                    values: snapshots.map { $0.sleepDurationHours ?? 0 },
                    unit: String(localized: "hr")
                )
                MetricChartView(
                    title: String(localized: "Active Energy"),
                    values: snapshots.map { $0.activeEnergyKcal ?? 0 },
                    unit: String(localized: "kcal")
                )
                Spacer()
            }
            .padding()
            .navigationTitle("Trends")
        }
    }
}

#Preview {
    TrendsView()
}
