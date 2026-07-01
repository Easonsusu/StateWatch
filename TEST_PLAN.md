# Test Plan

## Current scope

StateWatch now includes a runnable iOS app target, watchOS app target, WidgetKit complication target, and XCTest target. The current test focus is the mock dashboard, read-only HealthKit permission flow, local-only HealthKit data fetch foundation, rule-based baseline/scoring engine, debug-only HealthKit scoring preview, and mock-only WidgetKit/App Group shared-state behavior.

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
- Overall state combines recovery, sleep, fatigue context, and activity load with the MVP weights.
- Scores are clamped between 0 and 100.
- Low-data history produces lower-confidence StateAssessment output.
- Suggestion generation avoids medical advice and uses cautious language.
- HealthKit aggregation keeps missing data optional and never treats missing samples as a negative signal.

## Future Automated Tests

- Add fixture histories for low activity, high activity, strong sleep consistency, and mixed signal days.
- Add UI snapshot or preview checks once the dashboard consumes scored mock histories.

## Automated Debug Preview Tests

- Preview reports are not created from empty HealthKit history.
- All-nil snapshot histories show the empty-data state.
- Unavailable HealthKit environments show an unavailable state without loading samples.
- Preview reports include snapshot count, latest date, available metric count, baseline confidence, and assessment output.
- Sparse history shows lower-confidence preview guidance.
- Partial latest snapshots show a missing-data notice.

## GitHub Actions CI

- Pull requests and pushes to `main` run `.github/workflows/ios-watchos-ci.yml`.
- Draft pull requests run lightweight Ubuntu validation only: diff whitespace and expected project directory checks.
- Ready-for-review pull requests, pushes to `main`, and manual `workflow_dispatch` runs execute the full macOS Xcode validation job.
- Full CI checks diff whitespace, builds the `StateWatch` iOS scheme, runs the `StateWatch` XCTest suite, builds the `StateWatchWatchApp` watchOS scheme, and builds the `StateWatchComplications` WidgetKit scheme.
- CI disables code signing and compiler index storage for build/test verification.
- Local simulator validation should be used as the normal development/debugging loop before spending GitHub Actions macOS minutes.
- Local/manual testing is still required for HealthKit permission UI behavior and any real Apple Health data scenarios.

## Phase CI-1: Local Xcode Validation and Actions Cost Control

- Confirm `Docs/local-xcode-validation.md` exists and includes local iOS, watchOS, WidgetKit, and XCTest commands.
- Confirm local validation uses full Xcode, not Command Line Tools alone.
- Confirm an iPhone simulator is available locally.
- Confirm an Apple Watch simulator is available locally.
- Confirm `git diff --check origin/main...HEAD` passes locally.
- Confirm the `StateWatch` iOS scheme builds locally.
- Confirm the `StateWatch` XCTest suite runs locally.
- Confirm the `StateWatchWatchApp` watchOS scheme builds locally.
- Confirm the `StateWatchComplications` WidgetKit scheme builds locally.
- Confirm draft pull requests skip the full macOS Xcode job.
- Confirm ready-for-review pull requests, pushes to `main`, and manual workflow dispatch still run full macOS Xcode validation.
- Confirm no app behavior, HealthKit logic, networking, AI, HealthKit write access, or production data source changes were added.

## Design and UI QA

- Verify dark mode readability across dashboard, settings, Watch, and debug preview surfaces.
- Verify score ring legibility at iPhone and Apple Watch sizes.
- Verify component cards have clear hierarchy for title, value, confidence, and summary text.
- Verify low-data states are calm, non-alarming, and do not treat missing data as a negative wellness signal.
- Verify the Watch app is glanceable within a few seconds.
- Verify complication layouts do not overflow in accessory circular, rectangular, inline, or corner families.
- Verify text remains readable on small Apple Watch screens.
- Verify no medical, diagnosis, disease detection, clinical stress detection, or alarming wording appears in UI.
- Verify Figma design specs are reviewed before SwiftUI implementation begins.

## Figma Phase 5.7 Review

- Verify the Figma file `StateWatch UI Design System` contains `[Phase 5.7]` frames on `01 Design Tokens`, `02 iPhone Dashboard`, `03 Watch App`, `04 Watch Complications`, `05 Components`, and `06 Handoff Notes`.
- Verify all Phase 5.7 layers are editable and not flattened screenshots.
- Verify the token board includes final color, score-state, confidence-state, typography, spacing, radius, and effect specs.
- Verify iPhone dashboard frames cover normal, low data, loading, HealthKit unavailable, permission-needed, and debug-preview entry states.
- Verify Watch frames are glanceable within a few seconds and avoid tiny paragraphs.
- Verify complication variants do not overflow in normal, low confidence, stale data, or unavailable states.
- Verify low-data and unavailable wording is calm and non-alarming.
- Verify no medical, diagnosis, disease detection, clinical stress detection, warning, or health-risk wording appears in mockups.
- Verify Phase 5.8 SwiftUI work starts from Figma tokens and components rather than generic UI invention.

## SwiftUI Design System Foundation

- Verify design system components render in SwiftUI previews.
- Verify the score ring remains legible in dark mode across steady, mixed, cautious, and no-data examples.
- Verify glass cards do not overpower text or create heavy neon effects.
- Verify confidence badge wording is calm, especially `Low data`.
- Verify metric cards have a clear hierarchy for title, value, subtitle, and optional progress.
- Verify the mini trend chart handles empty data without crashing or implying a negative wellness state.
- Verify components do not introduce medical, diagnosis, disease detection, clinical stress detection, or alarming wording.
- Verify production `DashboardView` still behaves as before and remains mock-backed.
- Verify the Watch app still behaves as before and is not changed by the iOS design-system foundation.

## Debug Visual Preview Dashboard

- Run the `StateWatch` scheme on an iPhone simulator.
- Open Dashboard -> Settings.
- Under Developer Preview, open Visual Dashboard Preview.
- Confirm the preview uses the new technology-style design system components.
- Confirm Normal, Low Data, and Unavailable preview states are available.
- Confirm production `DashboardView` is unchanged and remains mock-backed.
- Confirm HealthKit Scoring Preview still opens from the same Developer Preview section.
- Confirm Visual Dashboard Preview does not request HealthKit permission.
- Confirm Visual Dashboard Preview does not fetch real HealthKit data.
- Confirm low-data and unavailable copy is calm and non-medical.
- Confirm dark mode readability, score ring legibility, and glass-card hierarchy.

## Phase 5.10 QA Audit

- Confirm GitHub Actions CI passes before merge.
- Confirm production `DashboardView` remains mock-backed.
- Confirm Settings -> Developer Preview -> HealthKit Scoring Preview opens.
- Confirm Settings -> Developer Preview -> Visual Dashboard Preview opens.
- Confirm Visual Dashboard Preview has Normal, Low Data, and Unavailable states.
- Confirm Visual Dashboard Preview does not request HealthKit permissions.
- Confirm Visual Dashboard Preview does not fetch real HealthKit data.
- Confirm Watch app still builds.
- Confirm no HealthKit write permission is requested.
- Confirm no networking or upload path exists.
- Confirm no medical or alarming UI wording exists.
- Confirm dark mode readability manually in Xcode previews or simulator when available.

## Phase 6.0 Production Dashboard Design Refresh

- Confirm iPhone app launches to the redesigned `DashboardView`.
- Confirm Dashboard still uses mock data.
- Confirm Settings gear opens Settings.
- Confirm Health Permissions still opens.
- Confirm HealthKit Scoring Preview still opens in DEBUG.
- Confirm Visual Dashboard Preview still opens in DEBUG.
- Confirm Dashboard does not request HealthKit permission.
- Confirm Dashboard does not fetch HealthKit data.
- Confirm Dashboard copy stays calm and non-medical.
- Confirm score ring is legible in dark mode.
- Confirm metric cards have clear hierarchy.
- Confirm glass cards do not overpower text.
- Confirm Watch app still builds and behavior is unchanged.
- Confirm CI passes before merge.

## Phase 6.1 Production Dashboard Design QA Audit

- Confirm PR #21 is merged before starting the audit branch.
- Confirm iPhone app launches to the redesigned `DashboardView`.
- Confirm production `DashboardView` still defaults to mock `StateAssessment` data.
- Confirm dashboard display text labels data as mock or demo where appropriate.
- Confirm dashboard trend values remain static mock values.
- Confirm dashboard display model exposes exactly four cards: Recovery, Sleep, Fatigue Context, and Activity Load.
- Confirm dashboard reasons and suggestion text are preserved from the supplied mock assessment.
- Confirm dashboard-related files do not reference `HealthKitDataFetcher`, `HealthKitAuthorizationService`, `HealthKitManager`, `requestAuthorization`, `fetchRecentSnapshots`, or `OverallStateEngine`.
- Confirm Dashboard does not request Apple Health permission or fetch HealthKit samples.
- Confirm Settings gear opens Settings.
- Confirm Settings -> Apple Health -> Health Permissions still opens.
- Confirm Settings -> Developer Preview -> HealthKit Scoring Preview still opens in DEBUG.
- Confirm Settings -> Developer Preview -> Visual Dashboard Preview still opens in DEBUG.
- Confirm dashboard copy avoids diagnosis, disease, illness, clinical stress, detection, treatment, prevention, health-risk, or warning wording.
- Confirm no networking, upload path, AI feature, WidgetKit target, App Group, or HealthKit write authorization is introduced.
- Confirm no Watch app behavior changes are included in the QA PR.
- Confirm `git diff --check origin/main...HEAD` passes.
- Confirm `plutil -lint StateWatch.xcodeproj/project.pbxproj` passes.
- Confirm GitHub Actions CI passes for iOS build, XCTest, and watchOS build before merge.

## Phase 6.4 WidgetKit Complication Mock Foundation

