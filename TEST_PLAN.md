# Test Plan

## Current scope

StateWatch now includes a runnable iOS app target, watchOS app target, and XCTest target. The current test focus is the mock dashboard, read-only HealthKit permission flow, and local-only HealthKit data fetch foundation.

## Foundation checks

- Confirm required root docs exist.
- Confirm required `Docs/` files exist.
- Confirm iOS and watchOS placeholder files exist.
- Confirm all previews and tests use mock data.
- Confirm no file claims medical diagnosis or disease detection.
- Confirm HealthKit data upload is not introduced.

## Future automated tests

- Baseline calculation handles empty, sparse, and normal mock histories.
- Recovery scoring responds conservatively to HRV and resting heart rate changes.
- Sleep scoring reflects duration and consistency without medical claims.
- Overall state combines components and generates user-facing reasons.
- Suggestion generation avoids medical advice and uses cautious language.
- HealthKit aggregation keeps missing data optional and never treats missing samples as a negative signal.

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
