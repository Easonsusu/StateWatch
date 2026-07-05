# Phase 9.31 Archive and Signing Environment Inventory

## Purpose

This is an archive and signing environment inventory, not an Xcode archive, TestFlight upload, App Store Connect release action, App Store submission, or release-ready claim.

Phase 9.31 records the currently visible local Xcode, SDK, simulator, scheme,
bundle identifier, version, signing, provisioning, entitlement, and capability
state for StateWatch after Phase 9.30.

No Xcode archive, .xcarchive creation, .ipa export, TestFlight upload, App Store Connect release work, App Store approval, App Store submission-readiness, or broad release-ready claim is made by this phase.

Internal TestFlight archive/signing planning may continue only with explicit limitations.

## Scope

In scope:

- Record read-only local Xcode and signing environment observations.
- Record currently visible schemes, targets, bundle identifiers, versions,
  build numbers, signing style, code signing identity, provisioning profile
  settings, entitlements, and capabilities.
- Separate observed local facts from Apple Developer / App Store Connect items
  that still require future verification.
- Carry forward Phase 9.22, real-device Watch QA, real-device HealthKit QA,
  Watch Check-in, privacy, HealthKit read-only, and medical-safety limitations.
- Add a matching Phase 9.31 checklist to `TEST_PLAN.md`.

Out of scope:

- Xcode archive execution.
- `.xcarchive` creation.
- `.ipa` export.
- TestFlight upload.
- App Store Connect release work.
- App Store metadata, screenshots, privacy-label edits, or review-note edits.
- Bundle identifier changes.
- Signing setting changes.
- Provisioning profile changes.
- Certificate installation or modification.
- Swift implementation changes.
- Xcode project changes.
- Entitlement changes.
- CI workflow changes.
- Product behavior changes.
- iPhone Check-in UI, history, deletion, management, or old scaffold cleanup.
- WidgetKit Check-in display, summary, or direct Check-in reads.
- App Group raw Check-in history, Check-in propagation, or display preference
  propagation.
- WatchConnectivity.
- State Score integration.
- HealthKit write access or write authorization.
- Networking, cloud sync, iCloud sync, analytics, AI cloud analysis, account
  systems, login, upload paths, or remote config.
- Latest-five history, clear-all UI, long-term history, notes, export,
  reminders, notifications, scheduling, trends, streaks, counts, causes,
  interpretations, pattern summaries, or insights.
- Phase 9.32 work.

## Current Baseline

- Phase 9.30 was merged through PR #77.
- Baseline commit at the start of this phase:
  `82043ca4843ee583defa2a404d9a3b5c74f6e147`.
- Watch Check-in remains Watch-only and local-only.
- The approved states remain `Energized`, `Stable`, `Tired`, and `Low`.
- Traditional Chinese reference labels remain `有活力`, `穩定`, `疲累`, and
  `低狀態`.
- Display modes remain `Icon + Text`, `Icon Only`, and `Text Only`.
- Default display remains `Icon + Text`.
- Recent history remains latest-three.
- Single-record local deletion remains the only deletion behavior in the Watch
  MVP.
- Phase 9.22 remains deferred/blocked, not completed.
- Real-device Watch VoiceOver QA remains unresolved.
- Physical Apple Watch tap ergonomics remain unresolved.
- Real Watch VoiceOver spoken cadence and focus order remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 validation was non-real-device validation only and does not replace real Apple Watch QA or real-device HealthKit QA.
- Phase 9.30 created an internal TestFlight build preparation plan only.
- Broad Watch Check-in release-ready claims remain blocked.
- External App Store submission readiness is not claimed.

## Inventory Labels

- Inventory recorded
- Needs verification before archive
- Needs Apple Developer access
- Deferred pending hardware
- Future external-release blocker
- Not applicable to current MVP
- Non-blocking follow-up

## Commands Run

Read-only inventory commands run locally:

- `xcodebuild -version`
- `xcodebuild -showsdks`
- `xcrun simctl list devices available`
- `xcrun xctrace list devices`
- `xcodebuild -project StateWatch.xcodeproj -list`
- `xcodebuild -project StateWatch.xcodeproj -scheme StateWatch -showBuildSettings`
- `xcodebuild -project StateWatch.xcodeproj -scheme StateWatchWatchApp -showBuildSettings`
- `xcodebuild -project StateWatch.xcodeproj -scheme StateWatchComplications -showBuildSettings`
- `security find-identity -v -p codesigning`
- `rg` searches over `StateWatch.xcodeproj/project.pbxproj`, target plists,
  entitlements, source files, docs, and `TEST_PLAN.md` for signing,
  entitlement, HealthKit, App Group, Watch, WidgetKit, TestFlight, App Store,
  networking, WatchConnectivity, HealthKit write, and medical-safety terms.