- Confirm PR #24 is merged before starting the WidgetKit complication branch.
- Confirm `StateWatchComplications` exists as a dedicated WidgetKit extension target.
- Confirm `StateWatchComplications` has a shared Xcode scheme.
- Confirm supported complication families include accessory circular, rectangular, inline, and corner.
- Confirm complication entries use static mock data only: score 76, label Mixed, confidence Medium, and demo text.
- Confirm complication source files do not import HealthKit.
- Confirm complication source files do not reference `HealthKitDataFetcher`, `HealthKitAuthorizationService`, `HealthKitManager`, `OverallStateEngine`, `requestAuthorization`, or `fetchRecentSnapshots`.
- Confirm complication source files do not use networking, `URLSession`, App Groups, WatchConnectivity, or shared containers.
- Confirm complication copy avoids diagnosis, disease, illness, clinical stress, detection, treatment, prevention, health-risk, or warning wording.
- Confirm production iPhone `DashboardView` remains mock-backed and unchanged.
- Confirm production Watch app remains mock-backed and unchanged.
- Confirm `StateWatchComplications` builds for a watchOS simulator in CI.
- Confirm `git diff --check origin/main...HEAD` passes.
- Confirm `plutil -lint StateWatch.xcodeproj/project.pbxproj` passes.
- Confirm GitHub Actions CI passes for iOS build, XCTest, watchOS app build, and WidgetKit complication build before merge.

## Phase 6.5 WidgetKit Mock Complication QA Audit

- Confirm PR #25 is merged before starting the WidgetKit complication QA branch.
- Confirm `StateWatchComplications` remains a dedicated WidgetKit extension target.
- Confirm `StateWatchComplications` shared scheme still builds in CI.
- Confirm supported complication families still include accessory circular, rectangular, inline, and corner.
- Confirm mock complication summary still uses score 76, label Mixed, confidence Medium, and demo text.
- Confirm family display strings remain short and glanceable.
- Confirm complication source files do not import HealthKit.
- Confirm complication source files do not reference `HealthKitDataFetcher`, `HealthKitAuthorizationService`, `HealthKitManager`, `OverallStateEngine`, `requestAuthorization`, or `fetchRecentSnapshots`.
- Confirm complication source files do not use networking, `URLSession`, App Groups, WatchConnectivity, shared containers, or local persistence.
- Confirm no App Group entitlement was added.
- Confirm no WatchConnectivity code was added.
- Confirm no HealthKit-backed complication timeline was added.
- Confirm production iPhone `DashboardView` remains mock-backed and unchanged.
- Confirm production Watch app remains mock-backed and unchanged.
- Confirm complication copy avoids diagnosis, disease, illness, clinical stress, detection, treatment, prevention, health-risk, or warning wording.
- Confirm `git diff --check origin/main...HEAD` passes.
- Confirm `plutil -lint StateWatch.xcodeproj/project.pbxproj StateWatchComplications/Info.plist` passes.
- Confirm `xmllint --noout StateWatch.xcodeproj/xcshareddata/xcschemes/StateWatchComplications.xcscheme` passes.
- Confirm GitHub Actions CI passes for iOS build, XCTest, watchOS app build, and WidgetKit complication build before merge.

## Phase 6.6 Shared Local State Architecture Design

- Confirm `Docs/shared-local-state-architecture.md` exists.
- Confirm the shared local state phase is documentation-only.
- Confirm no App Group entitlement was added.
- Confirm no WatchConnectivity code was added.
- Confirm no local persistence was added.
- Confirm no live WidgetKit timeline was added.
- Confirm no HealthKit production rollout was added.
- Confirm iPhone Dashboard remains mock-backed.
- Confirm Watch app remains mock-backed.
- Confirm WidgetKit complications remain static mock-backed.
- Confirm no networking, upload path, AI feature, or HealthKit write access was added.
- Confirm CI passes before merge.

## Phase 6.8 Mock App Group Shared State

- Confirm App Group entitlement `group.com.easonsusu.StateWatch` is present only for the iOS app, watchOS app, and WidgetKit complication targets.
- Confirm `SharedReadinessSummary` includes schema version, score, state label, confidence, short suggestion, updated text, generated date, source, and mock marker fields.
- Confirm the static mock summary uses score 76, label Mixed, confidence Medium, suggestion Demo data, updated text Demo, source mock-app-group, and `isMock` true.
- Confirm `SharedReadinessStore` uses `UserDefaults(suiteName:)` with key `statewatch.shared.readiness.summary.v1`.
- Confirm the shared store encodes and decodes JSON safely.
- Confirm the shared store returns a safe mock fallback when the App Group suite is unavailable.
- Confirm the shared store returns a safe mock fallback when data is missing, stale, or cannot be decoded.
- Confirm the iOS app seeds only the static mock summary.
- Confirm WidgetKit complications try the mock shared summary first and fall back to the existing static mock summary.
- Confirm WidgetKit complications do not fetch HealthKit samples directly.
- Confirm WidgetKit complications do not use live HealthKit-backed timelines.
- Confirm production `DashboardView` remains mock-backed and is not connected to HealthKit-derived scoring.
- Confirm production `WatchDashboardView` remains mock-backed and is not connected to HealthKit-derived scoring.
- Confirm no WatchConnectivity code was added.
- Confirm no local persistence beyond mock App Group `UserDefaults` summary storage was added.
- Confirm no networking, upload path, AI feature, or HealthKit write access was added.
- Confirm shared-state copy does not imply HealthKit, Apple Health, diagnosis, disease detection, clinical stress detection, treatment, warning, networking, AI, or HealthKit write access.
- Confirm `git diff --check origin/main...HEAD` passes.
- Confirm `plutil -lint StateWatch.xcodeproj/project.pbxproj` passes.
- Confirm changed plist and entitlement files pass `plutil -lint`.
- Confirm GitHub Actions CI passes for iOS build, XCTest, watchOS app build, and WidgetKit complication build before merge.

## Phase 6.9 Mock App Group Shared State QA Audit

- Confirm this phase is tests and documentation only.
- Confirm App Group entitlement `group.com.easonsusu.StateWatch` was added in Phase 6.8 and remains mock-only.
- Confirm `SharedReadinessStore.appGroupIdentifier` remains `group.com.easonsusu.StateWatch`.
- Confirm `SharedReadinessStore.storageKey` remains `statewatch.shared.readiness.summary.v1`.
- Confirm mock shared summary values remain score 76, label Mixed, confidence Medium, updated text Demo, source mock-app-group, and `isMock` true.
- Confirm shared summary schema version remains stable.
- Confirm shared summary score stays in the 0...100 display range.
- Confirm shared summary encode/decode preserves all fields.
- Confirm the shared store can save and load a mock summary.
- Confirm missing App Group data returns nil or safe fallback behavior.
- Confirm corrupted JSON data does not crash and falls back safely.
- Confirm stale shared data is treated safely.
- Confirm an unavailable App Group suite does not crash.
- Confirm WidgetKit complications can use a shared mock summary when available.
- Confirm WidgetKit complications fall back to the safe static mock summary when shared state is missing.
- Confirm WidgetKit complications do not fetch HealthKit samples directly.
- Confirm WidgetKit complications do not use WatchConnectivity.
- Confirm WidgetKit complications do not use networking or upload paths.
- Confirm iPhone Dashboard remains mock-backed.
- Confirm Watch app remains mock-backed.
- Confirm HealthKit-derived production rollout remains deferred.
- Confirm WatchConnectivity remains deferred.
- Confirm no HealthKit write access, AI feature, networking, live HealthKit-backed timeline, or production UI behavior change was added.
- Confirm mock shared state, docs, and complication-facing strings avoid medical diagnosis, disease detection, clinical stress detection, treatment, warning, alert, emergency, cloud upload, AI analysis, and live HealthKit-backed complication claims.
- Confirm `git diff --check origin/main...HEAD` passes.
- Confirm GitHub Actions CI passes for iOS build, XCTest, watchOS app build, and WidgetKit complication build before merge.

## Phase 7.0 iPhone Mock Dashboard Shared-State Publishing

- Confirm the iPhone app publishes the production mock dashboard summary into App Group shared state on app launch.
- Confirm the published summary maps from `StateAssessment.mock`.
- Confirm published mock values remain score 76, label Mixed, confidence Medium, updated text Demo, source iphone-mock-dashboard, and `isMock` true.
- Confirm the published short suggestion comes from the mock dashboard assessment.
- Confirm `SharedReadinessStore.appGroupIdentifier` remains `group.com.easonsusu.StateWatch`.
- Confirm `SharedReadinessStore.storageKey` remains `statewatch.shared.readiness.summary.v1`.
- Confirm App Group save failure is safe and does not block the dashboard.
- Confirm unavailable App Group storage does not crash the publisher.
- Confirm WidgetKit reads the shared mock summary when available.
- Confirm WidgetKit falls back to the static mock summary when shared state is missing, stale, corrupted, or unavailable.
- Confirm iPhone Dashboard remains visually and behaviorally mock-backed.
- Confirm Watch app remains visually and behaviorally mock-backed.
- Confirm HealthKit-derived production rollout remains deferred.
- Confirm WidgetKit complications do not fetch HealthKit samples directly.
- Confirm no WatchConnectivity code was added.
- Confirm no networking, upload path, AI feature, live HealthKit-backed timeline, HealthKit write access, or production UI behavior change was added.
- Confirm changed production-facing strings and docs avoid medical diagnosis, disease detection, clinical stress detection, treatment, warning, alert, emergency, cloud upload, AI analysis, live HealthKit-backed complication, or WatchConnectivity syncing claims.
- Confirm `git diff --check origin/main...HEAD` passes.
- Confirm `plutil -lint StateWatch.xcodeproj/project.pbxproj` passes.
- Confirm GitHub Actions CI passes for iOS build, XCTest, watchOS app build, and WidgetKit complication build before merge.

## Phase 7.1 iPhone Mock Dashboard Shared-State Publishing QA Audit

