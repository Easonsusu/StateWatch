import Foundation

struct SharedReadinessStore {
    static let appGroupIdentifier = "group.com.easonsusu.StateWatch"
    static let storageKey = "statewatch.shared.readiness.summary.v1"

    private let userDefaults: UserDefaults?

    init() {
        self.userDefaults = UserDefaults(suiteName: Self.appGroupIdentifier)
    }

    init(userDefaults: UserDefaults?) {
        self.userDefaults = userDefaults
    }

    @discardableResult
    func save(_ summary: SharedReadinessSummary) -> Bool {
        guard let userDefaults else {
            return false
        }

        do {
            let data = try JSONEncoder.stateWatchSharedState.encode(summary)
            userDefaults.set(data, forKey: Self.storageKey)
            return true
        } catch {
            return false
        }
    }

    @discardableResult
    func saveMockSummary(generatedAt: Date = Date()) -> Bool {
        save(.mock(generatedAt: generatedAt))
    }

    func load() -> SharedReadinessSummary? {
        guard let data = userDefaults?.data(forKey: Self.storageKey) else {
            return nil
        }

        return try? JSONDecoder.stateWatchSharedState.decode(SharedReadinessSummary.self, from: data)
    }

    func loadOrFallback(
        now: Date = Date(),
        maxAge: TimeInterval = 12 * 60 * 60
    ) -> SharedReadinessSummary {
        guard let summary = load(), !summary.isStale(relativeTo: now, maxAge: maxAge) else {
            return .mockFallback
        }

        return summary
    }
}
