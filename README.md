# StateWatch

StateWatch is an early-stage, local-first SwiftUI iOS + watchOS wellness app for reviewing recent recovery, sleep, fatigue context, and activity load signals from Apple Watch and Apple Health data.

The repository includes a runnable Xcode project, HealthKit read-permission handling, a local-only HealthKit data fetcher, baseline calculation, rule-based scoring engines, XCTest coverage, CI, a SwiftUI design-system foundation, a debug-only HealthKit Scoring Preview, a debug-only Visual Dashboard Preview, a WidgetKit complication foundation, and a mock-only App Group shared state foundation for iPhone, WidgetKit, and Watch surfaces.

StateWatch is still pre-release. The production iPhone dashboard and watchOS app now use the StateWatch dark technology-style visual direction, but both remain mock-backed. HealthKit-derived scoring is still validated through debug previews and should only reach production dashboard surfaces through a future gated rollout.

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
- HealthKit permission flow: implemented for read-only access.
- HealthKit data fetcher: implemented locally for recent Apple Health samples.
- Baseline and scoring engines: implemented as local rule-based wellness estimates.
- Debug HealthKit Scoring Preview: available from Settings in debug builds.
- Debug Visual Dashboard Preview: available from Settings in debug builds.
- CI: GitHub Actions runs whitespace checks, iOS build, iOS tests, watchOS build, and WidgetKit complication build.

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
- Debug-only HealthKit Scoring Preview for inspecting snapshots, baselines, scoring output, missing-data behavior, reasons, and suggestions.
- Debug-only Visual Dashboard Preview for validating the future visual direction.
- Manual QA checklist, stabilization tests, and GitHub Actions CI.

## Intentionally Deferred

- Production HealthKit-backed iPhone or Watch dashboard.
- Feature flag for switching the production dashboard from mock data to local HealthKit-derived scoring.
- Local persistence for snapshots and baselines.
- Real-device HealthKit QA.
- HealthKit-derived WidgetKit complication timelines.
- Production App Group shared state backed by real local scoring output.
- WatchConnectivity-backed state sharing.
- App Store release assets and final onboarding polish.
- Networking, upload paths, server sync, login, subscriptions, or backend services.
- AI features.
- HealthKit write access.

## Privacy and Medical Safety Stance

StateWatch is a wellness app, not a medical diagnosis app. It must not claim to diagnose, detect disease, detect illness, detect clinical stress, provide treatment guidance, or replace professional medical advice.

For the MVP:

- HealthKit data must remain local-only.
- HealthKit data must not be uploaded to a server.
- HealthKit data must not be used for advertising, marketing, profiling, or data mining.
- HealthKit write access must not be added unless explicitly discussed and approved for a future phase.
- Missing, denied, unavailable, empty, or partial HealthKit data should lower confidence or show calm fallback messaging instead of creating negative wellness conclusions.
- UI copy should use cautious wellness wording such as "recent signals," "wellness estimate," "fatigue context," "mixed," and "low data."

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

The WidgetKit complication target and Watch app intentionally use mock-only shared state and static fallback data. The iOS app publishes the current mock dashboard readiness summary through the App Group; WidgetKit and the Watch app can read that mock summary when available. HealthKit-derived scoring is not wired into production iPhone, Watch, or complication surfaces. WatchConnectivity and production-ready shared local state remain deferred.

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

GitHub Actions runs on pull requests and pushes to `main`. The workflow checks:

- `git diff --check`.
- iOS build for the `StateWatch` scheme.
- iOS XCTest for the `StateWatch` scheme.
- watchOS build for the `StateWatchWatchApp` scheme.
- WidgetKit complication build for the `StateWatchComplications` scheme.

Manual testing is still required for real-device HealthKit permission behavior, Apple Health data availability, complication gallery presentation, and visual QA in Xcode previews or simulators.
