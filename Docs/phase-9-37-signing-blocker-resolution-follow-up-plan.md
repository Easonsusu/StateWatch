# Phase 9.37 Signing Blocker Resolution Follow-up Plan

## Purpose

This is a signing blocker resolution follow-up plan, not Apple Developer configuration execution, signing configuration execution, Xcode project signing changes, Xcode archive, TestFlight upload, App Store Connect release action, App Store submission, or release-ready claim.

Phase 9.37 converts the remaining blockers from Phase 9.36 into a clear follow-up plan. It separates user-required manual account actions from Codex-verifiable local checks, defines non-secret evidence the user may provide later, and documents what must remain blocked until explicit authorization and prerequisite evidence exist.

No Apple Developer configuration, signing change, DEVELOPMENT_TEAM setting, certificate installation, provisioning profile creation, bundle identifier creation, capability change, Xcode archive, .xcarchive creation, .ipa export, TestFlight upload, App Store Connect release work, App Store approval, App Store submission-readiness, or broad release-ready claim is made by this phase.

Archive dry-run planning remains blocked until the required signing blockers are resolved or explicitly accepted as unresolved blockers.

TestFlight upload planning remains blocked until Apple Developer, App Store Connect, distribution signing, archive, and upload prerequisites are verified.

Phase 9.22 remains deferred/blocked, not completed.

Real-device Watch VoiceOver QA remains unresolved.

Real-device HealthKit QA remains planned, not executed.

Phase 9.27 validation was non-real-device validation only and does not replace real Apple Watch QA or real-device HealthKit QA.

## Scope

Included:

- Documentation-only signing blocker follow-up planning.
- Read-only review of Phase 9.23 through Phase 9.36 documentation.
- Read-only project signing, capability, entitlement, plist, Watch, WidgetKit, and HealthKit marker inspection.
- User action checklist for non-secret Apple Developer and App Store Connect evidence.
- Codex re-verification checklist for a future phase after user action.
- Archive dry-run and TestFlight upload blocker separation.
- Carry-forward of privacy, HealthKit, medical-safety, Watch Check-in, and real-device QA limitations.
- A matching Phase 9.37 checklist in `TEST_PLAN.md`.

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
- Phase 9.38 work.

## Current Baseline

- Current branch was created from `main` at `56f30a4d1a70eef6203767c462d8429e03705fec`.
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

## Relationship To Phase 9.23 Through Phase 9.36

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
- Phase 9.37 records signing blocker resolution follow-up planning only.

## Explicit Limitations Carried Forward

- Phase 9.22 remains deferred/blocked, not completed.
- Real-device Watch Check-in VoiceOver QA remains unresolved.
- Physical Apple Watch small-screen tap ergonomics remain unresolved.
- Real Watch VoiceOver spoken cadence and focus order remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 validation was non-real-device validation only and does not replace real Apple Watch QA or real-device HealthKit QA.
- Broad Watch Check-in release-ready claims remain blocked.
- External App Store submission readiness is not claimed.
- Internal TestFlight signing blocker resolution planning may continue only with explicit limitations.
- HealthKit remains read-only.
- StateWatch remains non-medical wellness/readiness software.
- Check-ins do not affect State Score, readiness, confidence, reasons, or suggestions.

## Phase 9.36 Remaining Blockers Carried Forward

- Apple Developer account access is unresolved.
- App Store Connect access is unresolved.
- Team ID is unknown/unverified.
- `DEVELOPMENT_TEAM` remains empty.
- Local signing identities are unavailable.
- Certificate handling is blocked.
- Provisioning profile availability is unresolved.
- Apple Developer App ID state is unresolved for `com.easonsusu.StateWatch`, `com.easonsusu.StateWatch.watchapp`, and `com.easonsusu.StateWatch.watchapp.StateWatchComplications`.
- Apple Developer HealthKit capability state is unresolved.
- Apple Developer App Group membership is unresolved.
- Watch app relationship is unresolved at account level.
- WidgetKit / complications extension relationship is unresolved at account level.
- Automatic signing profile resolution is unproven.
- Archive scheme readiness is blocked.
- Archive feasibility is unproven.
- TestFlight upload feasibility is unproven.
- Real-device Watch VoiceOver QA remains unresolved.
- Physical Apple Watch tap ergonomics remains unresolved.
- Real-device HealthKit QA remains planned, not executed.

