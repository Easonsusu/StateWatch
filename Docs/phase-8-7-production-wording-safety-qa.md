# Phase 8.7 Production Wording Safety QA

Phase 8.7 is a focused QA audit of the merged Phase 8.6 production wording and
App Store safety work. It verifies that StateWatch remains positioned as a
local-first wellness app, not a medical device.

StateWatch must not diagnose, treat, cure, or prevent any disease. It must not
claim to detect illness, clinical stress, emergency conditions, abnormal health
states, or medical risk.

## Purpose

- Validate production-facing copy after the Phase 8.6 wording pass.
- Confirm sparse, missing, denied, unavailable, stale, or low-confidence data is
  presented as lower confidence or limited data, not as a bad health state.
- Confirm the HealthKit-backed Dashboard remains behind a default-off local
  feature flag.
- Confirm HealthKit-derived output is not propagated to Watch, WidgetKit, or App
  Group shared state.
- Confirm no networking, cloud health database, account system, analytics
  rollout, remote config, server upload, AI cloud profiling, WatchConnectivity,
  or HealthKit write behavior was added.

## Files and Areas Reviewed

- `README.md`
- `APP_STORE_CHECKLIST.md`
- `PRIVACY_POLICY_DRAFT.md`
- `TEST_PLAN.md`
- `PRD.md`
- `Docs/app-store-submission.md`
- `Docs/healthkit-dashboard-rollout-plan.md`
- `Docs/medical-safety-wording.md`
- `Docs/phase-8-6-production-wording-audit.md`
- `Docs/scoring-rules.md`
- `Docs/ui-copy-guidelines.md`
- `StateWatchApp/Features/Onboarding/`
- `StateWatchApp/Features/Settings/`
- `StateWatchApp/Features/Dashboard/`
- `StateWatchApp/Features/CheckIn/`
- `StateWatchApp/Features/Debug/`
- `StateWatchApp/Services/Scoring/`
- `StateWatchApp/Services/Explanation/`
- `StateWatchApp/Models/`
- `StateWatchWatchApp/`
- `StateWatchComplications/`
- `StateWatchShared/`
- Existing wording and safety XCTest coverage.

## Search Terms Used

The audit used broad and focused searches for:

- `diagnos`
- `disease`
- `illness`
- `clinical`
- `treatment`
- `treat`
- `cure`
- `prevent`
- `medical advice`
- `medical device`
- `symptom`
- `emergency`
- `warning`
- `alert`
- `abnormal`
- `risk`
- `caused by`
- `because you`
- `stress`
- `fatigue`
- `HealthKit`
- `network`
- `cloud`
- `AI`
- `analytics`
- `remote config`
- `upload`
- `server`
- `developer access`
- `WatchConnectivity`
- `App Group`
- `WidgetKit`

Focused follow-up searches checked:

- `Stress/Fatigue`
- `Perceived stress`
- `clinical stress`
- `health warning`
- `abnormal health`
- `detected illness`
- `disease detection`
- `medical recommendation`
- `treat this as`
- `caused by`
- `because you`
- `URLSession`
- `requestAuthorization(toShare`
- `NSHealthUpdateUsageDescription`
- `WCSession`

## Risky Terms Found

Risky terms still appear in safe contexts such as disclaimers, forbidden-word
lists, safety documentation, or tests that assert those terms do not appear in
production copy. Those contexts are acceptable because they clearly state what
StateWatch does not do.

The audit found a few legacy documentation labels that could be clearer for
future handoff:

- `Stress/Fatigue` wording was replaced with `Fatigue Context`.
- `stress` in check-in documentation was replaced with `felt strain`.
- A legacy reviewer note was updated to the stronger disclaimer that StateWatch
  is not a medical device and does not diagnose, treat, cure, or prevent any
  disease.

Internal identifiers such as `stressFatigue` and `StressFatigueScoreEngine`
remain unchanged in this QA pass to avoid unnecessary refactors. Production
copy presents the component as `Fatigue Context`.

