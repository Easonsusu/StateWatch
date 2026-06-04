# Scoring Rules

StateWatch scores are wellness reflections, not medical assessments.

## Principles

- Prefer personal baselines over population thresholds.
- Prefer cautious language over certainty.
- Explain the main contributors behind each score.
- Use mock data until HealthKit fetching is implemented.
- Keep formulas simple enough to audit.

## Placeholder component scores

- Recovery score: influenced by HRV and resting heart rate compared with baseline.
- Sleep score: influenced by sleep duration and consistency.
- Stress/fatigue score: influenced by HRV, resting heart rate, mindfulness, and check-in fatigue/stress.
- Activity load score: influenced by active energy, steps, exercise minutes, and recent load.

## Overall state

The initial placeholder approach averages recovery, sleep, stress/fatigue, and activity balance with conservative labels:

- 80-100: Steady
- 60-79: Mixed
- 40-59: Low
- 0-39: Needs rest

## TODO

- Validate formulas with real-world mock scenarios before using HealthKit data.
- Add score confidence when data is missing or partial.
- Add guardrails that suppress strong claims when baseline history is short.
