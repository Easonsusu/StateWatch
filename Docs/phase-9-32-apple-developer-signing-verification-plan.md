# Phase 9.32 Apple Developer and Signing Verification Plan

## Purpose

This is an Apple Developer and signing verification plan, not Apple Developer configuration execution, signing configuration execution, an Xcode archive, TestFlight upload, App Store Connect release action, App Store submission, or release-ready claim.

Phase 9.32 uses the Phase 9.31 archive and signing environment inventory to define what must be verified in Apple Developer, Xcode signing, bundle identifiers, capabilities, provisioning, certificates, App Groups, HealthKit, the Watch app, and the WidgetKit complications extension before any future archive or upload phase.

No Apple Developer configuration, signing change, certificate installation, provisioning profile creation, Xcode archive, .xcarchive creation, .ipa export, TestFlight upload, App Store Connect release work, App Store approval, App Store submission-readiness, or broad release-ready claim is made by this phase.

Internal TestFlight signing verification planning may continue only with explicit limitations.

## Scope

In scope:

- Document Apple Developer and Xcode signing verification steps that must happen before archive or upload work.
- Carry forward Phase 9.31 signing inventory findings.
- Separate what can be planned from what must wait for Apple Developer access, signing identities, provisioning profiles, real hardware, or a later authorized phase.
- Preserve StateWatch privacy, HealthKit read-only, non-medical, Watch Check-in, and release-limitation guardrails.
- Add a matching Phase 9.32 checklist to `TEST_PLAN.md`.

Out of scope:

- Apple Developer configuration execution.
- Signing configuration execution.
- Xcode project signing changes.
- Setting `DEVELOPMENT_TEAM`.
- Certificate installation, revocation, modification, or keychain changes.
- Provisioning profile creation or modification.
- Bundle identifier creation or modification.
- Capability enablement or disablement.
- Xcode archive execution.
- Archive dry run.
- `.xcarchive` creation.
- `.ipa` export.
- TestFlight upload.
- App Store Connect release actions.
- App Store metadata, screenshots, privacy labels, or review-note edits.
- Swift implementation changes.
- Xcode project changes.
- Entitlement changes.
- Plist changes.
- CI workflow changes.
- Product behavior changes.
- Phase 9.33 work.

## Current Baseline

- Phase 9.31 was merged through PR #78.
- Baseline commit at the start of this phase: `1b9b5613efd0ac18395d344628eb9e64caed3b72`.
- Xcode observed in Phase 9.31: Xcode 26.6, build 17F113.
- SDKs observed in Phase 9.31 included iOS 26.5, iOS Simulator 26.5, watchOS 26.5, and watchOS Simulator 26.5.
- Schemes observed: `StateWatch`, `StateWatchWatchApp`, and `StateWatchComplications`.
- iOS app bundle ID observed: `com.easonsusu.StateWatch`.
- watchOS app bundle ID observed: `com.easonsusu.StateWatch.watchapp`.
- WidgetKit complications bundle ID observed: `com.easonsusu.StateWatch.watchapp.StateWatchComplications`.
- `MARKETING_VERSION` was observed as `0.1.0`.
- `CURRENT_PROJECT_VERSION` was observed as `1`.
- `CODE_SIGN_STYLE` was observed as `Automatic`.
- Phase 9.31 observed DEVELOPMENT_TEAM as empty and 0 valid local code-signing identities.
- No real iPhone or real Apple Watch was recorded as connected during Phase 9.31.
- Archive feasibility still requires future verification.
- TestFlight upload feasibility still requires Apple Developer / App Store Connect verification.

## Relationship To Phase 9.23 Through Phase 9.31

- Phase 9.23 recorded release blockers and deferred items.
- Phase 9.24 audited Check-in MVP release readiness and limited it to internal TestFlight planning with explicit limitations.
- Phase 9.25 added an internal TestFlight QA checklist; it did not execute TestFlight.
- Phase 9.26 completed an App Store privacy and medical-safety audit; it did not submit the app.
- Phase 9.27 recorded non-real-device release-candidate validation only.
- Phase 9.28 added known-limitations and release-notes guidance only.
- Phase 9.29 added internal TestFlight distribution readiness checklist only.
- Phase 9.30 added internal TestFlight build preparation plan only.
- Phase 9.31 recorded archive and signing environment inventory only.
- Phase 9.32 records Apple Developer and signing verification planning only.

## Explicit Limitations Carried Forward

