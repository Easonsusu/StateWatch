# Phase 8.9 Real-Device HealthKit QA Plan

Phase 8.9 defines the internal real-device QA plan for validating the
feature-flagged HealthKit-backed iPhone Dashboard. This phase is planning-only:
it does not add product functionality, change app behavior, or begin broader
rollout.

## Purpose

- Validate the HealthKit-backed iPhone Dashboard on a real iPhone before any
  production enablement.
- Confirm HealthKit access remains read-only and local-only.
- Confirm the HealthKit Dashboard path remains behind the local default-off
  feature flag.
- Confirm unavailable, denied, sparse, stale, or low-confidence data falls back
  calmly and does not create a negative wellness conclusion.
- Confirm HealthKit-derived output is not propagated to Watch, WidgetKit, or App
  Group shared state.

## Scope

This QA plan covers manual internal testing for:

- HealthKit permission behavior.
- Local HealthKit sample availability.
- Feature-flagged Dashboard behavior.
- Mock fallback behavior.
- Missing-data, sparse-data, stale-data, and low-confidence states.
- Privacy and safety wording checks.
- Watch, WidgetKit, and App Group non-propagation checks.
- Networking, cloud, AI, analytics, remote config, and upload-path absence.

## What This Phase Does Not Do

- Does not enable the HealthKit Dashboard by default.
- Does not add a public Settings toggle.
- Does not connect Watch, WidgetKit, or App Group shared state to
  HealthKit-derived output.
- Does not add WatchConnectivity.
- Does not add networking, cloud sync, account systems, analytics, remote
  config, AI, or AI cloud profiling.
- Does not request HealthKit write access.
- Does not store raw HealthKit samples in App Group shared state.
- Does not begin Phase 9 State Check-in work.
- Does not begin Watch or WidgetKit HealthKit-derived propagation.

## Required Device Setup

- A real iPhone is required for meaningful HealthKit validation.
- A paired Apple Watch is recommended for real sleep, activity, heart-rate, and
  workout data.
- Simulator validation is still useful for builds, but simulator HealthKit data
  may not represent real user data conditions.
- Use a development build only.
- Use an internal tester's own device only.
- Do not collect or commit screenshots containing sensitive personal health
  details unless those details are redacted.

## Preconditions

- Phase 8.8 is merged.
- The branch under test is built from current `main`.
- `StateWatch` builds and launches on the test iPhone.
- `StateWatchWatchApp` builds on an Apple Watch simulator or paired watch when
  available.
- `StateWatchComplications` builds on an Apple Watch simulator.
- The tester understands that StateWatch is a wellness estimate, not a medical
  device, and does not provide medical advice.

## Build Configuration

- Use a local development build from Xcode.
- Keep signing, provisioning, and device trust setup limited to the internal
  tester's device.
- Record the branch name and commit hash before testing.
- Do not use a remote feature flag, account setting, server state, or analytics
  property to control the HealthKit Dashboard.

## How To Keep The Feature Flag Default-Off

`HealthKitDashboardFeatureFlag` uses the local storage key:

```text
statewatch.feature.healthkitDashboard.enabled
```

The default state is off because the key is absent and `UserDefaults.bool`
returns `false`.

Before testing:

- Install a clean development build when possible.
- Confirm the Dashboard starts in mock-backed mode.
- Confirm the feature flag key is absent or set to `false`.
- Confirm Watch, WidgetKit, and App Group shared state remain mock-backed.

## How To Enable The HealthKit Dashboard Only For Local Internal Testing

Enable the HealthKit-backed Dashboard only through local internal test code or a
temporary local debug harness that sets:

```swift
HealthKitDashboardFeatureFlag().enable()
```

The enablement must remain:

- local-only
- development-build-only
- internal-tester-only
- not remotely controlled
- not account controlled
- not analytics controlled
- not pushed to Watch, WidgetKit, or App Group shared state

Do not add a public UI toggle for this QA phase.

## How To Reset The Flag After Testing

After each test pass, reset the flag locally:

```swift
HealthKitDashboardFeatureFlag().reset()
```

Then relaunch the app and confirm:

