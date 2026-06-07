# Roadmap

StateWatch is an early-stage, local-first iOS + watchOS wellness project. The roadmap prioritizes privacy, cautious wellness wording, testability, and incremental rollout before any production use of HealthKit-derived scoring.

## Completed

### Foundation and Documentation

- Added initial product, architecture, privacy, release, App Store, and medical-safety documentation.
- Added modular Swift placeholder structure for iOS, watchOS, models, services, views, and tests.
- Added mock data for previews and testing.

### Runnable Xcode Project

- Created `StateWatch.xcodeproj`.
- Added iOS app target `StateWatch`.
- Added watchOS app target `StateWatchWatchApp`.
- Added XCTest target `StateWatchTests`.
- Wired the iOS app to launch into `DashboardView` with mock `StateAssessment` data.
- Wired the watchOS app to launch into `WatchDashboardView` with mock `StateAssessment` data.
- Fixed watchOS target build output configuration.

### HealthKit Permission Foundation

- Added read-only HealthKit permission handling.
- Added HealthKit read type definitions for heart rate, resting heart rate, HRV SDNN, sleep analysis, step count, active energy burned, and workouts.
- Added Apple Health permission UI and Settings routes.
- Preserved safe fallback behavior for denied, unavailable, skipped, and mock states.

### HealthKit Fetch Foundation

- Added a local-only HealthKit data fetcher.
- Added aggregation of recent HealthKit samples into `[DailyHealthSnapshot]`.
- Added missing-data handling so nil metrics do not become negative wellness conclusions.
- Preserved `MockHealthDataFetcher` for previews, tests, and unavailable HealthKit environments.

### Baseline and Scoring Engine

- Added 7-day, 14-day, and 30-day baseline calculation.
- Added local rule-based recovery, sleep, fatigue-context, activity-load, and overall scoring.
- Added confidence handling for sparse or missing data.
- Added XCTest coverage for baseline, scoring, nil data, sparse data, and score clamping.

### Debug HealthKit Scoring Preview

- Added a debug-only HealthKit Scoring Preview route from Settings.
- Added preview states for idle, loading, loaded, empty, unavailable, and failed data.
- Added local preview output for snapshots, baseline confidence, component scores, reasons, suggestions, and missing-data notices.
- Kept the production dashboard mock-backed.

### CI and QA Infrastructure

- Added GitHub Actions for pull requests and pushes to `main`.
- Added automated iOS build, iOS tests, watchOS build, and whitespace checks.
- Added Phase 6 stabilization QA coverage.
- Added `MANUAL_QA_CHECKLIST.md`.

### Figma and Design System Foundation

- Added Figma-backed technology-style design-system planning.
- Added Phase 5.7 high-fidelity Figma handoff documentation.
- Added SwiftUI design-system token and component foundation.
- Kept production dashboard behavior unchanged during design-system foundation work.

### Debug Visual Dashboard Preview

- Added a debug-only Visual Dashboard Preview route from Settings.
- Used the SwiftUI design-system foundation for a mock, technology-style iPhone dashboard preview.
- Added Normal, Low Data, and Unavailable visual preview states.
- Kept the production dashboard mock-backed and visually unchanged.

## Next Phases

### 1. QA Audit Design System and Visual Dashboard Preview

- Complete focused QA for the SwiftUI design system and debug-only visual preview.
- Confirm production `DashboardView` remains mock-backed and unchanged.
- Confirm the visual preview remains debug-only.
- Confirm Figma alignment, dark-mode legibility, and no medical or alarming wording.

### 2. Real-Device HealthKit QA

- Test on a real iPhone and Apple Watch environment.
- Verify permission prompts, denied states, unavailable states, empty data states, and partial data states.
- Confirm HealthKit access remains read-only.
- Confirm no HealthKit write prompt appears.
- Confirm HealthKit data remains local-only.

### 3. Feature-Flag HealthKit-Backed Production Dashboard

- Add a feature flag for switching from mock `StateAssessment` data to local HealthKit-derived scoring.
- Keep the default production path conservative until real-device QA is complete.
- Preserve mock data for previews, tests, and fallback states.

### 4. Local Persistence for Snapshots and Baselines

- Design and implement local-only persistence for `DailyHealthSnapshot` history and `HealthBaseline` values.
- Avoid server sync, advertising, profiling, HealthKit data upload, or data mining.
- Add migration and reset behavior once persistence exists.

### 5. v0.1.0 Release Readiness

- Prepare a v0.1.0 release checklist.
- Review README, changelog, privacy policy, TEST_PLAN, CI status, manual QA, screenshots, and known limitations.
- Use mock data for public screenshots unless a later policy explicitly approves another approach.

### 6. App Store Privacy and Onboarding Polish

- Finalize privacy policy and App Store checklist.
- Polish onboarding and HealthKit permission copy.
- Ensure users see cautious wellness wording before HealthKit permission requests.
- Avoid diagnosis, disease detection, illness detection, clinical stress detection, treatment guidance, or medical advice.

## Intentionally Deferred

- Production HealthKit-backed dashboard.
- Production dashboard visual redesign.
- Local persistence.
- Networking or server sync.
- AI features.
- HealthKit write access.
- WidgetKit complication target.
- App Store release.
