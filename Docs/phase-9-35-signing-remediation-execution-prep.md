# Phase 9.35 Signing Remediation Execution Prep

## Purpose

This is signing remediation execution prep, not Apple Developer configuration execution, signing configuration execution, Xcode project signing changes, Xcode archive, TestFlight upload, App Store Connect release action, App Store submission, or release-ready claim.

Phase 9.35 uses the Phase 9.34 signing remediation plan to document the exact manual steps, evidence checklist, redaction rules, and stop conditions required before any future signing remediation execution phase.

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

- Convert the Phase 9.34 remediation plan into a future execution-prep checklist.
- Define manual Apple Developer, App Store Connect, and Xcode Account checks.
- Define evidence that must be captured before changing project signing.
- Define redaction rules for evidence that must not be committed.
- Define stop conditions before any future signing remediation execution, archive dry run, TestFlight upload, or App Store Connect release action.
- Carry forward unresolved Watch Check-in, real-device VoiceOver, physical Apple Watch ergonomics, real-device HealthKit QA, HealthKit read-only, privacy, and medical-safety limitations.
- Add a matching Phase 9.35 checklist to `TEST_PLAN.md`.

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
- iPhone Check-in, WidgetKit Check-in, App Group Check-in propagation, WatchConnectivity, State Score integration, HealthKit write, networking, cloud sync, analytics, AI, accounts, remote config, reminders, notifications, notes, export, trends, streaks, counts, causes, interpretations, pattern summaries, or insights.
- Phase 9.36 work.

## Current Baseline

- Phase 9.34 was merged through PR #81.
- Baseline commit at the start of this phase: `bce88ee351ff8ac4624d679c4cf3188a36c50c2e`.
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

## Relationship To Phase 9.23 Through Phase 9.34

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
- Phase 9.34 recorded the signing remediation plan only.
- Phase 9.35 records signing remediation execution prep only.

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
- Phase 9.34 recorded signing remediation plan only.
- Broad Watch Check-in release-ready claims remain blocked.
- External App Store submission readiness is not claimed.
- Internal TestFlight signing remediation execution prep may continue only with explicit limitations.
- HealthKit remains read-only.
- StateWatch remains non-medical wellness/readiness software.

## Phase 9.34 Signing Remediation Plan Carried Forward

- `DEVELOPMENT_TEAM` remains unresolved.
- Valid local signing identities remain unavailable unless a future execution phase proves otherwise.
- Apple Developer / App Store Connect verification remains unresolved unless account access is used.
- Archive feasibility remains unproven.
- TestFlight upload feasibility remains unproven.
- No Apple Developer configuration was performed.
- No signing configuration was changed.
- No certificates, provisioning profiles, bundle identifiers, or capabilities were changed.
- Future signing execution must capture evidence, define stop conditions, and avoid archive/upload work unless separately authorized.

## Files Reviewed

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
- `git remote get-url origin`
- `git pull origin main`
- `git checkout -b phase-9.35-signing-remediation-execution-prep`
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
- Release planning terms: Apple Developer, developer team, certificates, code signing identity, signing identity, provisioning, profile, bundle identifier, bundle ID, App ID, capability, HealthKit, App Group, WidgetKit, Watch app, TestFlight, App Store Connect, archive, `xcodebuild archive`, `xcarchive`, `ipa`, `exportOptions`, release-ready claims, approval claims, real-device QA, VoiceOver, HealthKit QA, and Phase 9.22 through Phase 9.35.
- Watch Check-in scope terms: Watch Check-in, State Check-in, check-in, latest-three, latest five, clear-all, display modes, approved labels, Traditional Chinese reference labels, self-reported, local Watch, local-only, Watch-only, single-record, and delete.
- Forbidden implementation mechanisms: iPhone Check-in, WidgetKit Check-in, App Group raw Check-in history, App Group Check-in, WatchConnectivity, `WCSession`, State Score integration, HealthKit write, `HKHealthStore.save`, `requestAuthorization(toShare`, `toShare`, `URLSession`, cloud, iCloud, analytics, remote config, AI cloud, account, login, sign in, upload path, developer database, sync, and network.
- Medical-safety terms: diagnosis, clinical, medical advice, treatment, therapy, emergency, warning, abnormal, health risk, anxiety, depression, disease, detected, caused by, because you, symptom history, medical record, score dropped, low because, bad health, doctor, physician, care provider, regulatory, FDA, and clearance.

