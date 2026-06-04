# Test Plan

## Current scope

This repository does not yet include a real Xcode project. Tests are placeholders intended to become XCTest target files once the project is created.

## Foundation checks

- Confirm required root docs exist.
- Confirm required `Docs/` files exist.
- Confirm iOS and watchOS placeholder files exist.
- Confirm all previews and tests use mock data.
- Confirm no file claims medical diagnosis or disease detection.
- Confirm HealthKit data upload is not introduced.

## Future automated tests

- Baseline calculation handles empty, sparse, and normal mock histories.
- Recovery scoring responds conservatively to HRV and resting heart rate changes.
- Sleep scoring reflects duration and consistency without medical claims.
- Overall state combines components and generates user-facing reasons.
- Suggestion generation avoids medical advice and uses cautious language.

## Manual QA for MVP

- First launch shows disclaimer before HealthKit permission request.
- HealthKit permission copy explains local-only use.
- Dashboard remains usable if permission is denied.
- Mock previews render without real HealthKit data.
- Settings privacy view clearly states data handling.
- Watch placeholders display mock score without needing HealthKit on watch.
