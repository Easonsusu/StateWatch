# Phase 9.38 Signing Evidence Collection Guide

## Purpose

This is a signing evidence collection guide, not Apple Developer configuration execution, signing configuration execution, Xcode project signing changes, Xcode archive, TestFlight upload, App Store Connect release action, App Store submission, or release-ready claim.

Phase 9.38 documents the non-secret evidence the user can safely collect before any future controlled signing re-verification, signing remediation, archive dry-run planning, TestFlight upload planning, or App Store Connect release work.

No Apple Developer configuration, signing change, DEVELOPMENT_TEAM setting, certificate installation, provisioning profile creation, bundle identifier creation, capability change, Xcode archive, .xcarchive creation, .ipa export, TestFlight upload, App Store Connect release work, App Store approval, App Store submission-readiness, or broad release-ready claim is made by this phase.

The guide asks only for non-secret evidence and explicitly forbids credentials, private keys, tokens, provisioning profile contents, account emails, and raw HealthKit data.

Archive dry-run planning remains blocked until the required signing blockers are resolved or explicitly accepted as unresolved blockers.

TestFlight upload planning remains blocked until Apple Developer, App Store Connect, distribution signing, archive, and upload prerequisites are verified.

Phase 9.22 remains deferred/blocked, not completed.

Real-device Watch VoiceOver QA remains unresolved.

Real-device HealthKit QA remains planned, not executed.

Phase 9.27 validation was non-real-device validation only and does not replace real Apple Watch QA or real-device HealthKit QA.

## Scope

Included:

- Documentation-only evidence collection guidance.
- A safe non-secret user evidence package template.
- Explicit secret handling and optional screenshot redaction rules.
- Separation of user-provided evidence from Codex re-verification work.
- Carry-forward of signing, privacy, HealthKit, medical-safety, real-device QA, and Watch Check-in MVP limitations.
- A matching Phase 9.38 checklist in `TEST_PLAN.md`.

Not included:

- Apple Developer configuration execution.
- App Store Connect configuration execution.
- Signing configuration execution.
- Xcode project signing changes.
- Setting `DEVELOPMENT_TEAM`.
- Certificate installation, revocation, creation, import, selection, or modification.
- Provisioning profile creation, download, installation, selection, or modification.
- Bundle identifier creation, verification, or modification in Apple Developer.
- Capability enablement or disablement.
- Entitlement, plist, or CI workflow changes.
- `xcodebuild archive`.
- `xcodebuild -allowProvisioningUpdates`.
- Xcode archive, `.xcarchive` creation, `.ipa` export, TestFlight upload, or App Store Connect release action.
- Swift implementation or product behavior changes.
- Phase 9.39 work.

## Current Baseline

- Current branch was created from `main` at `84417888afcccd9143eeb974cfc135c0f53e4cf9`.
- Xcode observed locally: Xcode 26.6, build 17F113.
- Schemes observed: `StateWatch`, `StateWatchWatchApp`, and `StateWatchComplications`.
- Targets observed: `StateWatch`, `StateWatchWatchApp`, `StateWatchTests`, and `StateWatchComplications`.
- `security find-identity -v -p codesigning` reported `0 valid identities found`.
- `CODE_SIGN_STYLE = Automatic` remains visible for relevant targets.
- `CODE_SIGN_IDENTITY = Apple Development` remains visible in the project file.
- `DEVELOPMENT_TEAM = ""` remains visible in `StateWatch.xcodeproj/project.pbxproj` for inspected configurations.
- `MARKETING_VERSION = 0.1.0` remains visible.
- `CURRENT_PROJECT_VERSION = 1` remains visible.
- iOS bundle ID observed: `com.easonsusu.StateWatch`.
- watchOS app bundle ID observed: `com.easonsusu.StateWatch.watchapp`.
- WidgetKit complications bundle ID observed: `com.easonsusu.StateWatch.watchapp.StateWatchComplications`.
- iOS HealthKit entitlement exists locally.
- App Group entitlement `group.com.easonsusu.StateWatch` exists locally for iOS app, watchOS app, and WidgetKit complications extension.
- iOS Info.plist includes `NSHealthShareUsageDescription`.
- No app plist key for `NSHealthUpdateUsageDescription` was observed; matches are documentation/test guardrails.
- `StateWatchWidgets` does not exist as a local directory; current WidgetKit code is under `StateWatchComplications`.
- Archive feasibility remains unproven.
- TestFlight upload feasibility remains unproven.