Matches were reviewed as existing boundary/disclaimer/test-context matches, Phase docs/test guardrails, forbidden-copy examples, release-note guidance, limitation language, signing remediation execution-prep language, release blocker language, or clearly marked fail criteria, not new unsafe product copy or implementation scope creep.

## Execution-prep Labels

Use these labels exactly for Phase 9.35 execution-prep planning:

- Prep documented
- Must capture evidence
- Must stop if unresolved
- Requires Apple Developer access
- Requires Xcode account/team setup
- Requires valid signing identity
- Deferred pending hardware
- Future external-release blocker
- Not applicable to current MVP
- Non-blocking follow-up

## Signing Remediation Execution-prep Summary Table

| ID | Execution-prep item | Label | Current unresolved state | Manual step / evidence to capture | Stop condition | Future phase allowed to execute |
| --- | --- | --- | --- | --- | --- | --- |
| EP-001 | Apple Developer account access | Requires Apple Developer access | Account/team access was not verified locally. | Sign in to Apple Developer, confirm membership, role, active agreements, and permission to manage identifiers/certificates/profiles/App Store Connect. Capture team name/ID at a non-secret level. | Stop if account access, team, role, or agreements are missing or ambiguous. | Phase 9.36 only with explicit authorization. |
| EP-002 | Development team ID | Must capture evidence | `DEVELOPMENT_TEAM` remains empty. | Capture the exact intended Team ID and the targets/configurations it would affect before setting it. | Stop if the Team ID is uncertain or belongs to the wrong account/team. | Phase 9.36 may set `DEVELOPMENT_TEAM` only if explicitly approved. |
| EP-003 | Local signing identities | Requires valid signing identity | `0 valid identities found`. | Run/inspect Xcode and Keychain identity availability for Apple Development and Apple Distribution; record only broad availability, not sensitive certificate details. | Stop if no valid identity exists or identity ownership is unclear. | Phase 9.36 may install/select identities only if explicitly approved. |
| EP-004 | Certificate handling | Requires valid signing identity | No valid local code-signing identity is available. | Prepare certificate import/create/select checklist; record who owns the cert and whether private key access exists without exposing private data. | Stop if private key provenance or access is unclear. | Phase 9.36 may handle certificates only if explicitly approved. |
| EP-005 | iOS app App ID / bundle identifier | Requires Apple Developer access | Local bundle ID `com.easonsusu.StateWatch`; Apple Developer App ID unresolved. | In Apple Developer, check Identifiers for `com.easonsusu.StateWatch`, team ownership, App ID type, and capability compatibility. | Stop if identifier is missing, owned elsewhere, or conflicts. | Phase 9.36 may verify/create only if explicitly approved. |
| EP-006 | Watch app App ID / bundle identifier | Requires Apple Developer access | Local bundle ID `com.easonsusu.StateWatch.watchapp`; Apple Developer App ID unresolved. | In Apple Developer, check the watch App ID and relationship to the iOS app. | Stop if watch relationship or ownership cannot be verified. | Phase 9.36 may verify/create only if explicitly approved. |
| EP-007 | WidgetKit / complications App ID / bundle identifier | Requires Apple Developer access | Local bundle ID `com.easonsusu.StateWatch.watchapp.StateWatchComplications`; Apple Developer App ID unresolved. | In Apple Developer, check extension identifier, parent relationship, signing eligibility, and capability compatibility. | Stop if extension relationship or identifier ownership is unclear. | Phase 9.36 may verify/create only if explicitly approved. |
| EP-008 | HealthKit capability | Must capture evidence | Local iOS HealthKit entitlement exists; Apple Developer capability unresolved. | Capture evidence that read-only HealthKit capability is available for the iOS App ID; confirm no write usage or write authorization is added. | Stop if verification suggests HealthKit write scope or missing entitlement. | Phase 9.36 may verify capability only if explicitly approved. |
| EP-009 | App Group capability | Must capture evidence | Local App Group entitlement exists; Apple Developer membership unresolved. | Capture evidence that `group.com.easonsusu.StateWatch` exists and is attached to iOS, watchOS, and WidgetKit identifiers. | Stop if App Group is missing, mis-owned, or requires product-scope changes. | Phase 9.36 may verify/attach only if explicitly approved. |
| EP-010 | Watch app relationship | Must capture evidence | Local watch target/scheme and `WKApplication` / `WKWatchOnly` markers exist; account-backed relationship unresolved. | Capture Xcode/Apple Developer/App Store Connect evidence that the Watch app relationship is correct and watch-only behavior remains intact. | Stop if relationship mismatch requires project changes beyond approved signing scope. | Phase 9.36 may verify relationship only if explicitly approved. |
| EP-011 | WidgetKit / complications relationship | Must capture evidence | Local WidgetKit extension target/plist/entitlement exist; account-backed relationship unresolved. | Capture evidence of extension relationship, signing coverage, and parent app linkage without adding Check-in widget display. | Stop if extension signing or parent relationship is unclear. | Phase 9.36 may verify relationship only if explicitly approved. |
| EP-012 | Xcode Accounts setup | Requires Xcode account/team setup | Xcode account/team setup was not changed. | Open Xcode > Settings > Accounts in a future authorized phase; verify account, team, and role before selecting team in Signing & Capabilities. | Stop if Xcode account or role is missing. | Phase 9.36 may perform account/team setup only if explicitly approved. |
| EP-013 | Automatic signing | Requires Xcode account/team setup | `CODE_SIGN_STYLE = Automatic`; profile resolution unproven. | After team/identity exists, verify Automatic signing can resolve required profiles without unexpected project/capability changes. | Stop if Automatic signing proposes unexpected capability, entitlement, or project changes. | Phase 9.36 may verify automatic signing only if explicitly approved. |
| EP-014 | Provisioning profiles | Must capture evidence | No provisioning profiles were verified. | Capture generated or explicit profile availability for iOS app, watch app, and WidgetKit extension. | Stop if any target lacks a matching profile. | Phase 9.36 may generate/download/select profiles only if explicitly approved. |
| EP-015 | Build number / version | Prep documented | `MARKETING_VERSION = 0.1.0`; `CURRENT_PROJECT_VERSION = 1`. | Decide whether build number should increment before archive/upload; no change in this phase. | Stop if release numbering policy is unclear. | Future release-prep phase may change version/build only if explicitly approved. |
| EP-016 | Archive scheme | Must capture evidence | Candidate archive scheme is not proven. | Capture evidence that the selected scheme, likely `StateWatch`, embeds/signs the Watch app and complications extension. | Stop if scheme or embedding behavior is unclear. | Future archive dry-run prep/execution phase, not Phase 9.35. |
| EP-017 | Archive dry-run readiness | Must stop if unresolved | Team, identity, profiles, capabilities, and scheme remain unresolved. | Prepare an archive dry-run go/no-go checklist requiring all signing evidence first. | Stop if any signing, App ID, capability, profile, or scheme evidence is missing. | Future separately authorized archive dry-run phase only. |
| EP-018 | TestFlight upload readiness | Must stop if unresolved | No archive, export, distribution signing, or upload path is verified. | Prepare upload go/no-go checklist requiring successful archive, distribution signing, App Store Connect record, compliance, and agreements. | Stop if archive/export/signing/App Store Connect state is incomplete. | Future separately authorized upload phase only. |
| EP-019 | App Store Connect app record | Requires Apple Developer access | App record and TestFlight availability unresolved. | Check app record, bundle linkage, platform support, SKU, category, compliance prompts, agreements, and TestFlight availability. | Stop if app record, agreements, compliance, or bundle linkage is missing. | Phase 9.36 may verify only if explicitly approved; upload waits. |
| EP-020 | Evidence handling | Must capture evidence | Evidence rules need to be explicit before execution. | Record non-secret team/bundle/capability/profile status; redact account emails, tokens, private keys, sensitive screenshots, serials, fingerprints, and private paths. | Stop if evidence would expose credentials or private certificate material. | Phase 9.36 may capture redacted evidence only. |
| EP-021 | Real-device Watch VoiceOver QA | Deferred pending hardware | Phase 9.22 remains deferred/blocked. | Preserve blocker; do not claim complete. | Stop any broad VoiceOver pass claim. | Separate hardware QA phase. |
| EP-022 | Physical Apple Watch tap ergonomics | Deferred pending hardware | Physical tap ergonomics remain unresolved. | Preserve blocker; do not claim complete. | Stop any physical ergonomics pass claim. | Separate hardware QA phase. |
| EP-023 | Real-device HealthKit QA | Deferred pending hardware | Real-device HealthKit QA remains planned, not executed. | Preserve blocker; do not claim complete. | Stop HealthKit production rollout claims. | Separate real-device HealthKit QA phase. |
| EP-024 | Watch Check-in MVP scope | Prep documented | Watch-only, local-only, latest-three, single-record deletion only. | Keep scope unchanged and document limitations. | Stop if signing prep expands product scope. | Future product phase only if explicitly approved. |
| EP-025 | iPhone Check-in | Not applicable to current MVP | iPhone Check-in is not supported. | Do not present as supported. | Stop if release docs imply iPhone Check-in support. | Separate future product phase. |
| EP-026 | WidgetKit Check-in | Not applicable to current MVP | WidgetKit Check-in is not supported. | Do not present as supported. | Stop if release docs imply WidgetKit Check-in support. | Separate future product/privacy phase. |
| EP-027 | WatchConnectivity | Not applicable to current MVP | WatchConnectivity is not included. | Do not present cross-device Check-in sync as supported. | Stop if prep implies WatchConnectivity. | Separate future architecture phase. |
| EP-028 | State Score integration | Not applicable to current MVP | Check-ins do not affect State Score, readiness, confidence, reasons, or suggestions. | Keep Check-ins separate from scoring. | Stop if prep implies scoring effects. | Separate future scoring/privacy phase. |
| EP-029 | Old iPhone CheckInView scaffold | Non-blocking follow-up | Old scaffold remains outside the Watch-only MVP. | Do not mention as user-facing; review separately. | Stop if release docs present it as supported. | Future cleanup/audit phase only. |
| EP-030 | StateWatchThemeTests.swift size | Non-blocking follow-up | Large test file remains a known refactor candidate. | Treat as internal test refactor only. | Stop if this docs phase starts test reorganization. | Separate future test refactor phase. |