- Confirm this phase is tests and documentation only.
- Confirm the iPhone mock dashboard publisher is tested.
- Confirm the publisher maps from the production mock `StateAssessment` source.
- Confirm publisher output remains score 76, label Mixed, confidence Medium, updated text Demo, source iphone-mock-dashboard, and `isMock` true.
- Confirm publisher output remains clearly mock-only and does not imply HealthKit-derived, live, or synced data.
- Confirm the publisher uses App Group identifier `group.com.easonsusu.StateWatch`.
- Confirm the publisher uses storage key `statewatch.shared.readiness.summary.v1`.
- Confirm App Group save failure is safe and does not block app launch or dashboard behavior.
- Confirm repeated app launch publishing safely overwrites the same mock summary shape.
- Confirm app startup calls the mock dashboard publisher without introducing HealthKit fetching, authorization, WatchConnectivity, networking, or upload paths.
- Confirm iPhone Dashboard remains mock-backed and is not connected to real HealthKit-derived scoring.
- Confirm Watch app remains mock-backed and does not require WatchConnectivity.
- Confirm WidgetKit reads iPhone-published mock summary values when available.
- Confirm WidgetKit fallback remains safe for missing, stale, corrupted, decoded-failure, or unavailable shared state.
- Confirm fallback values remain score 76, label Mixed, confidence Medium, suggestion Demo data, and updated text Demo.
- Confirm WidgetKit complications do not fetch HealthKit samples directly.
- Confirm WidgetKit complications do not use WatchConnectivity.
- Confirm WidgetKit complications do not use networking or upload paths.
- Confirm HealthKit production rollout remains deferred.
- Confirm no AI feature, live HealthKit-backed timeline, HealthKit write access, or production UI behavior change was added.
- Confirm changed production-facing strings, source comments, README, TEST_PLAN, and shared-state docs avoid medical diagnosis, disease detection, clinical stress detection, treatment, warning, alert, emergency, cloud upload, AI analysis, live HealthKit-backed complication, WatchConnectivity syncing, or production HealthKit rollout claims.
- Confirm `git diff --check origin/main...HEAD` passes.
- Confirm `plutil -lint` passes for changed plist or entitlement files if any are touched.
- Confirm GitHub Actions CI passes for iOS build, XCTest, watchOS app build, and WidgetKit complication build before merge.

## Phase 7.2 Watch Shared Mock App Group State

- Confirm the Watch app reads a mock App Group readiness summary when available.
- Confirm the Watch app maps the shared mock summary into the Watch dashboard display model.
- Confirm shared mock values remain score 76, label Mixed, confidence Medium, updated text Demo, source iphone-mock-dashboard, and `isMock` true.
- Confirm Watch display model still uses the same static component summaries for Recovery, Sleep, Fatigue Context, and Activity Load.
- Confirm the Watch app falls back to static mock values when shared state is unavailable.
- Confirm missing shared data is safe and does not crash the Watch app.
- Confirm corrupted shared data is safe and does not crash the Watch app.
- Confirm stale shared data is safe and falls back to static mock values.
- Confirm non-mock shared data is ignored in this phase and falls back to static mock values.
- Confirm static Watch fallback values remain score 76, label Mixed, confidence Medium, updated text Demo, source static-watch-mock, and `isMock` true.
- Confirm Watch UI layout and visual design remain unchanged.
- Confirm Watch app behavior remains mock-backed.
- Confirm WidgetKit complication fallback remains safe and unchanged.
- Confirm iPhone Dashboard remains mock-backed and continues publishing mock shared summary data.
- Confirm HealthKit-derived production wiring remains deferred for iPhone, Watch, and complications.
- Confirm WatchConnectivity remains deferred and no `WCSession` code was added.
- Confirm Watch app does not fetch HealthKit samples directly.
- Confirm WidgetKit complications do not fetch HealthKit samples directly.
- Confirm no networking, upload path, AI feature, live HealthKit-backed timeline, or HealthKit write access was added.
- Confirm changed Watch-facing strings, README, and TEST_PLAN avoid medical diagnosis, disease detection, clinical stress detection, treatment, warning, alert, emergency, cloud upload, AI analysis, live HealthKit-backed Watch state, WatchConnectivity syncing, or production HealthKit rollout claims.
- Confirm `git diff --check origin/main...HEAD` passes.
- Confirm `plutil -lint` passes for changed plist or entitlement files if any are touched.
- Confirm GitHub Actions CI passes for iOS build, XCTest, watchOS app build, and WidgetKit complication build before merge.

## Phase 7.3 Watch Shared Mock State QA Audit

- Confirm this phase is tests and documentation only.
- Confirm the Watch app reads a mock App Group readiness summary when available.
- Confirm the Watch display model can be created from `SharedReadinessSummary`.
- Confirm shared mock values remain score 76, label Mixed, confidence Medium, updated text Demo, source iphone-mock-dashboard or static-watch-mock, and `isMock` true.
- Confirm missing shared state falls back to static Watch mock values.
- Confirm stale shared state falls back safely.
- Confirm corrupted shared state falls back safely.
- Confirm unavailable shared state storage does not crash.
- Confirm non-mock shared state does not replace safe mock Watch display values.
- Confirm fallback values remain score 76, label Mixed, confidence Medium, updated text Demo, source static-watch-mock, and `isMock` true.
- Confirm Watch shared-state mapping does not imply real HealthKit-derived data.
- Confirm Watch app source does not use WatchConnectivity, `WCSession`, HealthKit fetching, HealthKit write access, networking, or upload paths.
- Confirm WidgetKit and Watch fallback expectations remain consistent.
- Confirm `SharedReadinessStore.appGroupIdentifier` remains `group.com.easonsusu.StateWatch`.
- Confirm `SharedReadinessStore.storageKey` remains `statewatch.shared.readiness.summary.v1`.
- Confirm App Group shared state remains mock-only.
- Confirm Watch UI layout and visual behavior remain unchanged.
- Confirm WidgetKit fallback remains safe.
- Confirm iPhone Dashboard remains mock-backed.
- Confirm HealthKit-derived production rollout remains deferred.
- Confirm no visual-first UI, icon assets, check-in UI, bilingual UI, localization, networking, AI, WatchConnectivity, HealthKit write access, or production data-source change was added.
- Confirm changed Watch-facing strings, README, TEST_PLAN, and shared-state docs avoid medical diagnosis, disease detection, clinical stress detection, treatment, warning, alert, emergency, cloud upload, AI analysis, live HealthKit-backed Watch state, WatchConnectivity syncing, or production HealthKit rollout claims.
- Confirm local Xcode validation is used before relying on GitHub Actions.
- Confirm the PR stays draft until final CI is intentionally needed.
- Confirm `git diff --check origin/main...HEAD` passes.
- Confirm `plutil -lint StateWatch.xcodeproj/project.pbxproj` passes.
- Confirm local iOS build and XCTest pass on an installed iPhone simulator.
- Confirm local watchOS app build passes on an installed Apple Watch simulator.
- Confirm local WidgetKit complication build passes on an installed Apple Watch simulator.


## Phase 8.0 Feature-Flagged HealthKit Dashboard Rollout Planning

- Confirm `Docs/healthkit-dashboard-rollout-plan.md` exists.
- Confirm this phase is planning and documentation only.
- Confirm production iPhone Dashboard remains mock-backed.
- Confirm Watch app remains mock-backed or shared-mock-backed only.
- Confirm WidgetKit complications remain shared-mock-backed with static fallback.
- Confirm no HealthKit production rollout was implemented.
- Confirm no HealthKit write access was added.
- Confirm no networking, upload path, cloud sync, login, subscriptions, or backend service was added.
- Confirm no AI feature or AI health profiling was added.
- Confirm no WatchConnectivity was added.
- Confirm no UI behavior change was added.
- Confirm no visual-first UI, icon assets, check-in UI, bilingual UI, localization files, or WidgetKit layout changes were added.
- Confirm future HealthKit-backed Dashboard rollout is described as feature-flagged, local-only, and disabled by default.
- Confirm missing, denied, unavailable, empty, partial, sparse, or stale data falls back to low-data, setup-needed, unavailable, mock, or safe fallback behavior.
- Confirm missing data lowers confidence and does not create negative wellness conclusions.
- Confirm WidgetKit and Watch are documented as later rollout surfaces, not direct HealthKit fetchers.
- Confirm App Group shared state is documented as compact-summary-only, not raw HealthKit samples.
- Confirm future State Check-in states are documented with safe English and Traditional Chinese labels.
- Confirm future UI, icon, complication, and localization work must review the Figma design system before SwiftUI implementation.
- Confirm changed docs avoid claiming diagnosis, disease detection, clinical stress detection, treatment, emergency handling, health alerts, live monitoring, cloud upload, networking, AI analysis, WatchConnectivity syncing, or HealthKit write access.
- Confirm local validation is used and GitHub Actions is not triggered for this planning PR.
- Confirm `git diff --check origin/main...HEAD` passes.
- Confirm the diff is limited to docs, README, and TEST_PLAN updates.


## Phase 8.1 HealthKit Dashboard Rollout Plan QA Audit

- Confirm `Docs/healthkit-dashboard-rollout-plan.md` was audited and strengthened.
- Confirm this phase remains documentation-only.
- Confirm production iPhone Dashboard remains mock-backed.
- Confirm the HealthKit-backed Dashboard feature flag default-off requirement is documented.
- Confirm the feature flag must be local-only and easy to disable.
- Confirm HealthKit authorization denied, missing, unavailable, empty, partial, sparse, revoked, and stale states are documented.
- Confirm low-data behavior is documented.
- Confirm missing data lowers confidence or shows a low-data state instead of creating negative wellness conclusions.
- Confirm privacy promise is documented: local-only HealthKit processing, no account required, no cloud health database, no developer access, no ad profile, and no AI cloud profiling.
- Confirm raw HealthKit samples are excluded from App Group storage.
- Confirm App Group storage is documented as compact-summary-only.
- Confirm Watch and WidgetKit direct HealthKit access is forbidden.
- Confirm no production HealthKit rollout was implemented.
- Confirm no Swift implementation changed.
- Confirm no Xcode project changed.
- Confirm no entitlements changed.
- Confirm no CI workflow changed.
- Confirm no networking, upload path, AI, WatchConnectivity, or HealthKit write access was added.
- Confirm no WidgetKit, Watch app, iPhone Dashboard, HealthKit, or App Group behavior changed.
- Confirm language audit documents approved wording and forbidden medical, diagnosis, disease detection, clinical stress detection, treatment, warning, emergency, alert, abnormal health alert, medical recommendation, and mental-health diagnosis wording.
- Confirm State Check-in and personalization are documented as future, local-only, subjective-feedback features.
- Confirm safe State Check-in labels are documented in English and Traditional Chinese.
- Confirm the Figma gate for future UI, icon, check-in, complication layout, localization, and bilingual copy work is documented.
- Confirm local validation is used.
- Confirm GitHub Actions is not manually triggered or used as the debugging loop.
- Confirm `git diff --check origin/main...HEAD` passes.
- Confirm the diff is limited to Docs, README, and TEST_PLAN updates.


## Phase 8.2 Internal Local HealthKit Dashboard Feature Flag Foundation

