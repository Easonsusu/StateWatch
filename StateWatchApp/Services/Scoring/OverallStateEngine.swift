import Foundation

struct OverallStateEngine {
    private let recoveryEngine = RecoveryScoreEngine()
    private let sleepEngine = SleepScoreEngine()
    private let stressFatigueEngine = StressFatigueScoreEngine()

    func assess(snapshot: DailyHealthSnapshot, baseline: HealthBaseline) -> StateAssessment {
        let recovery = recoveryEngine.score(snapshot: snapshot, baseline: baseline)
        let sleep = sleepEngine.score(snapshot: snapshot, baseline: baseline)
        let stressFatigue = stressFatigueEngine.score(snapshot: snapshot, baseline: baseline)
        let activityLoad = activityScore(snapshot: snapshot, baseline: baseline)
        let overall = [recovery, sleep, stressFatigue, activityLoad].map(\.score).reduce(0, +) / 4

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

    private func activityScore(snapshot: DailyHealthSnapshot, baseline: HealthBaseline) -> ScoreComponent {
        let activeEnergy = snapshot.activeEnergyKcal ?? baseline.activeEnergyAverage ?? 0
        let score = activeEnergy > 900 ? 62 : 74
        return ScoreComponent(title: "Activity Load", score: score, summary: "Activity load is estimated from today's movement signals.")
    }

    // TODO: Add missing-data confidence and user-visible data availability notes.
}