## Production-Facing Wording Findings

- Onboarding and privacy copy describe StateWatch as wellness support only.
- Dashboard component labels use `Fatigue Context` instead of
  `Stress/Fatigue`.
- Check-in UI uses `Felt strain` instead of `Perceived stress`.
- Watch-facing mock summary copy remains short and non-alarming.
- Complication-facing copy remains compact and does not claim live HealthKit
  analysis, medical detection, or emergency behavior.

No production-facing copy was found that claims diagnosis, disease detection,
clinical stress detection, treatment advice, emergency alerting, abnormal health
warnings, medical risk prediction, or causal health conclusions.

## Low-Data Wording Findings

Low-data, missing-data, denied, unavailable, stale, and fallback paths use calm
language such as:

- `low data`
- `unavailable`
- `not enough recent data`
- `Recent data is limited`
- `HealthKit data was unavailable, so the dashboard is showing mock data`

Missing or sparse data is not described as unhealthy, abnormal, dangerous, or a
bad health state.

## HealthKit Default-Off Verification

- `HealthKitDashboardFeatureFlag` uses `UserDefaults.bool(forKey:)`, so the
  local HealthKit-backed Dashboard path remains off until explicitly enabled.
- The default `DashboardView` still starts from `.mock`.
- If the feature flag is off, `DashboardAssessmentProvider` returns the mock
  assessment.
- If HealthKit data is empty, unavailable, sparse, or low confidence, the
  Dashboard falls back to mock data with calm low-data copy.
- HealthKit authorization remains read-only through
  `requestAuthorization(toShare: Set<HKSampleType>(), read: readTypes)`.

## Watch / WidgetKit / App Group Verification

- The Watch app does not directly fetch HealthKit data.
- WidgetKit complications do not directly fetch HealthKit data.
- WidgetKit reads only the compact shared readiness summary and falls back to
  static mock values when shared state is missing, stale, or unavailable.
- HealthKit-derived Dashboard output is not propagated to Watch, WidgetKit, or
  App Group shared state in this phase.
- App Group shared state does not store raw HealthKit samples.
- WatchConnectivity remains deferred.

## Networking / Cloud / AI Verification

The audit did not find production code paths for:

- networking or `URLSession`
- remote config
- cloud sync
- server upload
- account systems
- analytics rollout
- AI cloud analysis
- developer access to personal health data
- HealthKit write access

References to these terms remain in privacy boundaries, future-risk planning,
or QA checklists.

## Test Coverage Reviewed

Existing tests include wording and safety coverage for:

- non-medical wording boundaries
- forbidden user-facing terms
- low-data and fallback copy
- mock shared-state wording
- complication fallback copy
- HealthKit Dashboard default-off behavior
- read-only HealthKit authorization
- absence of live HealthKit rollout to Watch, WidgetKit, or App Group surfaces

No new test framework was added in Phase 8.7.

## Changes Made

- Updated legacy documentation wording from `Stress/Fatigue` to
  `Fatigue Context`.
- Updated check-in documentation wording from `stress` to `felt strain`.
- Strengthened medical-safety disclaimer wording in the medical wording and App
  Store submission docs.
- Added this Phase 8.7 QA audit document.

No Swift source files, Xcode project files, entitlements, CI workflow, assets,
or app behavior were changed.

## Final Phase 8.7 Result

Phase 8.7 confirms that the merged Phase 8.6 wording work is aligned with the
StateWatch safety stance:

- local-first
- non-medical
- low-anxiety
- read-only HealthKit
- no cloud health database
- no developer access to personal health data
- no AI cloud health profiling

The production HealthKit-backed Dashboard remains feature-flagged and
default-off. Production iPhone, Watch, WidgetKit, and App Group surfaces are not
connected to HealthKit-derived scoring by this QA pass.