- The Dashboard returns to mock-backed behavior.
- No HealthKit-derived output remains visible on the production Dashboard.
- Watch app behavior remains mock/shared-mock-backed.
- WidgetKit complications remain mock/shared-mock-backed.
- App Group shared state does not contain HealthKit-derived output.

## HealthKit Permission Test Cases

For each case, record pass/fail notes without collecting raw HealthKit samples.

| Case | Steps | Expected Result |
| --- | --- | --- |
| First launch before authorization | Install a fresh build and open StateWatch before granting Apple Health access. | App launches safely, production Dashboard is mock-backed, and no HealthKit prompt appears unless the user opens the permission flow. |
| Allow read permission | Open Settings -> Apple Health -> Health Permissions and grant read access for the supported types. | Request completes without any write prompt, and the app remains usable. |
| Deny read permission | Deny HealthKit read access during the request. | App remains usable and shows mock or fallback behavior without negative wellness conclusions. |
| Revoke permission | Revoke StateWatch permissions in iOS Settings or Health permission settings, then relaunch. | App does not crash and falls back calmly when HealthKit data is unavailable. |
| Partial data availability | Allow only some data categories or use a device with incomplete history. | Optional snapshot fields remain missing, confidence/fallback behavior stays calm, and missing data is not treated as a bad state. |
| No recent sleep data | Test with no recent sleep samples available. | Sleep-related gaps reduce confidence or fall back safely. |
| No recent activity data | Test with no recent steps, active energy, or workout data available. | Activity gaps reduce confidence or fall back safely. |
| Stale data | Test after a period without recent Apple Health updates or with old-only sample history. | App avoids implying live monitoring and falls back or shows low-data behavior. |
| Sparse data | Test with very few recent samples. | Dashboard uses mock fallback or lower-confidence behavior, not strong conclusions. |
| Low confidence | Use histories that cannot support a confident score. | Low confidence prevents overconfident HealthKit-derived Dashboard output. |
| HealthKit unavailable or fetch failure | Test on an unsupported environment or simulate fetch failure locally. | App falls back to mock data and remains usable. |

## Missing-Data / Sparse-Data / Stale-Data Test Cases

- Confirm all optional `DailyHealthSnapshot` fields can be absent without a
  crash.
- Confirm all-nil or mostly nil history does not produce a negative wellness
  state.
- Confirm sparse history lowers confidence or falls back to mock data.
- Confirm stale history is not described as a current live health signal.
- Confirm copy uses calm terms such as `low data`, `not enough recent data`,
  `unavailable`, or `showing mock data`.

## Denied-Permission Test Cases

- Deny HealthKit read permission during first request.
- Relaunch the app after denial.
- Enable the local internal feature flag and confirm the app falls back safely.
- Confirm no retry loop or blocking state prevents normal app use.
- Confirm the user can revisit Settings -> Apple Health -> Health Permissions
  for permission information.

## Revoked-Permission Test Cases

- Grant HealthKit read permission.
- Revoke the permission from iOS Settings or Apple Health permission settings.
- Relaunch StateWatch.
- Enable the local internal feature flag.
- Confirm HealthKit-derived scoring does not crash and falls back safely.
- Confirm the app does not ask for write access.

## Low-Confidence Test Cases

- Use sparse data.
- Use no recent sleep data.
- Use no HRV data.
- Use no recent resting-heart-rate data.
- Use no recent workouts.
- Confirm low confidence prevents strong or alarming output.
- Confirm the Dashboard either falls back to mock data or presents cautious,
  non-medical context only.

## Mock Fallback Verification

With the feature flag off:

- Dashboard remains mock-backed.
- App launch can publish the mock dashboard summary to App Group shared state.
- Watch app remains mock/shared-mock-backed.
- WidgetKit complications remain mock/shared-mock-backed.

With the feature flag on and HealthKit data unavailable, empty, sparse, stale, or
low confidence:

- Dashboard falls back to mock data.
- Fallback copy remains calm.
- HealthKit-derived output is not written to App Group shared state.
- Watch and WidgetKit surfaces do not change.

## Privacy Verification Checklist

- Health data stays on device.
- No account is required for MVP HealthKit processing.
- No cloud health database is introduced.
- Developers do not have access to user HealthKit data.
- HealthKit data is not uploaded, sold, used for advertising, profiling,
  marketing, or data mining.
