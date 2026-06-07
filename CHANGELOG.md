# Changelog

All notable changes to StateWatch will be documented in this file.

## Unreleased

### Added

- Initial project foundation documentation, architecture docs, privacy docs, release docs, App Store checklist, and medical-safety wording guidance.
- Runnable `StateWatch.xcodeproj` with iOS app, watchOS app, and XCTest targets.
- iOS SwiftUI app structure and watchOS SwiftUI app structure.
- Shared model layer for `DailyHealthSnapshot`, `HealthBaseline`, `StateAssessment`, `HealthMetricType`, `UserCheckIn`, and mock sample data.
- Mock-backed iPhone dashboard and watch dashboard.
- Settings entry point from the iPhone dashboard.
- Apple Health permission screens and read-only HealthKit authorization foundation.
- HealthKit read type definitions for heart rate, resting heart rate, HRV SDNN, sleep analysis, step count, active energy burned, and workouts.
- `NSHealthShareUsageDescription` for read-only Apple Health access.
- Local-only `HealthKitDataFetcher` that reads recent Apple Health samples and converts them into `[DailyHealthSnapshot]`.
- `MockHealthDataFetcher` for previews, tests, denied permissions, and unavailable HealthKit environments.
- Baseline calculation across 7-day, 14-day, and 30-day windows.
- Rule-based recovery, sleep, fatigue-context, activity-load, and overall scoring engines.
- Confidence handling for sparse, nil, unavailable, and partial data.
- Debug-only HealthKit Scoring Preview for inspecting local snapshots, baselines, scoring output, reasons, suggestions, and missing-data notices.
- Debug-only Visual Dashboard Preview for reviewing the future technology-style dashboard direction without changing the production dashboard.
- XCTest coverage for models, HealthKit permission behavior, HealthKit scoring preview states, baseline calculation, scoring, nil data, sparse data, and design-system tokens.
- GitHub Actions CI workflow for iOS build, iOS tests, watchOS build, and whitespace checks.
- Phase 6 QA hardening tests and `MANUAL_QA_CHECKLIST.md`.
- Figma-backed design-system planning docs, Phase 5.7 high-fidelity Figma handoff docs, and UI copy guidelines.
- SwiftUI design-system token and component foundation.

### Changed

- Updated iOS launch flow to open `DashboardView` with mock `StateAssessment` data by default.
- Updated watchOS launch flow to open `WatchDashboardView` with mock `StateAssessment` data by default.
- Updated Settings to expose Apple Health permission information, a debug-only HealthKit Scoring Preview route, and a debug-only Visual Dashboard Preview route.
- Updated HealthKit handling to preserve mock fallback behavior when HealthKit is unavailable, denied, empty, or partial.
- Updated scoring behavior so missing data lowers confidence or becomes unavailable instead of becoming a negative wellness conclusion.
- Updated documentation and QA guidance around local-only HealthKit handling and cautious wellness wording.

### Still Deferred

- Production HealthKit-backed dashboard.
- Production dashboard visual redesign.
- Feature flag for switching production dashboard data source.
- Local persistence for snapshots and baselines.
- Networking, server sync, upload paths, login, subscriptions, or backend services.
- AI features.
- HealthKit write access.
- Advertising, marketing, profiling, or data-mining use of HealthKit data.
- App Store release.
- WidgetKit complication target and real complication timelines.