## Apple Developer Account Access Manual Steps

For a future explicitly approved execution phase:

1. Open Apple Developer with the intended account.
2. Confirm the account belongs to the intended team.
3. Confirm the team role can manage Certificates, Identifiers, Profiles, and related capabilities.
4. Confirm agreements or membership status do not block identifier/profile changes.
5. Record only non-secret evidence: team display name, Team ID, role category, and whether permissions are available.
6. Do not record account password, 2FA codes, tokens, private email screenshots, or private account details.

Stop if the account, team, role, agreements, or permissions are ambiguous.

## Development Team ID Evidence Checklist

Before a future phase sets `DEVELOPMENT_TEAM`, capture:

- Intended Team ID.
- Intended team display name.
- Evidence that this team owns or can manage the StateWatch App IDs.
- Targets/configurations expected to receive the Team ID.
- Confirmation that the change is approved for iOS app, watchOS app, WidgetKit extension, and tests if needed.

Stop if the Team ID is uncertain, belongs to the wrong team, or would affect unexpected targets.

## Local Signing Identity Evidence Checklist

Before selecting or installing signing identities, capture:

- Whether a valid Apple Development identity is available.
- Whether a valid Apple Distribution identity is available.
- Whether the identity belongs to the intended Apple Developer team.
- Whether the private key is available locally when required.
- Whether Xcode can see the identity for the selected account/team.

