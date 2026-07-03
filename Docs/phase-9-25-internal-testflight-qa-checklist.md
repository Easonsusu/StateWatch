# Phase 9.25 Internal TestFlight QA Checklist

## Purpose

Phase 9.25 defines the internal TestFlight QA planning checklist for the
Watch Check-in MVP and the nearby StateWatch surfaces that internal testers
must verify before any broader release claim.

This is an internal TestFlight QA planning checklist, not a TestFlight execution report.

Internal TestFlight planning may continue only with explicit limitations.

Phase 9.22 remains deferred/blocked, not completed.

Real-device Watch VoiceOver QA remains unresolved.

Real-device HealthKit QA remains planned, not executed.

No broad release-ready claim should be made from this checklist alone.

## Scope

In scope:

- Create a planning checklist for future internal TestFlight QA.
- Carry forward Phase 9.23 release blockers and Phase 9.24 readiness limits.
- Define tester environment fields and tester instructions.
- Define iPhone, Watch, Watch Check-in, accessibility, HealthKit, privacy,
  Widget/App Group/WatchConnectivity, and medical-safety checks.
- Provide issue report and test result templates.
- Define exit criteria for a future TestFlight execution report.
- Add a matching Phase 9.25 checklist to `TEST_PLAN.md`.

Out of scope:

- Swift implementation changes.
- Xcode project changes.
- Entitlement changes.
- CI workflow changes.
- TestFlight upload, App Store Connect configuration, or external tester setup.
- iPhone Check-in UI, history, deletion, or management.
- Watch Check-in UI or behavior changes.
- WidgetKit Check-in display, summary, or direct reads.
- App Group raw Check-in history, Check-in propagation, or display preference
  propagation.
- WatchConnectivity.
- State Score integration.
- HealthKit write access or write authorization.
- Networking, cloud sync, iCloud sync, analytics, AI, account systems, login,
  upload paths, or remote config.
- Reminders, notifications, scheduling, notes, export, trends, streaks, counts,
  causes, interpretations, pattern summaries, or insights.
- Phase 9.26 work.

## Current Baseline

- Phase 9.24 was merged through PR #71.
- Baseline commit at the start of this phase:
  `0bf4377415e5a38b77a5ba9c0993171411a5c63e`.
- Watch Check-in remains Watch-only and local-only.
- The approved states remain `Energized`, `Stable`, `Tired`, and `Low`.
- Traditional Chinese reference labels remain `有活力`, `穩定`, `疲累`, and
  `低狀態`.
- Display modes remain `Icon + Text`, `Icon Only`, and `Text Only`.
- Default display remains `Icon + Text`.
- Recent history remains latest-three.
- Single-record local deletion remains the only deletion behavior in the Watch
  MVP.
- The iPhone production dashboard and Watch production surfaces remain within
  their existing guarded rollout boundaries.
- HealthKit-derived scoring is not broadly rolled out through production
  surfaces, Watch, WidgetKit, or App Group shared state.

## Relationship To Phase 9.23 And 9.24

Phase 9.23 is the release blocker register for Watch Check-in MVP. It records
the unresolved hardware-dependent blockers, especially real-device Watch
VoiceOver QA and physical Apple Watch tap ergonomics.

Phase 9.24 audits whether Watch Check-in MVP may proceed to internal
TestFlight planning. It allows planning only with explicit limitations and
blocks any broad release-ready claim.

Phase 9.25 converts those limits into an internal QA checklist. It does not
clear any blocker and does not claim internal TestFlight was executed.

## Explicit Limitations

- Phase 9.22 remains deferred/blocked, not completed.
- Real-device Watch Check-in VoiceOver QA remains unresolved.
- Physical Apple Watch tap ergonomics remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Simulator/source review does not replace real Apple Watch QA.
- Internal TestFlight planning does not equal release readiness.
- No broad Watch Check-in release-ready claim is allowed from this checklist.
- No external App Store submission readiness claim is allowed from this
  checklist.

## What This Checklist Is

This checklist is a planning artifact for internal testers. It defines what
testers should record when an internal TestFlight build becomes available and
what must be verified before the project can claim that an internal build was
tested.

## What This Checklist Is Not

This checklist is not:

