import Foundation

struct MockHealthDataFetcher: HealthDataFetcher {
    func fetchTodaySnapshot() async -> DailyHealthSnapshot {
        DailyHealthSnapshot.mockToday
    }

    func fetchRecentSnapshots(days: Int) async -> [DailyHealthSnapshot] {
        Array(DailyHealthSnapshot.mockWeek.prefix(max(0, days)))
    }
}