- No AI cloud health profiling is introduced.
- No networking or upload path is added.
- No raw HealthKit samples are stored in App Group shared state.
- HealthKit authorization remains read-only.

## Safety Wording Checklist

Confirm production-facing and debug-visible copy does not say or imply:

- medical diagnosis
- disease detection
- illness detection
- clinical stress detection
- treatment advice
- emergency handling
- abnormal health warnings
- health risk prediction
- medical advice

Preferred language includes:

- `daily state`
- `readiness`
- `recovery context`
- `sleep context`
- `activity load`
- `confidence`
- `low data`
- `not enough recent data`
- `based on available on-device data`
- `not a medical device`
- `does not provide medical advice`

Missing data should be framed as lower confidence, unavailable data, or fallback
behavior, not as a bad health state.

## Watch / WidgetKit / App Group Non-Propagation Checklist

- Watch app does not directly fetch HealthKit samples.
- WidgetKit complications do not directly fetch HealthKit samples.
- Watch app remains mock/shared-mock-backed.
- WidgetKit complications remain mock/shared-mock-backed.
- App Group shared state remains mock-only for this phase.
- App Group does not store `DailyHealthSnapshot`, `HealthBaseline`, raw samples,
  or HealthKit objects.
- HealthKit-derived iPhone Dashboard output is not written to App Group shared
  state.
- WatchConnectivity remains deferred.

## Networking / Cloud / AI Absence Checklist

Confirm the HealthKit Dashboard path and related state sharing do not add:

- `URLSession` upload paths
- server calls
- cloud sync
- remote config
- account systems
- analytics rollout
- AI features
- AI cloud analysis
- WatchConnectivity
- push-triggered rollout controls

## What Evidence To Collect

Collect only minimal QA metadata:

- build version, branch, and commit
- device model
- iOS version
- watchOS version if applicable
- permission state
- feature flag state
- pass/fail notes
- redacted screenshots only if necessary

## What Evidence Not To Collect

Do not collect:

- raw HealthKit samples
- full personal health history
- identifiable health screenshots
- exported Health database
- cloud logs containing health data
- user account health profile
- unredacted Apple Health detail screens

## Pass / Fail Criteria

Pass only if:

- HealthKit Dashboard appears only when the local internal flag is enabled.
- Dashboard returns to mock-backed behavior when the flag is off or reset.
- Denied, missing, sparse, stale, low-confidence, and unavailable data do not
  become negative health states.
- No HealthKit-derived data reaches Watch, WidgetKit, or App Group.
- No networking, cloud, AI, analytics, or remote config behavior is introduced.
- HealthKit authorization remains read-only.
- No unsafe medical wording appears.
- No raw HealthKit samples are stored outside the iPhone app's local HealthKit
  read path.

## Stop Conditions

Stop testing and file an issue if:

- A HealthKit write prompt appears.
- A data upload or networking path is discovered for HealthKit data.
- HealthKit-derived output appears in Watch, WidgetKit, or App Group shared
  state.
- Missing data is framed as a warning, bad health state, abnormal state, or
  emergency.
- The app claims diagnosis, disease detection, clinical stress detection,
  treatment, or medical advice.
- The app crashes, loses data, or blocks normal use after permission denial or
  revocation.
- A tester is asked to share personal health data.

## Known Limitations

- This plan does not perform real-device testing by itself.
- Simulator builds cannot fully validate Apple Health data availability.
- The feature flag does not provide a public UI control.
- The current fallback behavior favors mock data over exposing low-confidence
  HealthKit-derived output.
- Watch, WidgetKit, and App Group production HealthKit propagation remain future
  work.

## Final Phase 8.9 Result Checklist

- Real-device QA plan exists.
- TEST_PLAN links to the Phase 8.9 plan.
- HealthKit Dashboard remains default-off.
- Production Dashboard remains mock-backed by default.
- HealthKit remains read-only.
- HealthKit data remains local-only.
- HealthKit-derived output is not propagated to Watch, WidgetKit, or App Group.
- No networking, cloud sync, AI cloud analysis, analytics, accounts, remote
  config, WatchConnectivity, or HealthKit write access was added.
- No product feature, UI redesign, or public rollout was added.