## Files Reviewed

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
- `rg -n "DEVELOPMENT_TEAM|PRODUCT_BUNDLE_IDENTIFIER|MARKETING_VERSION|CURRENT_PROJECT_VERSION|CODE_SIGN_STYLE|CODE_SIGN_ENTITLEMENTS|INFOPLIST_FILE|SDKROOT|SUPPORTED_PLATFORMS|TARGETED_DEVICE_FAMILY" StateWatch.xcodeproj/project.pbxproj`
- `rg -n "com.apple.developer.healthkit|com.apple.security.application-groups|NSHealthShareUsageDescription|NSHealthUpdateUsageDescription|group.com.easonsusu.StateWatch" StateWatchApp StateWatchWatchApp StateWatchComplications StateWatchShared Docs README.md TEST_PLAN.md`
- Focused reference searches across docs, the Xcode project, source, tests, release planning docs, privacy docs, medical-safety docs, and UI copy docs.

`xcodebuild -project StateWatch.xcodeproj -list` emitted local CoreSimulator/cache warnings in this environment but returned the expected project targets and schemes.

## Search Terms Used

Searches covered these groups:

- Signing and project settings: `PRODUCT_BUNDLE_IDENTIFIER`, `MARKETING_VERSION`, `CURRENT_PROJECT_VERSION`, `CODE_SIGN_STYLE`, `DEVELOPMENT_TEAM`, `PROVISIONING_PROFILE_SPECIFIER`, `CODE_SIGN_IDENTITY`, `CODE_SIGN_ENTITLEMENTS`, `INFOPLIST_FILE`, `ASSETCATALOG_COMPILER_APPICON_NAME`, `SUPPORTED_PLATFORMS`, `SDKROOT`, and `TARGETED_DEVICE_FAMILY`.
- Capabilities and plists: `com.apple.developer.healthkit`, `com.apple.security.application-groups`, `aps-environment`, `keychain-access-groups`, `WKCompanionAppBundleIdentifier`, `WKApplication`, `WKWatchOnly`, `NSExtension`, `CFBundleIdentifier`, `CFBundleShortVersionString`, `CFBundleVersion`, `NSHealthShareUsageDescription`, and `NSHealthUpdateUsageDescription`.
- Release planning terms: Apple Developer, App Store Connect, certificates, signing identity, provisioning, profile, bundle identifier, bundle ID, App ID, capability, HealthKit, App Group, WidgetKit, Watch app, TestFlight, App Store Connect, archive, `xcodebuild archive`, `allowProvisioningUpdates`, `xcarchive`, `ipa`, `exportOptions`, approval claims, real-device QA, VoiceOver, HealthKit QA, and Phase 9.22 through Phase 9.37.
- Watch Check-in scope terms: Watch Check-in, State Check-in, check-in, latest-three, latest five, clear-all, `Icon + Text`, `Icon Only`, `Text Only`, Energized, Stable, Tired, Low, 有活力, 穩定, 疲累, 低狀態, self-reported, local Watch, local-only, Watch-only, single-record, and delete.
- Forbidden implementation mechanisms: iPhone Check-in, WidgetKit Check-in, App Group raw Check-in history, App Group Check-in, WatchConnectivity, `WCSession`, State Score integration, HealthKit write, `HKHealthStore.save`, `requestAuthorization(toShare`, `toShare`, `URLSession`, cloud, iCloud, analytics, remote config, AI cloud, account, login, sign in, upload path, developer database, sync, and network.
- Medical-safety terms: diagnosis, clinical, medical advice, treatment, therapy, emergency, warning, abnormal, health risk, anxiety, depression, disease, detected, caused by, because you, symptom history, medical record, score dropped, low because, bad health, doctor, physician, care provider, regulatory, FDA, and clearance.