Do not record serial numbers, SHA fingerprints, private key paths, or private certificate exports in committed files.

## Certificate Handling Prep

A future phase may import, create, or select certificates only with explicit approval. The prep checklist is:

1. Confirm whether Apple Development, Apple Distribution, or both are needed.
2. Confirm certificate ownership and team membership.
3. Confirm private key availability if using an existing certificate.
4. Confirm no certificates, private keys, profiles, or keychain exports are added to the repo.
5. Re-run high-level identity availability checks after approved setup.

Stop if certificate provenance, private key availability, or ownership is unclear.

## Bundle Identifier / App ID Manual Checks

Future Apple Developer checks should verify:

- `com.easonsusu.StateWatch` exists or can be created for the iOS app.
- `com.easonsusu.StateWatch.watchapp` exists or can be created for the watchOS app.
- `com.easonsusu.StateWatch.watchapp.StateWatchComplications` exists or can be created for the WidgetKit complications extension.
- Each App ID belongs to the intended team.
- Each App ID has the expected platform/extension relationship.
- No conflicting identifier is owned by another team or app.

Do not create or modify identifiers in this phase.

## HealthKit Capability Manual Checks

Future manual checks should verify:

- HealthKit is available for the iOS App ID `com.easonsusu.StateWatch`.
- The capability matches the MVP read-only HealthKit stance.
- No HealthKit write access, write authorization, or `NSHealthUpdateUsageDescription` is introduced.
- App Store privacy wording remains local-only and non-medical.

