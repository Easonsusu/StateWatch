# StateWatch Manual QA Checklist

Use this checklist for Phase 6 stabilization passes and for future pre-merge
reviews when CI alone is not enough. Keep the production dashboard mock-backed
until a later task explicitly wires local HealthKit scoring into the main app.

## Scope Guard

- [ ] No new product features were added during this QA pass.
- [ ] The iPhone Dashboard still launches with mock `StateAssessment` data.
- [ ] The Watch app behavior was not changed unless required for a build fix.
- [ ] No networking, upload, server sync, login, subscription, or AI paths were added.
- [ ] No HealthKit write permission or write authorization was added.
- [ ] No SwiftUI redesign was introduced as part of QA stabilization.

## Build And Test Gates

- [ ] GitHub Actions passes on the pull request.
- [ ] iOS build passes for the `StateWatch` scheme.
- [ ] iOS XCTest suite passes for the `StateWatch` scheme.
- [ ] watchOS build passes for the `StateWatchWatchApp` scheme.
- [ ] `git diff --check origin/main...HEAD` passes.

Optional local commands when full Xcode is available:

```sh
xcodebuild -project StateWatch.xcodeproj -scheme StateWatch -sdk iphonesimulator -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO COMPILER_INDEX_STORE_ENABLE=NO test
xcodebuild -project StateWatch.xcodeproj -scheme StateWatch -sdk iphonesimulator -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO COMPILER_INDEX_STORE_ENABLE=NO build
xcodebuild -project StateWatch.xcodeproj -scheme StateWatchWatchApp -sdk watchsimulator -destination 'generic/platform=watchOS Simulator' CODE_SIGNING_ALLOWED=NO COMPILER_INDEX_STORE_ENABLE=NO build
```

## iPhone App QA

- [ ] App launches to the mock dashboard.
- [ ] Overall score, component rows, reasons, and suggestions are visible.
- [ ] Settings button is visible from the dashboard.
- [ ] Settings opens without changing dashboard data source.
- [ ] Settings includes Apple Health / Health Permissions.
- [ ] Settings includes Developer Preview / HealthKit Scoring Preview.
- [ ] Returning from Settings leaves the dashboard mock-backed.

## HealthKit Permission QA

- [ ] Permission UI explains read-only Apple Health access.
- [ ] Permission UI does not mention HealthKit write access.
- [ ] Permission UI says HealthKit data stays local for the MVP.
- [ ] Requesting permission does not crash on simulator.
- [ ] Denied or limited access shows calm fallback messaging.
- [ ] HealthKit unavailable state shows a safe fallback message.
- [ ] No permission state treats missing samples as a negative wellness signal.
- [ ] `NSHealthShareUsageDescription` is present for the iOS app target.
- [ ] `NSHealthUpdateUsageDescription` is absent unless a future write-access task explicitly adds it.

## HealthKit Preview QA

- [ ] HealthKit Scoring Preview is reachable only from the Developer Preview section.
- [ ] Idle state is visible before loading.
- [ ] Loading state appears after tapping Load HealthKit Preview.
- [ ] Empty data state says the main dashboard can continue using mock data.
- [ ] Unavailable state is calm and does not imply a health issue.
- [ ] Failed state is calm and does not imply a health issue.
- [ ] Partial data lowers confidence or shows missing-data context.
- [ ] Sparse history shows that there is not enough data for a confident preview.
- [ ] Preview output is local-only and does not replace production dashboard data.

## Scoring QA

- [ ] Baselines ignore nil metric values.
- [ ] Metrics with too few valid samples are low confidence or unavailable.
- [ ] All-nil snapshot histories do not crash.
- [ ] Missing data does not lower a score as a negative wellness conclusion.
- [ ] Scores are clamped between 0 and 100.
- [ ] Overall score combines recovery, sleep, fatigue context, and activity load.
- [ ] Reasons and suggestions use cautious wellness wording.

## Watch App QA

- [ ] `StateWatchWatchApp` builds for watchOS simulator.
- [ ] Watch app launches to mock dashboard data.
- [ ] Watch UI remains glanceable and readable on a small simulator.
- [ ] Watch app does not request HealthKit write access.
- [ ] Watch app does not introduce networking or upload paths.

## Medical Safety And Privacy Wording

- [ ] UI does not claim to detect illness, disease, or medical conditions.
- [ ] UI does not claim to diagnose, treat, or prevent a condition.
- [ ] UI does not say the app detects clinical stress.
- [ ] Wording stays calm for low-data, unavailable, denied, and failed states.
- [ ] HealthKit data is described as local-only for the MVP.
- [ ] HealthKit data is not described as used for advertising, marketing, or data mining.
- [ ] If a medical concern is mentioned, copy directs users to qualified professional guidance.

## Networking And HealthKit Write Audit

- [ ] Search for `URLSession`, `upload`, `server`, and `network` before merge.
- [ ] Confirm any networking mentions are documentation only.
- [ ] Search for `toShare:` and confirm it remains an empty `Set<HKSampleType>()`.
- [ ] Search for `NSHealthUpdateUsageDescription` and confirm it is not present in app Info.plist.
- [ ] Confirm there are no server endpoints, API keys, tokens, or credentials committed.

## Design System Integration Risk

- [ ] Phase 5.7 Figma frames remain the source of truth for future visual refresh work.
- [ ] Phase 5.8 design-system code does not change HealthKit behavior.
- [ ] Any future SwiftUI visual refresh should inspect Figma specs before changing dashboard UI.
- [ ] Dark-mode contrast and score ring legibility still need manual visual review after UI changes.
- [ ] Watch and complication layouts still need small-screen overflow review before implementation.

## Sign-Off Notes

- Tester:
- Date:
- Simulator devices:
- GitHub Actions run:
- Known issues:
