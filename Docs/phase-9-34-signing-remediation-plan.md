# Phase 9.34 Signing Remediation Plan

## Purpose

This is a signing remediation plan, not Apple Developer configuration execution, signing configuration execution, Xcode project signing changes, Xcode archive, TestFlight upload, App Store Connect release action, App Store submission, or release-ready claim.

Phase 9.34 uses Phase 9.33 Apple Developer signing verification results as input and defines the smallest safe set of future actions needed to resolve signing blockers before any archive dry run, TestFlight upload, or App Store Connect release work.

No Apple Developer configuration, signing change, DEVELOPMENT_TEAM setting, certificate installation, provisioning profile creation, bundle identifier creation, capability change, Xcode archive, .xcarchive creation, .ipa export, TestFlight upload, App Store Connect release work, App Store approval, App Store submission-readiness, or broad release-ready claim is made by this phase.

DEVELOPMENT_TEAM remains unresolved until a future explicitly approved signing remediation execution phase.

Valid local code-signing identities remain unavailable until a future explicitly approved signing remediation execution phase proves otherwise.

Apple Developer / App Store Connect verification remains unresolved unless explicitly verified with account access.

Archive feasibility is not proven by this phase.

TestFlight upload feasibility is not proven by this phase.

Phase 9.22 remains deferred/blocked, not completed.

Real-device Watch VoiceOver QA remains unresolved.

Real-device HealthKit QA remains planned, not executed.

Phase 9.27 validation was non-real-device validation only and does not replace real Apple Watch QA or real-device HealthKit QA.

## Scope

In scope:

- Convert Phase 9.33 signing verification results into a future remediation plan.
- Identify the minimum future Apple Developer, Xcode account, certificate, profile, bundle identifier, capability, archive, and TestFlight prerequisites.
- Define stop conditions before any signing execution, archive dry run, TestFlight upload, or App Store Connect release action.
- Carry forward unresolved Watch Check-in, real-device VoiceOver, physical Apple Watch ergonomics, real-device HealthKit QA, HealthKit read-only, privacy, and medical-safety limitations.
- Add a matching Phase 9.34 checklist to `TEST_PLAN.md`.

Out of scope:

- Apple Developer configuration execution.
- Signing configuration execution.
- Xcode project signing changes.
- Setting `DEVELOPMENT_TEAM`.
- Certificate installation, revocation, modification, import, creation, or keychain changes.
- Provisioning profile creation, download, installation, or modification.
- Bundle identifier creation, verification, or modification in Apple Developer.
- Capability enablement or disablement.
- `xcodebuild archive`.
- `xcodebuild -allowProvisioningUpdates`.
- Xcode archive, archive dry run, `.xcarchive` creation, `.ipa` export, or TestFlight upload.
- App Store Connect release actions, metadata, screenshots, privacy labels, or review-note edits.
- Swift implementation changes.
- Xcode project, entitlement, plist, or CI workflow changes.
- Product behavior changes.
- iPhone Check-in, WidgetKit Check-in, App Group Check-in propagation, WatchConnectivity, State Score integration, HealthKit write, networking, cloud sync, analytics, AI, accounts, remote config, reminders, notifications, notes, export, trends, streaks, or pattern summaries.
- Phase 9.35 work.

## Current Baseline

- Phase 9.33 was merged through PR #80.
- Baseline commit at the start of this phase: `b22013df205c65be54d2635ca5aa8a2d3a21a492`.
- Xcode observed locally: Xcode 26.6, build 17F113.
- SDKs previously observed include iOS 26.5, iOS Simulator 26.5, watchOS 26.5, and watchOS Simulator 26.5.
- Schemes observed: `StateWatch`, `StateWatchWatchApp`, and `StateWatchComplications`.
- iOS app bundle ID observed locally: `com.easonsusu.StateWatch`.
- watchOS app bundle ID observed locally: `com.easonsusu.StateWatch.watchapp`.
- WidgetKit complications bundle ID observed locally: `com.easonsusu.StateWatch.watchapp.StateWatchComplications`.
- `MARKETING_VERSION` observed locally: `0.1.0`.
- `CURRENT_PROJECT_VERSION` observed locally: `1`.
- `CODE_SIGN_STYLE` observed locally: `Automatic`.
- `CODE_SIGN_IDENTITY` observed locally: `Apple Development`.
- `DEVELOPMENT_TEAM` remains empty in `StateWatch.xcodeproj/project.pbxproj`.
- `PROVISIONING_PROFILE_SPECIFIER` was not visible in filtered local output.
- `security find-identity -v -p codesigning` reported `0 valid identities found` in this phase.
- No real iPhone or real Apple Watch was recorded as connected during the signing verification phases.
- Local HealthKit entitlement exists for the iOS app.
- Local App Group entitlement exists for the iOS app, watchOS app, and WidgetKit complications extension.
- iOS Info.plist includes `NSHealthShareUsageDescription`.
- No `NSHealthUpdateUsageDescription` plist key was observed.
- Archive feasibility remains unproven.
- TestFlight upload feasibility remains unproven.

