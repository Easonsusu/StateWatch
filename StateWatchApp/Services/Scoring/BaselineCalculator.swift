import Foundation

struct BaselineCalculator {
    private let calendar: Calendar

    init(calendar: Calendar = .current) {
        self.calendar = calendar
    }

    func calculate(from snapshots: [DailyHealthSnapshot], window: BaselineWindow = .sevenDays) -> HealthBaseline {
        let windowSnapshots = snapshotsInWindow(window, from: snapshots)
        guard !windowSnapshots.isEmpty else {
            return HealthBaseline(
                window: window,
                restingHeartRate: .unavailable,
                averageHeartRate: .unavailable,
                heartRateVariability: .unavailable,
                sleepDuration: .unavailable,
                activeEnergy: .unavailable,
                exerciseMinutes: .unavailable,
                stepCount: .unavailable,
                sampleCount: 0
            )
        }

        return HealthBaseline(
            window: window,
            restingHeartRate: .calculated(from: windowSnapshots.compactMap { $0.restingHeartRate }),
            averageHeartRate: .calculated(from: windowSnapshots.compactMap { $0.averageHeartRate }),
            heartRateVariability: .calculated(from: windowSnapshots.compactMap { $0.heartRateVariability }),
            sleepDuration: .calculated(from: windowSnapshots.compactMap { $0.sleepDurationHours }),
            activeEnergy: .calculated(from: windowSnapshots.compactMap { $0.activeEnergyKcal }),
            exerciseMinutes: .calculated(from: windowSnapshots.compactMap { $0.exerciseMinutes }),
            stepCount: .calculated(from: windowSnapshots.compactMap { $0.stepCount }),
            sampleCount: windowSnapshots.count
        )
    }

    func calculateAllWindows(from snapshots: [DailyHealthSnapshot]) -> [BaselineWindow: HealthBaseline] {
        BaselineWindow.allCases.reduce(into: [:]) { output, window in
            output[window] = calculate(from: snapshots, window: window)
        }
    }

    private func snapshotsInWindow(_ window: BaselineWindow, from snapshots: [DailyHealthSnapshot]) -> [DailyHealthSnapshot] {
        guard let latestDate = snapshots.map(\.date).max() else { return [] }

        let latestDay = calendar.startOfDay(for: latestDate)
        let firstIncludedDay = calendar.date(byAdding: .day, value: -(window.dayCount - 1), to: latestDay) ?? latestDay

        return snapshots
            .filter { snapshot in
                let day = calendar.startOfDay(for: snapshot.date)
                return day >= firstIncludedDay && day <= latestDay
            }
            .sorted { $0.date < $1.date }
    }
}
