# HealthKit Data Map

StateWatch reads Apple Health data locally for wellness summaries. HealthKit data is not uploaded, used for advertising, or used beyond local wellness context.

## Read Types

| HealthKit type | Unit / value | `DailyHealthSnapshot` field | Aggregation |
| --- | --- | --- | --- |
| `HKQuantityTypeIdentifier.heartRate` | bpm | `averageHeartRate` | Average samples per calendar day. |
| `HKQuantityTypeIdentifier.restingHeartRate` | bpm | `restingHeartRate` | Average samples per calendar day. |
| `HKQuantityTypeIdentifier.heartRateVariabilitySDNN` | milliseconds | `heartRateVariability` | Average SDNN samples per calendar day. |
| `HKCategoryTypeIdentifier.sleepAnalysis` | asleep intervals | `sleepDurationHours` | Sum asleep interval seconds per calendar day, then convert to hours. |
| `HKQuantityTypeIdentifier.stepCount` | count | `stepCount` | Sum samples per calendar day. |
| `HKQuantityTypeIdentifier.activeEnergyBurned` | kilocalories | `activeEnergyKcal` | Sum samples per calendar day. |
| `HKWorkoutType.workoutType()` | workout intervals | `exerciseMinutes` | Sum workout interval seconds per calendar day, then convert to minutes. |

## Daily Aggregation

- `HealthKitDataFetcher` reads the last 30 days by default.
- Day boundaries use the user's current `Calendar` and time zone.
- Fetched samples are converted into lightweight local values before aggregation.
- Sleep and workout intervals that cross midnight are split across calendar days.
- Returned snapshots are sorted oldest to newest, with `date` set to the local start of each day.

## Permission principles

- Request only the minimum read permissions needed for the current feature.
- Explain each requested category before the system permission prompt.
- Continue gracefully if the user denies permission.
- Use mock data in previews and tests.

## Missing Data Behavior

- Missing metrics remain `nil`.
- Empty HealthKit query results do not crash the fetcher.
- Missing values are not interpreted as negative wellness signals.
- `MockHealthDataFetcher` remains available for previews, tests, denied permission states, and unavailable HealthKit environments.

## TODO

- Connect `DailyHealthSnapshot` histories to baseline and scoring in the next phase.
- Add an in-app debug/demo surface for reviewing fetched snapshots before replacing mock dashboard data.