## Relationship To Phase 9.23 Through Phase 9.33

- Phase 9.23 recorded release blockers and deferred items.
- Phase 9.24 audited Check-in MVP release readiness and allowed internal TestFlight planning only with explicit limitations.
- Phase 9.25 added an internal TestFlight QA checklist; it did not execute TestFlight.
- Phase 9.26 completed App Store privacy and medical-safety audit documentation; it did not submit the app.
- Phase 9.27 recorded non-real-device release candidate validation only.
- Phase 9.28 added known-limitations and release-notes guidance only.
- Phase 9.29 added internal TestFlight distribution readiness checklist only.
- Phase 9.30 added internal TestFlight build preparation plan only.
- Phase 9.31 recorded archive and signing environment inventory only.
- Phase 9.32 created Apple Developer and signing verification planning only.
- Phase 9.33 recorded Apple Developer signing verification results only.
- Phase 9.34 documents a future signing remediation plan only.

## Explicit Limitations Carried Forward

- Phase 9.22 remains deferred/blocked, not completed.
- Real-device Watch Check-in VoiceOver QA remains unresolved.
- Physical Apple Watch small-screen tap ergonomics remain unresolved.
- Real Watch VoiceOver spoken cadence and focus order remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 validation was non-real-device validation only and does not replace real Apple Watch QA or real-device HealthKit QA.
- Phase 9.28 created known-limitations and release-note guidance only.
- Phase 9.29 created internal TestFlight distribution readiness checklist only.
- Phase 9.30 created internal TestFlight build preparation plan only.
- Phase 9.31 created archive/signing environment inventory only.
- Phase 9.32 created Apple Developer and signing verification plan only.
- Phase 9.33 recorded Apple Developer signing verification results only.
- Broad Watch Check-in release-ready claims remain blocked.
- External App Store submission readiness is not claimed.
- Internal TestFlight signing remediation planning may continue only with explicit limitations.
- HealthKit remains read-only.
- StateWatch remains non-medical wellness/readiness software.

## Phase 9.33 Signing Blockers Carried Forward

- `DEVELOPMENT_TEAM` remains empty.
- Valid local code-signing identities remain unavailable.
- Apple Developer / App Store Connect verification remains unresolved unless explicitly verified with account access.
- Archive feasibility is not proven.
- TestFlight upload feasibility is not proven.
- No `xcodebuild archive` was run.
- No `xcodebuild -allowProvisioningUpdates` was run.
- No Apple Developer configuration was performed.
- No signing configuration was changed.
- No certificates, provisioning profiles, bundle identifiers, or capabilities were changed.
- No real-device QA result was fabricated.

## Files Reviewed

- `Docs/phase-9-33-apple-developer-signing-verification-results.md`
- `Docs/phase-9-32-apple-developer-signing-verification-plan.md`
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

`StateWatchWidgets` was referenced in requested searches, but no `StateWatchWidgets` directory is present in the current repository layout.

## Commands Run

Read-only commands run locally:

- `git status --short --branch`
- `git rev-parse HEAD`
- `git remote get-url origin`
- `git pull origin main`
- `git checkout -b phase-9.34-signing-remediation-plan`
- `rg -n "PRODUCT_BUNDLE_IDENTIFIER|MARKETING_VERSION|CURRENT_PROJECT_VERSION|CODE_SIGN_STYLE|DEVELOPMENT_TEAM|PROVISIONING_PROFILE_SPECIFIER|CODE_SIGN_IDENTITY|CODE_SIGN_ENTITLEMENTS|INFOPLIST_FILE|ASSETCATALOG_COMPILER_APPICON_NAME|SUPPORTED_PLATFORMS|SDKROOT|TARGETED_DEVICE_FAMILY" StateWatch.xcodeproj/project.pbxproj`
- `rg -n "com.apple.developer.healthkit|com.apple.security.application-groups|aps-environment|keychain-access-groups|WKCompanionAppBundleIdentifier|WKApplication|WKWatchOnly|NSExtension|CFBundleIdentifier|CFBundleShortVersionString|CFBundleVersion|NSHealthShareUsageDescription|NSHealthUpdateUsageDescription" StateWatchApp StateWatchWatchApp StateWatchComplications StateWatchShared StateWatchWidgets StateWatch.xcodeproj Docs TEST_PLAN.md`
- `xcodebuild -version`
- `xcodebuild -project StateWatch.xcodeproj -list`
- `security find-identity -v -p codesigning`
- Requested `rg` searches over docs, Xcode project, plists, entitlements, source, tests, and release planning files for signing, capability, HealthKit, App Group, Watch, WidgetKit, TestFlight, App Store, networking, WatchConnectivity, HealthKit write, Check-in, and medical-safety terms.

`xcodebuild -project StateWatch.xcodeproj -list` emitted local CoreSimulator/cache warnings in this environment but still listed the expected project targets and schemes. This phase did not run `xcodebuild archive` and did not run `xcodebuild -allowProvisioningUpdates`.

## Search Terms Used

Searches covered these groups:

- Signing and project settings: `PRODUCT_BUNDLE_IDENTIFIER`, `MARKETING_VERSION`, `CURRENT_PROJECT_VERSION`, `CODE_SIGN_STYLE`, `DEVELOPMENT_TEAM`, `PROVISIONING_PROFILE_SPECIFIER`, `CODE_SIGN_IDENTITY`, `CODE_SIGN_ENTITLEMENTS`, `INFOPLIST_FILE`, `ASSETCATALOG_COMPILER_APPICON_NAME`, `SUPPORTED_PLATFORMS`, `SDKROOT`, and `TARGETED_DEVICE_FAMILY`.
- Capabilities and plists: `com.apple.developer.healthkit`, `com.apple.security.application-groups`, `aps-environment`, `keychain-access-groups`, `WKCompanionAppBundleIdentifier`, `WKApplication`, `WKWatchOnly`, `NSExtension`, `CFBundleIdentifier`, `CFBundleShortVersionString`, `CFBundleVersion`, `NSHealthShareUsageDescription`, and `NSHealthUpdateUsageDescription`.
- Release planning terms: Apple Developer, developer team, certificates, code signing identity, signing identity, provisioning, profile, bundle identifier, bundle ID, App ID, capability, HealthKit, App Group, WidgetKit, Watch app, TestFlight, App Store Connect, archive, `xcodebuild archive`, `xcarchive`, `ipa`, `exportOptions`, release-ready claims, approval claims, real-device QA, VoiceOver, HealthKit QA, and Phase 9.22 through Phase 9.34.
- Watch Check-in scope terms: Watch Check-in, State Check-in, check-in, latest-three, latest five, clear-all, display modes, approved labels, Traditional Chinese reference labels, self-reported, local Watch, local-only, Watch-only, single-record, and delete.
- Forbidden implementation mechanisms: iPhone Check-in, WidgetKit Check-in, App Group raw Check-in history, App Group Check-in, WatchConnectivity, `WCSession`, State Score integration, HealthKit write, `HKHealthStore.save`, `requestAuthorization(toShare`, `toShare`, `URLSession`, cloud, iCloud, analytics, remote config, AI cloud, account, login, sign in, upload path, developer database, sync, and network.
- Medical-safety terms: diagnosis, clinical, medical advice, treatment, therapy, emergency, warning, abnormal, health risk, anxiety, depression, disease, detected, caused by, because you, symptom history, medical record, score dropped, low because, bad health, doctor, physician, care provider, regulatory, FDA, and clearance.

Matches were reviewed as existing boundary/disclaimer/test-context matches, Phase docs/test guardrails, forbidden-copy examples, limitation language, signing remediation planning language, release blocker language, or clearly marked fail criteria, not new unsafe product copy or implementation scope creep.

## Remediation Labels

Use these labels exactly for Phase 9.34 remediation planning:

- Remediation planned
- Must resolve before archive
- Must resolve before TestFlight upload
- Requires Apple Developer access
- Requires Xcode account/team setup
- Requires valid signing identity
- Deferred pending hardware
- Future external-release blocker
- Not applicable to current MVP
- Non-blocking follow-up

## Signing Remediation Summary Table