- Phase 9.22 remains deferred/blocked, not completed.
- Real-device Watch VoiceOver QA remains unresolved.
- Physical Apple Watch tap ergonomics remain unresolved.
- Real Watch VoiceOver spoken cadence and focus order remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 validation was non-real-device validation only and does not replace real Apple Watch QA or real-device HealthKit QA.
- Broad Watch Check-in release-ready claims remain blocked.
- External App Store submission readiness is not claimed.
- Internal TestFlight signing verification planning may continue only with explicit limitations.
- HealthKit remains read-only.
- StateWatch remains non-medical wellness/readiness software.

## Phase 9.31 Signing Inventory Findings Carried Forward

- Xcode 26.6, build 17F113 was observed locally.
- iOS, watchOS, simulator SDKs, schemes, targets, bundle identifiers, versions, signing style, entitlements, and plists were inventoried where locally visible.
- `DEVELOPMENT_TEAM` was empty.
- `security find-identity -v -p codesigning` reported `0 valid identities found`.
- `PROVISIONING_PROFILE_SPECIFIER` was not visible in the filtered project/build-setting output.
- The iOS app has HealthKit and App Group entitlements.
- The watchOS app and WidgetKit complications extension have App Group entitlements.
- The iOS app plist has `NSHealthShareUsageDescription`; no HealthKit write usage plist key was observed.
- Archive feasibility and TestFlight upload feasibility were not proven.

## Files Reviewed

- `Docs/phase-9-31-archive-signing-environment-inventory.md`
- `Docs/phase-9-30-internal-testflight-build-preparation-plan.md`
- `Docs/phase-9-29-internal-testflight-distribution-readiness-checklist.md`
- `Docs/phase-9-28-known-limitations-and-release-notes.md`
- `Docs/phase-9-27-non-real-device-release-candidate-validation.md`
- `Docs/phase-9-26-app-store-privacy-medical-safety-final-audit.md`
- `Docs/phase-9-25-internal-testflight-qa-checklist.md`
- `Docs/phase-9-24-checkin-mvp-release-readiness-audit.md`
- `Docs/phase-9-23-release-blocker-register.md`
- `Docs/phase-9-21-watch-checkin-voiceover-qa-results.md`
- `Docs/phase-9-20-watch-checkin-real-device-voiceover-qa-plan.md`
- `Docs/phase-8-9-real-device-healthkit-qa-plan.md`
- `Docs/phase-8-8-internal-test-mode-feature-flag-qa.md`
- `Docs/phase-8-7-production-wording-safety-qa.md`
- `Docs/phase-8-6-production-wording-audit.md`
- `Docs/medical-safety-wording.md`
- `Docs/ui-copy-guidelines.md`
- `TEST_PLAN.md`
- `PRD.md`
- `PRIVACY_POLICY_DRAFT.md`
- `APP_STORE_CHECKLIST.md`
- `README.md`
- `StateWatch.xcodeproj/project.pbxproj`
- `StateWatchApp/Resources/Info.plist`
- `StateWatchApp/Resources/StateWatch.entitlements`
- `StateWatchWatchApp/Resources/Info.plist`
- `StateWatchWatchApp/Resources/StateWatchWatchApp.entitlements`
- `StateWatchComplications/Info.plist`
- `StateWatchComplications/StateWatchComplications.entitlements`
- `StateWatchApp/Services/HealthKit/HealthKitAuthorizationService.swift`
- `StateWatchApp/Models/StateCheckInOption.swift`
- `StateWatchWatchApp/Features/WatchCheckInView.swift`
- `StateWatchWatchApp/Services/CheckIn/LocalStateCheckInStore.swift`
- `StateWatchTests/StateWatchThemeTests.swift`
- `StateWatchTests/StateCheckInStorageTests.swift`

`StateWatchWidgets` was included in requested searches where applicable, but no `StateWatchWidgets` directory is present in the current repository layout.

## Commands Run

Read-only planning commands run locally:

- `git checkout main`
- `git pull origin main`
- `git checkout -b phase-9.32-apple-developer-signing-verification-plan`
- `xcodebuild -version`
- `xcodebuild -project StateWatch.xcodeproj -list`
- `security find-identity -v -p codesigning`
- `rg` searches over the Xcode project, plists, entitlements, source, tests, docs, and release planning files for signing, capability, HealthKit, App Group, Watch, WidgetKit, TestFlight, App Store, networking, WatchConnectivity, HealthKit write, and medical-safety terms.

