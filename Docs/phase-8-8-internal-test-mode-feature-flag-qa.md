# Phase 8.8 Internal Test Mode and Feature Flag QA

Phase 8.8 audits the internal test mode and feature-flag controls for the
HealthKit-backed iPhone Dashboard. This phase is QA-only: it does not add public
product behavior, redesign UI, or change the HealthKit rollout path.

## Purpose

- Confirm the HealthKit-backed Dashboard remains internal-test-only.
- Confirm the default production Dashboard remains mock-backed.
- Confirm the HealthKit Dashboard flag is local-only and default-off.
- Confirm HealthKit-derived output is not propagated to Watch, WidgetKit, or App
  Group shared state.
- Confirm HealthKit access remains read-only.
- Confirm no networking, cloud sync, remote config, analytics, account system,
  AI cloud analysis, WatchConnectivity, or HealthKit write behavior was added.

## Files and Areas Reviewed

- `README.md`
- `TEST_PLAN.md`
- `Docs/healthkit-dashboard-rollout-plan.md`
- `Docs/phase-8-7-production-wording-safety-qa.md`
- `StateWatchApp/App/HealthKitDashboardFeatureFlag.swift`
- `StateWatchApp/Features/Dashboard/DashboardView.swift`
- `StateWatchApp/Features/Settings/SettingsView.swift`
- `StateWatchApp/Features/Debug/HealthKitScoringPreviewView.swift`
- `StateWatchApp/Features/Debug/VisualPreview/StateWatchVisualPreviewView.swift`
- `StateWatchApp/Services/HealthKit/HealthKitAuthorizationService.swift`
- `StateWatchShared/SharedReadinessSummary.swift`
- `StateWatchShared/SharedReadinessStore.swift`
- `StateWatchWatchApp/`
- `StateWatchComplications/`
- `StateWatchTests/StateWatchThemeTests.swift`

## Search Terms Used

The audit searched for:

- `HealthKitDashboardFeatureFlag`
- `healthKitDashboard`
- `HealthKit Dashboard`
- `feature flag`
- `FeatureFlag`
- `UserDefaults`
- `debug`
- `Debug`
- `internal test`
- `test mode`
- `mock`
- `DashboardAssessmentProvider`
- `App Group`
- `WidgetKit`
- `WatchConnectivity`
- `URLSession`
- `requestAuthorization`
- `toShare`
- `HKSampleType`
- `StateWatchComplications`
- `StateWatchWatchApp`

Focused searches checked:

- `bool(forKey:`
- `set(...forKey:`
- `UserDefaults.standard`
- `@AppStorage`
- `ProcessInfo`
- `DEBUG`
- `#if DEBUG`
- `Bundle.main`
- `remote config`
- `analytics`
- `URLSession`
- `WCSession`
- `requestAuthorization(toShare`
- `HealthKitDataFetcher`
- `fetchRecentSnapshots`
- `HKHealthStore`
- `HKQuantitySample`
- `DailyHealthSnapshot`
- `HealthBaseline`
- `raw HealthKit`

## Current Feature Flag Behavior

`HealthKitDashboardFeatureFlag` stores a local boolean in `UserDefaults`.

- Storage key: `statewatch.feature.healthkitDashboard.enabled`
- Default state: off, because `UserDefaults.bool(forKey:)` returns `false`
  when no value is present.
- Enable path: local `setEnabled(true)` or `enable()`.
- Disable path: local `setEnabled(false)` or `disable()`.
- Reset path: local `reset()`, which removes the stored key and returns the
  flag to default-off behavior.

The flag implementation does not use remote config, networking, analytics,
server state, account state, cloud sync, WatchConnectivity, or HealthKit write
behavior.

## Local Testing Enablement

The repository documents the HealthKit-backed Dashboard path as internal,
local-only, and default-off. There is no public Settings control or production
UI toggle for normal users.

The HealthKit-backed path can be enabled only by local internal test code that
sets the `HealthKitDashboardFeatureFlag` value. Debug-only inspection remains
available through the developer preview views in debug builds.

## Default Production Behavior

`DashboardView` starts with `.mock` data by default. `DashboardAssessmentProvider`
returns the fallback mock assessment whenever the feature flag is off.

When the flag is enabled, the provider may attempt local HealthKit snapshot
loading and scoring. It still falls back to mock data when HealthKit data is
unavailable, empty, sparse, low confidence, or fails to load.

Missing or sparse data is not described as a bad health state. Existing fallback
copy uses calm language such as:

- `HealthKit data was unavailable, so the dashboard is showing mock data.`
- `Recent data is limited, so the dashboard is showing mock data.`

## Local-Only Control Confirmation

The feature flag is stored locally in `UserDefaults` and is not controlled by:

- remote config
- server state
- account state
- analytics
- cloud sync
- push notifications
- environment variable rollout
- WatchConnectivity

The audit found no `URLSession`, `WCSession`, `WatchConnectivity`, remote config,
analytics rollout, cloud sync, or server upload implementation path in the
feature flag or Dashboard control path.

## Watch / WidgetKit / App Group Confirmation

- Watch app source does not directly fetch HealthKit data.
- WidgetKit complication source does not directly fetch HealthKit data.
- `StateWatchShared` stores only `SharedReadinessSummary`, not
  `DailyHealthSnapshot`, `HealthBaseline`, raw HealthKit samples, or HealthKit
  objects.
- WidgetKit complications read only the compact shared readiness summary and
  fall back to static mock values when shared state is missing or stale.
- The HealthKit-derived iPhone Dashboard output is not written to App Group
  shared state in this phase.

## HealthKit Read-Only Confirmation

HealthKit authorization still requests read access only:

`requestAuthorization(toShare: Set<HKSampleType>(), read: readTypes)`

The audit found no `HKHealthStore.save`, `NSHealthUpdateUsageDescription`, or
HealthKit write permission path.

## Existing Test Coverage Reviewed

Existing XCTest coverage already verifies:

- `HealthKitDashboardFeatureFlag` defaults off.
- The feature flag can be enabled, disabled, and reset locally.
- The feature flag storage key remains stable.
- The default-off Dashboard provider returns mock `StateAssessment`.
- The default-off path does not load HealthKit snapshots.
- Resetting the flag returns the Dashboard provider to the mock path.
- Empty, sparse, unavailable, low-confidence, and failed HealthKit loads fall
  back safely to mock data.
- Feature flag source does not use disallowed rollout mechanisms such as
  `URLSession`, `WatchConnectivity`, `WCSession`, remote config, analytics
  rollout, cloud sync, or HealthKit write behavior.
- Watch, WidgetKit, and App Group surfaces remain mock/shared-mock backed.

No new tests were added because the existing focused coverage already exercises
the Phase 8.8 safety requirements without requiring a fragile architecture or
test-file refactor.

## Risks Found

No unsafe behavior was found.

The main residual risk is operational: a developer with local access could set
the `UserDefaults` flag while testing. That is the intended internal validation
path and remains local-only, default-off, and easy to reset.

## Changes Made

- Added this Phase 8.8 QA audit document.

No Swift source files, Xcode project files, entitlements, CI workflow, assets,
or app behavior were changed.

## Final Phase 8.8 Result

Phase 8.8 confirms that the HealthKit-backed Dashboard remains:

- internal-test-only
- local-only
- default-off
- read-only HealthKit
- mock-backed by default
- isolated from Watch, WidgetKit, and App Group production propagation

No product feature, public UI toggle, HealthKit default-on behavior, networking,
cloud sync, AI cloud analysis, analytics, remote config, WatchConnectivity, or
HealthKit write access was added.