This phase did not run `xcodebuild archive`.

## Files Reviewed

- `StateWatch.xcodeproj/project.pbxproj`
- `StateWatchApp/Resources/Info.plist`
- `StateWatchApp/Resources/StateWatch.entitlements`
- `StateWatchWatchApp/Resources/Info.plist`
- `StateWatchWatchApp/Resources/StateWatchWatchApp.entitlements`
- `StateWatchComplications/Info.plist`
- `StateWatchComplications/StateWatchComplications.entitlements`
- `StateWatchApp/Services/HealthKit/HealthKitAuthorizationService.swift`
- `StateWatchApp/Models/StateCheckInOption.swift`
- `StateWatchApp/Features/CheckIn/CheckInView.swift`
- `StateWatchWatchApp/Features/WatchCheckInView.swift`
- `StateWatchWatchApp/Services/CheckIn/StateCheckInRecord.swift`
- `StateWatchWatchApp/Services/CheckIn/LocalStateCheckInStore.swift`
- `StateWatchWatchApp/Services/CheckIn/StateCheckInDisplayPreference.swift`
- `StateWatchComplications/StateWatchComplicationView.swift`
- `StateWatchTests/StateWatchThemeTests.swift`
- `StateWatchTests/StateCheckInStorageTests.swift`
- `README.md`
- `TEST_PLAN.md`
- `Docs/phase-9-23-release-blocker-register.md`
- `Docs/phase-9-24-checkin-mvp-release-readiness-audit.md`
- `Docs/phase-9-25-internal-testflight-qa-checklist.md`
- `Docs/phase-9-26-app-store-privacy-medical-safety-final-audit.md`
- `Docs/phase-9-27-non-real-device-release-candidate-validation.md`
- `Docs/phase-9-28-known-limitations-and-release-notes.md`
- `Docs/phase-9-29-internal-testflight-distribution-readiness-checklist.md`
- `Docs/phase-9-30-internal-testflight-build-preparation-plan.md`

## Environment Inventory

