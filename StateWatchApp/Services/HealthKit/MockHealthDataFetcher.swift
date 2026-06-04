import Foundation

struct MockHealthDataFetcher: HealthDataFetcher {
    func fetchTodaySnapshot() async throws -> DailyHealthSnapshot {
        .mock
    }
}
