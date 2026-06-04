# StateWatch

StateWatch is a SwiftUI iOS + watchOS wellness app concept for reflecting daily recovery, sleep, stress/fatigue, and activity load using Apple Watch and Apple Health data.

This repository now includes an initial runnable Xcode project with mock-data-only iOS, watchOS, and test targets. Real HealthKit fetching, networking, and AI features are intentionally not implemented yet.

## Product stance

StateWatch is not a medical diagnosis app. It should never claim to detect illness or disease. The app uses cautious wellness wording and should encourage users to seek professional guidance for medical concerns.

For the MVP, HealthKit data stays on device. The app must not upload HealthKit data to a server or use HealthKit data for advertising, marketing, data mining, or profiling.

## Current structure

```text
StateWatch.xcodeproj/         Xcode project with iOS, watchOS, and test targets
Docs/                         Product and engineering documentation
StateWatchApp/                iOS SwiftUI app source, shared models, services, and resources
StateWatchWatchApp/           watchOS app source, shared model usage, and resources
StateWatchTests/              XCTest target files using mock data
```

## Targets

- `StateWatch`: iOS SwiftUI app target. Launches directly into `DashboardView` with mock `StateAssessment` data for Phase 1.
- `StateWatchWatchApp`: watchOS SwiftUI app target. Launches into `WatchDashboardView` with mock `StateAssessment` data.
- `StateWatchTests`: XCTest target hosted by the iOS app target.

The complication/widget Swift files remain in the project navigator as placeholders, but they are not compiled into a target yet. A future task should add a dedicated Widget Extension target before enabling real complication timelines.

## Opening in Xcode

1. Open `StateWatch.xcodeproj` in Xcode.
2. Select the `StateWatch` scheme and an iPhone simulator.
3. Build and run. The app should open to the mock dashboard.
4. Select the `StateWatchWatchApp` scheme and a watch simulator.
5. Build and run. The watch app should open to the mock watch dashboard.
6. Select the `StateWatch` scheme and run tests to execute `StateWatchTests`.

A full Xcode installation is required. Command Line Tools alone are not enough for `xcodebuild`.

## Mock-only Phase 1 behavior

- HealthKit services remain placeholders and mock-backed.
- The app does not request real HealthKit authorization in this phase.
- No networking is added.
- No AI features are added.
- Mock data is used for previews, tests, the iOS dashboard, and the watch dashboard.

## Merge order

PR #2 (`chore/initial-project-foundation`) should merge first. PR #3 (`feature/core-models-and-mock-dashboard`) should merge after PR #2. This Xcode project branch is stacked after PR #3.

PR #1 is a separate Copilot scaffold that overlaps with PR #2. Do not merge duplicate foundation work from PR #1 if PR #2 is the chosen foundation branch.

## Next setup step

After this project setup branch is merged, implement HealthKit authorization as the next task while keeping HealthKit data local-only and continuing to use mock data for previews and tests.
