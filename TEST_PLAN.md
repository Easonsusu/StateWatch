# Test Plan

## Current scope

StateWatch now includes a runnable iOS app target, watchOS app target, and XCTest target. The current test focus is the mock dashboard, read-only HealthKit permission flow, local-only HealthKit data fetch foundation, and rule-based baseline/scoring engine.

## Foundation checks

- Confirm required root docs exist.
- Confirm required `Docs/` files exist.
- Confirm iOS and watchOS placeholder files exist.
- Confirm all previews and tests use mock data.
- Confirm no file claims medical diagnosis or disease detection.
- Confirm HealthKit data upload is not introduced.

## Automated Scoring Tests

- Baseline calculation handles empty, sparse, and normal mock histories.
- Baseline calculation ignores nil metric values.
- Baseline calculation requires enough valid samples before exposing a metric average.
- Baseline calculation supports 7-day, 14-day, and 30-day windows.
- Sparse baseline history produces low or unavailable confidence.
- Recovery scoring responds conservatively to HRV below baseline.
- Recovery scoring responds conservatively to resting heart rate above baseline.
- Sleep scoring reflects duration below baseline and recent sleep trend.
- Missing sleep data returns a cautious placeholder and unavailable confidence.
- Overall state combines recovery, sleep, stress/fatigue context, and activity load with the MVP weights.
- Scores are clamped between 0 and 100.
- Low-data history produces lower-confidence StateAssessment output.
- Suggestion generation avoids medical advice and uses cautious language.
- HealthKit aggregation keeps missing data optional and never treats missing samples as a negative signal.

## Future Automated Tests

- Add fixture histories for low activity, high activity, strong sleep consistency, and mixed signal days.
- Add UI snapshot or preview checks once the dashboard consumes scored mock histories.
- Add regression tests for any debug-only HealthKit assessment preview added in a later phase.

## Manual QA for MVP

- First launch shows disclaimer before HealthKit permission request.
- HealthKit permission copy explains local-only use.
- Dashboard remains usable if permission is denied.
- Mock previews render without real HealthKit data.
- Settings privacy view clearly states data handling.
- Watch placeholders display mock score without needing HealthKit on watch.

## Manual HealthKit Data Fetch Checks

- Run the `StateWatch` scheme on an iPhone simulator or device that can access Apple Health data.
- Open Dashboard -> Settings -> Apple Health -> Health Permissions.
- Tap Request Read Access and grant read access for heart rate, resting heart rate, HRV, sleep, steps, active energy, and workouts.
- Confirm the app remains usable if some data categories are missing or denied.
- Confirm the mock dashboard still appears; Phase 3 does not replace dashboard scoring with fetched data.
- In Xcode or a temporary debug harness, instantiate `HealthKitDataFetcher` and call `fetchRecentSnapshots(days: 30)`.
- Confirm returned snapshots are local day-start dates using the current calendar/time zone.
- Confirm available HealthKit samples populate optional snapshot fields and unavailable metrics remain `nil`.
- Confirm no HealthKit write prompt appears.
- Confirm no network calls or upload paths are introduced.

## Manual Scoring Checks

- Run the `StateWatch` scheme on an iPhone simulator and confirm the dashboard still shows the mock wellness assessment.
- Run the `StateWatchWatchApp` scheme on an Apple Watch simulator and confirm the watch dashboard still shows mock assessment data.
- Confirm no production dashboard path has been switched to live HealthKit data.
- Run the XCTest target and confirm baseline/scoring tests pass.
- Review score explanations for cautious wellness wording.
- Confirm sparse or missing mock history produces lower confidence language instead of negative health conclusions.
- Confirm no score text claims to detect illness, disease, a medical condition, or clinical stress.