- Confirm `HealthKitDashboardFeatureFlag` exists.
- Confirm the feature flag default is off.
- Confirm the feature flag uses stable local storage key `statewatch.feature.healthkitDashboard.enabled`.
- Confirm the feature flag can be enabled locally.
- Confirm the feature flag can be disabled locally.
- Confirm reset returns the flag to default off.
- Confirm production iPhone Dashboard remains mock-backed.
- Confirm current mock dashboard display and App Group mock publishing behavior are unchanged.
- Confirm no HealthKit production rollout was implemented.
- Confirm Dashboard does not call HealthKit data fetching, scoring, or authorization paths.
- Confirm no HealthKit write access was added.
- Confirm no networking, upload path, remote config, analytics rollout, cloud sync, login, server call, or AI was added.
- Confirm no WatchConnectivity was added.
- Confirm WidgetKit does not fetch HealthKit data.
- Confirm Watch app does not fetch HealthKit data.
- Confirm Watch app behavior is unchanged.
- Confirm WidgetKit behavior is unchanged.
- Confirm App Group behavior is unchanged.
- Confirm no visual-first UI, icon assets, check-in UI, bilingual UI, localization, or Dashboard layout changes were added.
- Confirm future UI/icon/check-in/complication/localization work still uses Figma as source of truth first.
- Confirm `git diff --check origin/main...HEAD` passes.
- Confirm `plutil -lint StateWatch.xcodeproj/project.pbxproj` passes if the project file is touched.
- Confirm `xcodebuild -version` was recorded.
- Confirm `xcrun simctl list devices available` was used to select installed simulator names.
- Confirm `xcodebuild -project StateWatch.xcodeproj -list` passes.
- Confirm local iOS build and XCTest pass on an installed iPhone simulator.
- Confirm local watchOS app build passes on an installed Apple Watch simulator.
- Confirm local WidgetKit complication build passes on an installed Apple Watch simulator.
- Confirm GitHub Actions is not manually triggered or used as the debugging loop.


## Phase 8.3 Feature-Flagged HealthKit-Backed iPhone Dashboard

- Confirm `DashboardAssessmentProvider` returns mock `StateAssessment` when the local feature flag is off.
- Confirm the local feature flag storage key remains `statewatch.feature.healthkitDashboard.enabled`.
- Confirm enabling the local feature flag routes the iPhone Dashboard provider through the HealthKit-derived assessment path.
- Confirm disabling or resetting the local feature flag returns the provider to the mock path.
- Confirm HealthKit unavailable, empty data, sparse history, low-confidence assessment, and loading failure states fall back safely to mock data.
- Confirm HealthKit-derived assessment scores are clamped to `0...100`.
- Confirm all-nil or sparse snapshot history does not create a negative wellness conclusion.
- Confirm production iPhone Dashboard remains mock-backed by default.
- Confirm the iPhone Dashboard does not publish HealthKit-derived summaries to App Group shared state in this phase.
- Confirm Watch app behavior remains mock/shared-mock-backed.
- Confirm WidgetKit complication behavior remains mock/shared-mock-backed with static fallback.
- Confirm WidgetKit does not fetch HealthKit data.
- Confirm Watch app does not fetch HealthKit data.
- Confirm no raw HealthKit samples are stored in App Group shared state.
- Confirm no HealthKit write access was added.
- Confirm no networking, upload path, remote config, cloud sync, WatchConnectivity, login, subscription, server call, or AI was added.
- Confirm no visual redesign, icons, check-in UI, bilingual UI, localization, or Watch/WidgetKit UI changes were added.
- Confirm local iOS XCTest passes on a concrete installed iPhone simulator.
- Confirm local iOS build passes on an installed iPhone simulator.
- Confirm local watchOS app build passes on an installed Apple Watch simulator.
- Confirm local WidgetKit complication build passes on an installed Apple Watch simulator.
- Confirm GitHub Actions is not manually triggered or used as the debugging loop.

## Phase 8.4 QA Audit for Feature-Flagged HealthKit Dashboard

- Confirm the HealthKit Dashboard feature flag defaults off.
- Confirm Dashboard remains mock-backed when the flag is off.
- Confirm the default Dashboard mock values remain stable: score `76`, state label `Mixed`, confidence `Medium`, Dashboard demo text, and shared summary updated text `Demo`.
- Confirm the HealthKit path only runs when the local flag is on.
- Confirm HealthKit-derived assessment scores remain within `0...100`.
- Confirm the HealthKit path reuses the existing HealthKit snapshot, baseline, and scoring pipeline instead of duplicating scoring logic.
- Confirm HealthKit unavailable, unauthorized, empty, sparse, low-confidence, and failed scoring/loading states fall back safely.
- Confirm missing data is not treated as a negative health status.
- Confirm fallback copy remains calm and avoids diagnosis, disease detection, clinical stress detection, treatment, warning, alert, emergency, or medical advice language.
- Confirm Watch app behavior remains unchanged.
- Confirm WidgetKit behavior remains unchanged.
- Confirm App Group behavior remains mock-only.
- Confirm no HealthKit-derived summary is propagated to App Group.
- Confirm no raw HealthKit samples are stored in App Group.
- Confirm WidgetKit complications do not fetch HealthKit directly.
- Confirm the Watch app does not fetch HealthKit directly.
- Confirm no HealthKit write access was added.
- Confirm no networking, upload path, remote config, cloud sync, WatchConnectivity, login, server call, or AI was added.
- Confirm no visual-first UI, icon assets, check-in UI, bilingual UI, localization, or Dashboard layout changes were added.
- Confirm future UI, icon, state imagery, check-in, complication, or bilingual work still uses the existing Figma design system as the source of truth first.
- Confirm local Xcode validation was used.
- Confirm GitHub Actions was not manually triggered.

## Phase 8.5 Low-Data / Missing-Data Safety Audit for HealthKit Dashboard

- Confirm missing HealthKit authorization is safe.
- Confirm empty HealthKit snapshots are safe.
- Confirm empty sleep, HRV, resting heart rate, and activity/load inputs are safe.
- Confirm sparse or partial data is safe.
- Confirm stale data is safe and does not produce strong current-state claims.
- Confirm scoring failure does not crash.
- Confirm impossible finite inputs do not crash and any produced score remains within `0...100`.
- Confirm missing data is not treated as negative health status.
- Confirm low confidence does not produce strong advice.
- Confirm unavailable data is not described as bad health.
- Confirm Dashboard remains mock-backed when the feature flag is off.
- Confirm the HealthKit path only runs when the feature flag is on.
- Confirm Watch app behavior remains unchanged.
- Confirm WidgetKit behavior remains unchanged.
- Confirm App Group behavior remains mock-only.
- Confirm no HealthKit-derived summary is propagated to App Group.
- Confirm no raw HealthKit samples are stored in App Group.
- Confirm WidgetKit complications do not fetch HealthKit directly.
- Confirm the Watch app does not fetch HealthKit directly.
- Confirm no HealthKit write access was added.
- Confirm no networking, upload path, remote config, cloud sync, WatchConnectivity, login, server call, or AI was added.
- Confirm no visual-first UI, icon assets, check-in UI, bilingual UI, localization, or Dashboard layout changes were added.
- Confirm future UI, icon, state imagery, check-in, complication, or bilingual work still uses the existing Figma design system as the source of truth first.
- Confirm local Xcode validation was used.
- Confirm GitHub Actions was not manually triggered.

## Phase 8.6 Production Wording and App Store Safety Audit

- Confirm `Docs/phase-8-6-production-wording-audit.md` exists.
- Confirm production-facing Dashboard, Watch, WidgetKit, onboarding, permission, privacy, and debug-preview copy uses cautious wellness wording.
- Confirm user-facing component labels use `Fatigue Context` instead of `Stress/Fatigue`.
- Confirm low-data summaries do not use treatment-like phrasing such as `treat this as`.
- Confirm missing, sparse, stale, denied, or unavailable data is described as `low data`, `not enough recent data`, `unavailable`, or lower confidence, not as a bad health state.
- Confirm copy does not claim medical diagnosis, disease detection, illness detection, clinical stress detection, treatment, emergency alerting, abnormal-health warnings, medical risk prediction, or medical advice.
- Confirm any high-risk words appear only in disclaimers or forbidden-word safety checklists.
- Confirm correlation copy uses pattern language and avoids causal claims such as `you feel tired because you slept less`.
- Confirm HealthKit-backed Dashboard remains behind the default-off local feature flag.
- Confirm production iPhone Dashboard remains mock-backed by default.
- Confirm HealthKit-derived output is not propagated to Watch, WidgetKit, or App Group shared state.
- Confirm Watch app behavior remains unchanged.
- Confirm WidgetKit behavior remains unchanged.
- Confirm App Group shared state remains mock-only and summary-only.
- Confirm no raw HealthKit samples are stored in App Group shared state.
- Confirm no HealthKit write access, networking, cloud sync, account system, analytics rollout, remote config, server upload, or AI cloud analysis was added.
- Confirm local Xcode validation was used.

## Phase 8.9 Real-Device HealthKit QA Plan

- Confirm `Docs/phase-8-9-real-device-healthkit-qa-plan.md` exists.
- Confirm the plan requires a real iPhone for meaningful HealthKit validation.
- Confirm a paired Apple Watch is recommended, but not required, for richer real-device data.
- Confirm simulator validation is described as useful for builds but insufficient for real HealthKit data behavior.
- Confirm the HealthKit Dashboard feature flag remains local-only and default-off.
- Confirm the production Dashboard remains mock-backed when the flag is off or reset.
- Confirm local internal testing instructions do not add a public Settings toggle, remote config, account control, or analytics control.
- Confirm HealthKit permission test cases cover first launch, allowed access, denied access, revoked access, partial data, no sleep data, no activity data, stale data, sparse data, low confidence, and unavailable/fetch-failure states.
- Confirm missing, denied, sparse, stale, low-confidence, and unavailable data are expected to lower confidence, show unavailable/low-data/fallback behavior, or keep mock data instead of creating a negative health state.
- Confirm evidence collection excludes raw HealthKit samples, full health history, identifiable screenshots, exported Health databases, cloud logs containing health data, and user account health profiles.
- Confirm HealthKit-derived output remains isolated to the feature-flagged iPhone Dashboard path and is not propagated to Watch, WidgetKit, or App Group shared state.
- Confirm no networking, upload path, cloud sync, AI, analytics, remote config, account system, WatchConnectivity, or HealthKit write access was added.
- Confirm no Phase 9 State Check-in or Watch/WidgetKit HealthKit propagation work was started.
- Confirm GitHub Actions is not manually triggered or used as the debugging loop.