## Relationship To Phase 9.23 Through Phase 9.37

- Phase 9.23 records release blockers and deferred blockers.
- Phase 9.24 limits Watch Check-in MVP readiness to internal TestFlight planning with explicit limitations.
- Phase 9.25 creates an internal TestFlight QA checklist, not an executed TestFlight report.
- Phase 9.26 audits App Store privacy and medical-safety boundaries, not App Store submission.
- Phase 9.27 records non-real-device validation only.
- Phase 9.28 records known limitations and release-note guidance only.
- Phase 9.29 records internal TestFlight distribution readiness checklist only.
- Phase 9.30 records internal TestFlight build preparation plan only.
- Phase 9.31 records archive/signing environment inventory only.
- Phase 9.32 records Apple Developer and signing verification plan only.
- Phase 9.33 records Apple Developer signing verification results only.
- Phase 9.34 records signing remediation plan only.
- Phase 9.35 records signing remediation execution prep only.
- Phase 9.36 records signing remediation execution results only.
- Phase 9.37 records signing blocker resolution follow-up plan only.
- Phase 9.38 records signing evidence collection guidance only.

## Explicit Limitations Carried Forward

- Phase 9.22 remains deferred/blocked, not completed.
- Real-device Watch Check-in VoiceOver QA remains unresolved.
- Physical Apple Watch small-screen tap ergonomics remain unresolved.
- Real Watch VoiceOver spoken cadence and focus order remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 validation was non-real-device validation only and does not replace real Apple Watch QA or real-device HealthKit QA.
- Broad Watch Check-in release-ready claims remain blocked.
- External App Store submission readiness is not claimed.
- Internal TestFlight signing evidence collection may continue only with explicit limitations.
- HealthKit remains read-only.
- StateWatch remains non-medical wellness/readiness software.
- Check-ins do not affect State Score, readiness, confidence, reasons, or suggestions.

## Phase 9.37 Blocker Follow-up Carried Forward

- Apple Developer account access remains unresolved.
- App Store Connect access remains unresolved.
- Team ID / `DEVELOPMENT_TEAM` remains unresolved.
- Valid local signing identities remain unavailable.
- Certificate handling remains blocked.
- Provisioning profile availability remains unresolved.
- App ID account-level state remains unresolved for iOS app, watchOS app, and WidgetKit complications extension.
- HealthKit capability account-level state remains unresolved.
- App Group account-level state remains unresolved.
- Watch app and WidgetKit relationship state remains unresolved.
- Archive dry-run planning remains blocked until signing blockers are resolved or explicitly accepted.
- TestFlight upload planning remains blocked until Apple Developer, App Store Connect, distribution signing, archive, and upload prerequisites are verified.

## Files Reviewed

- `Docs/phase-9-37-signing-blocker-resolution-follow-up-plan.md`
- `Docs/phase-9-36-signing-remediation-execution-results.md`
- `Docs/phase-9-35-signing-remediation-execution-prep.md`
- `Docs/phase-9-34-signing-remediation-plan.md`
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
- `xcodebuild -version`
- `xcodebuild -project StateWatch.xcodeproj -list`
- `security find-identity -v -p codesigning`
- `rg -n "PRODUCT_BUNDLE_IDENTIFIER|MARKETING_VERSION|CURRENT_PROJECT_VERSION|CODE_SIGN_STYLE|DEVELOPMENT_TEAM|PROVISIONING_PROFILE_SPECIFIER|CODE_SIGN_IDENTITY|CODE_SIGN_ENTITLEMENTS|INFOPLIST_FILE|ASSETCATALOG_COMPILER_APPICON_NAME|SUPPORTED_PLATFORMS|SDKROOT|TARGETED_DEVICE_FAMILY" StateWatch.xcodeproj/project.pbxproj`
- `rg -n "com.apple.developer.healthkit|com.apple.security.application-groups|aps-environment|keychain-access-groups|WKCompanionAppBundleIdentifier|WKApplication|WKWatchOnly|NSExtension|CFBundleIdentifier|CFBundleShortVersionString|CFBundleVersion|NSHealthShareUsageDescription|NSHealthUpdateUsageDescription" StateWatchApp StateWatchWatchApp StateWatchComplications StateWatchShared StateWatchWidgets StateWatch.xcodeproj Docs TEST_PLAN.md`
- Focused reference searches across docs, the Xcode project, source, tests, release planning docs, privacy docs, medical-safety docs, and UI copy docs.

