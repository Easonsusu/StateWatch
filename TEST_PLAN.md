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
- Overall state combines recovery, sleep, stress/fatigue context, and activity load with the MVP weights.
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
- CI checks diff whitespace, builds the `StateWatch` iOS scheme, runs the `StateWatch` XCTest suite, builds the `StateWatchWatchApp` watchOS scheme, and builds the `StateWatchComplications` WidgetKit scheme.
- CI disables code signing and compiler index storage for build/test verification.
- Local/manual testing is still required for HealthKit permission UI behavior and any real Apple Health data scenarios.

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