## Phase 9.0 State Check-in Architecture Design

- Confirm `Docs/phase-9-0-state-checkin-architecture.md` exists.
- Confirm State Check-in is documented as subjective self-report only.
- Confirm the initial states are exactly `Energized`, `Stable`, `Tired`, and `Low`.
- Confirm Traditional Chinese labels are exactly `有活力`, `穩定`, `疲累`, and `低狀態`.
- Confirm the architecture avoids emotion diagnosis, mental-health diagnosis, anxiety detection, depression detection, clinical stress detection, disease detection, treatment, emergency, abnormal-state, and medical advice claims.
- Confirm future timing concepts such as morning, midday, and evening do not add scheduling, reminders, notifications, or background delivery in Phase 9.0.
- Confirm the proposed model is documentation-only and no Swift `StateCheckIn` implementation was added.
- Confirm local-only storage direction is documented without adding storage, cloud sync, account systems, analytics, AI, or developer-accessible data.
- Confirm App Group use is deferred and raw check-in history, notes, HealthKit samples, and HealthKit objects are excluded from future shared state.
- Confirm HealthKit relationship is complementary and avoids causal or medical-signal claims.
- Confirm missing check-ins remain optional and do not imply a bad state or lower HealthKit-derived scores.
- Confirm future UI work is gated by Figma, especially Watch layout, icon buttons, and bilingual layout.
- Confirm no iPhone UI, Watch UI, WidgetKit display, App Group propagation, WatchConnectivity, HealthKit write access, networking, remote config, or Phase 9.1+ work was added.
- Confirm GitHub Actions is not manually triggered or used as the debugging loop.

## Phase 9.1 State Check-in Architecture QA

- Confirm `Docs/phase-9-1-state-checkin-architecture-qa.md` exists.
- Confirm the QA audit reviewed `Docs/phase-9-0-state-checkin-architecture.md` and related safety, privacy, scoring, rollout, and planning docs.
- Confirm State Check-in remains subjective self-report only.
- Confirm the approved states remain exactly `Energized`, `Stable`, `Tired`, and `Low`.
- Confirm Traditional Chinese labels remain exactly `有活力`, `穩定`, `疲累`, and `低狀態`.
- Confirm no diagnosis, mental-health detection, anxiety detection, depression detection, clinical stress detection, treatment, therapy, emergency, warning, abnormal-state, or medical-advice claims were introduced.
- Confirm missing check-ins remain optional and are not treated as negative or score-lowering.
- Confirm future storage remains local-only and no cloud, developer-accessible database, analytics, AI cloud profiling, ad profile, networking, or remote config was added.
- Confirm HealthKit relationship remains complementary and non-causal.
- Confirm App Group, WidgetKit, WatchConnectivity, HealthKit write, reminders, notifications, scheduling, storage, and UI implementation remain out of scope.
- Confirm Figma-first sequencing is preserved before any Watch, iPhone, bilingual, icon, or complication UI implementation.
- Confirm Phase 9.2, Phase 9.3, and Phase 9.4 remain future work.
- Confirm GitHub Actions is not manually triggered or used as the debugging loop.

## Phase 9.2 Watch Check-in Figma Mockups

- Confirm `Docs/phase-9-2-watch-checkin-figma-mockups.md` exists.
- Confirm the phase is documentation and Figma handoff planning only.
- Confirm no Swift source files, Xcode project files, assets, or Figma binary files changed.
- Confirm the approved states are exactly `Energized`, `Stable`, `Tired`, and `Low`.
- Confirm Traditional Chinese labels are exactly `有活力`, `穩定`, `疲累`, and `低狀態`.
- Confirm at least two Watch layout options are documented.
- Confirm confirmation, no-check-in-yet, and unavailable copy is calm and non-alarming.
- Confirm icon direction remains placeholder-level only.
- Confirm the Figma handoff checklist exists before Phase 9.3 SwiftUI work.
- Confirm no check-in storage, reminders, notifications, WidgetKit check-in display, App Group propagation, WatchConnectivity, networking, cloud, analytics, remote config, AI, HealthKit write access, or HealthKit rollout behavior was added.
- Confirm GitHub Actions is not manually triggered or used as the debugging loop.

## Phase 9.3 Watch Check-in Mock UI

- Confirm Watch app builds and launches to the existing mock-backed dashboard.
- Confirm the Watch Dashboard includes a visible `Check in` entry as a Watch tab.
- Confirm the check-in screen uses exactly these options: `Energized`, `Stable`, `Tired`, and `Low`.
- Confirm Traditional Chinese reference labels remain exactly `有活力`, `穩定`, `疲累`, and `低狀態`.
- Confirm each option can be tapped on Apple Watch and shows a calm confirmation state.
- Confirm the confirmation copy is `Saved`, `Check-in saved`, and `You can update it later.`
- Confirm `Done` returns to the check-in option list.
- Confirm selected check-in state is held in memory only and is not persisted.
- Confirm no check-in storage, reminders, notifications, WidgetKit check-in display, App Group propagation, WatchConnectivity, networking, cloud, analytics, remote config, AI, HealthKit write access, or HealthKit rollout behavior was added.
- Confirm the iPhone Dashboard remains mock-backed and HealthKit-backed Dashboard remains feature-flagged/default-off.
- Confirm the Watch score, state label, confidence, metrics, and suggestion remain mock-backed and are not affected by check-in selection.
- Confirm WidgetKit complications remain mock-backed and do not display check-in state.
- Confirm no medical, diagnostic, clinical, warning, emergency, treatment, or cause-and-effect wording appears in check-in UI copy.
- Confirm GitHub Actions is not manually triggered or used as the debugging loop.

## Phase 9.4 Watch Check-in Mock UI QA

- Confirm `Docs/phase-9-4-watch-checkin-mock-ui-qa.md` exists.
- Confirm this phase is QA/documentation-first and does not add product behavior.
- Confirm `WatchCheckInView` is reachable as a page inside the Watch Dashboard `TabView`.
- Confirm any `tab` wording refers to the existing Watch `TabView` page, not a new navigation architecture.
- Confirm `StateCheckInOption` remains UI-only and does not introduce storage fields, schema versions, migrations, HealthKit data, or sharing fields.
- Confirm `selectedOption` and `showsConfirmation` remain private `@State` inside `WatchCheckInView`.
- Confirm selected check-in state does not escape `WatchCheckInView`.
- Confirm check-in selection does not modify score, state label, confidence, metrics, suggestion, WidgetKit complications, App Group summary, or iPhone state.
- Confirm no check-in storage, UserDefaults, @AppStorage, SwiftData, CoreData, FileManager persistence, database, schema, or migration logic was added.
- Confirm no reminders, notifications, scheduling, WidgetKit check-in display, App Group propagation, WatchConnectivity, networking, cloud, analytics, remote config, AI, HealthKit write access, or HealthKit rollout behavior was added.
- Confirm the approved states are exactly `Energized`, `Stable`, `Tired`, and `Low`.
- Confirm Traditional Chinese references are exactly `有活力`, `穩定`, `疲累`, and `低狀態`.
- Confirm user-facing copy remains subjective, calm, optional, and non-medical.
- Confirm `Low` uses calm styling and does not appear as a red alert, danger state, health warning, or medical condition.
- Confirm existing tests cover approved labels, Traditional Chinese references, safe confirmation copy, forbidden medical wording, and storage/sync concept drift.
- Confirm GitHub Actions is not manually triggered or used as the debugging loop.

## Phase 9.5 State Check-in Local Storage Design

- Confirm `Docs/phase-9-5-state-checkin-local-storage-design.md` exists.
- Confirm Phase 9.5 is architecture/documentation only.
- Confirm no check-in storage implementation was added.
- Confirm future `StateCheckInRecord` fields are documented.
- Confirm explicitly excluded fields include raw HealthKit samples, diagnoses, clinical labels, treatment recommendations, cloud/account/ad/analytics identifiers, precise location, unnecessary device identifiers, and hidden AI profile information.
- Confirm storage options compare UserDefaults, local JSON file, SwiftData, and CoreData.
- Confirm the recommended first implementation is a small local JSON file or equivalent lightweight local store behind a narrow repository/service abstraction.
- Confirm future deletion and clear-all expectations are documented.
- Confirm retention remains local, conservative, and avoids permanent-history or cloud-backup promises.
- Confirm missing check-ins remain neutral and do not reduce State Score.
- Confirm `Low` check-ins remain subjective, non-medical, and non-warning.
- Confirm HealthKit remains read-only and check-in records do not store raw HealthKit samples.
- Confirm WidgetKit does not read check-ins directly.
- Confirm App Group does not store raw check-in history or notes.
- Confirm WatchConnectivity remains deferred to a separate future phase.
- Confirm no reminders, notifications, scheduling, networking, cloud sync, iCloud sync, AI cloud analysis, accounts, analytics, remote config, or HealthKit write access was added.
- Confirm no iPhone check-in UI or Watch check-in behavior change was added.
- Confirm GitHub Actions is not manually triggered or used as the debugging loop.

## Phase 9.6 State Check-in Local Storage Design QA

- Confirm `Docs/phase-9-6-state-checkin-local-storage-design-qa.md` exists.
- Confirm Phase 9.6 is QA/documentation only.
- Confirm no check-in storage implementation was added.
- Confirm no Swift source, Xcode project, entitlement, or CI workflow files were changed.
- Confirm the future `StateCheckInRecord` concept remains narrow and privacy-safe.
- Confirm included fields are minimal and justified.
- Confirm excluded fields cover raw HealthKit samples, diagnoses, clinical labels, treatment recommendations, anxiety/depression labels, inferred emotions, cloud/account/ad/analytics identifiers, remote config variants, precise location, unnecessary device identifiers, and hidden AI profile information.
- Confirm local JSON or an equivalent lightweight local store remains recommended only behind a narrow repository/service abstraction.
- Confirm raw `UserDefaults` arrays are not recommended for check-in history.
- Confirm atomic writes, decode-failure behavior, corruption handling, and schema versioning are required for the future implementation phase.
- Confirm deletion, clear-all, and conservative local retention expectations remain documented.
- Confirm notes and export remain deferred until later privacy-reviewed phases.
- Confirm missing check-ins remain neutral and non-score-lowering.
- Confirm `Low` check-ins remain subjective, non-medical, and non-warning.
- Confirm State Score relationship remains non-medical and non-punitive.
- Confirm HealthKit remains read-only and check-in records do not store raw HealthKit samples.
- Confirm WidgetKit direct check-in reads remain forbidden.
- Confirm App Group raw check-in history and notes remain forbidden.
- Confirm WatchConnectivity remains deferred to a separate future design and QA phase.
- Confirm future pattern summaries remain local-only and non-causal.
- Confirm no reminders, notifications, scheduling, networking, cloud sync, iCloud sync, AI cloud analysis, accounts, analytics, remote config, HealthKit write access, HealthKit rollout change, iPhone check-in UI, Watch check-in behavior change, or Phase 9.7 implementation work was added.
- Confirm GitHub Actions is not manually triggered or used as the debugging loop.