Matches were reviewed as existing boundary/disclaimer/test-context matches, Phase docs/test guardrails, forbidden-copy examples, limitation language, signing blocker follow-up planning language, release blocker language, or clearly marked fail criteria, not new unsafe product copy or implementation scope creep.

## Blocker Labels

Use these labels for Phase 9.37 blocker resolution tracking:

- User action required
- Codex can verify after user action
- Blocked before archive dry-run
- Blocked before TestFlight upload
- Requires Apple Developer access
- Requires App Store Connect access
- Requires valid signing identity
- Requires explicit authorization
- Deferred pending hardware
- Future external-release blocker
- Not applicable to current MVP
- Non-blocking follow-up

## Signing Blocker Resolution Summary Table

| ID | Blocker | Label | Current state | User action required | Codex can verify after action | Blocks archive dry-run? | Blocks TestFlight upload? | Next step |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| SB-001 | Apple Developer account access | User action required | Unresolved in this Codex session. | Confirm active Apple Developer Program membership and role without sharing credentials. | Re-check project signing assumptions against provided non-secret team status. | Yes | Yes | User confirms membership and role. |
| SB-002 | App Store Connect access | User action required | Unresolved in this Codex session. | Confirm App Store Connect access and whether an app record exists. | Re-check upload planning constraints after access is confirmed. | No | Yes | User confirms access and app record status. |
| SB-003 | Team ID / DEVELOPMENT_TEAM | Requires explicit authorization | `DEVELOPMENT_TEAM` remains empty. | Provide correct non-secret Team ID and explicit authorization before any future project edit. | Verify exact target/config changes in a future authorized phase. | Yes | Yes | Do not set until authorized. |
| SB-004 | Local signing identities | Requires valid signing identity | `0 valid identities found`. | Install/select valid Apple Development and Apple Distribution identities locally. | Re-run `security find-identity -v -p codesigning`. | Yes | Yes | User resolves local signing identity availability. |
| SB-005 | Certificate handling | Requires explicit authorization | No certificates installed, revoked, or modified. | Authorize any future certificate action and keep private keys secret. | Verify presence of valid identities without exposing secrets. | Yes | Yes | Document exact intended certificate action before execution. |
| SB-006 | Provisioning profiles | Blocked before archive dry-run | Availability unresolved. | Ensure profiles exist or are automatically resolvable for app, watch app, and extension. | Inspect build settings and archive dry-run prerequisites after user action. | Yes | Yes | Resolve profile availability before archive dry-run planning. |
| SB-007 | iOS App ID / bundle identifier | Requires Apple Developer access | Account-level state unresolved for `com.easonsusu.StateWatch`. | Confirm App ID exists under intended team. | Compare local bundle ID to user-provided non-secret account result. | Yes | Yes | Verify iOS App ID in Apple Developer. |
| SB-008 | watchOS App ID / bundle identifier | Requires Apple Developer access | Account-level state unresolved for `com.easonsusu.StateWatch.watchapp`. | Confirm App ID exists and belongs to correct team. | Compare local watch bundle ID to user-provided result. | Yes | Yes | Verify watchOS App ID in Apple Developer. |
| SB-009 | WidgetKit / complications App ID / bundle identifier | Requires Apple Developer access | Account-level state unresolved for `com.easonsusu.StateWatch.watchapp.StateWatchComplications`. | Confirm extension App ID exists and belongs to correct team. | Compare local extension bundle ID to user-provided result. | Yes | Yes | Verify WidgetKit extension App ID. |
| SB-010 | HealthKit capability | Blocked before TestFlight upload | Local iOS entitlement exists; Apple Developer capability unresolved. | Confirm read-only HealthKit capability for iOS App ID. | Verify no write entitlement/plist/authorization was introduced. | Maybe | Yes | Verify read-only HealthKit capability. |
| SB-011 | App Group capability | Blocked before archive dry-run | Local App Group entitlement exists; Apple Developer membership unresolved. | Confirm `group.com.easonsusu.StateWatch` exists and is attached to iOS, watchOS, and WidgetKit identifiers. | Verify entitlements remain unchanged and match account-level result. | Yes | Yes | Verify App Group ownership and membership. |
| SB-012 | Watch app relationship | Blocked before archive dry-run | Account-level relationship unresolved. | Confirm iOS/watch relationship under intended team. | Re-check bundle IDs and Watch app plist relationship markers. | Yes | Yes | Verify relationship before archive dry-run planning. |
| SB-013 | WidgetKit / complications relationship | Blocked before archive dry-run | Account-level extension relationship unresolved. | Confirm extension relationship under intended team. | Re-check extension plist/project relationship markers. | Yes | Yes | Verify extension relationship before archive dry-run planning. |
| SB-014 | Xcode account/team setup | User action required | Not configured in this session. | Add/select correct team in Xcode Settings > Accounts. | Run build-setting checks after user action. | Yes | Yes | User completes Xcode account/team setup. |
| SB-015 | Automatic signing | Codex can verify after user action | `CODE_SIGN_STYLE = Automatic`; resolution unproven. | Complete account/team/signing identity setup. | Re-run build settings and, only if authorized later, archive planning checks. | Yes | Yes | Verify automatic signing after prerequisites. |
| SB-016 | Build number / version | Codex can verify after user action | `MARKETING_VERSION = 0.1.0`; `CURRENT_PROJECT_VERSION = 1`. | Decide later whether build number/version changes are needed. | Verify project settings remain intentional. | No | Maybe | Keep unchanged in Phase 9.37. |
| SB-017 | Archive dry-run readiness | Blocked before archive dry-run | Blocked by signing/account/profile/App ID/capability uncertainties. | Resolve or explicitly accept blockers. | Confirm prerequisites before any future archive dry-run plan. | Yes | Yes | Do not plan archive dry-run until blockers are resolved or accepted. |
| SB-018 | TestFlight upload readiness | Blocked before TestFlight upload | Blocked by Apple Developer, App Store Connect, distribution signing, archive, and upload prerequisites. | Resolve upload prerequisites and App Store Connect access. | Verify only in a future authorized upload planning phase. | N/A | Yes | Keep upload planning blocked. |
| SB-019 | User evidence package | User action required | Not provided. | Provide non-secret status answers listed below. | Use answers to choose Phase 9.38 path. | Yes | Yes | User provides non-secret evidence package. |
| SB-020 | Secret handling | Requires explicit authorization | No secrets committed. | Do not paste or commit credentials, keys, private certificates, profiles, or health data. | Review diffs and logs for accidental secrets. | Yes | Yes | Keep evidence high level and redacted. |
| SB-021 | Real-device Watch VoiceOver QA | Deferred pending hardware | Unresolved. | Test on physical Apple Watch when available. | Review documented real-device results later. | No | Future external-release blocker | Keep unresolved until real-device QA. |
| SB-022 | Physical Apple Watch tap ergonomics | Deferred pending hardware | Unresolved. | Test on physical Apple Watch when available. | Review documented real-device results later. | No | Future external-release blocker | Keep unresolved until real-device QA. |
| SB-023 | Real-device HealthKit QA | Deferred pending hardware | Planned, not executed. | Test with real iPhone/Apple Watch HealthKit data when available. | Review documented real-device results later. | No | Future external-release blocker | Keep unresolved until real-device QA. |
| SB-024 | Watch Check-in MVP scope | Codex can verify after user action | Watch-only, local-only scope remains. | Do not expand scope while signing blockers are unresolved. | Confirm scope boundaries in future diffs. | No | No | Preserve MVP boundaries. |
| SB-025 | iPhone Check-in | Not applicable to current MVP | Not included. | Do not present as supported. | Confirm no iPhone Check-in UI/history/deletion was added. | No | No | Keep out of MVP. |
| SB-026 | WidgetKit Check-in | Not applicable to current MVP | Not included. | Do not present as supported. | Confirm no WidgetKit Check-in display/summary/read was added. | No | No | Keep out of MVP. |
| SB-027 | WatchConnectivity | Not applicable to current MVP | Not included. | Do not present as supported. | Confirm no `WCSession` / WatchConnectivity implementation was added. | No | No | Keep out of MVP. |
| SB-028 | State Score integration | Not applicable to current MVP | Not included. | Do not imply Check-ins affect scores. | Confirm Check-ins do not affect readiness, score, confidence, reasons, or suggestions. | No | No | Keep out of MVP. |
| SB-029 | Old iPhone CheckInView scaffold | Non-blocking follow-up | Not addressed in this phase. | Review separately if needed. | Verify no user-facing claim depends on it. | No | No | Leave for separate cleanup. |
| SB-030 | StateWatchThemeTests.swift size | Non-blocking follow-up | Large test file remains. | Refactor only in a future test-maintenance phase. | Verify no Phase 9.37 dependency. | No | No | Leave for separate test refactor. |