This phase did not run `xcodebuild archive`.

## Search Terms Used

Searches covered these groups:

- Signing and project settings: `PRODUCT_BUNDLE_IDENTIFIER`, `MARKETING_VERSION`, `CURRENT_PROJECT_VERSION`, `CODE_SIGN_STYLE`, `DEVELOPMENT_TEAM`, `PROVISIONING_PROFILE_SPECIFIER`, `CODE_SIGN_IDENTITY`, `CODE_SIGN_ENTITLEMENTS`, `INFOPLIST_FILE`, `SUPPORTED_PLATFORMS`, `SDKROOT`, and `TARGETED_DEVICE_FAMILY`.
- Capabilities and plists: `com.apple.developer.healthkit`, `com.apple.security.application-groups`, `WKApplication`, `WKWatchOnly`, `NSExtension`, `CFBundleIdentifier`, `CFBundleShortVersionString`, `CFBundleVersion`, `NSHealthShareUsageDescription`, and `NSHealthUpdateUsageDescription`.
- Release planning terms: Apple Developer, developer team, certificates, provisioning, profiles, bundle identifiers, App IDs, capabilities, HealthKit, App Group, WidgetKit, Watch app, TestFlight, App Store Connect, archive, `xcarchive`, `ipa`, release-ready claims, approval claims, real-device QA, VoiceOver, and HealthKit QA.
- Watch Check-in scope terms: Watch Check-in, State Check-in, check-in, latest-three, clear-all, display modes, approved labels, Traditional Chinese reference labels, local-only, Watch-only, and single-record deletion.
- Forbidden implementation mechanisms: iPhone Check-in rollout, WidgetKit Check-in rollout, App Group raw Check-in history, WatchConnectivity, `WCSession`, State Score integration, HealthKit write, `HKHealthStore.save`, `requestAuthorization(toShare`, `URLSession`, cloud, iCloud, analytics, remote config, AI cloud, account, login, upload path, and sync.
- Medical-safety terms: diagnosis, clinical, medical advice, treatment, therapy, emergency, warning, abnormal, health risk, anxiety, depression, disease, detected, caused by, because you, symptom history, medical record, score dropped, low because, bad health, doctor, physician, regulatory, and FDA.

Matches were reviewed as existing boundary/disclaimer/test-context matches, Phase docs/test guardrails, forbidden-copy examples, limitation language, signing verification planning language, release blocker language, or clearly marked fail criteria, not new unsafe product copy or implementation scope creep.

## Verification Labels

Use these labels exactly in future follow-up planning:

- Verification planned
- Must verify in Apple Developer
- Must verify in Xcode
- Blocked until signing identity exists
- Deferred pending hardware
- Future external-release blocker
- Not applicable to current MVP
- Non-blocking follow-up

## Apple Developer / Signing Verification Summary Table