- a completed TestFlight execution report
- proof that a real Apple Watch was tested
- proof that real-device VoiceOver QA passed
- proof that real-device HealthKit QA passed
- a release-ready claim
- an App Store submission approval checklist
- permission to add new product behavior

## Entry Criteria

Before future internal TestFlight execution starts, confirm:

- The build number, branch, and commit hash are recorded.
- The tester has an internal TestFlight build installed.
- The tester records real device model names and OS versions.
- Any real Apple Watch availability or absence is documented.
- Any HealthKit testing capability is documented before testing.
- The feature flag state is recorded where relevant.
- The tester understands StateWatch is local-first and non-medical.
- Known limitations from Phase 9.23 and Phase 9.24 are carried forward.

## Internal Tester Environment Template

| Field | Tester entry |
| --- | --- |
| Test session ID |  |
| Tester initials or alias |  |
| Date |  |
| Build number |  |
| Branch |  |
| Commit hash |  |
| iPhone model |  |
| iOS version |  |
| Apple Watch model |  |
| watchOS version |  |
| Real Apple Watch available | Yes / No |
| Paired Watch used | Yes / No |
| VoiceOver tested on real Watch | Yes / No / Not available |
| Screen Curtain used | Yes / No / Not available |
| HealthKit permission testing possible | Yes / No |
| Real HealthKit sample data available | Yes / No / Partial / Unknown |
| HealthKit Dashboard flag state | Off / On for local internal test only |
| Network state during test | Offline / Online / Mixed |
| Notes about limitations |  |

## Internal Tester Instructions

- Use only internal builds and internal tester devices.
- Do not share screenshots that expose personal HealthKit details.
- Do not record raw HealthKit samples in public issues, PRs, docs, or chat.
- Record limitations honestly instead of converting them into pass results.
- Keep HealthKit-derived Dashboard testing separated from Watch Check-in QA.
- Keep Watch Check-in test notes subjective and non-medical.
- File issues with exact device, OS, build, and reproduction details.
- Do not treat simulator results as real-device Watch accessibility results.

## iPhone App Smoke Checklist

- Launch the iPhone app from a clean install when possible.
- Confirm the app opens without crashing.
- Confirm the Dashboard remains within the approved rollout behavior.
- Confirm mock-backed or guarded fallback behavior is calm and non-medical.
- Confirm Settings remains reachable.
- Confirm Apple Health / Health Permissions information is reachable where
  present.
- Confirm HealthKit permission copy remains read-only and local-first.
- Confirm denied, unavailable, sparse, or missing HealthKit data does not create
  a negative wellness conclusion.
- Confirm no sign-in, account, cloud upload, analytics opt-in, or remote config
  dependency appears.

## Watch App Smoke Checklist

- Launch the Watch app on the paired Apple Watch if available.
- Confirm the Watch score screen opens without crashing.
- Confirm score, state label, confidence, metrics, and suggestion remain within
  existing guarded behavior.
- Confirm Watch Check-in remains a Watch-only page.
- Confirm the Watch app does not ask for HealthKit write access.
- Confirm the Watch app does not require iPhone Check-in UI, WatchConnectivity,
  cloud sync, account login, analytics, or remote config.
- Confirm small-screen readability and tap behavior on real hardware when
  hardware is available.

## Watch Check-in MVP Checklist

- Confirm the four approved states are exactly `Energized`, `Stable`, `Tired`,
  and `Low`.
- Confirm Traditional Chinese reference labels are exactly `有活力`, `穩定`,
  `疲累`, and `低狀態`.
- Confirm display modes are exactly `Icon + Text`, `Icon Only`, and
  `Text Only`.
- Confirm default display remains `Icon + Text`.
- Confirm selected check-in state is stored locally on Watch only.
- Confirm latest-three history remains unchanged.
- Confirm single-record local deletion remains the only deletion behavior.
- Confirm no latest-five history was added.
- Confirm no clear-all UI was added.
- Confirm no long-term Check-in history was added.
- Confirm no notes, export, reminders, notifications, trends, streaks, counts,
  causes, interpretations, pattern summaries, or insights were added.
- Confirm Check-ins do not change State Score, HealthKit-derived scoring,
  readiness, confidence, reasons, suggestions, WidgetKit, App Group shared
  state, iPhone Dashboard state, or Watch score state.
