# StateWatch

StateWatch is a SwiftUI iOS + watchOS wellness app concept for reflecting daily recovery, sleep, stress/fatigue, and activity load using Apple Watch and Apple Health data.

This repository currently contains the initial project foundation only: documentation, placeholder Swift files, mock data, scoring skeletons, and test placeholders. It does not yet include a generated Xcode project.

## Product stance

StateWatch is not a medical diagnosis app. It should never claim to detect illness or disease. The app uses cautious wellness wording and should encourage users to seek professional guidance for medical concerns.

For the MVP, HealthKit data stays on device. The app must not upload HealthKit data to a server or use HealthKit data for advertising, marketing, data mining, or profiling.

## Current structure

```text
Docs/                         Product and engineering documentation
StateWatchApp/                iOS SwiftUI placeholder app structure
StateWatchWatchApp/           watchOS placeholder app and complication structure
StateWatchTests/              XCTest placeholder files using mock data
```

## What exists today

- Root planning and compliance documents.
- Architecture, HealthKit mapping, scoring, wording, App Store, and release docs.
- Swift models for daily snapshots, baselines, assessments, metric types, and check-ins.
- HealthKit service placeholders with TODOs for authorization and fetching.
- Scoring service placeholders using explainable mock-friendly logic.
- SwiftUI placeholders for onboarding, dashboard, trends, check-in, settings, and privacy.
- watchOS placeholders for dashboard, score, suggestions, and complication widgets.
- XCTest placeholders for scoring and baseline behavior.

## Next setup step

Create the real Xcode project and targets, wire shared model files into both iOS and watchOS targets, then replace mock-only flows with a HealthKit authorization and local-fetch MVP.
