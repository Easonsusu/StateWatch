# Changelog

All notable changes to StateWatch will be documented in this file.

## Unreleased

### Added

- Initial project foundation documentation.
- iOS SwiftUI placeholder structure.
- watchOS placeholder structure.
- Mock health models and scoring service skeletons.
- XCTest placeholder files for baseline and scoring behavior.
- Privacy, App Store, release, and medical-safety wording docs.
- `StateWatch.xcodeproj` with iOS app, watchOS app, and XCTest targets.
- Placeholder `Info.plist` files for app, watch app, and tests.
- Placeholder asset catalogs for iOS and watchOS resources.
- Shared Xcode schemes for `StateWatch` and `StateWatchWatchApp`.

### Changed

- iOS launch flow now opens `DashboardView` with mock `StateAssessment` data for Phase 1.
- watchOS launch flow remains mock-dashboard-only.
- `HealthKitManager` imports `Combine` so its placeholder observable state can compile in an app target.

### Not implemented yet

- Full HealthKit authorization and data fetching.
- Networking or server sync.
- AI features.
- Persistent local storage.
- Production scoring validation.
- Watch connectivity and real complication timeline data.
- A dedicated Widget Extension target for complication placeholders.