## Phase 9.7 Watch Check-in Local Storage Foundation

- Confirm `Docs/phase-9-7-watch-checkin-local-storage-foundation.md` exists.
- Confirm Watch Check-in storage is local-only and limited to the Watch app surface.
- Confirm `StateCheckInRecord` includes only `id`, `option`, `createdAt`, `updatedAt`, `sourceSurface`, `schemaVersion`, and `noteStatus`.
- Confirm `StateCheckInRecord` does not store raw HealthKit samples, inferred health state, diagnosis, clinical labels, treatment recommendations, cloud identifiers, account identifiers, advertising identifiers, analytics identifiers, remote config variants, precise location, unnecessary device identifiers, hidden AI profile information, or free-form notes.
- Confirm the approved states remain exactly `Energized`, `Stable`, `Tired`, and `Low`.
- Confirm Traditional Chinese references remain exactly `有活力`, `穩定`, `疲累`, and `低狀態`.
- Confirm the store uses a local JSON file or equivalent lightweight local store behind a narrow storage protocol.
- Confirm local writes are atomic.
- Confirm empty history loads safely.
- Confirm corrupted JSON loads safely as empty history and does not crash.
- Confirm unknown future schema versions are ignored safely.
- Confirm clear-all behavior is available for future deletion UI and tests.
- Confirm Watch Check-in save confirmation remains calm and non-medical.
- Confirm unavailable storage copy remains calm and does not imply a bad health state.
- Confirm missing check-ins remain neutral and non-score-lowering.
- Confirm `Low` remains subjective, non-medical, and non-warning.
- Confirm check-ins do not change State Score, state label, confidence, metrics, suggestions, HealthKit-derived output, WidgetKit complications, App Group summary, iPhone Dashboard state, or Watch score state.
- Confirm iPhone Dashboard remains mock-backed by default and HealthKit-backed Dashboard remains feature-flagged/default-off.
- Confirm no iPhone check-in UI was added.
- Confirm no WidgetKit check-in display was added.
- Confirm no WidgetKit reads of check-in records were added.
- Confirm no App Group check-in propagation was added.
- Confirm raw check-in history is not stored in App Group shared state.
- Confirm no WatchConnectivity was added.
- Confirm no reminders, notifications, scheduling, or background delivery were added.
- Confirm no HealthKit write access or HealthKit write authorization was added.
- Confirm no networking, cloud sync, iCloud sync, accounts, analytics, remote config, AI, or AI cloud analysis was added.
- Confirm XCTest covers record coding, stable schema version, approved labels, empty history, save/load, recent-history ordering, clear-all, corrupted JSON, unknown schema fallback, and prohibited propagation/upload mechanisms.
- Confirm GitHub Actions is not manually triggered or used as the debugging loop.

## Phase 9.8 Watch Check-in Local Storage Foundation QA

- Confirm `Docs/phase-9-8-watch-checkin-local-storage-foundation-qa.md` exists.
- Confirm Phase 9.8 is QA/documentation-only unless a concrete issue requires a minimal fix.
- Confirm no production Swift files, Xcode project files, entitlements, or CI workflows changed unless a concrete audit issue required it.
- Confirm Phase 9.7 implementation remains Watch-only.
- Confirm `StateCheckInRecord` remains limited to `id`, `option`, `createdAt`, `updatedAt`, `sourceSurface`, `schemaVersion`, and `noteStatus`.
- Confirm `StateCheckInRecord` stores stable `StateCheckInOption` raw values, not localized display labels.
- Confirm `StateCheckInSourceSurface` remains Watch-only for now.
- Confirm `StateCheckInNoteStatus` stores metadata only and no free-form notes.
- Confirm `LocalStateCheckInStore` remains app-container scoped and does not use App Group storage.
- Confirm the default storage directory is Application Support, with temporary directory only as a local fallback.
- Confirm writes remain atomic.
- Confirm missing storage file, corrupted JSON, and unsupported future schema versions load safely as empty history.
- Confirm `loadRecent` returns newest-first results and respects its limit.
- Confirm `save` replaces records with the same local id rather than duplicating them.
- Confirm `clearAll` removes the local file safely and is covered by tests.
- Confirm `WatchCheckInView` save wiring remains minimal and uses calm unavailable copy on save failure.
- Confirm unavailable storage copy does not imply a bad health state, warning, emergency, diagnosis, treatment, or clinical claim.
- Confirm check-ins do not affect State Score, component scores, confidence, reasons, suggestions, HealthKit-derived scoring, WidgetKit complications, App Group summary, iPhone Dashboard state, or Watch score state.
- Confirm missing check-ins remain neutral and non-score-lowering.
- Confirm `Low` check-ins remain subjective, non-medical, and non-warning.
- Confirm no iPhone check-in UI or behavior was added.
- Confirm no WidgetKit check-in display or direct check-in read was added.
- Confirm no App Group raw check-in history or check-in propagation was added.
- Confirm no WatchConnectivity was added.
- Confirm no HealthKit write access or HealthKit write authorization was added.
- Confirm no raw HealthKit samples are stored in check-in records.
- Confirm no reminders, notifications, scheduling, export, notes, or pattern summaries were added.
- Confirm no networking, cloud sync, iCloud sync, analytics, remote config, AI, account system, upload path, or developer-accessible database was added.
- Confirm XCTest coverage still includes record coding, approved labels, stable schema, forbidden fields, empty history, save/load, newest-first history, clear-all, corrupted JSON, future-schema fallback, and forbidden propagation/upload mechanisms.
- Confirm local validation is used as the source of truth if GitHub Actions quota or availability is limited.
- Confirm GitHub Actions is not manually triggered or used as the debugging loop.
- Confirm no Phase 9.9 work was started.

## Phase 9.9 Watch Check-in Display Preference

- Confirm `Docs/phase-9-9-watch-checkin-display-preference.md` exists.
- Confirm Watch Check-in supports `iconAndText`, `iconOnly`, and `textOnly` display modes.
- Confirm `iconAndText` remains the default display mode.
- Confirm invalid or missing stored display preference values fall back to `iconAndText`.
- Confirm the display preference stores only a tiny raw value in Watch app `UserDefaults.standard`.
- Confirm the display preference key remains `statewatch.watchCheckIn.displayMode.v1`.
- Confirm the display preference does not store check-in records, check-in history, notes, HealthKit data, score output, or raw HealthKit samples.
- Confirm `StateCheckInRecord` schema remains unchanged.
- Confirm `LocalStateCheckInStore` remains the check-in history store and was not replaced with UserDefaults arrays.
- Confirm no `UserDefaults(suiteName:)` production storage was added for the display preference.
- Confirm no App Group check-in propagation was added.
- Confirm no WidgetKit check-in display or direct check-in read was added.
- Confirm no WatchConnectivity was added.
- Confirm no reminders, notifications, scheduling, or background delivery were added.
- Confirm no iPhone check-in UI or behavior was added.
- Confirm Watch score, state label, confidence, metrics, suggestion, WidgetKit complications, App Group summary, HealthKit-derived output, and iPhone state remain unaffected by the display preference.
- Confirm HealthKit rollout behavior remains unchanged and default-off where applicable.
- Confirm no HealthKit write access or HealthKit write authorization was added.
- Confirm no networking, cloud sync, iCloud sync, accounts, analytics, remote config, AI, or AI cloud analysis was added.
- Confirm icon-only mode keeps meaningful accessibility labels for all check-in options.
- Confirm the four approved states remain exactly `Energized`, `Stable`, `Tired`, and `Low`.
- Confirm user-facing copy remains subjective, calm, and non-medical.
- Confirm no diagnosis, anxiety detection, depression detection, clinical stress detection, disease detection, treatment, therapy, emergency, warning, abnormal-state, or medical-advice wording was introduced.
- Confirm XCTest covers stable display mode raw values, labels, default fallback, invalid fallback, save/load, storage value boundaries, and forbidden propagation/upload mechanisms.
- Confirm local validation is used as the source of truth if GitHub Actions quota or availability is limited.
- Confirm GitHub Actions is not manually triggered or used as the debugging loop.

## Phase 9.10 Watch Check-in Display Preference QA

