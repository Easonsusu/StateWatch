# Contributing to StateWatch

Thank you for your interest in contributing to StateWatch.

StateWatch is a local-first SwiftUI iOS + watchOS wellness app. It uses Apple Health / HealthKit data, mock data, and local rule-based logic to help users review recent wellness signals such as recovery, sleep, fatigue context, and activity load. StateWatch is not a medical diagnosis app and should not be presented as one.

## Project Setup

1. Clone the repository.
2. Open `StateWatch.xcodeproj` in Xcode.
3. Use the `StateWatch` scheme for the iOS app.
4. Use the `StateWatchWatchApp` scheme for the watchOS app.
5. Use simulator builds for normal development unless a task specifically requires device-only HealthKit behavior.

The production dashboard currently uses mock data by default. HealthKit permission and data-fetching paths should remain local-only and should continue to handle unavailable, denied, empty, and partial data states gracefully.

## Running the Apps and Tests

In Xcode:

- Select the `StateWatch` scheme and an iPhone simulator to run the iOS app.
- Select the `StateWatchWatchApp` scheme and an Apple Watch simulator to run the watchOS app.
- Select the `StateWatch` scheme and run tests with Product > Test.

From the command line, useful verification commands are:

```sh
xcodebuild -project StateWatch.xcodeproj -scheme StateWatch -sdk iphonesimulator -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO COMPILER_INDEX_STORE_ENABLE=NO build
```

```sh
xcodebuild -project StateWatch.xcodeproj -scheme StateWatch -sdk iphonesimulator -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO COMPILER_INDEX_STORE_ENABLE=NO test
```

```sh
xcodebuild -project StateWatch.xcodeproj -scheme StateWatchWatchApp -sdk watchsimulator -destination 'generic/platform=watchOS Simulator' CODE_SIGNING_ALLOWED=NO COMPILER_INDEX_STORE_ENABLE=NO build
```

## Pull Requests

- Create a branch from `main`.
- Keep changes small, focused, and easy to review.
- Do not mix product changes, documentation changes, project-file changes, and broad refactors unless the task requires it.
- Include a clear summary, testing performed, known limitations, and any privacy or HealthKit considerations.
- Update `TEST_PLAN.md` when adding or changing user-visible behavior.
- Wait for CI and review before merging.

## Coding Style

- Prefer SwiftUI-native patterns and small, readable views.
- Keep models, HealthKit services, scoring logic, and UI code modular.
- Use mock data for previews and tests.
- Keep TODO comments specific to the next implementation phase.
- Avoid broad refactors when a focused change is enough.
- Keep cautious wellness wording in code, UI copy, documentation, and test fixtures.

## HealthKit Privacy Rules

- HealthKit data must remain local in the MVP.
- Do not add networking or upload paths for HealthKit data.
- Do not send HealthKit data to analytics, advertising, marketing, profiling, or data-mining systems.
- Do not add HealthKit write access unless it has been explicitly discussed and approved for a future phase.
- Request only the HealthKit permissions needed for the current feature.
- Preserve graceful fallback behavior for denied, unavailable, empty, and partial HealthKit data states.

## Medical-Safety Wording Rules

- Do not claim diagnosis, disease detection, illness detection, clinical stress detection, treatment guidance, or medical advice.
- Use cautious wellness wording.
- Prefer language such as "recent signals," "wellness estimate," "fatigue context," "mixed," "low data," and "consider a lighter day if that matches how you feel."
- Avoid alarming language such as "warning," "health risk," "bad recovery," or "high stress" unless a future safety review explicitly approves different wording.
- Remind users where appropriate that StateWatch is a wellness tool and not medical advice.

## Testing Requirements

- Run or update XCTest when changing models, scoring, HealthKit authorization, HealthKit fetching, or UI behavior.
- Add focused tests for nil, sparse, empty, denied, and unavailable data paths when touching HealthKit or scoring logic.
- Keep the production dashboard mock-backed unless a task explicitly changes that behavior.
- Update `TEST_PLAN.md` when adding user-visible behavior, manual QA steps, or new CI expectations.