| ID | Remediation item | Label | Current blocker / observed state | Planned remediation | Stop condition | Required follow-up |
| --- | --- | --- | --- | --- | --- | --- |
| SR-001 | Apple Developer account access | Requires Apple Developer access | Account membership was not verified locally. | In a future approved phase, sign in to Apple Developer / Xcode with the correct account and verify team access before changing signing. | Stop if account access, agreements, or permissions are missing. | Capture account/team evidence without exposing private credentials. |
| SR-002 | Development team ID | Must resolve before archive | `DEVELOPMENT_TEAM` is empty in the Xcode project. | Identify the correct Team ID and document where it may need to be set in a future explicitly approved signing execution phase. | Stop if the correct Team ID cannot be verified. | Future approved phase may set team only after evidence is captured. |
| SR-003 | Local signing identities | Must resolve before archive | `security find-identity -v -p codesigning` reported `0 valid identities found`. | Obtain or select valid Apple Development and Apple Distribution identities without exposing private certificate details. | Stop if no valid identity appears or if identity ownership is unclear. | Re-check `security find-identity` after approved certificate setup. |
| SR-004 | Certificate handling | Requires valid signing identity | No valid local code-signing identities are available. | Plan certificate import, creation, or checking in a future phase; never commit certificates or private keys to the repo. | Stop if certificate provenance, keychain state, or private key access is unclear. | Record only high-level identity availability, not serials, fingerprints, or private key paths. |
| SR-005 | iOS app App ID / bundle identifier | Requires Apple Developer access | Local bundle ID is `com.easonsusu.StateWatch`; Apple Developer App ID is unresolved. | Verify or create the App ID only in a future approved Apple Developer phase. | Stop if the identifier is unavailable or conflicts with another team/app. | Confirm HealthKit and App Group compatibility for this App ID. |
| SR-006 | Watch app App ID / bundle identifier | Requires Apple Developer access | Local bundle ID is `com.easonsusu.StateWatch.watchapp`; Apple Developer App ID is unresolved. | Verify or create the watch App ID only in a future approved Apple Developer phase. | Stop if the identifier is unavailable or relationship cannot be verified. | Confirm relationship to the iOS app before archive. |
| SR-007 | WidgetKit / complications App ID / bundle identifier | Requires Apple Developer access | Local bundle ID is `com.easonsusu.StateWatch.watchapp.StateWatchComplications`; Apple Developer App ID is unresolved. | Verify or create the extension App ID only in a future approved Apple Developer phase. | Stop if extension relationship, capability, or signing configuration is unclear. | Confirm extension signing and parent relationship before archive. |
| SR-008 | HealthKit capability | Must resolve before TestFlight upload | Local iOS entitlement and read usage string exist; Apple Developer capability remains unresolved. | Verify read-only HealthKit capability for the iOS App ID; do not add write access. | Stop if HealthKit capability cannot be verified as read-only. | Confirm no `NSHealthUpdateUsageDescription` or HealthKit write authorization is added. |
| SR-009 | App Group capability | Must resolve before archive | Local App Group entitlement exists for iOS, watchOS, and WidgetKit; Apple Developer App Group membership remains unresolved. | Verify `group.com.easonsusu.StateWatch` and attach it to iOS, watchOS, and WidgetKit identifiers without implying Check-in propagation. | Stop if App Group ownership or membership cannot be verified. | Document membership evidence before archive. |
| SR-010 | Watch app relationship | Must resolve before archive | Local watch target/scheme and `WKApplication` / `WKWatchOnly` markers exist; Apple Developer relationship remains unresolved. | Verify iOS/watch relationship and watch-only behavior in Apple Developer / Xcode. | Stop if the watch app relationship is missing or mismatched. | Confirm archive candidate embeds/signs watch app correctly in a future dry-run phase. |
| SR-011 | WidgetKit / complications relationship | Must resolve before archive | Local WidgetKit extension target, scheme, plist, and entitlement exist; Apple Developer relationship remains unresolved. | Verify extension relationship and signing without adding WidgetKit Check-in display. | Stop if extension relationship or signing identity is unclear. | Confirm extension is included only as existing complication functionality. |
| SR-012 | Automatic signing | Requires Xcode account/team setup | `CODE_SIGN_STYLE = Automatic`; no team/identity/profile resolution is proven. | After account/team/identity exists, verify whether Automatic signing can generate/resolve profiles safely. | Stop if automatic signing attempts require unexpected capability/project changes. | Do not run `-allowProvisioningUpdates` until an approved execution phase. |
| SR-013 | Provisioning profiles | Must resolve before archive | No profile specifier was visible; profiles were not verified. | Verify generated or explicit profiles for iOS app, watch app, and WidgetKit extension. | Stop if any target lacks a valid profile. | Record profile availability at a high level without exposing sensitive profile details. |
| SR-014 | Build number / version | Remediation planned | `MARKETING_VERSION = 0.1.0`; `CURRENT_PROJECT_VERSION = 1`. | Decide whether `CURRENT_PROJECT_VERSION` should be incremented before archive/upload; do not change it in this phase. | Stop if release numbering policy is unclear. | Future release phase should update only with explicit approval. |
| SR-015 | Archive scheme | Must resolve before archive | Schemes visible: `StateWatch`, `StateWatchWatchApp`, `StateWatchComplications`; archive candidate is not proven. | Verify the candidate archive scheme, likely `StateWatch` if it embeds the Watch app and complications, but do not claim until tested. | Stop if archive scheme or embedding behavior is unclear. | Future archive dry-run phase must record exact scheme and destination. |
| SR-016 | Archive feasibility | Must resolve before archive | Empty `DEVELOPMENT_TEAM`, no valid identities, unresolved profiles, and no archive run. | Plan future archive dry run only after signing blockers are resolved. | Stop before archive if team, identity, profile, capability, or scheme evidence is incomplete. | Archive dry run belongs to a separate explicitly approved phase. |
| SR-017 | TestFlight upload feasibility | Must resolve before TestFlight upload | No archive, distribution signing, App Store Connect verification, or upload path was tested. | Plan future upload verification only after successful archive and distribution signing. | Stop if App Store Connect record, compliance, agreements, archive, or export is incomplete. | Separate TestFlight upload phase with explicit approval. |
| SR-018 | App Store Connect app record | Must resolve before TestFlight upload | App record, SKU, category, compliance prompts, and TestFlight availability were not verified. | Verify app record, bundle linkage, platform support, SKU, category, compliance prompts, agreements, and TestFlight availability. | Stop if any account, agreement, bundle, or compliance prompt is unresolved. | Capture high-level App Store Connect readiness without claiming release readiness. |
| SR-019 | Real-device Watch VoiceOver QA | Deferred pending hardware | Phase 9.22 remains deferred/blocked and no real Apple Watch result is available. | Keep blocker open until real Watch VoiceOver QA is executed. | Stop any broad VoiceOver pass claim until real-device evidence exists. | Execute real-device QA in a separate hardware phase. |
| SR-020 | Physical Apple Watch tap ergonomics | Deferred pending hardware | Physical small-screen tap ergonomics remain unresolved. | Test on real Apple Watch hardware before broad Watch release claims. | Stop any ergonomics pass claim without hardware. | Record hardware model, watchOS version, and tester notes in a future phase. |
| SR-021 | Real-device HealthKit QA | Deferred pending hardware | Real-device HealthKit QA remains planned, not executed. | Execute real iPhone / Apple Watch HealthKit QA before HealthKit production rollout or external HealthKit claims. | Stop HealthKit production rollout claims until real-device QA evidence exists. | Use Phase 8.9 plan and privacy guardrails. |
| SR-022 | Watch Check-in MVP scope | Remediation planned | Watch Check-in is Watch-only, local-only, latest-three, single-record deletion only. | Preserve scope; do not expand as part of signing remediation. | Stop if signing work starts adding product scope. | Keep release notes explicit about limitations. |
| SR-023 | iPhone Check-in | Not applicable to current MVP | iPhone Check-in UI/history/deletion/management is not supported. | Do not present iPhone Check-in as supported. | Stop if docs imply iPhone Check-in support. | Separate future product design and implementation phase if desired. |
| SR-024 | WidgetKit Check-in | Not applicable to current MVP | WidgetKit does not display or directly read Check-ins. | Do not present WidgetKit Check-in as supported. | Stop if docs imply WidgetKit Check-in support. | Separate future privacy/design phase if desired. |
| SR-025 | WatchConnectivity | Not applicable to current MVP | WatchConnectivity is not part of the MVP. | Do not present cross-device Check-in sync as supported. | Stop if remediation implies WatchConnectivity. | Separate future architecture phase if desired. |
| SR-026 | State Score integration | Not applicable to current MVP | Check-ins do not affect State Score, readiness, confidence, reasons, or suggestions. | Keep Check-ins separate from scoring. | Stop if remediation implies Check-ins affect scores. | Separate future scoring/privacy review if ever considered. |
| SR-027 | Old iPhone CheckInView scaffold | Non-blocking follow-up | Old scaffold remains outside the Watch-only MVP. | Do not mention it as user-facing support; review separately. | Stop if release docs present it as supported. | Future cleanup/audit phase only. |
| SR-028 | StateWatchThemeTests.swift size | Non-blocking follow-up | Large test file remains a known refactor candidate. | Treat as internal test refactor only. | Stop if this docs phase starts test reorganization. | Separate future test refactor phase. |

