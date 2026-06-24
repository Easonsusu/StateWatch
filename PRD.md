# Product Requirements Document

## Product summary

StateWatch helps users reflect on their daily wellness state by combining Apple Watch / Apple Health signals with optional user check-ins. The MVP focuses on recovery, sleep, fatigue context, and activity load.

## Goals

- Provide a simple daily wellness summary that is easy to understand.
- Explain the main non-medical factors behind the score.
- Keep HealthKit data local in the MVP.
- Use mock data for previews and automated tests.
- Build a modular SwiftUI foundation for iOS and watchOS.

## Non-goals

- No medical diagnosis, disease detection, illness prediction, or treatment guidance.
- No server upload of HealthKit data in the MVP.
- No advertising, marketing, data mining, or profiling use of HealthKit data.
- No production scoring claims until validated with conservative wording and user testing.

## MVP user stories

- As a user, I can grant HealthKit read access after seeing a plain-language privacy explanation.
- As a user, I can view a daily wellness state score with recovery, sleep, fatigue context, and activity context.
- As a user, I can see reasons behind today's state in cautious language.
- As a user, I can add a subjective check-in to complement wearable signals.
- As a user, I can view simple trend placeholders before deeper charts are built.
- As a user, I can review privacy notes and understand data stays local.

## Data categories

- Resting heart rate.
- Heart rate variability.
- Sleep duration and sleep consistency.
- Active energy, steps, exercise minutes, and stand hours.
- Mindfulness minutes, when available.
- Optional user check-ins for mood, fatigue, felt strain, and notes.

## Acceptance criteria for this foundation task

- Required root files exist.
- Required Docs files exist.
- Required iOS placeholder structure exists.
- Required watchOS placeholder structure exists.
- Required test placeholder files exist.
- HealthKit implementation remains TODO-level.
- Mock data powers previews and tests.
- Documentation clearly states wellness-only and local-data rules.