Stop if capability verification would require HealthKit write scope or new medical claims.

## App Group Capability Manual Checks

Future manual checks should verify:

- App Group `group.com.easonsusu.StateWatch` exists under the intended team.
- The iOS app, watchOS app, and WidgetKit complications extension identifiers are attached as needed.
- App Group verification does not imply raw Check-in history propagation, display preference propagation, WatchConnectivity, cloud sync, or HealthKit data export.

Stop if App Group ownership or membership is unclear.

## Watch App Relationship Manual Checks

Future manual checks should verify:

- Xcode recognizes the Watch app target relationship.
- Apple Developer and App Store Connect relationships match the local bundle IDs.
- Watch-only behavior remains as currently documented.
- Any archive candidate embeds/signs the Watch app correctly before archive claims are made.

Stop if fixing the relationship requires product behavior or project changes outside explicit signing scope.

## WidgetKit / Complications Relationship Manual Checks

Future manual checks should verify:

- WidgetKit complications extension identifier belongs to the intended team.
- Extension relationship to the Watch app / parent app is correct.
- App Group membership is correct.
- Signing profile coverage includes the extension.

Do not add WidgetKit Check-in display, Check-in summary, direct Check-in reads, or HealthKit-backed complication timelines.

## Xcode Accounts Setup Prep

A future authorized phase may use Xcode > Settings > Accounts to:

1. Add or select the intended Apple ID.
2. Confirm the intended team is visible.
3. Confirm the role can manage signing.
4. Confirm certificates/profiles can be viewed or downloaded.
5. Only then consider target Signing & Capabilities changes.

Stop if the team is missing, account permissions are insufficient, or Xcode proposes broad unintended project changes.

## Automatic Signing Prep

Because `CODE_SIGN_STYLE = Automatic`, a future phase should verify whether Xcode can resolve profiles automatically after team and identity setup. Automatic signing should not be allowed to silently add capabilities, alter entitlements, change bundle IDs, or change product behavior.

Do not run `xcodebuild -allowProvisioningUpdates` in this phase.

## Provisioning Profile Prep

Before archive, a future phase must verify profiles for:

- iOS app `com.easonsusu.StateWatch`.
- watchOS app `com.easonsusu.StateWatch.watchapp`.
- WidgetKit complications extension `com.easonsusu.StateWatch.watchapp.StateWatchComplications`.

Evidence should include high-level profile availability and matching target/bundle/capability coverage. Do not commit profile files or private profile details.