- Confirm `Low` remains subjective, non-medical, non-warning, and
  non-score-lowering.

## Accessibility / VoiceOver Checklist

- Confirm real Apple Watch VoiceOver testing is marked unresolved unless a real
  Watch is available and actually tested.
- Confirm VoiceOver spoken labels, hints, values, cadence, and focus order are
  not marked passed from source review alone.
- Confirm Icon Only mode is not marked fully validated without real VoiceOver.
- Confirm Screen Curtain testing is recorded only if actually performed.
- Confirm physical tap comfort and wrist ergonomics are recorded only from real
  hardware.
- Confirm any unresolved accessibility item remains `Partial`, `Blocked`, or
  explicitly limited.

## HealthKit Checklist

- Confirm HealthKit authorization remains read-only.
- Confirm no HealthKit write prompt appears.
- Confirm denied, unavailable, sparse, stale, or partial HealthKit data remains
  safe and non-alarming.
- Confirm HealthKit-derived Dashboard behavior remains within the approved
  feature-flag and rollout boundaries.
- Confirm real-device HealthKit QA is not marked executed unless a real device
  test actually occurred.
- Confirm HealthKit-derived output is not propagated to Watch, WidgetKit, or
  App Group shared state unless a future approved phase explicitly does so.
- Confirm raw HealthKit samples are not stored in App Group shared state.

## Privacy / Local-First Checklist

- Confirm personal health data stays on device.
- Confirm no developer-accessible health database exists.
- Confirm no HealthKit data upload path exists.
- Confirm no advertising, marketing, data mining, profiling, analytics, or AI
  cloud health profiling path exists.
- Confirm no account, login, iCloud sync, cloud sync, remote config, or
  subscription dependency is introduced by the tested build.
- Confirm internal tester notes do not include raw personal health samples.

## Widget / App Group / WatchConnectivity Checklist

- Confirm WidgetKit complications do not display Check-in data.
- Confirm WidgetKit complications do not directly read Check-in history.
- Confirm WidgetKit complications do not fetch HealthKit samples.
- Confirm App Group shared state does not contain raw Check-in history.
- Confirm App Group shared state does not propagate Check-in records.
- Confirm App Group shared state does not propagate Watch Check-in display
  preference.
- Confirm WatchConnectivity is not added.
- Confirm no `WCSession` rollout appears.

## Medical-Safety Checklist

- Confirm the app does not claim diagnosis, disease detection, clinical stress
  detection, treatment, therapy, emergency handling, warnings, abnormal-state
  detection, or medical advice.
- Confirm subjective Check-in states are presented as user-reported context,
  not clinical findings.
- Confirm missing Check-ins and missing HealthKit data are neutral.
- Confirm `Low` does not imply bad health, warning, abnormal state, health risk,
  diagnosis, or score penalty.
- Confirm correlation wording avoids causal claims such as "because you".
- Confirm copy uses cautious wellness terms such as daily state, readiness,
  recovery context, sleep context, activity load, confidence, low data, and not
  enough recent data.

## Issue Report Template

Use this template for future internal TestFlight issue reports:

```markdown
### Summary

### Area
iPhone / Watch / Watch Check-in / VoiceOver / HealthKit / Privacy / Widget / Other

### Build
- Build number:
- Branch:
- Commit:

### Environment
- iPhone model:
- iOS version:
- Apple Watch model:
- watchOS version:
- Real Apple Watch used: Yes / No
- VoiceOver enabled: Yes / No / Not applicable
- HealthKit testing possible: Yes / No / Partial

### Steps To Reproduce
1.
2.
3.

### Expected Result

### Actual Result

### Privacy / Medical-Safety Impact

### Attachments
Avoid screenshots or logs containing personal HealthKit details.

### Limitation Notes
```

## Test Result Template

Use this template for future internal TestFlight execution summaries:

```markdown
### Test Session
- Session ID:
- Tester:
- Date:
- Build number:
- Commit:

### Status
Passed / Partial / Blocked / Failed / Not tested

### iPhone Smoke Result

### Watch Smoke Result

### Watch Check-in MVP Result

### Accessibility / VoiceOver Result

### HealthKit Result

### Privacy / Local-First Result

### Widget / App Group / WatchConnectivity Result

### Medical-Safety Result

### Known Limitations

### Issues Filed

### Release Claim Allowed?
No broad release-ready claim unless unresolved blockers are cleared or
explicitly limited.
```