| ID | Category | Label | Observed state | Required follow-up |
| --- | --- | --- | --- | --- |
| INV-001 | Xcode version | Inventory recorded | `xcodebuild -version` reported Xcode 26.6, build 17F113. | Re-record immediately before any archive. |
| INV-002 | SDK inventory | Inventory recorded | SDKs visible: iOS 26.5, iOS Simulator 26.5, watchOS 26.5, watchOS Simulator 26.5, plus macOS, tvOS, visionOS, and DriverKit SDKs. | Re-record immediately before any archive. |
| INV-003 | Device inventory | Inventory recorded | `simctl` reported available iOS 26.5 simulators including iPhone 17 Pro and watchOS 26.5 simulators including Apple Watch Series 11 (46mm). | Simulator inventory does not replace real-device QA. |
| INV-004 | Physical device inventory | Deferred pending hardware | `xctrace` reported the local Mac and simulators. No real iPhone or real Apple Watch was recorded as connected for this phase. | Connect real hardware before real-device Watch and HealthKit QA. |
| INV-005 | Scheme inventory | Inventory recorded | Project schemes: `StateWatch`, `StateWatchWatchApp`, and `StateWatchComplications`. Targets: `StateWatch`, `StateWatchWatchApp`, `StateWatchTests`, and `StateWatchComplications`. | Recheck scheme share/archive settings before archive. |
| INV-006 | Archive scheme decision | Needs verification before archive | No archive was run. The correct archive path still needs future verification, especially how the iOS app, Watch app, and WidgetKit extension should be archived for internal TestFlight. | Decide and verify archive scheme in a separate archive phase. |
| INV-007 | iOS bundle identifier | Inventory recorded | `StateWatch`: `com.easonsusu.StateWatch`. | Verify this bundle ID exists in Apple Developer / App Store Connect before upload. |
| INV-008 | watchOS bundle identifier | Inventory recorded | `StateWatchWatchApp`: `com.easonsusu.StateWatch.watchapp`. | Verify this bundle ID exists and is configured correctly before upload. |
| INV-009 | WidgetKit bundle identifier | Inventory recorded | `StateWatchComplications`: `com.easonsusu.StateWatch.watchapp.StateWatchComplications`. | Verify this extension bundle ID exists and is configured correctly before upload. |
| INV-010 | Test bundle identifier | Inventory recorded | `StateWatchTests`: `com.easonsusu.StateWatchTests`. | Not a distribution artifact; keep out of release metadata. |
| INV-011 | Marketing version | Inventory recorded | All inspected distribution-facing schemes report `MARKETING_VERSION = 0.1.0`. | Confirm intended version before archive. |
| INV-012 | Build number | Inventory recorded | All inspected distribution-facing schemes report `CURRENT_PROJECT_VERSION = 1`. | Increment or confirm build number before archive/upload. |
| INV-013 | Signing style | Inventory recorded | `CODE_SIGN_STYLE = Automatic` for app, watch app, tests, and complications. | Confirm automatic signing works with the selected Apple Developer team before archive. |
| INV-014 | Development team | Needs Apple Developer access | `DEVELOPMENT_TEAM = ""` in the project file for visible configurations. | Set or verify the team in a separate signing phase with Apple Developer access. |
| INV-015 | Code signing identity | Needs verification before archive | Build settings show `CODE_SIGN_IDENTITY = Apple Development` for app, watch app, and complications. | Verify distribution signing identity before archive/upload. |
| INV-016 | Provisioning profile specifier | Needs Apple Developer access | No `PROVISIONING_PROFILE_SPECIFIER` value was visible in the filtered project/build-setting output. | Verify generated or explicit profiles through Apple Developer / Xcode signing before archive. |
| INV-017 | Local code-signing identities | Needs Apple Developer access | `security find-identity -v -p codesigning` reported `0 valid identities found`. | Install or select valid signing identities before distribution archive. |
| INV-018 | Info.plist handling | Inventory recorded | `GENERATE_INFOPLIST_FILE = NO`; plists are explicit files for app, watch app, tests, and complications. | Keep explicit plist values aligned before archive. |
| INV-019 | iOS entitlements | Inventory recorded | `StateWatch.entitlements` contains HealthKit and `group.com.easonsusu.StateWatch`. | Verify both capabilities exist in Apple Developer for the bundle ID. |
| INV-020 | watchOS entitlements | Inventory recorded | `StateWatchWatchApp.entitlements` contains `group.com.easonsusu.StateWatch`. | Verify App Group membership before archive. |
| INV-021 | WidgetKit entitlements | Inventory recorded | `StateWatchComplications.entitlements` contains `group.com.easonsusu.StateWatch`. | Verify App Group membership before archive. |
| INV-022 | HealthKit capability | Needs Apple Developer access | iOS app has `com.apple.developer.healthkit = true`; Info.plist includes `NSHealthShareUsageDescription`; no `NSHealthUpdateUsageDescription` plist key was observed. | Verify HealthKit read capability and privacy copy before upload. |
| INV-023 | App Groups / Widget / Watch capabilities | Needs Apple Developer access | App Group identifier is `group.com.easonsusu.StateWatch`; watch app plist has `WKApplication = true` and `WKWatchOnly = true`; complication plist has WidgetKit `NSExtensionPointIdentifier`. | Verify App Group and extension capabilities in Apple Developer / App Store Connect. |
| INV-024 | Archive feasibility | Needs verification before archive | No archive command was run; simulator build history does not prove archive feasibility. | Run a separate explicit archive phase only after signing is verified. |
| INV-025 | TestFlight upload feasibility | Needs Apple Developer access | No `.ipa`, App Store Connect configuration, or upload path was created or verified. | Verify App Store Connect app record, bundle IDs, export method, compliance prompts, and upload tooling later. |
| INV-026 | Real-device Watch VoiceOver QA | Deferred pending hardware | Still unresolved. Phase 9.21 recorded simulator/source-review limitations and Phase 9.22 remains deferred/blocked. | Execute real Apple Watch VoiceOver QA before broad Watch release claims. |
| INV-027 | Physical Apple Watch tap ergonomics | Deferred pending hardware | Still unresolved. | Execute physical Watch tap/ergonomics QA before broad Watch release claims. |
| INV-028 | Real-device HealthKit QA | Deferred pending hardware | Still planned, not executed. | Execute real iPhone / Apple Watch HealthKit QA before HealthKit production rollout claims. |
| INV-029 | Watch Check-in MVP scope | Inventory recorded | Watch Check-in remains Watch-only, local-only, latest-three, subjective, and non-score-integrated. | Keep limitations explicit in TestFlight notes. |
| INV-030 | iPhone Check-in | Not applicable to current MVP | No iPhone Check-in UI, history, deletion, or management is included in the Watch Check-in MVP. | Separate future design/implementation phase if needed. |
| INV-031 | WidgetKit Check-in | Not applicable to current MVP | WidgetKit does not display or directly read Check-ins. | Separate future design/implementation phase if needed. |
| INV-032 | WatchConnectivity | Not applicable to current MVP | Narrow source search found no `WCSession` / WatchConnectivity rollout code. | Separate future design/implementation phase if needed. |
| INV-033 | State Score integration | Not applicable to current MVP | Check-ins remain separate from State Score, readiness, confidence, reasons, and suggestions. | Separate future scoring/privacy review if needed. |
| INV-034 | Old iPhone CheckInView scaffold | Non-blocking follow-up | Existing scaffold remains identified as not part of the Watch-only MVP and was not addressed in this phase. | Review separately before any iPhone Check-in release work. |
| INV-035 | StateWatchThemeTests.swift size | Non-blocking follow-up | The large test file remains a known non-blocking refactor candidate. | Split in a separate test refactor phase, not this inventory. |

