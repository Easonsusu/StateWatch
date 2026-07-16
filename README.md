# StateWatch

StateWatch is an early-stage, local-first SwiftUI iOS + watchOS wellness app for reviewing recent recovery, sleep, fatigue context, and activity load signals from Apple Watch and Apple Health data.

The repository includes a runnable Xcode project, HealthKit read-permission handling, a local-only HealthKit data fetcher, baseline calculation, rule-based scoring engines, XCTest coverage, CI, a SwiftUI design-system foundation, a debug-only HealthKit Scoring Preview, a debug-only Visual Dashboard Preview, a WidgetKit complication foundation, and a mock-only App Group shared state foundation for iPhone, WidgetKit, and Watch surfaces.

StateWatch is still pre-release. The production iPhone dashboard and watchOS app now use the StateWatch dark technology-style visual direction, but both remain mock-backed. HealthKit-derived scoring is now available to the iPhone Dashboard only through an internal, default-off local feature flag. The default user experience remains mock-backed, and HealthKit-derived output is not propagated to Watch, WidgetKit, or App Group shared state.

## Current Status

- Runnable iOS app target: `StateWatch`.
- Runnable watchOS app target: `StateWatchWatchApp`.
- XCTest target: `StateWatchTests`.
- Production iPhone dashboard: redesigned with StateWatch design-system components and mock `StateAssessment` data.
- Production watch dashboard: visually refreshed and mock-backed; it can read a mock App Group readiness summary when available.
- WidgetKit complications: dedicated watch extension target that can read the iPhone-published mock dashboard summary and falls back to static mock data.
- Mock App Group shared state: implemented for a summary-only demo handoff using `group.com.easonsusu.StateWatch`.
- iPhone mock dashboard publishing: app launch publishes the current mock `StateAssessment` summary into App Group shared state.
- Watch mock shared-state reading: the Watch app reads the mock shared summary when available and uses static mock fallback otherwise.
- Shared local state architecture: documented for future production-ready summary sharing across iPhone, Watch, and WidgetKit surfaces.
- HealthKit-backed iPhone Dashboard path: implemented behind the local default-off `HealthKitDashboardFeatureFlag`; default production launch remains mock-backed.
- HealthKit permission flow: implemented for read-only access.
- HealthKit data fetcher: implemented locally for recent Apple Health samples.
- Baseline and scoring engines: implemented as local rule-based wellness estimates.
- Internal local HealthKit Dashboard feature flag: implemented with default-off local storage; when enabled internally, the iPhone Dashboard can attempt local HealthKit-derived scoring and falls back to mock data for unavailable, empty, sparse, or failed loads.
- Debug HealthKit Scoring Preview: available from Settings in debug builds.
- Debug Visual Dashboard Preview: available from Settings in debug builds.
- CI: GitHub Actions runs lightweight checks on draft PRs and full Xcode validation on ready PRs, pushes to `main`, or manual dispatch.

## Implemented

- `StateWatch.xcodeproj` with iOS, watchOS, and XCTest targets.
- SwiftUI app entry points for iPhone and Apple Watch.
- Core models including `DailyHealthSnapshot`, `HealthBaseline`, `StateAssessment`, `HealthMetricType`, and `UserCheckIn`.
- Mock sample data for previews, tests, and the default dashboard data source.
- HealthKit read-only permission foundation.
- HealthKit read type definitions for heart rate, resting heart rate, HRV SDNN, sleep analysis, step count, active energy burned, and workouts.
- Local-only `HealthKitDataFetcher` that converts recent HealthKit samples into `[DailyHealthSnapshot]`.
- `MockHealthDataFetcher` for previews, tests, denied permission states, and unavailable HealthKit environments.
- Baseline calculation across 7-day, 14-day, and 30-day windows.
- Rule-based recovery, sleep, fatigue-context, activity-load, and overall scoring engines.
- SwiftUI design-system tokens and reusable components.
- Production iPhone dashboard design refresh using the StateWatch design system while staying mock-backed.
- Production watchOS dashboard visual refresh while staying mock-backed.
- Mock WidgetKit complication extension target for accessory circular, rectangular, inline, and corner families.
- Mock App Group shared readiness summary model and `UserDefaults(suiteName:)` store.
- iPhone-side mock dashboard publisher that saves the production mock dashboard summary into shared state.
- Watch-side mock shared-state reader that maps the App Group summary into the Watch display model with static mock fallback.
- WidgetKit fallback behavior when iPhone-published mock shared summary data is unavailable, stale, or cannot be decoded.
- Documentation for future shared local state architecture in `Docs/shared-local-state-architecture.md`.
- Documentation for a future feature-flagged, local-only HealthKit-backed iPhone Dashboard rollout in `Docs/healthkit-dashboard-rollout-plan.md`.
- Local-only `HealthKitDashboardFeatureFlag` foundation with stable UserDefaults storage key `statewatch.feature.healthkitDashboard.enabled`; default remains off.
- Debug-only HealthKit Scoring Preview for inspecting snapshots, baselines, scoring output, missing-data behavior, reasons, and suggestions.
- Debug-only Visual Dashboard Preview for validating the future visual direction.
- Manual QA checklist, stabilization tests, and GitHub Actions CI.

## Intentionally Deferred

- Default-on or broadly released HealthKit-backed iPhone dashboard.
- Production HealthKit-backed Watch dashboard.
- Local persistence for snapshots and baselines.
- Real-device HealthKit QA.
- HealthKit-derived WidgetKit complication timelines.
- Production App Group shared state backed by real local scoring output.
- WatchConnectivity-backed state sharing.
- App Store release assets and final onboarding polish.
- Networking, upload paths, server sync, login, subscriptions, or backend services.
- AI features.
- HealthKit write access.

