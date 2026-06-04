# Roadmap

## Phase 0: Foundation

- Add documentation and safety guardrails.
- Add Swift models, services, placeholder views, mock data, and test placeholders.
- Avoid creating a real Xcode project until target setup is planned.

## Phase 1: Xcode project setup

- Create iOS app, watch app, watch extension, and test targets.
- Add shared model/service files to the correct target memberships.
- Verify the placeholder app builds on iOS simulator and watchOS simulator.

## Phase 2: Local HealthKit MVP

- Implement HealthKit authorization.
- Fetch a small read-only set of HealthKit metrics locally.
- Add local-only baseline calculation and dashboard updates.
- Add privacy review for HealthKit usage descriptions.

## Phase 3: Scoring and explanations

- Refine scoring rules with conservative thresholds.
- Add reason ranking and plain-language suggestions.
- Validate wording against `Docs/medical-safety-wording.md`.

## Phase 4: Trends and watch experience

- Add trend charts and watch dashboard flows.
- Add complication timeline placeholders backed by local app state.
- Evaluate watch connectivity only for local device sync.

## Phase 5: Release readiness

- Complete App Store checklist.
- Finalize privacy policy.
- Add screenshots generated only from mock data.
- Run device testing and accessibility review.