`xcodebuild -project StateWatch.xcodeproj -list` emitted local CoreSimulator/cache warnings in this environment but returned the expected project targets and schemes.

## Search Terms Used

Searches covered these groups:

- Signing and project settings: `PRODUCT_BUNDLE_IDENTIFIER`, `MARKETING_VERSION`, `CURRENT_PROJECT_VERSION`, `CODE_SIGN_STYLE`, `DEVELOPMENT_TEAM`, `PROVISIONING_PROFILE_SPECIFIER`, `CODE_SIGN_IDENTITY`, `CODE_SIGN_ENTITLEMENTS`, `INFOPLIST_FILE`, `ASSETCATALOG_COMPILER_APPICON_NAME`, `SUPPORTED_PLATFORMS`, `SDKROOT`, and `TARGETED_DEVICE_FAMILY`.
- Capabilities and plists: `com.apple.developer.healthkit`, `com.apple.security.application-groups`, `aps-environment`, `keychain-access-groups`, `WKCompanionAppBundleIdentifier`, `WKApplication`, `WKWatchOnly`, `NSExtension`, `CFBundleIdentifier`, `CFBundleShortVersionString`, `CFBundleVersion`, `NSHealthShareUsageDescription`, and `NSHealthUpdateUsageDescription`.
- Release planning terms: Apple Developer, App Store Connect, certificates, signing identity, provisioning, profile, bundle identifier, bundle ID, App ID, capability, HealthKit, App Group, WidgetKit, Watch app, TestFlight, App Store Connect, archive, `xcodebuild archive`, `allowProvisioningUpdates`, `xcarchive`, `ipa`, `exportOptions`, approval claims, real-device QA, VoiceOver, HealthKit QA, and Phase 9.22 through Phase 9.38.
- Evidence safety terms: Apple ID email, password, 2FA, token, API key, private key, certificate serial, fingerprint, provisioning profile contents, profile UUID, raw HealthKit, HealthKit sample, and account email.
- Watch Check-in scope terms: Watch Check-in, State Check-in, check-in, latest-three, latest five, clear-all, `Icon + Text`, `Icon Only`, `Text Only`, Energized, Stable, Tired, Low, 有活力, 穩定, 疲累, 低狀態, self-reported, local Watch, local-only, Watch-only, single-record, and delete.
- Forbidden implementation mechanisms: iPhone Check-in, WidgetKit Check-in, App Group raw Check-in history, App Group Check-in, WatchConnectivity, `WCSession`, State Score integration, HealthKit write, `HKHealthStore.save`, `requestAuthorization(toShare`, `toShare`, `URLSession`, cloud, iCloud, analytics, remote config, AI cloud, account, login, sign in, upload path, developer database, sync, and network.
- Medical-safety terms: diagnosis, clinical, medical advice, treatment, therapy, emergency, warning, abnormal, health risk, anxiety, depression, disease, detected, caused by, because you, symptom history, medical record, score dropped, low because, bad health, doctor, physician, care provider, regulatory, FDA, and clearance.

Matches were reviewed as existing boundary/disclaimer/test-context matches, Phase docs/test guardrails, forbidden-copy examples, limitation language, evidence collection rules, signing blocker follow-up planning language, release blocker language, or clearly marked fail criteria, not new unsafe product copy or implementation scope creep.

## Evidence Labels

Use these labels for Phase 9.38 evidence collection:

- User can provide non-secret answer
- User must not share secret
- Screenshot optional with redaction
- Codex can re-check locally after evidence
- Requires Apple Developer access
- Requires App Store Connect access
- Requires valid signing identity
- Requires explicit authorization
- Blocked before archive dry-run
- Blocked before TestFlight upload
- Deferred pending hardware
- Future external-release blocker
- Not applicable to current MVP
- Non-blocking follow-up