- Confirm `Docs/phase-9-10-watch-checkin-display-preference-qa.md` exists.
- Confirm Phase 9.10 is QA/documentation-only unless a concrete audit issue requires a minimal fix.
- Confirm Phase 9.9 implementation remains Watch-only.
- Confirm display modes remain exactly `iconAndText`, `iconOnly`, and `textOnly`.
- Confirm no new display modes were added.
- Confirm `iconAndText` remains the default display mode.
- Confirm invalid or missing stored display preference values fall back to `iconAndText`.
- Confirm the display preference key remains `statewatch.watchCheckIn.displayMode.v1`.
- Confirm the display preference stores only the display mode raw value.
- Confirm production display preference storage uses Watch app `UserDefaults.standard`.
- Confirm production display preference storage does not use `UserDefaults(suiteName:)`, App Group storage, iCloud key-value storage, or shared container storage.
- Confirm test-only isolated `UserDefaults(suiteName:)` usage remains limited to XCTest.
- Confirm check-in history is not stored in UserDefaults.
- Confirm `StateCheckInRecord` schema remains unchanged.
- Confirm `LocalStateCheckInStore` history behavior remains unchanged.
- Confirm icon-only mode keeps meaningful accessibility labels for all check-in options.
- Confirm text-only mode remains visually clear and accessible.
- Confirm the display preference selector has clear accessibility labeling.
- Confirm the check-in save flow remains separate from display preference updates.
- Confirm display preference does not affect State Score, component scores, confidence, reasons, suggestions, HealthKit-derived scoring, WidgetKit complications, App Group summary, iPhone Dashboard state, or Watch score state.
- Confirm missing check-ins remain neutral and do not lower State Score.
- Confirm `Low` check-ins remain subjective, non-medical, and non-warning.
- Confirm no iPhone check-in UI or behavior was added.
- Confirm no WidgetKit check-in display or direct check-in read was added.
- Confirm no App Group raw check-in history or display preference propagation was added.
- Confirm no WatchConnectivity was added.
- Confirm no HealthKit write access or HealthKit write authorization was added.
- Confirm no raw HealthKit samples are stored in check-in records, UserDefaults, App Group, or WidgetKit.
- Confirm no reminders, notifications, scheduling, export, notes, or pattern summaries were added.
- Confirm no networking, cloud sync, iCloud sync, analytics, remote config, AI, account system, login, upload path, or developer-accessible database was added.
- Confirm user-facing copy remains subjective, calm, and non-medical.
- Confirm no diagnosis, anxiety detection, depression detection, clinical stress detection, disease detection, treatment, therapy, emergency, warning, abnormal-state, health-risk, or medical-advice wording was introduced.
- Confirm XCTest coverage includes display mode raw values, labels, IDs, default fallback, invalid fallback, save/load, raw-value storage, no check-in record storage, forbidden mechanism source checks, and non-medical display mode copy.
- Confirm local validation is used as the source of truth if GitHub Actions quota or availability is limited.
- Confirm GitHub Actions is not manually triggered or used as the debugging loop.
- Confirm no Phase 9.11 work was started.

## Phase 9.11 Watch Check-in History Management Design

- Confirm `Docs/phase-9-11-watch-checkin-history-management-design.md` exists.
- Confirm Phase 9.11 is design/documentation-only.
- Confirm no production Swift files changed.
- Confirm no Xcode project files changed.
- Confirm no entitlements changed.
- Confirm no CI workflows changed.
- Confirm no product behavior changed.
- Confirm no history UI was implemented.
- Confirm no deletion UI was implemented.
- Confirm no clear-all UI was implemented.
- Confirm no new storage behavior was implemented.
- Confirm no `StateCheckInRecord` schema change was added.
- Confirm no `LocalStateCheckInStore` behavior change was added.
- Confirm the recommended future recent history list is Watch-only.
- Confirm the recommended first visible history limit is the latest 3 check-ins.
- Confirm any latest-5 history display remains a future readability-dependent option only.
- Confirm single-record deletion remains future design and was not implemented.
- Confirm clear-all remains future design and was not implemented.
- Confirm empty history uses calm neutral copy such as `No check-ins yet` and `Check-ins are optional.`
- Confirm missing check-ins remain neutral and non-score-lowering.
- Confirm `Low` check-ins remain subjective, non-medical, non-warning, and not styled as danger or emergency.
- Confirm future deletion copy states local Watch scope and does not imply HealthKit, cloud, account, or medical-record deletion.
- Confirm no iPhone check-in UI or behavior was added.
- Confirm no WidgetKit check-in display or direct check-in read was added.
- Confirm no App Group raw check-in history, display preference, deletion state, or check-in propagation was added.
- Confirm no raw check-in history is stored in App Group shared state.
- Confirm no WatchConnectivity was added.
- Confirm no HealthKit write access or HealthKit write authorization was added.
- Confirm no raw HealthKit samples are stored in check-in records.
- Confirm HealthKit rollout behavior remains unchanged and default-off where applicable.
- Confirm no reminders, notifications, scheduling, export, notes, or pattern summaries were added.
- Confirm no networking, cloud sync, iCloud sync, analytics, remote config, AI, AI cloud analysis, account system, login, upload path, or developer-accessible database was added.
- Confirm check-ins do not affect State Score, component scores, confidence, reasons, suggestions, HealthKit-derived scoring, WidgetKit complications, App Group summary, iPhone Dashboard state, or Watch score state.
- Confirm user-facing copy remains subjective, calm, and non-medical.
- Confirm no diagnosis, anxiety detection, depression detection, clinical stress detection, disease detection, treatment, therapy, emergency, warning, abnormal-state, health-risk, symptom-history, medical-record, or medical-advice wording was introduced outside safety guardrails or forbidden-copy examples.
- Confirm future implementation requires a separate implementation phase and QA phase.
- Confirm local validation is used as the source of truth if GitHub Actions quota or availability is limited.
- Confirm GitHub Actions is not manually triggered or used as the debugging loop.
- Confirm no Phase 9.12 implementation or later work was started.

## Phase 9.12 Watch Check-in History Management Design QA

- Confirm `Docs/phase-9-12-watch-checkin-history-management-design-qa.md` exists.
- Confirm Phase 9.12 is QA/documentation-only.
- Confirm no production Swift files changed.
- Confirm no Xcode project files changed.
- Confirm no entitlements changed.
- Confirm no CI workflows changed.
- Confirm no product behavior changed.
- Confirm no history UI was implemented.
- Confirm no deletion UI was implemented.
- Confirm no clear-all UI was implemented.
- Confirm no settings UI was implemented.
- Confirm no new storage behavior was implemented.
- Confirm Phase 9.11 history management design remains Watch-only.
- Confirm the recommended first visible history limit remains the latest 3 check-ins.
- Confirm the latest 5 history option remains future and readability-dependent only.
- Confirm single-record deletion remains future implementation work.
- Confirm clear-all remains future implementation work.
- Confirm `StateCheckInRecord` schema remains unchanged.
- Confirm `LocalStateCheckInStore` behavior remains unchanged.
- Confirm no raw check-in history is stored in `UserDefaults`.
- Confirm no raw check-in history is stored in App Group shared state.
- Confirm no App Group check-in propagation, display preference propagation, or deletion state propagation was added.
- Confirm no WidgetKit check-in display or direct check-in read was added.
- Confirm no WatchConnectivity was added.
- Confirm no iPhone check-in UI or behavior was added.
- Confirm no HealthKit write access or HealthKit write authorization was added.
- Confirm HealthKit rollout behavior remains unchanged and default-off where applicable.
- Confirm no raw HealthKit samples are stored in check-in records.
- Confirm no reminders, notifications, scheduling, export, notes, or pattern summaries were added.
- Confirm no networking, cloud sync, iCloud sync, analytics, remote config, AI, AI cloud analysis, account system, login, upload path, or developer-accessible database was added.
- Confirm check-ins do not affect State Score, component scores, confidence, reasons, suggestions, HealthKit-derived scoring, WidgetKit complications, App Group summary, iPhone Dashboard state, or Watch score state.
- Confirm missing check-ins remain neutral and non-score-lowering.
- Confirm `Low` check-ins remain subjective, non-medical, non-warning, and not styled or described as danger, risk, emergency, or abnormal state.
- Confirm future deletion and clear-all copy remains scoped to local Watch check-ins only.
- Confirm user-facing copy remains subjective, calm, and non-medical.
- Confirm risky wording appears only as safety guardrails or forbidden-copy examples.
- Confirm no diagnosis, anxiety detection, depression detection, clinical stress detection, disease detection, treatment, therapy, emergency, warning, abnormal-state, health-risk, symptom-history, medical-record, or medical-advice wording was introduced as approved product copy.
- Confirm future implementation still requires a separate implementation phase and QA phase.
- Confirm local validation is used as the source of truth if GitHub Actions quota or availability is limited.
- Confirm GitHub Actions is not manually triggered or used as the debugging loop.
- Confirm no Phase 9.13 implementation or later work was started.

## Phase 9.13 Watch Check-in Recent History and Deletion Foundation

- Confirm `Docs/phase-9-13-watch-checkin-recent-history-deletion-foundation.md` exists.
- Confirm the Watch Check-in screen shows recent check-ins only on Apple Watch.
- Confirm the recent list is capped at the latest 3 records.
- Confirm recent history is ordered newest-first.
- Confirm empty history uses neutral copy: `No check-in yet` and `Check-ins are optional.`
- Confirm saving a new check-in refreshes the recent history list.
- Confirm each recent row shows a subjective state label and compact timestamp context.
- Confirm icon-only display preference does not remove meaningful accessibility labels.
- Confirm single-record deletion is available for recent check-ins.
- Confirm deletion uses calm local-only confirmation copy.
- Confirm deleting one record removes only that matching local Watch record.
- Confirm deleting a missing record is a safe no-op.
- Confirm deletion failure uses calm fallback copy and does not imply a bad health state.
- Confirm no clear-all UI was added.
- Confirm no history export was added.
- Confirm no notes, free-form text, causes, interpretations, trends, counts, streaks, or pattern summaries were added.
- Confirm `StateCheckInRecord` schema remains limited to `id`, `option`, `createdAt`, `updatedAt`, `sourceSurface`, `schemaVersion`, and `noteStatus`.
- Confirm no HealthKit sample identifiers, raw HealthKit samples, symptoms, medical fields, account identifiers, analytics identifiers, cloud identifiers, or AI profile fields were added to the record schema.
- Confirm `LocalStateCheckInStore.delete(id:)` is local-only and uses the existing Watch-local JSON store.
- Confirm Watch check-ins remain stored in the Watch app container only.
- Confirm no raw check-in history is stored in `UserDefaults`.
- Confirm no raw check-in history is stored in App Group shared state.
- Confirm no App Group check-in propagation, deletion state propagation, or display preference propagation was added.
- Confirm no WidgetKit check-in display or direct check-in read was added.
- Confirm no WatchConnectivity was added.
- Confirm no iPhone check-in UI, iPhone history display, iPhone deletion, or iPhone settings were added.
- Confirm no HealthKit write access or HealthKit write authorization was added.
- Confirm HealthKit rollout behavior remains unchanged and default-off where applicable.
- Confirm no raw HealthKit samples are stored in check-in records.
- Confirm check-ins do not affect State Score, component scores, confidence, reasons, suggestions, HealthKit-derived scoring, WidgetKit complications, App Group summary, iPhone Dashboard state, or Watch score state.
- Confirm missing check-ins remain neutral and non-score-lowering.
- Confirm `Low` check-ins remain subjective, non-medical, non-warning, and not styled or described as danger, risk, emergency, or abnormal state.
- Confirm no reminders, notifications, scheduling, background delivery, completion pressure, or prompts were added.
- Confirm no networking, cloud sync, iCloud sync, analytics, remote config, AI, AI cloud analysis, account system, login, upload path, or developer-accessible database was added.
- Confirm user-facing copy remains subjective, calm, and non-medical.
- Confirm no diagnosis, anxiety detection, depression detection, clinical stress detection, disease detection, treatment, therapy, emergency, warning, abnormal-state, health-risk, symptom-history, medical-record, or medical-advice wording was introduced as approved product copy.
- Confirm XCTest coverage includes latest-three newest-first history, single-record deletion, missing-record deletion no-op behavior, post-delete recent history, safe copy, and existing storage boundary checks.
- Confirm local validation is used as the source of truth if GitHub Actions quota or availability is limited.
- Confirm GitHub Actions is not manually triggered or used as the debugging loop.
- Confirm no Phase 9.14 QA or later work was started.

