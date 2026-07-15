import Foundation

struct StressFatigueScoreEngine {
    func score(
        snapshot: DailyHealthSnapshot,
        baseline: HealthBaseline,
        recentSnapshots: [DailyHealthSnapshot] = []
    ) -> ScoreComponent {
        var score = 74
        var confidences: [ScoreConfidence] = []
        var usedSignals = 0

        if snapshot.checkIn?.fatigue == .high { score -= 12 }
        if snapshot.checkIn?.perceivedStress == .high { score -= 10 }

        if let hrv = snapshot.heartRateVariability,
           let baselineHRV = baseline.heartRateVariabilityAverage {
            usedSignals += 1
            confidences.append(baseline.confidence(for: .heartRateVariability))
            if hrv < baselineHRV * 0.85 {
                score -= 10
            } else if hrv < baselineHRV * 0.92 {
                score -= 5
            }
        }

        if let rhr = snapshot.restingHeartRate,
           let baselineRHR = baseline.restingHeartRateAverage {
            usedSignals += 1
            confidences.append(baseline.confidence(for: .restingHeartRate))
            if rhr > baselineRHR * 1.1 {
                score -= 10
            } else if rhr > baselineRHR * 1.05 {
                score -= 5
            }
        }

        if let sleep = snapshot.sleepDurationHours,
           let baselineSleep = baseline.sleepDurationAverage {
            usedSignals += 1
            confidences.append(baseline.confidence(for: .sleepDuration))
            if sleep < baselineSleep - 1.25 {
                score -= 10
            } else if sleep < baselineSleep - 0.5 {
                score -= 5
            }
        }

        if let baselineExercise = baseline.exerciseMinutesAverage {
            let recentExercise = recentAverage(recentSnapshots, keyPath: \.exerciseMinutes) ?? snapshot.exerciseMinutes
            if let recentExercise {
                usedSignals += 1
                confidences.append(baseline.confidence(for: .exerciseMinutes))
                if recentExercise > baselineExercise * 1.5 {
                    score -= 6
                }
            }
        }

        let confidence = usedSignals == 0 && snapshot.checkIn == nil ? .unavailable : ScoreConfidence.combined(confidences + (snapshot.checkIn == nil ? [] : [.medium]))
        let summary: String
        switch confidence {
        case .high, .medium:
            summary = String(localized: "Fatigue context reflects recent wearable trends and your check-in when available.")
        case .low:
            summary = String(localized: "Fatigue context uses limited data, so this remains a softer wellness estimate.")
        case .unavailable:
            summary = String(localized: "Fatigue context is limited today because key signals are unavailable.")
        }

        return ScoreComponent(
            title: String(localized: "Fatigue Context"),
            score: clamp(score),
            confidence: confidence,
            summary: summary
        )
    }

    private func clamp(_ value: Int) -> Int {
        min(100, max(0, value))
    }

    private func recentAverage(_ snapshots: [DailyHealthSnapshot], keyPath: KeyPath<DailyHealthSnapshot, Double?>) -> Double? {
        let values = snapshots.suffix(3).compactMap { $0[keyPath: keyPath] }
        guard !values.isEmpty else { return nil }
        return values.reduce(0, +) / Double(values.count)
    }
}