## User Action Checklist

The user can prepare the next phase by confirming these non-secret results:

- Whether Apple Developer Program membership is active.
- Whether App Store Connect access is available.
- Whether the correct Team ID is known.
- Whether the team role can manage Certificates, Identifiers & Profiles.
- Whether required Apple Developer / App Store Connect agreements are active.
- Whether a valid Apple Development identity exists locally.
- Whether a valid Apple Distribution identity exists locally.
- Whether these three App IDs exist under the intended team:
  - `com.easonsusu.StateWatch`
  - `com.easonsusu.StateWatch.watchapp`
  - `com.easonsusu.StateWatch.watchapp.StateWatchComplications`
- Whether the iOS App ID has read-only HealthKit capability enabled.
- Whether App Group `group.com.easonsusu.StateWatch` exists.
- Whether the App Group is attached to the iOS, watchOS, and WidgetKit identifiers.
- Whether Xcode Settings > Accounts shows the correct team.
- Whether an App Store Connect app record exists for StateWatch.

Do not paste or commit:

- Apple ID email.
- Passwords.
- 2FA codes.
- Tokens or API keys.
- Certificate private keys.
- Certificate serials/fingerprints.
- Provisioning profile contents.
- Profile UUIDs unless explicitly redacted.
- Screenshots with private account/device data.
- Raw HealthKit data.