## Apple Developer Account Access Remediation Plan

A future signing remediation execution phase should verify Apple Developer account membership before any signing changes. The user or authorized maintainer should confirm that the correct Apple Developer team is available in Apple Developer and Xcode, agreements are current, and the account has permission to manage identifiers, certificates, profiles, and App Store Connect records.

Stop if the account is missing, the team is ambiguous, agreements are incomplete, or permissions are insufficient.

## Development Team ID Remediation Plan

`DEVELOPMENT_TEAM` is currently empty and must remain unchanged in this planning phase. A future explicitly approved signing remediation execution phase should identify the correct Team ID from Apple Developer / Xcode account settings, document the intended target/configuration impact, and only then update signing settings if approved.

Stop if the Team ID cannot be verified from account-backed evidence.

## Local Signing Identity Remediation Plan

Valid local code-signing identities remain unavailable until a future explicitly approved signing remediation execution phase proves otherwise. A future phase should decide whether Apple Development, Apple Distribution, or both identities are required for the next step, then install, create, or select identities through Xcode / Apple Developer / Keychain only with explicit user approval.

Do not paste certificate serials, fingerprints, private key paths, or personal certificate details into project docs. Record only whether valid identities are available and which broad type is present.

## Certificate Handling Plan

Certificates must never be committed to the repository. A future phase may verify certificate status, create/import certificates, or select existing identities only after account/team access is confirmed. Certificate operations should be treated as security-sensitive and stopped if provenance, ownership, or private key access is unclear.

## Bundle Identifier / App ID Remediation Plan

Future Apple Developer verification should cover:

- iOS app App ID for `com.easonsusu.StateWatch`.
- watchOS app App ID for `com.easonsusu.StateWatch.watchapp`.
- WidgetKit complications App ID for `com.easonsusu.StateWatch.watchapp.StateWatchComplications`.

Do not create or modify bundle identifiers in this phase. Future creation or modification requires explicit approval and should stop if an identifier conflict, ownership mismatch, or capability mismatch appears.

## HealthKit Capability Remediation Plan

