# Architecture

## Overview

StateWatch is planned as a local-first SwiftUI iOS + watchOS app. The MVP should read HealthKit data on device, convert it into daily snapshots, calculate local baselines, and produce cautious wellness summaries.

## Layers

- `App`: app entry point and high-level coordination.
- `Models`: value types shared by views, scoring, tests, and watch placeholders.
- `Services/HealthKit`: authorization and data-fetching boundary.
- `Services/Scoring`: baseline, component score, and overall state logic.
- `Services/Explanation`: human-readable reasons and suggestions.
- `Features`: SwiftUI views grouped by user workflow.
- `StateWatchWatchApp`: watch-specific placeholder UI and complications.

## Data flow

1. HealthKit authorization is requested after onboarding and disclaimer copy.
2. A `HealthDataFetcher` returns a local `DailyHealthSnapshot`.
3. `BaselineCalculator` compares recent local snapshots.
4. Scoring engines produce explainable component scores.
5. `OverallStateEngine` combines components into a `StateAssessment`.
6. SwiftUI views render scores, reasons, suggestions, and trends.

## MVP privacy boundary

HealthKit data must remain local. No server upload, advertising use, marketing use, data mining, or profiling is allowed for HealthKit data in the MVP.

## TODO

- Create the real Xcode project and targets.
- Decide whether shared models live in a Swift package or shared target group.
- Add local persistence for snapshots and baselines.
- Add watch connectivity only if data remains local to the user's devices.
