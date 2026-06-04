import Foundation

protocol HealthDataFetcher {
    func fetchTodaySnapshot() async throws -> DailyHealthSnapshot
}