| ID | Verification item | Label | Current observed state | Required verification | Safe wording | Follow-up |
| --- | --- | --- | --- | --- | --- | --- |
| V-001 | Apple Developer account access | Must verify in Apple Developer | No Apple Developer account state is verified from the repository. | Confirm the user can access the Apple Developer account/team intended for StateWatch. | Apple Developer account access still requires verification. | Verify in Apple Developer before signing work. |
| V-002 | Development team ID | Must verify in Apple Developer | `DEVELOPMENT_TEAM` was observed empty in Phase 9.31. | Identify the correct team ID and set it only in a future explicitly approved signing phase. | Development team selection is not configured by this phase. | Future Apple Developer signing verification execution. |
| V-003 | Local signing identities | Blocked until signing identity exists | Phase 9.31 observed 0 valid local code-signing identities. | Install/select appropriate Apple Development and/or Apple Distribution identities in a future approved phase. | Local signing identities are not available yet. | Block archive feasibility until identities exist. |
| V-004 | iOS app bundle ID | Must verify in Apple Developer | Project observes `com.easonsusu.StateWatch`. | Verify the App ID exists and matches Xcode. | iOS bundle ID requires Apple Developer verification. | Verify bundle ID and capabilities. |
| V-005 | Watch app bundle ID | Must verify in Apple Developer | Project observes `com.easonsusu.StateWatch.watchapp`. | Verify the watchOS App ID exists and is correctly associated. | Watch bundle ID requires Apple Developer verification. | Verify relationship before archive. |
| V-006 | WidgetKit / complications bundle ID | Must verify in Apple Developer | Project observes `com.easonsusu.StateWatch.watchapp.StateWatchComplications`. | Verify the extension App ID exists and is correctly associated. | WidgetKit bundle ID requires Apple Developer verification. | Verify extension capability and relationship. |
| V-007 | App Store Connect app record | Must verify in Apple Developer | No App Store Connect app record state is verified from the repository. | Verify app record, bundle linkage, platform support, SKU, category, compliance prompts, and TestFlight availability later. | App Store Connect setup still requires verification. | Future App Store Connect verification phase. |
| V-008 | HealthKit capability | Must verify in Apple Developer | iOS app entitlement and `NSHealthShareUsageDescription` are present; no write usage key was observed. | Verify read-only HealthKit capability for the iOS bundle ID; do not add write access. | HealthKit capability requires Apple Developer verification and remains read-only. | Verify capability and privacy copy. |
| V-009 | App Group capability | Must verify in Apple Developer | `group.com.easonsusu.StateWatch` appears in iOS, watchOS, and WidgetKit entitlements. | Verify the App Group exists and is attached to required identifiers without implying Check-in propagation. | App Group capability requires Apple Developer verification. | Verify membership only. |
| V-010 | Watch app capability / relationship | Must verify in Apple Developer | Watch plist includes watch app markers; archive relationship was not verified. | Verify watch app configuration for the iOS app / watch-only behavior. | Watch app relationship requires verification. | Verify before archive. |
| V-011 | WidgetKit / complications capability | Must verify in Apple Developer | WidgetKit extension plist and App Group entitlement are present. | Verify extension signing and relationship without adding Check-in widget display. | WidgetKit capability requires verification. | Verify before archive. |
| V-012 | Automatic signing mode | Must verify in Xcode | `CODE_SIGN_STYLE = Automatic` was observed. | Verify automatic signing can resolve profiles after team and identities exist. | Automatic signing is planned for verification, not proven. | Future Xcode signing verification. |
| V-013 | Provisioning profiles | Must verify in Xcode | No profile specifier was visible in the filtered local output. | Verify generated or explicit profiles for iOS, watchOS, and WidgetKit targets. | Provisioning profiles are not created or verified by this phase. | Future signing verification. |
| V-014 | Certificate type needed | Must verify in Apple Developer | No valid local code-signing identities were observed. | Determine whether Apple Development is enough for local/archive testing and Apple Distribution is required for TestFlight upload. | Certificate requirements still need verification. | Future Apple Developer account check. |
| V-015 | Archive scheme | Must verify in Xcode | Schemes exist; no archive was run. | Verify whether archive should use `StateWatch` or another scheme that embeds the Watch app and complications. | Archive scheme is not proven. | Future archive planning/dry-run phase. |
| V-016 | Build number / version | Verification planned | `MARKETING_VERSION = 0.1.0`; `CURRENT_PROJECT_VERSION = 1`. | Confirm or increment before any upload phase. | Version/build values are recorded, not finalized for upload. | Recheck before archive/upload. |
| V-017 | Archive feasibility | Must verify in Xcode | Archive success was not tested; signing prerequisites are incomplete. | Verify only after team, signing identities, and profiles are configured. | Archive feasibility depends on future signing/team/profile verification. | Block archive claims until verified. |
| V-018 | TestFlight upload feasibility | Must verify in Apple Developer | No upload path or App Store Connect feasibility was verified. | Verify through App Store Connect / Apple Developer before any upload. | TestFlight upload feasibility requires Apple Developer / App Store Connect verification. | Future App Store Connect verification. |
| V-019 | Real-device Watch VoiceOver QA | Deferred pending hardware | Phase 9.22 remains deferred/blocked. | Execute real Apple Watch VoiceOver QA before broad Watch release claims. | Real-device Watch VoiceOver QA remains unresolved. | Future hardware QA. |
| V-020 | Physical Apple Watch tap ergonomics | Deferred pending hardware | No physical Apple Watch ergonomics result was recorded. | Execute real hardware tap/ergonomics QA. | Physical Apple Watch tap ergonomics remain unresolved. | Future hardware QA. |
| V-021 | Real-device HealthKit QA | Future external-release blocker | Real-device HealthKit QA remains planned, not executed. | Execute real iPhone / Apple Watch HealthKit QA before HealthKit production rollout or external claims. | Real-device HealthKit QA remains planned, not executed. | Future hardware QA. |
| V-022 | Watch Check-in MVP scope | Verification planned | Watch-only, local-only, latest-three, single-record deletion only. | Keep TestFlight notes explicit and avoid broader claims. | Watch Check-in MVP is Watch-only and local-only. | Continue limitation review. |
| V-023 | iPhone Check-in | Not applicable to current MVP | Old scaffold exists but is not the current MVP surface. | Do not present iPhone Check-in as supported. | iPhone Check-in is not included in the current MVP. | Separate future design/implementation phase. |
| V-024 | WidgetKit Check-in | Not applicable to current MVP | WidgetKit does not display or directly read Check-ins. | Do not present WidgetKit Check-in as supported. | WidgetKit Check-in is not included in the current MVP. | Separate future design/implementation phase. |
| V-025 | WatchConnectivity | Not applicable to current MVP | No WatchConnectivity rollout is included. | Do not present cross-device Check-in sync as supported. | WatchConnectivity is not included in the current MVP. | Separate future architecture phase. |
| V-026 | State Score integration | Not applicable to current MVP | Check-ins do not affect score, readiness, confidence, reasons, or suggestions. | Keep Check-ins separate from State Score. | Check-ins do not change State Score. | Future scoring/privacy review if ever considered. |
| V-027 | Old iPhone CheckInView scaffold | Non-blocking follow-up | Existing scaffold remains outside the Watch-only MVP. | Review separately before any iPhone Check-in release work. | Old iPhone scaffold is a non-blocking follow-up. | Separate cleanup/audit phase. |
| V-028 | StateWatchThemeTests.swift size | Non-blocking follow-up | Large test file remains a known refactor candidate. | Split only in a separate test refactor phase. | Test file size is a non-blocking follow-up. | Future test maintenance phase. |

