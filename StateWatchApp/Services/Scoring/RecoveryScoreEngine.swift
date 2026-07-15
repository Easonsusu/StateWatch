import Foundation

struct RecoveryScoreEngine {
    func score(
        snapshot: DailyHealthSnapshot,
        baseline: HealthBaseline,
        recentSnapshots: [DailyHealthSnapshot] = []
    ) -> ScoreComponent {
        var score = 75
        var confidences: [ScoreConfidence] = []
        var usedSignals = 0

        if let hrv = snapshot.heartRateVariability,
           let baselineHRV = baseline.heartRateVariabilityAverage {
            usedSignals += 1
            confidences.append(baseline.confidence(for: .heartRateVariability))
            let ratio = hrv / baselineHRV
            if ratio < 0.8 {
                score -= 16
            } else if ratio < 0.9 {
                score -= 8
            } else if ratio > 1.08 {
                score += 5
            }
        }

        if let rhr = snapshot.restingHeartRate,
           let baselineRHR = baseline.restingHeartRateAverage {
            usedSignals += 1
            confidences.append(baseline.confidence(for: .restingHeartRate))
            let ratio = rhr / baselineRHR
            if ratio > 1.12 {
                score -= 14
            } else if ratio > 1.06 {
                score -= 7
            } else if ratio < 0.95 {
                score += 4
            }
        }

        if let baselineExercise = baseline.exerciseMinutesAverage {
            let recentExercise = recentAverage(recentSnapshots, keyPath: \.exerciseMinutes) ?? snapshot.exerciseMinutes
            if let recentExercise {
                usedSignals += 1
                confidences.append(baseline.confidence(for: .exerciseMinutes))
                let ratio = recentExercise / baselineExercise
                if ratio > 1.6 {
                    score -= 10
                } else if ratio > 1.3 {
                    score -= 5
                }
            }
        }

        let confidence = componentConfidence(usedSignals: usedSignals, baselineConfidences: confidences)
        let summary: String
        switch confidence {
        case .high, .medium:
            summary = String(localized: "Recovery reflects HRV, resting heart rate, and recent load compared with your baseline.")
        case .low:
            summary = String(localized: "Recovery uses limited baseline data, so this remains a softer wellness estimate.")
        case .unavailable:
            summary = String(localized: "Recovery data is limited today, so this score stays cautious.")
        }

        return ScoreComponent(
            title: String(localized: "Recovery"),
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

    private func componentConfidence(
        usedSignals: Int,
        baselineConfidences: [ScoreConfidence]
    ) -> ScoreConfidence {
        guard usedSignals > 0 else { return .unavailable }
        let combined = ScoreConfidence.combined(baselineConfidences)
        return usedSignals == 1 && combined == .high ? .medium : combined
    }
}
