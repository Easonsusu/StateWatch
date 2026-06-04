import Foundation

protocol HealthDataFetcher {
    func fetchTodaySnapshot() async -> DailyHealthSnapshot
    func fetchRecentSnapshots(days: Int) async -> [DailyHealthSnapshot]
}