## Apple Developer Account Access Plan

Verify that the user can access the Apple Developer account/team intended for StateWatch. This phase does not log into Apple Developer, change account state, or claim account access is confirmed.

## Development Team ID Verification Plan

Verify the correct Apple Developer team ID in a future approved phase. Because `DEVELOPMENT_TEAM` is currently empty, any future team selection must be intentional, reviewed, and limited to a separately authorized signing configuration phase.

## Local Signing Identity Verification Plan

Verify whether valid Apple Development and/or Apple Distribution signing identities are available in Keychain. Phase 9.31 observed 0 valid local code-signing identities. This phase does not install, modify, export, revoke, or commit certificates.

## Bundle Identifier Verification Plan

Verify these identifiers in Apple Developer and App Store Connect before archive/upload work:

- iOS app: `com.easonsusu.StateWatch`
- watchOS app: `com.easonsusu.StateWatch.watchapp`
- WidgetKit complications extension: `com.easonsusu.StateWatch.watchapp.StateWatchComplications`

The current phase does not create, modify, or verify bundle IDs in Apple Developer.

## App Store Connect App Record Verification Plan

Verify the App Store Connect app record, bundle linkage, platform support, SKU, category, compliance prompts, TestFlight availability, and any required review metadata in a future phase. This phase does not perform App Store Connect release work or metadata changes.

## HealthKit Capability Verification Plan

Verify the iOS app bundle ID has the required read-only HealthKit capability. Do not add HealthKit write access, `NSHealthUpdateUsageDescription`, or HealthKit write authorization unless a future explicitly approved phase changes scope.

## App Group Capability Verification Plan

Verify `group.com.easonsusu.StateWatch` exists and is assigned to the iOS app, watchOS app, and WidgetKit complications extension where required. This verification must not imply raw Check-in history propagation, WidgetKit Check-in display, WatchConnectivity sync, or HealthKit-derived production rollout.

## Watch App Relationship Verification Plan

Verify the watchOS app relationship and signing configuration so the correct app/watch surfaces are included for future internal TestFlight work. This phase does not change watch app behavior, watch-only behavior, or product scope.

## WidgetKit / Complications Capability Verification Plan

Verify WidgetKit extension signing, relationship, bundle ID, and App Group capability in Apple Developer/Xcode before archive work. This phase does not add WidgetKit Check-in display, Check-in summaries, direct Check-in reads, or live HealthKit-backed complications.

## Automatic Signing Verification Plan

Because `CODE_SIGN_STYLE = Automatic` was observed, future verification should confirm automatic signing resolves the required profiles after the correct team and signing identities exist. This phase does not change signing settings.

