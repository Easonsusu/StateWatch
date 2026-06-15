import Foundation

struct OverallStateEngine {
    private let recoveryEngine = RecoveryScoreEngine()
    private let sleepEngine = SleepScoreEngine()
    private let stressFatigueEngine = StressFatigueScoreEngine()

    func assess(snapshot: DailyHealthSnapshot, baseline: HealthBaseline) -> StateAssessment {
        assess(snapshot: snapshot, baseline: baseline, recentSnapshots: [])
    }

    func assess(history: [DailyHealthSnapshot], window: BaselineWindow = .thirtyDays) -> StateAssessment? {
        let sortedHistory = history.sorted { $0.date < $1.date }
        guard let latest = sortedHistory.last else { return nil }

        let priorSnapshots = Array(sortedHistory.dropLast())
        let baseline = BaselineCalculator().calculate(from: priorSnapshots, window: window)
        return assess(snapshot: latest, baseline: baseline, recentSnapshots: sortedHistory)
    }

    static func weightedOverallScore(
        recovery: Int,
        sleep: Int,
        stressFatigue: Int,
        activityLoad: Int
    ) -> Int {
        let score = Double(recovery) * 0.35
            + Double(sleep) * 0.25
            + Double(stressFatigue) * 0.25
            + Double(activityLoad) * 0.15

        return min(100, max(0, Int(score.rounded())))
    }

    private func assess(
        snapshot: DailyHealthSnapshot,
        baseline: HealthBaseline,
        recentSnapshots: [DailyHealthSnapshot]
    ) -> StateAssessment {
        let recovery = recoveryEngine.score(snapshot: snapshot, baseline: baseline, recentSnapshots: recentSnapshots)
        let sleep = sleepEngine.score(snapshot: snapshot, baseline: baseline, recentSnapshots: recentSnapshots)
        let stressFatigue = stressFatigueEngine.score(snapshot: snapshot, baseline: baseline, recentSnapshots: recentSnapshots)
        let activityLoad = activityScore(snapshot: snapshot, baseline: baseline, recentSnapshots: recentSnapshots)
        let overall = Self.weightedOverallScore(
            recovery: recovery.score,
            sleep: sleep.score,
            stressFatigue: stressFatigue.score,
            activityLoad: activityLoad.score
        )

        let explanations = ExplanationGenerator().reasons(
            snapshot: snapshot,
            baseline: baseline,
            components: [recovery, sleep, stressFatigue, activityLoad]
        )

        return StateAssessment(
            date: snapshot.date,
            overallScore: overall,
            level: StateLevel.level(for: overall),
            recovery: recovery,
            sleep: sleep,
            stressFatigue: stressFatigue,
            activityLoad: activityLoad,
            reasons: explanations,
            suggestions: SuggestionGenerator().suggestions(for: overall, snapshot: snapshot)
        )
    }

    private func activityScore(
        snapshot: DailyHealthSnapshot,
        baseline: HealthBaseline,
        recentSnapshots: [DailyHealthSnapshot]
    ) -> ScoreComponent {
        var score = 74
        var confidences: [ScoreConfidence] = []
        var usedSignals = 0

        applyActivityRule(
            currentValue: snapshot.stepCount,
            baselineMetric: baseline.stepCount,
            to: &score,
            usedSignals: &usedSignals,
            confidences: &confidences
        )
        applyActivityRule(
            currentValue: snapshot.activeEnergyKcal,
            baselineMetric: baseline.activeEnergy,
            to: &score,
            usedSignals: &usedSignals,
            confidences: &confidences
        )

        let recentExercise = recentAverage(recentSnapshots, keyPath: \.exerciseMinutes) ?? snapshot.exerciseMinutes
        applyActivityRule(
            currentValue: recentExercise,
            baselineMetric: baseline.exerciseMinutes,
            to: &score,
            usedSignals: &usedSignals,
            confidences: &confidences
        )

        guard usedSignals > 0 else {
            return ScoreComponent(
                title: "Activity Load",
                score: 50,
                confidence: .unavailable,
                summary: "Activity data is limited today, so this score stays cautious."
            )
        }

        let confidence = ScoreConfidence.combined(confidences)
        let summary: String
        switch confidence {
        case .high, .medium:
            summary = "Activity load compares steps, active energy, and exercise minutes with your baseline."
        case .low:
            summary = "Activity load uses limited baseline data, so this remains a softer wellness estimate."
        case .unavailable:
            summary = "Activity data is limited today, so this score stays cautious."
        }

        return ScoreComponent(title: "Activity Load", score: score, confidence: confidence, summary: summary)
    }

    private func applyActivityRule(
        currentValue: Double?,
        baselineMetric: MetricBaseline,
        to score: inout Int,
        usedSignals: inout Int,
        confidences: inout [ScoreConfidence]
    ) {
        guard let currentValue,
              let baselineAverage = baselineMetric.average,
              baselineAverage > 0
        else {
            return
        }

        usedSignals += 1
        confidences.append(baselineMetric.confidence)
        let ratio = currentValue / baselineAverage

        if ratio > 1.7 {
            score -= 8
        } else if ratio > 1.35 {
            score -= 4
        } else if ratio < 0.5 {
            score -= 4
        } else if ratio >= 0.8 && ratio <= 1.2 {
            score += 2
        }
    }

    private func recentAverage(_ snapshots: [DailyHealthSnapshot], keyPath: KeyPath<DailyHealthSnapshot, Double?>) -> Double? {
        let values = snapshots.suffix(3).compactMap { $0[keyPath: keyPath] }
        guard !values.isEmpty else { return nil }
        return values.reduce(0, +) / Double(values.count)
    }

    // TODO: Wire HealthKit-backed histories into this engine only after a safe debug review surface exists.
}