## Evidence Collection Summary Table

| ID | Evidence item | Label | User can provide | User must not provide | Blocks archive dry-run? | Blocks TestFlight upload? | Codex follow-up after evidence |
| --- | --- | --- | --- | --- | --- | --- | --- |
| EV-001 | Apple Developer Program membership | User can provide non-secret answer | Active / inactive / unsure. | Apple ID email, password, 2FA, tokens. | Yes | Yes | Use status to choose next phase. |
| EV-002 | Apple Developer team role | User can provide non-secret answer | Whether role can manage Certificates, Identifiers & Profiles. | Account email or private screenshots. | Yes | Yes | Confirm role is enough for signing remediation. |
| EV-003 | Team ID | User can provide non-secret answer | Intended Team ID, partially redacted if desired. | Apple ID email or account details. | Yes | Yes | Compare to future authorized `DEVELOPMENT_TEAM` change. |
| EV-004 | Xcode account/team visibility | Screenshot optional with redaction | Whether Xcode Settings > Accounts shows correct team. | Unredacted Apple ID email. | Yes | Yes | Re-check build settings after setup. |
| EV-005 | Apple Development signing identity | Requires valid signing identity | Yes / no / unsure that a valid identity exists locally. | Serial, fingerprint, private key. | Yes | Yes | Re-run local signing identity check. |
| EV-006 | Apple Distribution signing identity | Requires valid signing identity | Yes / no / unsure that a valid identity exists locally. | Serial, fingerprint, private key. | Maybe | Yes | Re-run local signing identity check. |
| EV-007 | iOS App ID existence | Requires Apple Developer access | Whether `com.easonsusu.StateWatch` exists. | Account screenshots with private data. | Yes | Yes | Compare with local bundle ID. |
| EV-008 | watchOS App ID existence | Requires Apple Developer access | Whether `com.easonsusu.StateWatch.watchapp` exists. | Account screenshots with private data. | Yes | Yes | Compare with local bundle ID. |
| EV-009 | WidgetKit complications App ID existence | Requires Apple Developer access | Whether `com.easonsusu.StateWatch.watchapp.StateWatchComplications` exists. | Account screenshots with private data. | Yes | Yes | Compare with local bundle ID. |
| EV-010 | HealthKit capability | Blocked before TestFlight upload | Whether HealthKit is enabled for iOS App ID only. | HealthKit samples or write-scope changes. | Maybe | Yes | Confirm read-only HealthKit boundaries. |
| EV-011 | App Group existence | Blocked before archive dry-run | Whether `group.com.easonsusu.StateWatch` exists. | Account screenshots with private data. | Yes | Yes | Compare with local entitlements. |
| EV-012 | App Group attachment | Blocked before archive dry-run | Whether App Group is attached to iOS, watchOS, and WidgetKit identifiers. | Unredacted account screenshots. | Yes | Yes | Compare target entitlements. |
| EV-013 | Watch app relationship | Blocked before archive dry-run | Whether iOS/watch relationship is valid. | Private account/device data. | Yes | Yes | Re-check local plist/project relationship markers. |
| EV-014 | WidgetKit / complications relationship | Blocked before archive dry-run | Whether extension relationship is valid. | Private account/device data. | Yes | Yes | Re-check local extension markers. |
| EV-015 | App Store Connect access | Requires App Store Connect access | Whether access exists for intended team. | Apple ID email, passwords, tokens. | No | Yes | Determine upload planning feasibility. |
| EV-016 | App Store Connect app record | Requires App Store Connect access | Whether StateWatch app record exists. | Private screenshots or account identifiers. | No | Yes | Use status for future upload planning. |
| EV-017 | Agreements / compliance prompts | Blocked before TestFlight upload | Whether agreements/prompts block upload. | Private account details. | No | Yes | Carry blockers into upload plan. |
| EV-018 | TestFlight access | Blocked before TestFlight upload | Whether TestFlight is available for the app record. | Private account details. | No | Yes | Determine upload path readiness. |
| EV-019 | Provisioning profile availability | Blocked before archive dry-run | Whether profiles are available or automatically resolvable. | Profile contents or UUIDs unless redacted. | Yes | Yes | Re-check build settings only after user action. |
| EV-020 | DEVELOPMENT_TEAM authorization | Requires explicit authorization | Yes / no authorization for a future phase. | Account email or credentials. | Yes | Yes | Only act in a future authorized phase. |
| EV-021 | Certificate/provisioning authorization | Requires explicit authorization | Yes / no authorization for future cert/profile actions. | Private keys, cert serials/fingerprints, profiles. | Yes | Yes | Only act in a future authorized phase. |
| EV-022 | Archive dry-run authorization | Requires explicit authorization | Yes / no authorization for a future non-upload archive dry-run. | Signing secrets. | Yes | Yes | Only plan/archive in a future phase. |
| EV-023 | Real-device Watch VoiceOver hardware | Deferred pending hardware | Whether real Apple Watch is available later. | Personal device identifiers. | No | Future external-release blocker | Keep QA unresolved until executed. |
| EV-024 | Physical Apple Watch tap ergonomics hardware | Deferred pending hardware | Whether real Apple Watch is available later. | Personal device identifiers. | No | Future external-release blocker | Keep QA unresolved until executed. |
| EV-025 | Real-device HealthKit hardware | Deferred pending hardware | Whether real iPhone / Apple Watch setup is available later. | Raw HealthKit data. | No | Future external-release blocker | Keep QA unresolved until executed. |
| EV-026 | Watch Check-in MVP scope | Codex can re-check locally after evidence | Confirm no request to expand scope. | Not applicable. | No | No | Confirm future diffs preserve Watch-only local-only scope. |
| EV-027 | iPhone Check-in | Not applicable to current MVP | No evidence needed. | Claims of iPhone Check-in support. | No | No | Keep out of MVP. |
| EV-028 | WidgetKit Check-in | Not applicable to current MVP | No evidence needed. | Claims of WidgetKit Check-in support. | No | No | Keep out of MVP. |
| EV-029 | WatchConnectivity | Not applicable to current MVP | No evidence needed. | Claims of WatchConnectivity sync. | No | No | Keep out of MVP. |
| EV-030 | State Score integration | Not applicable to current MVP | No evidence needed. | Claims that Check-ins affect score. | No | No | Keep out of MVP. |
| EV-031 | Old iPhone CheckInView scaffold | Non-blocking follow-up | No signing evidence needed. | User-facing support claims. | No | No | Review separately later. |
| EV-032 | StateWatchThemeTests.swift size | Non-blocking follow-up | No signing evidence needed. | Not applicable. | No | No | Refactor in separate test-maintenance phase. |

