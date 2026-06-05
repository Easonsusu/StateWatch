import Foundation

struct MockHealthDataFetcher: HealthDataFetcher {
    func fetchTodaySnapshot() async -> DailyHealthSnapshot {
        MockSampleData.todaySnapshot
    }

    func fetchRecentSnapshots(days: Int) async -> [DailyHealthSnapshot] {
        Array(MockSampleData.weeklySnapshots.prefix(max(0, days)))
    }

    // TODO: Preserve mock fixtures for previews, tests, denied permissions, and unavailable HealthKit states.
}