## Build Number / Version Decision Point

`MARKETING_VERSION` is `0.1.0` and `CURRENT_PROJECT_VERSION` is `1`. A future release-prep phase should decide whether to increment `CURRENT_PROJECT_VERSION` before archive/upload. This phase does not change either value.

## Archive Scheme Evidence Checklist

Before any archive dry run, capture:

- Selected scheme name.
- Destination/platform used for archive planning.
- Evidence that the scheme includes the iOS app and required Watch/WidgetKit products.
- Evidence that all signing targets have team/identity/profile coverage.
- Stop condition if scheme embedding/signing behavior is unclear.

The likely candidate may be `StateWatch`, but this phase does not verify or claim archive behavior.

## Archive Dry-run Stop Conditions

Do not start an archive dry run if any of these remain unresolved:

- Apple Developer account/team access.
- Correct Team ID.
- Valid signing identity.
- App IDs and bundle ownership.
- HealthKit capability.
- App Group membership.
- Watch app relationship.
- WidgetKit extension relationship.
- Provisioning profiles for every required target.
- Archive scheme selection.
- Evidence capture and redaction plan.
- Explicit user approval for archive dry-run scope.

## TestFlight Upload Stop Conditions

Do not upload to TestFlight if any of these remain unresolved:

- No successful archive exists.
- Distribution signing is not verified.
- `.ipa` export path is not explicitly authorized and verified.
- App Store Connect app record is missing or ambiguous.
- Bundle linkage/platform support/SKU/category/compliance prompts/agreements are incomplete.
- Privacy labels or App Store metadata are not ready for the intended internal testing scope.
- Real-device limitations are not documented for testers.
- Explicit user approval for upload is missing.

## App Store Connect App Record Manual Checks

Future manual checks should verify:

- App record exists for the intended bundle ID.
- Platform support is correct.
- SKU is known.
- Category and compliance prompts are understood.
- Agreements and paid apps setup do not block TestFlight.
- TestFlight tab/build upload path is available.
- Internal testing limitations are ready to disclose.

Do not change App Store Connect metadata in this phase.

## Evidence Handling And Redaction Rules

Allowed to record in docs:

- High-level account/team access status.
- Team ID and team display name if the user approves recording them.
- Bundle IDs.
- Capability enabled/disabled status.
- Profile availability status.
- Broad certificate type availability, such as Apple Development or Apple Distribution present/not present.
- Non-sensitive screenshots only after redacting account email, tokens, private identifiers, certificate details, and personal information.

Do not commit:

- Certificates or private keys.
- Provisioning profile files.
- Keychain exports.
- Passwords, tokens, 2FA codes, API keys, or App Store Connect keys.
- Certificate serial numbers, SHA fingerprints, private key paths, or sensitive account screenshots.
- Full personal account emails unless the user explicitly approves.

Stop if evidence cannot be safely redacted.

## Real-device QA Blockers Carried Forward

- Phase 9.22 remains deferred/blocked, not completed.
- Real-device Watch VoiceOver QA remains unresolved.
- Physical Apple Watch tap ergonomics remain unresolved.
- Real Watch VoiceOver spoken cadence and focus order remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 validation was non-real-device validation only and does not replace real Apple Watch QA or real-device HealthKit QA.

## Privacy / HealthKit Execution-prep Review

- HealthKit remains read-only.
- No HealthKit write access or write authorization was added.
- No `NSHealthUpdateUsageDescription` key was added.
- No raw HealthKit upload or developer-accessible health database was introduced.
- No networking, cloud sync, iCloud sync, analytics, remote config, AI cloud analysis, account system, login, upload path, or remote health profile was added.
- Missing HealthKit data remains neutral and should reduce confidence rather than imply a negative wellness state.

## Medical-safety Execution-prep Review

StateWatch remains non-medical wellness/readiness software. This phase does not claim diagnosis, treatment, therapy, emergency support, abnormal-state detection, warning behavior, disease detection, clinical stress detection, medical-grade status, or medical advice.