## Codex Re-verification Checklist After User Action

After the user provides non-secret evidence and explicit authorization for a future phase, Codex may re-check:

- `git status --short --branch` to confirm a clean branch.
- `xcodebuild -version` for local Xcode context.
- `xcodebuild -project StateWatch.xcodeproj -list` for scheme and target visibility.
- `security find-identity -v -p codesigning` for valid code-signing identities, without exposing private keys.
- Project build settings for `DEVELOPMENT_TEAM`, `CODE_SIGN_STYLE`, `CODE_SIGN_IDENTITY`, bundle IDs, versions, plists, and entitlements.
- Local entitlements for HealthKit and App Group consistency.
- Local plists for HealthKit read usage string and Watch / WidgetKit relationship markers.
- Whether the future action remains within explicit authorization.

No future re-verification should run `xcodebuild archive`, `xcodebuild -allowProvisioningUpdates`, export an `.ipa`, or upload to TestFlight unless that exact action is explicitly authorized in that future phase.

## Apple Developer Account Access Follow-up

The user must confirm active Apple Developer Program membership and an appropriate team role before any signing remediation can proceed. Codex should not infer account access from local files.

## App Store Connect Access Follow-up

The user must confirm App Store Connect access and whether a StateWatch app record exists. TestFlight upload planning remains blocked until this is known.

## Team ID / DEVELOPMENT_TEAM Follow-up

`DEVELOPMENT_TEAM` remains empty in the project. A future phase may set it only if the user provides the correct non-secret Team ID and explicitly authorizes the exact target/configuration changes.

## Local Signing Identity Follow-up

Local code-signing identity availability remains blocked because `security find-identity -v -p codesigning` reported `0 valid identities found`. The user should install/select valid Apple Development and Apple Distribution identities locally without sharing private keys or certificate secrets.

## Certificate Handling Follow-up

Certificate work requires explicit authorization. Future work may verify identity availability, but must not install, revoke, create, import, select, or modify certificates unless the user explicitly requests that exact action.

## Provisioning Profile Follow-up

Provisioning profile availability must be resolved or automatically resolvable before archive dry-run planning. Do not create, download, install, or select profiles in this phase.

## Bundle Identifier / App ID Follow-up