## User Evidence Checklist

The user should collect only high-level, non-secret answers. A copied evidence package is enough; screenshots are optional and must be redacted.

## User Evidence Package Template

- Apple Developer Program membership active: Yes / No / Unsure
- Apple Developer team role can manage Certificates, Identifiers & Profiles: Yes / No / Unsure
- Team ID intended for StateWatch: [Team ID or partially redacted]
- Xcode Settings > Accounts shows correct team: Yes / No / Unsure
- Valid Apple Development identity available locally: Yes / No / Unsure
- Valid Apple Distribution identity available locally: Yes / No / Unsure
- iOS App ID com.easonsusu.StateWatch exists: Yes / No / Unsure
- watchOS App ID com.easonsusu.StateWatch.watchapp exists: Yes / No / Unsure
- WidgetKit App ID com.easonsusu.StateWatch.watchapp.StateWatchComplications exists: Yes / No / Unsure
- HealthKit enabled for iOS App ID only: Yes / No / Unsure
- App Group group.com.easonsusu.StateWatch exists: Yes / No / Unsure
- App Group attached to iOS/watchOS/WidgetKit identifiers: Yes / No / Unsure
- Watch app relationship valid: Yes / No / Unsure
- WidgetKit/complications relationship valid: Yes / No / Unsure
- App Store Connect access available: Yes / No / Unsure
- App Store Connect StateWatch app record exists: Yes / No / Unsure
- Agreements/compliance prompts blocking upload: Yes / No / Unsure
- TestFlight available for the app record: Yes / No / Unsure
- Provisioning profiles automatically resolvable or available: Yes / No / Unsure
- User explicitly authorizes future DEVELOPMENT_TEAM setting after evidence is reviewed: Yes / No
- User explicitly authorizes future certificate/profile actions if required: Yes / No
- User explicitly authorizes future non-upload archive dry-run after blockers are resolved: Yes / No
- Real Apple Watch available for VoiceOver/tap QA later: Yes / No / Unsure
- Real iPhone/Apple Watch HealthKit QA setup available later: Yes / No / Unsure