## Provisioning Profile Verification Plan

Verify generated or explicit provisioning profiles for the iOS app, watchOS app, and WidgetKit complications extension. This phase does not create, download, install, or modify profiles.

## Certificate Type Verification Plan

Determine in a future Apple Developer verification phase whether Apple Development certificates are sufficient for local archive testing and whether Apple Distribution certificates are required for TestFlight upload. This phase does not install or modify certificates.

## Archive Scheme Verification Plan

Verify whether future archive work should use the `StateWatch` scheme or another archive scheme that properly includes the watchOS app and WidgetKit complications extension. This phase does not run an archive or archive dry run.

## Build Number / Version Verification Plan

`MARKETING_VERSION = 0.1.0` and `CURRENT_PROJECT_VERSION = 1` were observed. Future upload work must confirm or increment the build number before upload. This phase does not change versioning.

## Archive Feasibility Dependency Note

Archive feasibility is not proven. It depends on future verification of Apple Developer account access, development team ID, signing identities, provisioning profiles, bundle IDs, App Group capability, HealthKit capability, Watch app relationship, WidgetKit extension relationship, and archive scheme behavior.

## TestFlight Upload Feasibility Dependency Note

TestFlight upload feasibility is not proven. It requires future Apple Developer / App Store Connect verification, signing and provisioning verification, bundle linkage, compliance prompts, build number readiness, export/upload tooling verification, and explicit authorization for upload work.

## Privacy / HealthKit Verification Review

- HealthKit remains read-only.
- No HealthKit write access or write authorization was added.
- No raw HealthKit upload or developer-accessible health database was introduced.
- No networking, cloud sync, iCloud sync, analytics, remote config, AI cloud analysis, account system, login, upload path, or remote health profile was added.
- Missing HealthKit data remains neutral and should reduce confidence rather than imply a negative wellness state.

## Medical-safety Verification Review

StateWatch remains non-medical wellness/readiness software. This phase does not claim diagnosis, treatment, therapy, emergency support, abnormal-state detection, warning behavior, disease detection, clinical stress detection, medical-grade status, or medical advice.

## Watch Check-in MVP Verification Review

- Watch Check-in remains Watch-only.
- Watch Check-in remains local-only.
- The four states remain exactly `Energized`, `Stable`, `Tired`, and `Low`.
- Traditional Chinese reference labels remain exactly `有活力`, `穩定`, `疲累`, and `低狀態`.
- Display modes remain `Icon + Text`, `Icon Only`, and `Text Only`.
- Default display remains `Icon + Text`.
- Latest-three recent history remains unchanged.
- Single-record deletion remains unchanged.
- Missing Check-ins remain neutral.
- `Low` remains subjective, non-medical, non-warning, and non-score-lowering.
- Check-ins do not affect State Score, readiness, confidence, reasons, suggestions, HealthKit-derived scoring, WidgetKit complications, App Group summary, iPhone Dashboard state, or Watch score state.

## Items Not Included In Current MVP

- iPhone Check-in UI, history, deletion, or management.
- WidgetKit Check-in display, summary, or direct Check-in reads.
- App Group raw Check-in history, Check-in propagation, or display preference propagation.
- WatchConnectivity.
- State Score integration.
- Latest-five history.
- Clear-all UI.
- Long-term history.
- Notes, export, reminders, notifications, scheduling, trends, streaks, counts, causes, interpretations, pattern summaries, or insights.
- HealthKit write access.
- Networking, cloud sync, iCloud sync, analytics, AI, account systems, login, upload paths, or remote config.

## Prohibited Verification Claims

Do not claim any of the following for Phase 9.32:

- Release ready.
- App Store ready.
- Approved for external release.
- Signing fully verified.
- Apple Developer configured.
- DEVELOPMENT_TEAM fixed.
- Certificates installed.
- Provisioning profiles created.
- Bundle IDs created or verified.
- Capabilities enabled.
- Archive-ready.
- Archived successfully.
- .xcarchive created.
- IPA exported.
- Uploaded to TestFlight.
- App Store Connect configured.
- Fully validated on Apple Watch.
- VoiceOver verified on real Apple Watch.
- HealthKit QA complete on real devices.
- Medical-grade.
- Diagnoses stress, anxiety, depression, disease, or illness.
- Warns about abnormal state.
- Low means bad health.
- Check-ins change your score.
- Syncs Check-ins to iPhone, widgets, App Group, cloud, or WatchConnectivity.

