import Foundation

struct MockHealthDataFetcher: HealthDataFetcher {
    func fetchTodaySnapshot() async -> DailyHealthSnapshot {
        MockSampleData.todaySnapshot
    }

    func fetchRecentSnapshots(days: Int) async -> [DailyHealthSnapshot] {
        Array(MockSampleData.weeklySnapshots.prefix(max(0, days)))
    }

    // TODO: Keep this mock-only until local HealthKit fetching is implemented.
}