## Roadmap Notes

- HealthKit-backed iPhone Dashboard work now has a default-off, local-only implementation path for internal testing.
- HealthKit-derived scoring should not become the default production Dashboard until later QA explicitly approves enabling the local feature flag beyond internal validation.
- Developers should not have cloud or backend access to user HealthKit data.
- App Group shared state currently carries mock summary data only; production HealthKit-derived shared summaries remain deferred.
- The production iPhone app, Apple Watch app, and WidgetKit complications support English and Traditional Chinese (`zh-Hant`) through target-specific native String Catalogs. English remains the source and fallback language, and each surface follows the system language automatically.
- Future visual or localization-layout refinements should continue through Figma design review. Real-device Apple Watch and complication localization validation remains deferred.

## Privacy and Medical Safety Stance

StateWatch is a wellness app, not a medical diagnosis app. It must not claim to diagnose, treat, cure, or prevent disease; detect illness or clinical stress; provide medical advice; or replace professional guidance for medical concerns.

For the MVP:

- HealthKit data must remain local-only.
- HealthKit data must not be uploaded to a server.
- HealthKit data must not be used for advertising, marketing, profiling, or data mining.
- HealthKit write access must not be added unless explicitly discussed and approved for a future phase.
- Missing, denied, unavailable, empty, or partial HealthKit data should lower confidence or show calm fallback messaging instead of creating negative wellness conclusions.
- UI copy should use cautious wellness wording such as "recent signals," "wellness estimate," "fatigue context," "mixed," and "low data."
- Production-facing wording is tracked in `Docs/phase-8-6-production-wording-audit.md`.

## Project Structure

```text
StateWatch.xcodeproj/         Xcode project with iOS, watchOS, WidgetKit, and test targets
.github/workflows/            GitHub Actions CI workflow
Docs/                         Product, architecture, safety, design, and release docs
StateWatchApp/                iOS SwiftUI app source, shared models, services, and resources
StateWatchComplications/      WidgetKit watch complication extension using mock shared data with static fallback
StateWatchShared/             Mock shared readiness summary model and App Group store
StateWatchWatchApp/           watchOS app source, shared model usage, and resources
StateWatchTests/              XCTest target files using mock data and pure helper coverage
MANUAL_QA_CHECKLIST.md        Manual QA checklist for stabilization and release review
```

The WidgetKit complication target and Watch app intentionally use mock-only shared state and static fallback data. The iOS app publishes the current mock dashboard readiness summary through the App Group; WidgetKit and the Watch app can read that mock summary when available. The iPhone Dashboard can attempt HealthKit-derived scoring only when the internal local feature flag is enabled, and that HealthKit-derived output is not published to Watch, WidgetKit, or App Group shared state. WatchConnectivity and production-ready shared local state remain deferred.

## How to Run

A full Xcode installation is required. Command Line Tools alone are not enough for simulator builds with `xcodebuild`.

### iOS App

1. Open `StateWatch.xcodeproj` in Xcode.
2. Select the `StateWatch` scheme.
3. Select an iPhone simulator.
4. Build and run. The app should launch to the redesigned mock-backed dashboard.

Command-line build:

```sh
xcodebuild -project StateWatch.xcodeproj -scheme StateWatch -sdk iphonesimulator -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO COMPILER_INDEX_STORE_ENABLE=NO build
```

### watchOS App

1. Open `StateWatch.xcodeproj` in Xcode.
2. Select the `StateWatchWatchApp` scheme.
3. Select an Apple Watch simulator.
4. Build and run. The watch app should launch to the refreshed mock-backed watch dashboard. If a mock App Group summary is available, the Watch display model can use it; otherwise it falls back to static mock data.

Command-line build:

```sh
xcodebuild -project StateWatch.xcodeproj -scheme StateWatchWatchApp -sdk watchsimulator -destination 'generic/platform=watchOS Simulator' CODE_SIGNING_ALLOWED=NO COMPILER_INDEX_STORE_ENABLE=NO build
```

### WidgetKit Complications

1. Open `StateWatch.xcodeproj` in Xcode.
2. Select the `StateWatchComplications` scheme.
3. Build for an Apple Watch simulator. The complication views should use iPhone-published mock App Group data when available and static mock fallback data otherwise.

Command-line build:

```sh
xcodebuild -project StateWatch.xcodeproj -scheme StateWatchComplications -sdk watchsimulator -destination 'generic/platform=watchOS Simulator' CODE_SIGNING_ALLOWED=NO COMPILER_INDEX_STORE_ENABLE=NO build
```

### XCTest

In Xcode, select the `StateWatch` scheme and run Product > Test.

Command-line test:

```sh
xcodebuild -project StateWatch.xcodeproj -scheme StateWatch -sdk iphonesimulator -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO COMPILER_INDEX_STORE_ENABLE=NO test
```

## CI

GitHub Actions runs on pull requests, pushes to `main`, and manual `workflow_dispatch` runs. Draft pull requests run lightweight Ubuntu validation only, while ready-for-review pull requests, pushes to `main`, and manual dispatch run the full macOS Xcode validation job.

Lightweight validation checks:

- `git diff --check`.
- Expected project directories are present.

Full Xcode validation checks:

- iOS build for the `StateWatch` scheme.
- iOS XCTest for the `StateWatch` scheme.
- watchOS build for the `StateWatchWatchApp` scheme.
- WidgetKit complication build for the `StateWatchComplications` scheme.

For day-to-day development, prefer the local simulator commands in `Docs/local-xcode-validation.md` before spending GitHub Actions macOS minutes. Manual testing is still required for real-device HealthKit permission behavior, Apple Health data availability, complication gallery presentation, and visual QA in Xcode previews or simulators.
