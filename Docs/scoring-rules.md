# Scoring Rules

StateWatch scores are personal trend-based wellness estimates. They are not
clinical or diagnostic information, and the app should avoid wording that sounds
like it detects illness, disease, or a medical condition.

## Principles

- Prefer personal baselines over population thresholds.
- Prefer cautious language over certainty.
- Explain the main contributors behind each score.
- Treat missing data as lower confidence, not as a negative wellness signal.
- Keep formulas simple enough to audit.
- Keep all HealthKit-derived data local in the MVP.

## Baseline Windows

`BaselineCalculator` can calculate 7-day, 14-day, and 30-day baselines from
`DailyHealthSnapshot` history. Each baseline uses the user's current calendar and
compares the latest local day against recent personal data.

Baselines are calculated for:

- Resting heart rate
- Average heart rate
- Heart rate variability
- Sleep duration
- Active energy
- Exercise minutes
- Step count

Nil values are ignored. A metric needs at least three valid samples before an
average is exposed. With fewer samples, the metric remains unavailable or low
confidence so the app can explain that the estimate is based on limited history.

## Confidence

Scores and baselines use lightweight confidence values:

- `high`: enough recent samples are available for the relevant signals.
- `medium`: some usable history exists, but the signal set is incomplete.
- `low`: very limited history exists.
- `unavailable`: no usable data exists for the relevant signal.

Missing data should soften reasons and suggestions. It should not imply that the
user is doing worse.

## Component Scores

### Recovery

The recovery score compares the current day with the user's recent baseline. It
considers HRV, resting heart rate, and recent exercise load when those values are
available. Lower HRV than baseline or higher resting heart rate than baseline can
lower the score, while values near baseline keep the score steady.

### Sleep

The sleep score compares sleep duration with the user's baseline, looks at the
recent 7-day sleep trend, and applies a simple sleep debt approximation when
recent sleep is consistently below baseline. Missing sleep data returns a
conservative placeholder with unavailable confidence rather than a negative
conclusion.

### Stress/Fatigue Context

The stress/fatigue score is a cautious context score, not stress detection. It
looks for patterns such as HRV below baseline, resting heart rate above baseline,
sleep below baseline, recent activity load, and optional user check-in context.
Explanations should use wording like "fatigue context" or "your body may benefit
from a lighter day" rather than medical-style claims.

### Activity Load

Activity load compares step count, active energy, and exercise minutes with the
user's personal baseline. Moderate activity close to baseline supports a steadier
score. Recent load far above baseline can lower the score because it may affect
recovery, while missing activity data lowers confidence only.

## Overall state

`OverallStateEngine` uses a simple weighted average:

- Recovery: 35%
- Sleep: 25%
- Stress/fatigue context: 25%
- Activity load: 15%

Scores are clamped from 0 to 100. The MVP labels are intentionally plain:

- 80-100: Steady
- 60-79: Mixed
- 40-59: Low
- 0-39: Needs rest

## TODO

- Validate the rule weights with more mock histories before wiring the dashboard
  to HealthKit-backed data.
- Add a debug-only review path that compares mock and local HealthKit-derived
  assessments before changing the visible dashboard.
- Revisit confidence thresholds after real-device testing with sparse Apple
  Health histories.