## What The User Should Provide

- Yes / No / Unsure answers from the template above.
- Optional redacted screenshots only if they help clarify team, role, App ID, capability, or app-record status.
- A plain statement of whether future `DEVELOPMENT_TEAM`, certificate/profile, or non-upload archive dry-run work is authorized.
- No raw account, certificate, profile, private key, or health data.

## What The User Must Not Provide

- Apple ID email.
- Passwords.
- 2FA codes.
- Tokens.
- API keys.
- Certificate private keys.
- Certificate serials/fingerprints.
- Provisioning profile contents.
- Profile UUIDs unless explicitly redacted.
- Screenshots with private account/device data.
- Raw HealthKit data.
- HealthKit samples.
- Account emails.

## Optional Screenshot Redaction Rules

Screenshots are optional. If provided, redact Apple ID email, personal names if desired, team member emails, certificate serials, certificate fingerprints, profile UUIDs, device names, device UDIDs, tokens, private keys, App Store Connect user lists, and any HealthKit or personal health data.

## Apple Developer Evidence Section

The useful evidence is whether membership is active, whether the intended team is visible, whether the role can manage Certificates, Identifiers & Profiles, and whether required App IDs/capabilities/App Groups exist. Do not share credentials or private account identity details.

## Xcode Account/Team Evidence Section

The useful evidence is whether Xcode Settings > Accounts shows the intended team. Screenshots are optional and must redact Apple ID email.

## Signing Identity Evidence Section

The useful evidence is whether valid Apple Development and Apple Distribution identities are available locally. Do not share certificate serials, fingerprints, private keys, or keychain details.

## App ID / Bundle Identifier Evidence Section

The useful evidence is whether these App IDs exist under the intended team:

- `com.easonsusu.StateWatch`
- `com.easonsusu.StateWatch.watchapp`
- `com.easonsusu.StateWatch.watchapp.StateWatchComplications`

Do not create or modify App IDs in this phase.

## HealthKit Capability Evidence Section

The useful evidence is whether HealthKit is enabled for the iOS App ID only. Do not enable or request HealthKit write access, do not add `NSHealthUpdateUsageDescription`, and do not share raw HealthKit data.

## App Group Capability Evidence Section

The useful evidence is whether App Group `group.com.easonsusu.StateWatch` exists and is attached to the iOS, watchOS, and WidgetKit identifiers as needed. This does not imply Check-in propagation, WidgetKit Check-in display, WatchConnectivity, or HealthKit-derived production rollout.

## Watch App Relationship Evidence Section

The useful evidence is whether the watch app relationship is valid for the iOS app under the intended team. Do not make project or account changes in this phase.

## WidgetKit / Complications Relationship Evidence Section

The useful evidence is whether the WidgetKit/complications extension relationship is valid for the watch app. This does not add WidgetKit Check-in display, summary, direct reads, or live HealthKit-backed timelines.

## App Store Connect Evidence Section

The useful evidence is whether the user can access App Store Connect, whether a StateWatch app record exists for `com.easonsusu.StateWatch`, whether agreements or compliance prompts are blocking upload, and whether TestFlight is available for the app record. Do not create the app record in this phase.

## Provisioning Profile Evidence Section

The useful evidence is whether profiles are automatically resolvable or available for app, watch app, and extension. Do not paste profile contents or unredacted UUIDs.

## Authorization Evidence Section

The useful evidence is explicit yes/no authorization for future phases, not execution in this phase:

- Future `DEVELOPMENT_TEAM` setting after evidence is reviewed.
- Future certificate/profile actions if required.
- Future non-upload archive dry-run after blockers are resolved.

## Archive Dry-run Evidence Section

Archive dry-run planning remains blocked until signing blockers are resolved or explicitly accepted as unresolved. This phase does not run an archive.

## TestFlight Upload Evidence Section

TestFlight upload planning remains blocked until Apple Developer, App Store Connect, distribution signing, archive, and upload prerequisites are verified. This phase does not upload to TestFlight.