Apple Developer App ID state remains unresolved for:

- `com.easonsusu.StateWatch`
- `com.easonsusu.StateWatch.watchapp`
- `com.easonsusu.StateWatch.watchapp.StateWatchComplications`

The user should confirm these identifiers exist under the intended team. Codex can compare those non-secret confirmations against local bundle IDs later.

## HealthKit Capability Follow-up

Local iOS HealthKit entitlement and `NSHealthShareUsageDescription` exist. Account-level HealthKit capability state remains unresolved. Future verification must confirm read-only HealthKit capability for the iOS App ID and must not add HealthKit write access, `NSHealthUpdateUsageDescription`, or write authorization.

## App Group Capability Follow-up

Local App Group entitlements use `group.com.easonsusu.StateWatch` for iOS app, watchOS app, and WidgetKit complications extension. Account-level App Group ownership and identifier membership remain unresolved.

## Watch App Relationship Follow-up

The account-level iOS/watch app relationship must be verified before archive dry-run planning. Local bundle IDs and plist markers are visible, but account-level relationship status is not proven.

## WidgetKit / Complications Relationship Follow-up

The WidgetKit complications extension relationship must be verified before archive dry-run planning. This does not imply WidgetKit Check-in display, Check-in summary, or direct Check-in reads.

## Xcode Accounts Setup Follow-up

The user should confirm Xcode Settings > Accounts shows the correct team. Codex can re-check build settings after the user completes this setup.

## Automatic Signing Follow-up

`CODE_SIGN_STYLE = Automatic` remains visible locally, but automatic signing profile resolution is unproven. Codex can re-check after the user resolves account/team/signing identity prerequisites.

## Build Number / Version Follow-up

`MARKETING_VERSION = 0.1.0` and `CURRENT_PROJECT_VERSION = 1` remain unchanged in this phase. A later release-prep phase should decide whether to increment either value before archive or TestFlight work.

## Archive Dry-run Readiness Blockers

Archive dry-run planning remains blocked until these are resolved or explicitly accepted as unresolved blockers:

- Apple Developer account access.
- Correct Team ID and explicit authorization for any `DEVELOPMENT_TEAM` change.
- Valid local Apple Development and/or distribution signing identity as needed.
- App ID existence for iOS, watchOS, and WidgetKit extension.
- App Group capability and membership.
- Watch app relationship.
- WidgetKit extension relationship.
- Provisioning profile availability or automatic signing profile resolution.
- Clear decision on whether build/version values remain unchanged for the dry run.

## TestFlight Upload Readiness Blockers

TestFlight upload planning remains blocked until these are verified:

- Apple Developer membership and role.
- App Store Connect access and app record.
- Distribution signing identity.
- Provisioning profile and capability resolution.
- Successful future archive dry run, if explicitly authorized.
- Export/upload prerequisites.
- HealthKit read-only capability and privacy boundaries.
- Known unresolved real-device QA limitations documented for internal-only distribution planning.

## User Evidence Package

A future user evidence package should contain only non-secret status statements, such as:

- Apple Developer membership is active or unavailable.
- App Store Connect access is available or unavailable.
- Correct Team ID is known or still unknown.
- Xcode Accounts shows the intended team or does not.
- Valid Apple Development identity exists or does not.
- Valid Apple Distribution identity exists or does not.
- Required App IDs exist or do not.
- HealthKit read-only capability is enabled or still unknown.
- App Group exists and is attached to the expected identifiers or still unknown.
- App Store Connect app record exists or does not.

## Secret Handling Rules

Never commit, paste, or request unnecessary secret material. This includes Apple account emails, passwords, 2FA codes, tokens, API keys, certificate private keys, certificate serials/fingerprints, provisioning profile contents, unredacted profile UUIDs, private screenshots, local keychain internals, and raw HealthKit data.

## Real-device QA Blockers Carried Forward

- Real-device Watch VoiceOver QA remains unresolved.
- Physical Apple Watch tap ergonomics remains unresolved.
- Real Watch VoiceOver spoken cadence and focus order remains unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 remains non-real-device validation only.

## Privacy / HealthKit Blocker Review