`Low` remains subjective, non-medical, non-warning, and non-score-lowering.

## Watch Check-in MVP Execution-prep Review

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

## Prohibited Execution-prep Claims

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

## Allowed Execution-prep Claims

It is accurate to claim:

- Signing remediation execution prep recorded.
- Manual signing remediation steps are documented for a future phase.
- Evidence and stop-condition checklists are documented.
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

- Phase 9.36 signing remediation execution if explicitly authorized.
- Apple Developer / App Store Connect manual verification with evidence redaction.
- Xcode account/team setup preparation.
- Real-device Watch VoiceOver QA preparation.
- Real-device HealthKit QA preparation.
- Documentation-only release planning with explicit limitations.

## Work That Must Wait

- Apple Developer configuration execution unless explicitly authorized in a future phase.
- Signing configuration execution unless explicitly authorized in a future phase.
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

- This phase does not execute signing remediation.
- Apple Developer and App Store Connect state was not verified with account access.
- Valid local signing identities are unavailable in the current environment.
- Automatic signing may require account/team/profile setup before it can resolve profiles.
- Archive feasibility and TestFlight upload feasibility remain unproven.
- Real Apple Watch VoiceOver QA and physical tap ergonomics remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Google Drive sync location may affect local filesystem behavior; work should continue only inside the existing checkout and avoid editing cloud metadata.

## Recommended Next Phase

Phase 9.36: Signing Remediation Execution

Phase 9.36 should:

- Use Phase 9.35 as input.
- Execute only the smallest explicitly approved signing remediation actions needed to unblock future archive dry-run.
- May involve Apple Developer / Xcode account verification, `DEVELOPMENT_TEAM` selection, signing identity verification, provisioning profile generation/selection, App ID/capability verification, and App Store Connect app record verification only if explicitly authorized.
- Must not run `xcodebuild archive` unless separately authorized.
- Must not create `.xcarchive`, export `.ipa`, upload to TestFlight, or perform App Store Connect release work.
- Must preserve unresolved real-device Watch VoiceOver and real-device HealthKit QA limitations.
- Must avoid broad release-ready language unless limitations are explicit.
- Must record every setting changed and evidence captured.

## Changes Made

- Added `Docs/phase-9-35-signing-remediation-execution-prep.md`.
- Updated `TEST_PLAN.md` with a Phase 9.35 checklist.

## Final Phase 9.35 Checklist

- Phase 9.35 signing remediation execution prep document exists.
- The document is signing remediation execution prep only, not Apple Developer configuration execution, signing configuration execution, Xcode project signing changes, Xcode archive, TestFlight upload, App Store Connect release action, App Store submission, or release-ready claim.
- Phase 9.23 through Phase 9.34 were used as input.
- Explicit limitations are carried forward.
- Phase 9.34 signing remediation plan is carried forward.
- `DEVELOPMENT_TEAM` unresolved status is documented.
- Valid local signing identities unavailable status is documented.
- Apple Developer / App Store Connect verification unresolved status is documented.
- Archive feasibility unproven status is documented.
- TestFlight upload feasibility unproven status is documented.
- Apple Developer account access manual steps are documented.
- Development team ID evidence checklist is documented.
- Local signing identity evidence checklist is documented.
- Certificate handling prep is documented.
- Bundle identifier / App ID manual checks are documented.
- HealthKit capability manual checks are documented.
- App Group capability manual checks are documented.
- Watch app relationship manual checks are documented.
- WidgetKit / complications relationship manual checks are documented.
- Xcode Accounts setup prep is documented.
- Automatic signing prep is documented.
- Provisioning profile prep is documented.
- Build number / version decision point is documented.
- Archive scheme evidence checklist is documented.
- Archive dry-run stop conditions are documented.
- TestFlight upload stop conditions are documented.
- App Store Connect app record manual checks are documented.
- Evidence handling and redaction rules are documented.
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
- Recommended next phase is Phase 9.36: Signing Remediation Execution.
- Local validation commands pass.
- GitHub Actions status is reviewed after PR creation.
- No Phase 9.36 work started.