The iOS app has a local HealthKit entitlement and read-only HealthKit privacy string. Future Apple Developer verification must confirm read-only HealthKit capability for the iOS App ID. Do not add HealthKit write access, HealthKit write authorization, or `NSHealthUpdateUsageDescription` for the MVP.

Stop if HealthKit capability verification suggests scope expansion beyond read-only local wellness processing.

## App Group Capability Remediation Plan

The local App Group entitlement uses `group.com.easonsusu.StateWatch` for iOS app, watchOS app, and WidgetKit complications extension. Future Apple Developer verification should confirm the App Group exists and is attached to the required identifiers.

This verification must not imply raw Check-in history propagation, display preference propagation, WatchConnectivity, cloud sync, or HealthKit data export.

## Watch App Relationship Remediation Plan

Future signing remediation should verify the iOS/watch relationship and watch-only behavior through Xcode and Apple Developer / App Store Connect. The likely archive path should preserve the existing Watch app relationship without adding new Watch Check-in behavior.

Stop if the relationship is missing, mismatched, or requires product-scope changes.

## WidgetKit / Complications Relationship Remediation Plan

Future signing remediation should verify the WidgetKit complications extension relationship, extension bundle ID, App Group membership, and signing profile coverage. This must not add WidgetKit Check-in display, WidgetKit Check-in summary, direct Check-in reads, or HealthKit-backed complication timelines.

## Automatic Signing Remediation Plan

The project currently uses Automatic signing. A future phase should verify whether Automatic signing can resolve profiles after the correct team and signing identity are available. Do not run `xcodebuild -allowProvisioningUpdates` in this planning phase.

Stop if Automatic signing proposes unexpected capability, entitlement, bundle identifier, or project changes.

## Provisioning Profile Remediation Plan

Future remediation should verify provisioning profiles for iOS app, watchOS app, and WidgetKit complications extension. Profiles may be Xcode-managed or explicit, but the choice must be documented before archive. The project should not claim archive readiness until all required profiles are available and matched to the correct bundle IDs, capabilities, and signing identities.

## Build Number / Version Remediation Plan

`MARKETING_VERSION` is `0.1.0` and `CURRENT_PROJECT_VERSION` is `1`. A future release-prep phase should decide whether to increment `CURRENT_PROJECT_VERSION` before archive/upload. This phase does not change either value.

## Archive Scheme Remediation Plan

The visible schemes are `StateWatch`, `StateWatchWatchApp`, and `StateWatchComplications`. A future archive dry-run planning or execution phase should verify the exact archive scheme. The likely candidate is `StateWatch` if it embeds/signs the Watch app and complications extension, but this phase does not claim that until verified.

## Archive Feasibility Remediation Plan

Archive feasibility is not proven by this phase. A future archive dry-run phase may proceed only after these blockers are resolved or explicitly accepted as stop conditions:

- Correct Apple Developer account/team access verified.
- `DEVELOPMENT_TEAM` resolved in an approved signing execution phase.
- Valid local signing identity available.
- Bundle IDs and App IDs verified.
- HealthKit and App Group capabilities verified.
- Watch app and WidgetKit relationships verified.
- Provisioning profiles available.
- Archive scheme selected and documented.

Do not run an archive until those preconditions are met or explicitly scoped for a dry-run failure investigation.

## TestFlight Upload Feasibility Remediation Plan

TestFlight upload feasibility is not proven by this phase. A future TestFlight upload phase should require:

- Successful archive.
- Export or upload path verified.
- Distribution signing available.
- App Store Connect app record verified.
- Bundle linkage and platform support verified.
- Compliance prompts and agreements resolved.
- Internal testing scope and limitations documented.

Do not upload to TestFlight in this phase.

## App Store Connect App Record Remediation Plan

Future App Store Connect verification should confirm app record existence, bundle linkage, platform support, SKU, category, compliance prompts, agreements, privacy questions, TestFlight availability, and required metadata state. This phase does not change App Store metadata, screenshots, privacy labels, review notes, or release settings.

## Real-device QA Blockers Carried Forward

- Phase 9.22 remains deferred/blocked, not completed.
- Real-device Watch VoiceOver QA remains unresolved.
- Physical Apple Watch tap ergonomics remain unresolved.
- Real Watch VoiceOver spoken cadence and focus order remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 validation was non-real-device validation only and does not replace real Apple Watch QA or real-device HealthKit QA.

## Privacy / HealthKit Remediation Review

- HealthKit remains read-only.
- No HealthKit write access or write authorization was added.
- No `NSHealthUpdateUsageDescription` key was added.
- No raw HealthKit upload or developer-accessible health database was introduced.
- No networking, cloud sync, iCloud sync, analytics, remote config, AI cloud analysis, account system, login, upload path, or remote health profile was added.
- Missing HealthKit data remains neutral and should reduce confidence rather than imply a negative wellness state.

## Medical-safety Remediation Review

StateWatch remains non-medical wellness/readiness software. This phase does not claim diagnosis, treatment, therapy, emergency support, abnormal-state detection, warning behavior, disease detection, clinical stress detection, medical-grade status, or medical advice.