## Bundle and Version Details

| Target / scheme | Bundle identifier | Marketing version | Build number | Supported platforms | Targeted device family |
| --- | --- | --- | --- | --- | --- |
| `StateWatch` | `com.easonsusu.StateWatch` | `0.1.0` | `1` | `iphoneos iphonesimulator` | `1,2` |
| `StateWatchWatchApp` | `com.easonsusu.StateWatch.watchapp` | `0.1.0` | `1` | `watchos watchsimulator` | `4` |
| `StateWatchComplications` | `com.easonsusu.StateWatch.watchapp.StateWatchComplications` | `0.1.0` | `1` | `watchos watchsimulator` | `4` |
| `StateWatchTests` | `com.easonsusu.StateWatchTests` | `0.1.0` | `1` | `iphoneos iphonesimulator` | `1,2` |

## Entitlement and Capability Summary

| Surface | Entitlements / plist observations | Label | Follow-up |
| --- | --- | --- | --- |
| iOS app | HealthKit entitlement, App Group entitlement, read-only HealthKit privacy string. | Needs Apple Developer access | Verify HealthKit and App Group capabilities for `com.easonsusu.StateWatch`. |
| watchOS app | App Group entitlement, watch app plist markers. | Needs Apple Developer access | Verify watch app signing and App Group capability. |
| WidgetKit complications | App Group entitlement and WidgetKit extension plist marker. | Needs Apple Developer access | Verify extension signing, App Group capability, and App Store Connect relationship. |
| Tests | Explicit test plist, no distribution capability claim. | Not applicable to current MVP | Keep out of release distribution metadata. |

## HealthKit and Privacy Boundary

- HealthKit remains read-only.
- The iOS Info.plist includes `NSHealthShareUsageDescription`.
- No `NSHealthUpdateUsageDescription` plist key was observed.
- The HealthKit authorization service requests `toShare: Set<HKSampleType>()`
  with read types only.
- No HealthKit write access or write authorization was added in this phase.
- No raw HealthKit upload, developer-accessible health database, networking,
  cloud sync, analytics, AI cloud analysis, account system, login, or remote
  config was added in this phase.

## Watch Check-in Boundary

- Watch Check-in remains Watch-only and local-only.
- The four approved states remain exactly `Energized`, `Stable`, `Tired`, and
  `Low`.
- Traditional Chinese reference labels remain exactly `有活力`, `穩定`, `疲累`,
  and `低狀態`.
- Display modes remain `Icon + Text`, `Icon Only`, and `Text Only`.
- Default display remains `Icon + Text`.
- Recent history remains latest-three.
- No latest-five history was added.
- No clear-all UI was added.
- No iPhone Check-in UI, history, deletion, or management was added.
- No WidgetKit Check-in display, summary, or direct read was added.
- No App Group raw Check-in history, Check-in propagation, or display preference
  propagation was added.
- No WatchConnectivity was added.
- No State Score integration was added.

## Prohibited Inventory Claims

This phase does not claim:

- Release ready.
- App Store ready.
- Approved for external release.
- Archived successfully.
- `.xcarchive` created.
- IPA exported.
- Uploaded to TestFlight.
- App Store Connect configured.
- Signing fully verified for distribution.
- Fully validated on Apple Watch.
- VoiceOver verified on real Apple Watch.
- HealthKit QA complete on real devices.
- Medical-grade.
- Diagnoses stress, anxiety, depression, disease, or illness.
- Warns about abnormal state.
- Low means bad health.
- Check-ins change your score.
- Syncs Check-ins to iPhone, widgets, App Group, cloud, or WatchConnectivity.

## Allowed Inventory Claims

This phase may claim:

- Archive/signing environment inventory recorded.
- No archive or upload performed in this phase.
- Xcode, SDK, scheme, bundle, version, signing, provisioning, and entitlement
  observations were recorded where visible.
- Archive scheme requires future verification before archive.
- TestFlight upload feasibility requires Apple Developer / App Store Connect
  verification.
- Simulator build/test validation passed for the recorded Phase 9.27
  environment.
- Watch Check-in MVP is Watch-only and local-only.
- Real-device Watch VoiceOver and real-device HealthKit QA remain pending.
- HealthKit remains read-only.
- StateWatch remains non-medical wellness/readiness software.

## Needs Verification Before Archive

Before any future archive phase, verify:

- Intended archive scheme and destination.
- Whether archive should run from the iOS app scheme and how the Watch app and
  WidgetKit extension are included.
- Apple Developer team selection.
- Distribution signing identity.
- Provisioning profiles for iOS app, watch app, and WidgetKit extension.
- App Group capability membership for all relevant bundle identifiers.
- HealthKit capability for the iOS app bundle identifier.
- App Store Connect app record and bundle identifier relationships.
- Version and build number strategy.
- Export method and upload path.

## Needs Apple Developer Access

These items cannot be fully verified from the local repository alone:

- Team ID and membership.
- Installed or cloud-managed distribution certificates.
- Apple Developer bundle ID records.
- App Group capability records.
- HealthKit capability records.
- Provisioning profiles.
- App Store Connect app record.
- TestFlight processing, compliance prompts, tester groups, and release notes.

## Deferred Pending Hardware

- Real-device Watch Check-in VoiceOver QA.
- Physical Apple Watch tap ergonomics.
- Real Watch spoken cadence and focus order.
- Real-device HealthKit QA on an iPhone / Apple Watch environment.

## Future External-release Blockers

- Broad Watch Check-in release-ready claims remain blocked until real-device QA
  is completed or explicitly limited.
- External App Store submission-readiness remains blocked until signing,
  provisioning, App Store Connect, real-device QA, privacy labels, metadata, and
  final medical-safety review are completed in future phases.
- HealthKit-derived production rollout claims remain blocked until real-device
  HealthKit QA and rollout review are completed.

## Work That May Continue

- Internal TestFlight archive/signing planning with explicit limitations.
- Apple Developer and App Store Connect verification planning.
- Future archive dry-run planning, if separately authorized.
- Real-device Watch VoiceOver and tap ergonomics preparation.
- Real-device HealthKit QA preparation.
- Documentation and checklist refinement.

## Work That Must Wait

- Actual Xcode archive.
- `.xcarchive` creation.
- `.ipa` export.
- TestFlight upload.
- App Store Connect release actions.
- App Store metadata or screenshot work.
- External release-ready claims.
- HealthKit-backed production propagation to Watch, WidgetKit, or App Group.
- Check-in propagation to iPhone, WidgetKit, App Group, cloud, or
  WatchConnectivity.
- Any HealthKit write access.

## Validation

Post-change validation for this documentation-only phase should include:

- `git diff --check origin/main...HEAD`
- `git diff --cached --check`
- `plutil -lint StateWatch.xcodeproj/project.pbxproj`

Simulator builds are not required for this phase because only documentation and
test-plan checklist files changed.

## Files Changed In This Phase

- Added `Docs/phase-9-31-archive-signing-environment-inventory.md`.
- Updated `TEST_PLAN.md` with a Phase 9.31 checklist.

No Swift files, Xcode project files, entitlements, plists, CI workflows, assets,
or app behavior were changed.

## Recommended Next Phase

Phase 9.32: Archive dry-run planning or Apple Developer signing verification,
still without performing an archive unless explicitly authorized.