## Real-device QA Evidence Section

The useful evidence is only whether hardware will be available later. Real-device Watch VoiceOver QA, physical Apple Watch tap ergonomics QA, and real-device HealthKit QA remain unresolved until actually performed.

## Codex Re-verification Checklist After User Evidence

After the user provides non-secret evidence and explicit authorization in a future phase, Codex may re-check:

- Branch cleanliness and target branch state.
- Xcode version and project scheme list.
- Local signing identity availability.
- `DEVELOPMENT_TEAM`, `CODE_SIGN_STYLE`, `CODE_SIGN_IDENTITY`, bundle IDs, versions, plist paths, and entitlement paths.
- HealthKit read-only entitlement and plist boundaries.
- App Group entitlement consistency.
- Watch app and WidgetKit relationship markers.
- Whether the future requested action matches explicit authorization.

Codex must not run `xcodebuild archive`, `xcodebuild -allowProvisioningUpdates`, export an `.ipa`, or upload to TestFlight unless that exact action is explicitly authorized in a future phase.

## Privacy / HealthKit Evidence Review

HealthKit remains read-only. This guide forbids raw HealthKit data, HealthKit samples, HealthKit write access, write authorization, raw HealthKit upload, developer-accessible health databases, networking paths, cloud sync, analytics paths, AI cloud analysis, account systems, and remote config.

## Medical-safety Evidence Review

StateWatch remains non-medical wellness/readiness software. This guide does not introduce diagnosis, treatment, therapy, emergency, abnormal-state, warning, disease-detection, clinical-stress, medical-grade, medical-advice, or risk-claim product behavior.

## Watch Check-in MVP Evidence Review

Watch Check-in remains Watch-only and local-only. The four states remain `Energized`, `Stable`, `Tired`, and `Low`; Traditional Chinese reference labels remain `有活力`, `穩定`, `疲累`, and `低狀態`; display modes remain `Icon + Text`, `Icon Only`, and `Text Only`; default display remains `Icon + Text`; latest-three history remains unchanged.

Check-ins do not affect State Score, readiness, confidence, reasons, suggestions, iPhone surfaces, WidgetKit complications, App Group summaries, WatchConnectivity, HealthKit, networking, cloud, analytics, AI, accounts, reminders, notifications, trends, streaks, counts, causes, interpretations, pattern summaries, or insights.

## Items Not Included In Current MVP

- iPhone Check-in UI, history, deletion, or management.
- WidgetKit Check-in display, summary, or direct read.
- App Group raw Check-in history or display preference propagation.
- WatchConnectivity.
- State Score integration.
- latest-five history.
- clear-all UI.
- long-term history.
- notes, export, reminders, notifications, scheduling, trends, streaks, counts, causes, interpretations, pattern summaries, or insights.

## Prohibited Evidence-collection Claims

Do not claim:

- Release ready.
- App Store ready.
- Approved for external release.
- Signing fixed.
- Signing fully verified.
- Apple Developer configured.
- App Store Connect configured.
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

## Allowed Evidence-collection Claims

It is acceptable to say:

- Signing evidence collection guide recorded.
- Non-secret evidence checklist is documented.
- Secret handling and screenshot redaction rules are documented.
- Remaining signing blockers are separated into user evidence and Codex re-verification items.
- No Apple Developer or signing configuration was changed in this phase.
- No `DEVELOPMENT_TEAM` was set in this phase.
- No certificates, provisioning profiles, bundle identifiers, or capabilities were changed in this phase.
- No archive or upload was performed in this phase.
- Archive dry-run planning remains blocked until signing blockers are resolved or explicitly accepted.
- TestFlight upload planning remains blocked until Apple Developer, App Store Connect, distribution signing, archive, and upload prerequisites are verified.
- Watch Check-in MVP is Watch-only and local-only.
- Real-device Watch VoiceOver and real-device HealthKit QA remain pending.
- HealthKit remains read-only.
- StateWatch remains non-medical wellness/readiness software.

## Work That May Continue

- Documentation-only signing evidence collection.
- Documentation-only QA planning.
- Source review of privacy, HealthKit read-only boundaries, medical-safety wording, and Watch Check-in MVP scope.
- Non-mutating local verification commands.
- Future branch planning that explicitly avoids signing, archive, upload, App Store Connect, or product behavior changes.