`Low` remains subjective, non-medical, non-warning, and non-score-lowering.

## Watch Check-in MVP Remediation Review

- Watch Check-in remains Watch-only.
- Watch Check-in remains local-only.
- The four states remain exactly `Energized`, `Stable`, `Tired`, and `Low`.
- Traditional Chinese reference labels remain exactly `有活力`, `穩定`, `疲累`, and `低狀態`.
- Display modes remain `Icon + Text`, `Icon Only`, and `Text Only`.
- Default display remains `Icon + Text`.
- Latest-three recent history remains unchanged.
- Single-record deletion remains unchanged.
- Missing Check-ins remain neutral.
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

## Prohibited Remediation Claims

Do not claim:

- Release ready.
- App Store ready.
- Approved for external release.
- Signing fixed.
- Signing fully verified.
- Apple Developer configured.
- DEVELOPMENT_TEAM fixed.
- Certificates installed.
- Provisioning profiles created.
- Bundle IDs created or verified, unless actually verified with account evidence.
- Capabilities enabled.
- Archive-ready.
- Archive feasible.
- Archived successfully.
- .xcarchive created.
- IPA exported.
- Uploaded to TestFlight.
- App Store Connect configured.
- TestFlight-ready.
- Fully validated on Apple Watch.
- VoiceOver verified on real Apple Watch.
- HealthKit QA complete on real devices.
- Medical-grade.
- Diagnoses stress, anxiety, depression, disease, or illness.
- Warns about abnormal state.
- Low means bad health.
- Check-ins change your score.
- Syncs Check-ins to iPhone, widgets, App Group, cloud, or WatchConnectivity.

## Allowed Remediation Claims

It is accurate to claim:

- Signing remediation plan recorded.
- No Apple Developer or signing configuration was changed in this phase.
- No DEVELOPMENT_TEAM was set in this phase.
- No certificates, provisioning profiles, bundle identifiers, or capabilities were changed in this phase.
- No archive or upload was performed in this phase.
- DEVELOPMENT_TEAM remains unresolved.
- Valid local signing identities remain unavailable unless a future execution phase proves otherwise.
- Apple Developer / App Store Connect verification remains unresolved unless account access is used.
- Archive feasibility remains unproven.
- TestFlight upload feasibility remains unproven.
- Watch Check-in MVP is Watch-only and local-only.
- Real-device Watch VoiceOver and real-device HealthKit QA remain pending.
- HealthKit remains read-only.
- StateWatch remains non-medical wellness/readiness software.

## Work That May Continue

- Phase 9.35 signing remediation execution prep with explicit limitations.
- Apple Developer / App Store Connect manual verification preparation.
- Documentation of stop conditions and evidence capture requirements.
- Real-device Watch VoiceOver QA preparation.
- Real-device HealthKit QA preparation.
- Non-product documentation cleanup that preserves current limitations.

## Work That Must Wait

- Apple Developer configuration execution.
- Signing configuration execution.
- Setting `DEVELOPMENT_TEAM`.
- Certificate installation or keychain changes.
- Provisioning profile creation or modification.
- Bundle identifier creation or modification.
- Capability enablement or disablement.
- `xcodebuild archive`.
- `xcodebuild -allowProvisioningUpdates`.
- `.xcarchive` creation.
- `.ipa` export.
- TestFlight upload.
- App Store Connect release actions.
- App Store metadata, screenshots, privacy labels, or review-note changes.
- Broad release-ready or App Store-ready claims.
- Real-device Watch VoiceOver pass claims.
- Real-device HealthKit QA completion claims.
- iPhone Check-in, WidgetKit Check-in, App Group Check-in propagation, WatchConnectivity, State Score integration, or product scope expansion.

## Non-blocking Follow-ups

- Review the old iPhone `CheckInView` scaffold separately before any iPhone Check-in release work.
- Split `StateWatchThemeTests.swift` in a future test refactor phase if maintenance becomes painful.
- Keep documentation ordering tidy after the rapid Phase 9.x planning sequence.

## Risks / Limitations

- This phase does not prove archive feasibility or TestFlight upload feasibility.
- Apple Developer and App Store Connect state was not verified with account access.
- Valid local signing identities are unavailable in the current environment.
- Automatic signing may require account/team/profile setup before it can resolve profiles.
- Real Apple Watch VoiceOver QA and physical tap ergonomics remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Google Drive sync location may affect local filesystem behavior; work should continue only inside the existing checkout and avoid editing cloud metadata.

## Recommended Next Phase

Phase 9.35: Signing Remediation Execution Prep

Phase 9.35 should:

- Use Phase 9.34 as input.
- Prepare a minimal, step-by-step execution checklist for the user to resolve signing in Apple Developer / Xcode.
- Include exact manual UI steps where possible.
- Define stop conditions before any archive.
- Define what evidence must be captured before changing project signing.
- Still avoid `xcodebuild archive`, `.xcarchive` creation, `.ipa` export, TestFlight upload, and App Store Connect release work.
- Preserve unresolved real-device Watch VoiceOver and real-device HealthKit QA limitations.
- Avoid broad release-ready language unless limitations are explicit.

