# Release Plan

## Internal alpha

- Build placeholder app from real Xcode project.
- Confirm onboarding, dashboard, settings, and watch screens compile.
- Use mock data only.

## Local HealthKit beta

- Add HealthKit authorization and local read-only fetching.
- Test denied, partial, and unavailable permission paths.
- Add local persistence and reset controls.

## TestFlight beta

- Validate wording and expectations with a small set of testers.
- Confirm users understand the app is wellness-only.
- Check watch performance and battery impact.

## App Store release candidate

- Complete privacy policy and App Store checklist.
- Verify no HealthKit data leaves device in MVP.
- Run accessibility and localization pass.
- Prepare screenshots using mock data.

## TODO

- Define release versioning once Xcode project settings exist.
- Add CI after the project can build from command line.
