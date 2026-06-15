# Phase 8.6 Production Wording and App Store Safety Audit

Phase 8.6 reviews production-facing copy for App Store safety before any broader
HealthKit-backed Dashboard rollout.

StateWatch remains a local-first wellness app. It is not a medical device and
does not diagnose, treat, cure, or prevent any disease.

## Files Reviewed

- `README.md`
- `APP_STORE_CHECKLIST.md`
- `PRIVACY_POLICY_DRAFT.md`
- `Docs/scoring-rules.md`
- `Docs/healthkit-dashboard-rollout-plan.md`
- `Docs/medical-safety-wording.md`
- `Docs/ui-copy-guidelines.md`
- `StateWatchApp/Features/Onboarding/DisclaimerView.swift`
- `StateWatchApp/Features/Onboarding/HealthPermissionView.swift`
- `StateWatchApp/Features/Settings/DataPermissionView.swift`
- `StateWatchApp/Features/Settings/PrivacyView.swift`
- `StateWatchApp/Features/Dashboard/DashboardView.swift`
- `StateWatchApp/Features/Debug/HealthKitScoringPreviewView.swift`
- `StateWatchApp/Features/CheckIn/CheckInView.swift`
- `StateWatchApp/Services/Scoring/*ScoreEngine.swift`
- `StateWatchApp/Services/Explanation/*.swift`
- `StateWatchApp/Models/MockSampleData.swift`
- `StateWatchApp/Models/HealthMetricType.swift`
- `StateWatchWatchApp/Features/*.swift`
- `StateWatchComplications/*.swift`
- `StateWatchShared/*.swift`

## Risky Terms Checked

The audit checked for language that could imply:

- medical diagnosis
- disease or illness detection
- clinical stress detection
- treatment advice
- emergency or alert behavior
- abnormal-health warnings
- medical risk prediction
- causal health claims
- cloud health analysis
- developer access to personal health data

High-risk words may still appear in disclaimers, forbidden-word checklists, or
safety documentation when they clearly say StateWatch does not provide those
capabilities.

## Wording Changes Made

- Replaced `Stress/Fatigue` user-facing labels with `Fatigue Context`.
- Replaced low-data scoring summaries that said `treat this as a softer wellness
  estimate` with `this remains a softer wellness estimate`.
- Updated onboarding and privacy disclaimer copy to say StateWatch does not
  diagnose, treat, cure, or prevent any disease and does not provide medical
  advice.
- Changed the check-in picker label from `Perceived stress` to `Felt strain`.
- Added App Store checklist guidance for non-causal pattern language.
- Updated scoring documentation to use `Fatigue Context` terminology.

## Safety Boundaries Confirmed

- HealthKit-backed iPhone Dashboard remains behind the default-off local feature
  flag.
- The default production iPhone Dashboard remains mock-backed.
- HealthKit-derived output is not propagated to Watch, WidgetKit, or App Group
  shared state.
- Watch app and WidgetKit complications remain mock/shared-mock backed.
- App Group shared state remains summary-only and mock-only for production
  surfaces.
- Raw HealthKit samples are not stored in App Group shared state.
- HealthKit access remains read-only.
- No HealthKit write access was added.
- No networking, cloud sync, account system, analytics rollout, remote config,
  server upload, or AI cloud analysis was added.

## Copy Rules Going Forward

Use:

- `daily state`
- `readiness`
- `recovery context`
- `sleep context`
- `fatigue context`
- `activity load`
- `confidence`
- `low data`
- `not enough recent data`
- `based on available on-device data`

Avoid production-facing claims that say or imply:

- `diagnosis`
- `disease detection`
- `clinical stress`
- `treatment`
- `health warning`
- `emergency`
- `abnormal health`
- `medical risk`
- `AI health analysis`

Correlation language must stay cautious. For example:

- Allowed: `On days with lower sleep, you more often reported feeling tired.`
- Not allowed: `You feel tired because you slept less.`

## Phase 8.6 Result

Phase 8.6 is a wording and documentation safety pass only. It does not implement
new product behavior or change the HealthKit rollout plan.