## Allowed Verification Claims

Phase 9.32 may claim only:

- Apple Developer and signing verification plan recorded.
- No Apple Developer or signing configuration was changed in this phase.
- No archive or upload was performed in this phase.
- Phase 9.31 observed DEVELOPMENT_TEAM empty and 0 valid local signing identities.
- Bundle identifiers and capabilities requiring verification are listed.
- Archive feasibility depends on future signing/team/profile verification.
- TestFlight upload feasibility requires Apple Developer / App Store Connect verification.
- Watch Check-in MVP is Watch-only and local-only.
- Real-device Watch VoiceOver and real-device HealthKit QA remain pending.
- HealthKit remains read-only.
- StateWatch remains non-medical wellness/readiness software.

## Work That May Continue

- Apple Developer and App Store Connect verification preparation.
- Internal TestFlight signing verification planning with explicit limitations.
- Bundle ID, capability, App Group, HealthKit, Watch app, WidgetKit, certificate, profile, and scheme verification planning.
- Real-device Watch VoiceOver and tap ergonomics preparation.
- Real-device HealthKit QA preparation.
- Documentation and checklist refinement.

## Work That Must Wait

- Apple Developer configuration execution.
- Signing configuration execution.
- Setting `DEVELOPMENT_TEAM`.
- Certificate installation, revocation, or modification.
- Provisioning profile creation or modification.
- Bundle ID creation or modification.
- Capability enablement or disablement.
- Xcode archive or archive dry run.
- `.xcarchive` creation.
- `.ipa` export.
- TestFlight upload.
- App Store Connect release actions.
- App Store metadata, screenshots, privacy labels, or review-note updates.
- Broad release-ready claims.
- External App Store submission-readiness claims.
- HealthKit-backed production propagation to Watch, WidgetKit, or App Group.
- Check-in propagation to iPhone, WidgetKit, App Group, cloud, or WatchConnectivity.
- Any HealthKit write access.

## Non-blocking Follow-ups

- Review the old iPhone `CheckInView` scaffold separately before any iPhone Check-in release work.
- Split `StateWatchThemeTests.swift` in a separate test refactor phase if needed.
- Re-record Xcode, SDK, simulator, scheme, and signing inventory immediately before any future archive-related phase.

## Risks / Limitations

- Apple Developer account access was not verified in this phase.
- App Store Connect app record state was not verified in this phase.
- `DEVELOPMENT_TEAM` remains empty.
- No valid local code-signing identities were observed in Phase 9.31.
- Archive feasibility remains unproven.
- TestFlight upload feasibility remains unproven.
- Real Apple Watch VoiceOver QA remains unresolved.
- Physical Apple Watch tap ergonomics remain unresolved.
- Real-device HealthKit QA remains planned, not executed.

## Recommended Next Phase

Phase 9.33: Apple Developer Signing Verification Execution.

Phase 9.33 should use this plan to execute carefully scoped verification in Apple Developer and Xcode without archiving or uploading unless a separate explicit phase authorizes it. It should verify account access, team ID, App IDs, capabilities, App Group, HealthKit, Watch app, WidgetKit extension, signing identities, and provisioning status while preserving all unresolved real-device QA limitations.

## Changes Made

- Added `Docs/phase-9-32-apple-developer-signing-verification-plan.md`.
- Updated `TEST_PLAN.md` with a Phase 9.32 checklist.

No Swift files, Xcode project files, entitlements, plists, CI workflows, assets, signing settings, certificates, provisioning profiles, bundle identifiers, capabilities, App Store metadata, or product behavior were changed.

## Final Phase 9.32 Checklist

- Apple Developer and signing verification plan recorded.
- Phase 9.23 through Phase 9.31 used as input.
- Phase 9.31 `DEVELOPMENT_TEAM` empty observation carried forward.
- Phase 9.31 0 valid local signing identities observation carried forward.
- Apple Developer account, team ID, signing identity, bundle ID, App Store Connect, HealthKit, App Group, Watch app, WidgetKit, automatic signing, provisioning, certificate, archive scheme, version/build, archive feasibility, and TestFlight feasibility verification plans recorded.
- Explicit limitations carried forward.
- No Apple Developer configuration was performed.
- No signing configuration was changed.
- No archive or upload was performed.
- No product behavior was changed.
- No prohibited release, signing, real-device, HealthKit, or medical-safety claim was made.
- Phase 9.33 was not started.