HealthKit remains read-only. No HealthKit write access, write authorization, raw HealthKit upload, developer-accessible health database, networking path, cloud sync, analytics path, AI cloud analysis, account system, or remote config was added in this phase.

## Medical-safety Blocker Review

StateWatch remains framed as non-medical wellness/readiness software. This phase does not introduce diagnosis, treatment, therapy, emergency, abnormal-state, warning, disease-detection, clinical-stress, medical-grade, medical-advice, or risk-claim language as product behavior.

## Watch Check-in MVP Blocker Review

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

## Prohibited Follow-up Claims

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

## Allowed Follow-up Claims

It is acceptable to say:

- Signing blocker resolution follow-up plan recorded.
- Remaining signing blockers are separated into user action and Codex re-verification items.
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

- Documentation-only signing evidence collection guidance.
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
- Valid signing identity availability remains unresolved locally.
- Automatic signing may still fail even after account setup if App IDs, capabilities, profiles, or bundle relationships are misconfigured.
- Archive and upload feasibility remain unproven.
- Real-device Watch VoiceOver, real Apple Watch tap ergonomics, and real-device HealthKit QA remain unresolved.
- Google Drive sync may create local filesystem timing issues; repository work should stay inside the existing checkout and avoid modifying unrelated sync metadata.

## Recommended Next Phase

Phase 9.38 depends on user-provided evidence:

- If required user evidence is still missing: Phase 9.38: Signing Evidence Collection Guide.
- If the user provides enough non-secret evidence: Phase 9.38: Controlled Signing Re-verification.
- If signing prerequisites are verified and explicitly authorized: Phase 9.38: Archive Dry-Run Plan.

Phase 9.38 must use this document as input, avoid archive/upload unless explicitly authorized in its own phase, preserve unresolved real-device Watch VoiceOver and real-device HealthKit QA limitations, and avoid broad release-ready language unless limitations are explicit.

## Changes Made

- Added `Docs/phase-9-37-signing-blocker-resolution-follow-up-plan.md`.
- Updated `TEST_PLAN.md` with a Phase 9.37 checklist.

No Swift files, Xcode project files, entitlements, plist files, CI workflows, signing settings, certificates, provisioning profiles, bundle identifiers, capabilities, archives, uploads, App Store Connect records, App Store metadata, screenshots, privacy labels, review notes, or product behavior were changed.

## Final Phase 9.37 Checklist

- Phase 9.37 signing blocker resolution follow-up plan documented.
- Phase 9.23 through Phase 9.36 used as input.
- Phase 9.36 remaining blockers carried forward.
- Apple Developer account access unresolved.
- App Store Connect access unresolved.
- Team ID / `DEVELOPMENT_TEAM` unresolved.
- Valid local signing identities unavailable.
- Certificate handling blocked.
- Provisioning profile availability unresolved.
- Bundle identifier / App ID account-level state unresolved.
- HealthKit capability account-level state unresolved.
- App Group capability account-level state unresolved.
- Watch app relationship unresolved at account level.
- WidgetKit / complications relationship unresolved at account level.
- Xcode Accounts setup blocker documented.
- Automatic signing profile resolution blocker documented.
- Build number / version decision point documented.
- Archive dry-run readiness blockers documented.
- TestFlight upload readiness blockers documented.
- User action checklist documented.
- Codex re-verification checklist documented.
- User evidence package documented.
- Secret handling rules documented.
- No Apple Developer configuration performed.
- No signing configuration changed.
- No `DEVELOPMENT_TEAM` set.
- No certificates, provisioning profiles, bundle IDs, or capabilities changed.
- No archive, `.xcarchive`, `.ipa`, TestFlight upload, or App Store Connect release work performed.
- No broad release-ready, App Store approval, external submission-readiness, signing-fixed, archive-ready, or TestFlight-ready claim made.
- Phase 9.22 remains deferred/blocked.
- Real-device Watch VoiceOver QA remains unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 remains non-real-device validation only.
- HealthKit remains read-only.
- Watch Check-in remains Watch-only and local-only.
- No prohibited product scope added.
- Phase 9.38 not started.