## Exit Criteria For Future TestFlight Execution

A future internal TestFlight execution report can be considered complete only
when:

- tester environment details are filled in
- build number and commit hash are recorded
- iPhone and Watch smoke checks are executed or explicitly marked unavailable
- Watch Check-in MVP checks are executed
- real-device VoiceOver status is honestly recorded
- real-device HealthKit QA status is honestly recorded
- privacy and medical-safety checks are reviewed
- issues are filed for failures or blockers
- unresolved limitations remain visible in the summary

## Claims That Remain Prohibited

Do not claim:

- Phase 9.22 is complete.
- Real-device Watch VoiceOver QA passed.
- Physical Apple Watch tap ergonomics passed.
- Watch Check-in is broadly release-ready without limitations.
- Real-device HealthKit QA was executed if only this checklist exists.
- HealthKit-backed scoring is broadly rolled out to production surfaces.
- Check-ins sync to iPhone, WidgetKit, App Group raw history,
  WatchConnectivity, cloud, iCloud, analytics, AI, or an account system.
- Check-ins affect State Score, readiness, HealthKit-derived scoring, reasons,
  suggestions, or WidgetKit complications.
- StateWatch diagnoses, detects disease, detects clinical stress, provides
  treatment, handles emergencies, or gives medical advice.

## Work That May Continue

- Internal TestFlight planning with explicit limitations.
- Internal tester checklist refinement.
- Internal release note drafting that clearly says unresolved real-device QA
  remains unresolved.
- Future real-device Watch VoiceOver QA planning.
- Future real-device HealthKit QA execution planning.
- Future App Store / privacy / medical-safety audit planning.

## Work That Must Wait

- Broad release-ready claims.
- External App Store submission readiness claims.
- Marking Phase 9.22 complete.
- Marking real-device Watch VoiceOver QA passed.
- Marking physical Watch tap ergonomics passed.
- Marking real-device HealthKit QA executed.
- WidgetKit Check-in display or direct Check-in reads.
- App Group raw Check-in history or Check-in propagation.
- WatchConnectivity.
- State Score integration.
- HealthKit write access.
- Networking, cloud sync, iCloud sync, analytics, AI, account systems, login,
  upload paths, or remote config.

## Risks / Limitations

- Planning artifacts can be mistaken for executed QA if wording is not clear.
- Real-device accessibility and physical ergonomics remain unresolved.
- Real-device HealthKit behavior remains planned, not executed.
- Internal testers may have incomplete HealthKit data; missing data must remain
  neutral.
- Future TestFlight reports must not expose personal health data.

## Recommended Next Phase

Phase 9.26: App Store / Privacy / Medical Safety Final Audit.

The next phase should audit public-facing claims, privacy descriptions,
HealthKit permission wording, App Store readiness language, and medical-safety
wording before any external submission. It should not add product features.

## Changes Made

- Added this Phase 9.25 internal TestFlight QA planning checklist.
- Added a matching Phase 9.25 checklist to `TEST_PLAN.md`.
- Kept all changes documentation-only.

## Final Phase 9.25 Checklist

- Confirm this document exists.
- Confirm this document is planning-only and not a TestFlight execution report.
- Confirm Phase 9.23 and Phase 9.24 limitations are carried forward.
- Confirm Phase 9.22 remains deferred/blocked, not completed.
- Confirm real-device Watch VoiceOver QA remains unresolved.
- Confirm real-device HealthKit QA remains planned, not executed.
- Confirm no broad release-ready claim is made.
- Confirm no Swift files changed.
- Confirm no Xcode project files changed.
- Confirm no entitlement files changed.
- Confirm no CI workflow files changed.
- Confirm no TestFlight upload or App Store Connect configuration was changed.
- Confirm no product behavior changed.
- Confirm no prohibited rollout, networking, cloud, AI, account, analytics,
  WatchConnectivity, HealthKit write, or storage behavior was added.
- Confirm Phase 9.26 was not started.