## Changes Made

- Added `Docs/phase-9-34-signing-remediation-plan.md`.
- Updated `TEST_PLAN.md` with a Phase 9.34 checklist.

## Final Phase 9.34 Checklist

- Phase 9.34 signing remediation plan document exists.
- The document is signing remediation plan only, not Apple Developer configuration execution, signing configuration execution, Xcode project signing changes, Xcode archive, TestFlight upload, App Store Connect release action, App Store submission, or release-ready claim.
- Phase 9.23 through Phase 9.33 were used as input.
- Explicit limitations are carried forward.
- Phase 9.33 signing blockers are carried forward.
- `DEVELOPMENT_TEAM` unresolved status is documented.
- Valid local signing identities unavailable status is documented.
- Apple Developer / App Store Connect verification unresolved status is documented.
- Archive feasibility unproven status is documented.
- TestFlight upload feasibility unproven status is documented.
- Apple Developer account access remediation plan is documented.
- Development team ID remediation plan is documented.
- Local signing identity remediation plan is documented.
- Certificate handling plan is documented.
- Bundle identifier / App ID remediation plan is documented.
- HealthKit capability remediation plan is documented.
- App Group capability remediation plan is documented.
- Watch app relationship remediation plan is documented.
- WidgetKit / complications relationship remediation plan is documented.
- Automatic signing remediation plan is documented.
- Provisioning profile remediation plan is documented.
- Build number / version remediation plan is documented.
- Archive scheme remediation plan is documented.
- Archive feasibility remediation plan is documented.
- TestFlight upload feasibility remediation plan is documented.
- App Store Connect app record remediation plan is documented.
- Real-device QA blockers are carried forward.
- No Apple Developer configuration was performed.
- No signing configuration was changed.
- No `DEVELOPMENT_TEAM` was set.
- No certificates were installed, revoked, or modified.
- No provisioning profiles were created or modified.
- No bundle identifiers were created or modified.
- No capabilities were enabled or disabled.
- No `xcodebuild archive` was run.
- No `xcodebuild -allowProvisioningUpdates` was run.
- No Xcode archive was performed.
- No `.xcarchive` was created.
- No `.ipa` was exported.
- No TestFlight upload was performed.
- No App Store Connect release work was performed.
- No App Store metadata was changed.
- No screenshots, privacy labels, or review notes were changed.
- No broad release-ready claim is made.
- No App Store approval or external submission-readiness claim is made.
- No claim is made that signing is fixed or fully verified for distribution.
- No claim is made that StateWatch is archive-ready or TestFlight-ready.
- Phase 9.22 remains deferred/blocked, not completed.
- Real-device Watch Check-in VoiceOver QA remains unresolved.
- Physical Apple Watch tap ergonomics remain unresolved.
- Real Watch VoiceOver spoken cadence and focus order remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 validation is described as non-real-device validation only.
- Non-real-device validation is not treated as real Apple Watch QA or real-device HealthKit QA.
- No real-device QA result was fabricated.
- HealthKit remains read-only.
- No HealthKit write access or write authorization was added.
- No raw HealthKit upload or developer-accessible health database is introduced.
- No diagnosis, treatment, therapy, emergency, abnormal-state, warning, disease-detection, clinical-stress, medical-grade, or medical-advice claim is made.
- `Low` remains subjective, non-medical, non-warning, and non-score-lowering.
- Missing Check-ins and missing HealthKit data remain neutral.
- Check-ins do not affect State Score.
- Watch Check-in remains Watch-only.
- Watch Check-in remains local-only.
- The four states remain exactly `Energized`, `Stable`, `Tired`, and `Low`.
- Traditional Chinese reference labels remain exactly `有活力`, `穩定`, `疲累`, and `低狀態`.
- Display modes remain `Icon + Text`, `Icon Only`, and `Text Only`.
- Default display remains `Icon + Text`.
- Latest-three recent history remains unchanged.
- No latest-five history added.
- No clear-all UI added.
- No long-term history added.
- No notes, export, reminders, notifications, trends, streaks, counts, causes, interpretations, pattern summaries, or insights added.
- No iPhone Check-in UI, history, deletion, or management added.
- Old iPhone CheckInView scaffold was not addressed.
- No WidgetKit Check-in display, summary, or direct read added.
- No App Group raw Check-in history, propagation, or display preference propagation added.
- No WatchConnectivity added.
- No State Score integration added.
- No networking, cloud sync, iCloud sync, analytics, AI, account system, login, upload path, or remote config added.
- No Swift files changed.
- No Xcode project files changed.
- No entitlements changed.
- No plist files changed.
- No CI workflows changed.
- No product behavior changed.
- Recommended next phase is Phase 9.35: Signing Remediation Execution Prep.
- Local validation commands pass.
- GitHub Actions status is reviewed after PR creation.
- No Phase 9.35 work started.