## Phase 9.14 Watch Check-in Recent History and Deletion QA

- Confirm `Docs/phase-9-14-watch-checkin-recent-history-deletion-qa.md` exists.
- Confirm Phase 9.14 is QA-first.
- Confirm no new product features were added unless a concrete minimal fix was required.
- Confirm Watch-only latest-3 recent history remains the only history surface.
- Confirm latest 5 was not implemented.
- Confirm recent history still uses `LocalStateCheckInStore.loadRecent(limit: 3)`.
- Confirm recent history remains newest-first.
- Confirm saving a check-in refreshes recent history.
- Confirm deleting a check-in refreshes recent history.
- Confirm single-record deletion remains Watch-local only.
- Confirm delete missing id is a safe no-op.
- Confirm existing `clearAll()` storage behavior remains intact.
- Confirm no clear-all UI was added.
- Confirm no `StateCheckInRecord` schema change was added.
- Confirm no history moved to `UserDefaults`.
- Confirm no raw history moved to App Group.
- Confirm no WidgetKit check-in display or direct read was added.
- Confirm no WatchConnectivity was added.
- Confirm no iPhone check-in UI, history, deletion, or settings were added.
- Confirm no HealthKit write access or HealthKit write authorization was added.
- Confirm no raw HealthKit samples are stored in check-in records.
- Confirm no networking, cloud sync, iCloud sync, analytics, AI, account system, login, upload path, or remote config was added.
- Confirm no reminders, notifications, scheduling, background delivery, completion pressure, export, notes, or pattern summaries were added.
- Confirm check-ins do not affect State Score, component scores, confidence, reasons, suggestions, HealthKit-derived scoring, WidgetKit complications, App Group summary, iPhone Dashboard state, or Watch score state.
- Confirm missing check-ins remain neutral and non-score-lowering.
- Confirm `Low` remains subjective, non-medical, non-warning, and non-score-lowering.
- Confirm user-facing copy remains calm, local-only, and non-medical.
- Confirm accessibility labels remain meaningful for check-in options, recent rows, delete actions, and delete confirmation.
- Confirm icon-only display preference does not remove accessibility meaning.
- Confirm tests cover recent history, latest-three ordering, single-record deletion, missing-id no-op deletion, post-delete history, copy safety, and storage boundaries.
- Confirm local validation passes.
- Confirm automatic GitHub Actions status is reviewed after PR creation.
- Confirm GitHub Actions is not manually rerun unless a clear transient or infrastructure failure is identified after local validation passes.
- Confirm no Phase 9.15 work was started.

## Phase 9.15 MVP Check-in Boundary Decision

- Confirm `Docs/phase-9-15-mvp-checkin-boundary-decision.md` exists.
- Confirm Phase 9.15 is design/documentation-only.
- Confirm MVP Check-in remains Watch-only.
- Confirm MVP Check-in remains local-only.
- Confirm no iPhone read-only check-in history was added.
- Confirm no iPhone check-in entry was added.
- Confirm no iPhone check-in deletion was added.
- Confirm no WidgetKit check-in summary/display was added.
- Confirm no WidgetKit direct check-in read was added.
- Confirm no App Group raw check-in history was added.
- Confirm no App Group check-in propagation was added.
- Confirm no WatchConnectivity was added.
- Confirm no State Score integration was added.
- Confirm no clear-all UI was added.
- Confirm no notes were added.
- Confirm no export was added.
- Confirm no reminders, notifications, scheduling, or background delivery were added.
- Confirm no trends, streaks, counts, causes, interpretations, or pattern summaries were added.
- Confirm no HealthKit write access or write authorization was added.
- Confirm no networking, cloud sync, iCloud sync, analytics, AI, account system, login, upload path, or remote config was added.
- Confirm missing check-ins remain neutral.
- Confirm `Low` check-ins remain subjective, non-medical, non-warning, and non-score-lowering.
- Confirm future iPhone, WidgetKit, App Group, WatchConnectivity, or State Score check-in work requires separate design, privacy, deletion, consistency, and QA phases.
- Confirm automatic GitHub Actions status is reviewed after PR creation.
- Confirm GitHub Actions is not manually rerun unless a clear transient or infrastructure failure is identified after local validation passes.
- Confirm no Phase 9.16 work was started.

## Phase 9.16 MVP Check-in Boundary QA

- Confirm `Docs/phase-9-16-mvp-checkin-boundary-qa.md` exists.
- Confirm Phase 9.16 is QA/documentation-only.
- Confirm Phase 9.15 decision remains unchanged.
- Confirm MVP Check-in remains Watch-only.
- Confirm MVP Check-in remains local-only.
- Confirm no iPhone read-only check-in history was added.
- Confirm no iPhone check-in entry, deletion, or management was added.
- Confirm no WidgetKit check-in display, summary, or direct read was added.
- Confirm no App Group raw check-in history, propagation, deletion state, or display preference propagation was added.
- Confirm no WatchConnectivity was added.
- Confirm no State Score integration was added.
- Confirm no clear-all UI was added.
- Confirm no notes or export were added.
- Confirm no reminders, notifications, scheduling, or background delivery were added.
- Confirm no trends, streaks, counts, causes, interpretations, or pattern summaries were added.
- Confirm no HealthKit write access or write authorization was added.
- Confirm no networking, cloud sync, iCloud sync, analytics, AI, account system, login, upload path, or remote config was added.
- Confirm missing check-ins remain neutral.
- Confirm `Low` check-ins remain subjective, non-medical, non-warning, and non-score-lowering.
- Confirm future iPhone, WidgetKit, App Group, WatchConnectivity, or State Score check-in work requires separate design, privacy, deletion, consistency, and QA phases.
- Confirm local validation passes.
- Confirm automatic GitHub Actions status is reviewed after PR creation.
- Confirm GitHub Actions is not manually rerun unless a clear transient or infrastructure failure is identified after local validation passes.
- Confirm no Phase 9.17 work was started.

## Phase 6.2 Watch App Visual Refresh

- Confirm PR #22 is merged before starting the Watch visual refresh branch.
- Confirm Watch app builds.
- Confirm Watch app launches to the refreshed mock-backed UI.
- Confirm the overall score screen is readable on a small Apple Watch simulator.
- Confirm the component summary is readable and includes Recovery, Sleep, Fatigue Context, and Activity Load.
- Confirm the suggestion screen uses calm non-medical wording.
- Confirm confidence and demo/updated text are visible.
- Confirm Watch app does not request HealthKit permission.
- Confirm Watch app does not fetch HealthKit data.
- Confirm no WidgetKit target was added.
- Confirm no App Groups were added.
- Confirm iPhone `DashboardView` still builds and remains mock-backed.
- Confirm no networking, upload path, AI feature, HealthKit write access, or medical diagnosis wording was introduced.
- Confirm `git diff --check origin/main...HEAD` passes.
- Confirm `plutil -lint StateWatch.xcodeproj/project.pbxproj` passes.
- Confirm GitHub Actions CI passes for iOS build, XCTest, and watchOS build before merge.

## Phase 6.3 Watch App Visual Refresh QA Audit

- Confirm PR #23 is merged before starting the Watch visual refresh QA branch.
- Confirm Watch app builds.
- Confirm Watch app launches to refreshed mock-backed UI.
- Confirm score screen is readable on a small Apple Watch simulator.
- Confirm component summary is readable and includes Recovery, Sleep, Fatigue Context, and Activity Load.
- Confirm suggestion screen uses calm non-medical wording.
- Confirm confidence and demo data screen is visible.
- Confirm Watch app does not request HealthKit permission.
- Confirm Watch app does not fetch HealthKit data.
- Confirm Watch app does not use WidgetKit.
- Confirm no WidgetKit target was added.
- Confirm no App Groups were added.
- Confirm iPhone `DashboardView` still builds and remains mock-backed.
- Confirm HealthKit Scoring Preview still opens in DEBUG.
- Confirm Visual Dashboard Preview still opens in DEBUG.
- Confirm `git diff --check origin/main...HEAD` passes.
- Confirm `plutil -lint StateWatch.xcodeproj/project.pbxproj` passes.
- Confirm GitHub Actions CI passes for iOS build, XCTest, and watchOS build before merge.

## Manual QA for MVP

- First launch shows disclaimer before HealthKit permission request.
- HealthKit permission copy explains local-only use.
- Dashboard remains usable if permission is denied.
- Mock previews render without real HealthKit data.
- Settings privacy view clearly states data handling.
- Watch app displays the refreshed mock score flow without needing HealthKit on watch.

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

## Manual HealthKit Scoring Preview Checks

- Run the `StateWatch` scheme on an iPhone simulator or device.
- Open Dashboard -> Settings.
- Open Developer Preview -> HealthKit Scoring Preview.
- Tap Load HealthKit Preview.
- Confirm the screen handles unavailable Apple Health access without crashing.
- Confirm no recent Apple Health samples show: "No recent Apple Health samples were available. The main dashboard can continue using mock data."
- Confirm sparse data can show: "There is not enough recent data to produce a confident preview yet."
- Confirm loaded data shows snapshot count, latest snapshot date, available metrics count, baseline confidence, component scores, component confidence, reasons, and suggestions.
- Confirm the production dashboard remains mock-backed after returning from the preview.
- Confirm no HealthKit write prompt appears.
- Confirm no network calls or upload paths are introduced.