## Work That Must Wait

- Setting `DEVELOPMENT_TEAM`.
- Changing Xcode signing settings.
- Certificate handling.
- Provisioning profile handling.
- Bundle ID or capability changes.
- Archive dry-run execution.
- `.xcarchive` creation.
- `.ipa` export.
- TestFlight upload.
- App Store Connect release action.
- External release-readiness claims.
- Claims based on real-device Watch VoiceOver or real-device HealthKit QA.

## Non-blocking Follow-ups

- Review the old iPhone `CheckInView` scaffold separately if needed.
- Split `StateWatchThemeTests.swift` in a later test refactor phase.
- Continue docs-only release planning with explicit limitations.

## Risks / Limitations

- Apple Developer and App Store Connect status cannot be proven from local repository files.
- User-provided evidence must be non-secret and may still require later verification.
- Valid signing identity availability remains unresolved locally.
- Automatic signing may still fail later if App IDs, capabilities, profiles, or bundle relationships are misconfigured.
- Archive and upload feasibility remain unproven.
- Real-device Watch VoiceOver, real Apple Watch tap ergonomics, and real-device HealthKit QA remain unresolved.
- Google Drive sync may create local filesystem timing issues; repository work should stay inside the existing checkout and avoid modifying unrelated sync metadata.

## Recommended Next Phase

If the user still cannot provide enough non-secret evidence: Phase 9.39: Signing Evidence Collection Follow-up.

If the user provides enough non-secret evidence: Phase 9.39: Controlled Signing Re-verification.

If signing prerequisites are verified and explicitly authorized: Phase 9.39: Archive Dry-Run Plan.

Phase 9.39 must use this document as input, avoid mutable signing changes unless explicitly authorized, avoid archive/upload unless explicitly authorized in its own phase, preserve unresolved real-device Watch VoiceOver and real-device HealthKit QA limitations, and avoid broad release-ready language unless limitations are explicit.

## Changes Made

- Added `Docs/phase-9-38-signing-evidence-collection-guide.md`.
- Updated `TEST_PLAN.md` with a Phase 9.38 checklist.

No Swift files, Xcode project files, entitlements, plist files, CI workflows, signing settings, certificates, provisioning profiles, bundle identifiers, capabilities, archives, uploads, App Store Connect records, App Store metadata, screenshots, privacy labels, review notes, or product behavior were changed.

## Final Phase 9.38 Checklist

- Phase 9.38 signing evidence collection guide documented.
- Phase 9.23 through Phase 9.37 used as input.
- Phase 9.37 signing blockers carried forward.
- Apple Developer evidence checklist documented.
- Xcode account/team evidence checklist documented.
- Signing identity evidence checklist documented.
- App ID / bundle identifier evidence checklist documented.
- HealthKit capability evidence checklist documented.
- App Group capability evidence checklist documented.
- Watch app relationship evidence checklist documented.
- WidgetKit / complications relationship evidence checklist documented.
- App Store Connect evidence checklist documented.
- Provisioning profile evidence checklist documented.
- Authorization evidence checklist documented.
- Archive dry-run evidence checklist documented.
- TestFlight upload evidence checklist documented.
- Real-device QA evidence checklist documented.
- User Evidence Package Template documented.
- Secret handling and screenshot redaction rules documented.
- Codex re-verification checklist documented.
- No Apple Developer configuration performed.
- No signing configuration changed.
- No `DEVELOPMENT_TEAM` set.
- No certificates, provisioning profiles, bundle IDs, or capabilities changed.
- No archive, `.xcarchive`, `.ipa`, TestFlight upload, or App Store Connect release work performed.
- No secrets, private keys, profiles, tokens, account emails, or raw HealthKit data committed.
- No broad release-ready, App Store approval, external submission-readiness, signing-fixed, archive-ready, or TestFlight-ready claim made.
- Phase 9.22 remains deferred/blocked.
- Real-device Watch VoiceOver QA remains unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 remains non-real-device validation only.
- HealthKit remains read-only.
- Watch Check-in remains Watch-only and local-only.
- No prohibited product scope added.
- Phase 9.39 not started.
