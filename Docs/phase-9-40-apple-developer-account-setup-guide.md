# Phase 9.40 Apple Developer Account Setup Guide

## Purpose

This is an Apple Developer account setup guide, not Apple Developer configuration execution, App Store Connect configuration execution, signing configuration execution, controlled signing re-verification, Xcode project signing changes, Xcode archive, TestFlight upload, App Store Connect release action, App Store submission, or release-ready claim.

Phase 9.40 gives the user a safe, manual checklist for checking Apple Developer, App Store Connect, Xcode Accounts, Team ID, signing identity, App ID, capability, App Group, provisioning/profile, and real-device QA prerequisites before any future controlled signing re-verification, signing remediation, archive dry-run planning, or TestFlight upload planning.

This guide is for user-performed manual checks only. It does not authorize Codex to change Apple Developer settings, App Store Connect settings, Xcode signing settings, certificates, provisioning profiles, bundle identifiers, capabilities, entitlements, plists, or project files.

The user must not paste Apple ID emails, passwords, 2FA codes, tokens, API keys, private keys, certificate serials, certificate fingerprints, provisioning profile contents, unredacted profile UUIDs, unredacted screenshots, device UDIDs, personal addresses, phone numbers, or raw HealthKit data.

Controlled signing re-verification remains blocked until the user provides enough non-secret evidence for Apple Developer membership, team role, Team ID, Xcode account/team visibility, valid local signing identities, relevant App IDs, capabilities, App Group, provisioning/profile resolution, and explicit authorization.

Archive dry-run planning remains blocked until Apple Developer membership, Team ID, Xcode account/team visibility, valid signing identities, App IDs, capabilities, App Group, provisioning/profile resolution, and required authorization are resolved or explicitly accepted as unresolved blockers.

TestFlight upload planning remains blocked until Apple Developer, App Store Connect, distribution signing, archive, upload, agreement, compliance, and TestFlight prerequisites are verified.

Phase 9.22 remains deferred/blocked, not completed.

Real-device Watch VoiceOver QA remains unresolved.

Real-device HealthKit QA remains planned, not executed.

Phase 9.27 validation was non-real-device validation only and does not replace real Apple Watch QA or real-device HealthKit QA.

## Scope

Included:

- Documentation-only Apple Developer account setup guidance.
- Manual Apple Developer Program membership, team role, and Team ID checks.
- Manual Xcode Settings > Accounts and local signing identity checks.
- Manual iOS, watchOS, and WidgetKit App ID checks.
- Manual HealthKit, App Group, watch app relationship, and WidgetKit relationship checks.
- Manual App Store Connect access, app record, agreements/compliance, and TestFlight availability checks.
- Manual provisioning/profile resolution readiness checks.
- Future authorization decision checklist for controlled signing re-verification, certificate/profile actions, and non-upload archive dry-run planning.
- Real-device Watch and HealthKit QA availability checks.
- Safe user output template, screenshot redaction rules, and secret handling rules.
- Enough-evidence criteria for controlled signing re-verification, archive dry-run planning, and TestFlight upload planning.
- A matching Phase 9.40 checklist in `TEST_PLAN.md`.

Not included:

- Apple Developer configuration execution.
- App Store Connect configuration execution.
- Signing configuration execution.
- Controlled signing re-verification.
- Xcode project signing changes.
- Setting `DEVELOPMENT_TEAM`.
- Certificate installation, creation, revocation, import, download, selection, or modification.
- Keychain item modification.
- Provisioning profile creation, download, installation, selection, or modification.
- Bundle identifier creation or modification.
- Capability enablement or disablement.
- Entitlement, plist, CI workflow, Swift, or product behavior changes.
- `xcodebuild archive`.
- `xcodebuild -allowProvisioningUpdates`.
- Xcode archive, `.xcarchive` creation, `.ipa` export, TestFlight upload, or App Store Connect release action.
- App Store metadata, screenshots, privacy labels, or review note changes.
- iPhone Check-in UI, history, deletion, or management.
- WidgetKit Check-in display, summary, or direct reads.
- App Group raw Check-in history or Check-in propagation.
- WatchConnectivity, networking, cloud sync, iCloud sync, AI cloud analysis, analytics, account systems, or remote config.
- HealthKit write access or write authorization.
- Phase 9.41 work.

## Current Baseline

- Current branch was created from `main` after Phase 9.39 was merged at `bed6983966e604fdd1aec3eca9933142203125b4`.
- Xcode observed locally: Xcode 26.6, build 17F113.
- SDKs recorded in prior signing phases include iOS 26.5, iOS Simulator 26.5, watchOS 26.5, and watchOS Simulator 26.5.
- Schemes observed locally: `StateWatch`, `StateWatchWatchApp`, and `StateWatchComplications`.
- `security find-identity -v -p codesigning` reported `0 valid identities found`.
- iOS app bundle ID observed locally: `com.easonsusu.StateWatch`.
- watchOS app bundle ID observed locally: `com.easonsusu.StateWatch.watchapp`.
- WidgetKit complications bundle ID observed locally: `com.easonsusu.StateWatch.watchapp.StateWatchComplications`.
- `MARKETING_VERSION = 0.1.0` remains visible.
- `CURRENT_PROJECT_VERSION = 1` remains visible.
- `CODE_SIGN_STYLE = Automatic` remains visible for relevant targets.
- `CODE_SIGN_IDENTITY = Apple Development` remains visible for relevant targets.
- `DEVELOPMENT_TEAM = ""` remains visible for inspected configurations.
- `PROVISIONING_PROFILE_SPECIFIER` was not visible in filtered local output.
- Local HealthKit entitlement exists for the iOS app.
- Local App Group entitlement `group.com.easonsusu.StateWatch` exists for the iOS app, watchOS app, and WidgetKit complications extension.
- iOS Info.plist includes `NSHealthShareUsageDescription`.
- No HealthKit write usage plist key is expected for the MVP.
- `StateWatchWidgets` directory is not present; current WidgetKit code is under `StateWatchComplications`.
- Archive feasibility remains unproven.
- TestFlight upload feasibility remains unproven.

## Relationship To Phase 9.23 Through Phase 9.39

- Phase 9.23 records release blockers and deferred blockers.
- Phase 9.24 limits Watch Check-in MVP readiness to internal TestFlight planning with explicit limitations.
- Phase 9.25 creates an internal TestFlight QA checklist, not an executed TestFlight report.
- Phase 9.26 audits App Store privacy and medical-safety boundaries, not App Store submission.
- Phase 9.27 records non-real-device validation only.
- Phase 9.28 records known-limitations and release-note guidance only.
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
- Phase 9.39 records the conservative signing evidence collection follow-up only.
- Phase 9.40 records a manual Apple Developer account setup guide only.

## Conservative Evidence Carried Forward From Phase 9.39

The conservative Phase 9.39 evidence package remains the active baseline:

- Apple Developer Program membership active: Unsure.
- Apple Developer team role can manage Certificates, Identifiers & Profiles: Unsure.
- Team ID intended for StateWatch: Unsure.
- Xcode Settings > Accounts shows correct team: Unsure.
- Valid Apple Development identity available locally: No.
- Valid Apple Distribution identity available locally: No.
- iOS App ID `com.easonsusu.StateWatch` exists: Unsure.
- watchOS App ID `com.easonsusu.StateWatch.watchapp` exists: Unsure.
- WidgetKit App ID `com.easonsusu.StateWatch.watchapp.StateWatchComplications` exists: Unsure.
- HealthKit enabled for iOS App ID only: Unsure.
- App Group `group.com.easonsusu.StateWatch` exists: Unsure.
- App Group attached to iOS/watchOS/WidgetKit identifiers: Unsure.
- Watch app relationship valid: Unsure.
- WidgetKit/complications relationship valid: Unsure.
- App Store Connect access available: Unsure.
- App Store Connect StateWatch app record exists: Unsure.
- Agreements/compliance prompts blocking upload: Unsure.
- TestFlight available for the app record: Unsure.
- Provisioning profiles automatically resolvable or available: Unsure.
- Future `DEVELOPMENT_TEAM` authorization: No.
- Future certificate/profile authorization: No.
- Future non-upload archive dry-run authorization: No.
- Real Apple Watch availability for VoiceOver/tap QA later: Unanswered / unresolved.
- Real iPhone/Apple Watch HealthKit QA setup availability later: Unanswered / unresolved.

## What The Guide Helps The User Check

This guide helps the user manually check:

- Apple Developer Program membership.
- Apple Developer team role.
- Team ID.
- Xcode Settings > Accounts team visibility.
- Apple Development signing identity availability.
- Apple Distribution signing identity availability.
- Apple Developer App IDs.
- HealthKit capability.
- App Group capability.
- Watch app relationship.
- WidgetKit / complications relationship.
- App Store Connect access.
- App Store Connect app record.
- Agreements / compliance blockers.
- TestFlight availability.
- Provisioning/profile resolution readiness.
- Explicit authorization requirements before any future mutable signing or archive phase.
- Real-device Watch VoiceOver/tap QA and real-device HealthKit QA availability.

## What The Guide Must Not Ask The User To Share

The user must not share:

- Apple ID email.
- Passwords.
- 2FA codes.
- Tokens.
- API keys.
- Private keys.
- Certificate serials.
- Certificate fingerprints.
- Provisioning profile contents.
- Unredacted profile UUIDs.
- Unredacted screenshots.
- Device UDIDs.
- Personal addresses.
- Phone numbers.
- Raw HealthKit data.
- Private Apple Developer or App Store Connect account details that are not needed for a non-secret Yes / No / Unsure answer.

## Manual Setup/check Sequence Overview

The user should complete these checks manually in Apple Developer, App Store Connect, Xcode Settings, and local keychain/Xcode signing views. Each answer should be reported in the safe template below, using `Yes`, `No`, `Unsure`, or a redacted value where requested.

## Step 1: Apple Developer Program Membership Check

- Goal: Confirm whether Apple Developer Program membership is active for the team intended to ship StateWatch.
- Where user checks manually: Apple Developer account membership page or Apple Developer app/account settings.
- Safe answer format: `Yes / No / Unsure`.
- What not to share: Apple ID email, password, 2FA code, billing details, personal address, phone number, account screenshots with private data.
- Blocks controlled signing re-verification: Yes.
- Blocks archive dry-run planning: Yes.
- Blocks TestFlight upload planning: Yes.

## Step 2: Apple Developer Team Role Check

- Goal: Confirm whether the user's team role can manage Certificates, Identifiers & Profiles.
- Where user checks manually: Apple Developer account People/roles view or App Store Connect user/access view.
- Safe answer format: `Yes / No / Unsure`.
- What not to share: Apple ID email, team member emails, account holder identity details, screenshots with private account data.
- Blocks controlled signing re-verification: Yes.
- Blocks archive dry-run planning: Yes.
- Blocks TestFlight upload planning: Yes.

## Step 3: Team ID Check

- Goal: Identify the intended Apple Developer Team ID for StateWatch.
- Where user checks manually: Apple Developer membership details, Xcode Settings > Accounts team details, or App Store Connect account/team details.
- Safe answer format: `[Team ID or partially redacted / Unsure]`.
- What not to share: Apple ID email, account owner details, 2FA codes, or unredacted screenshots; the Team ID may be partially redacted if the user prefers.
- Blocks controlled signing re-verification: Yes.
- Blocks archive dry-run planning: Yes.
- Blocks TestFlight upload planning: Yes.

## Step 4: Xcode Settings > Accounts Check

- Goal: Confirm whether Xcode can see the intended Apple Developer team.
- Where user checks manually: Xcode > Settings > Accounts, then select the Apple ID account and inspect available teams.
- Safe answer format: `Yes / No / Unsure`.
- What not to share: Apple ID email, account screenshots with private data, team member emails, device identifiers.
- Blocks controlled signing re-verification: Yes.
- Blocks archive dry-run planning: Yes.
- Blocks TestFlight upload planning: Yes.

## Step 5: Apple Development Signing Identity Check

- Goal: Confirm whether a valid Apple Development signing identity is available locally.
- Where user checks manually: Xcode account signing certificate list, Keychain Access certificates view, or `security find-identity -v -p codesigning` output after redaction.
- Safe answer format: `Yes / No / Unsure`.
- What not to share: private keys, certificate serials, certificate fingerprints, keychain screenshots with personal account data.
- Blocks controlled signing re-verification: Maybe; it blocks re-verification if the future check needs a local development identity.
- Blocks archive dry-run planning: Yes.
- Blocks TestFlight upload planning: Yes.

## Step 6: Apple Distribution Signing Identity Check

- Goal: Confirm whether a valid Apple Distribution signing identity is available locally.
- Where user checks manually: Xcode account signing certificate list, Keychain Access certificates view, or `security find-identity -v -p codesigning` output after redaction.
- Safe answer format: `Yes / No / Unsure`.
- What not to share: private keys, certificate serials, certificate fingerprints, keychain screenshots with personal account data.
- Blocks controlled signing re-verification: Maybe; a development-only re-check might not require distribution signing if the limitation is documented.
- Blocks archive dry-run planning: Yes, depending on archive method.
- Blocks TestFlight upload planning: Yes.

## Step 7: iOS App ID Check

- Goal: Confirm whether the iOS App ID `com.easonsusu.StateWatch` exists for the intended team.
- Where user checks manually: Apple Developer > Certificates, Identifiers & Profiles > Identifiers.
- Safe answer format: `Yes / No / Unsure`.
- What not to share: account screenshots with private team or profile details, profile UUIDs, certificates, private keys.
- Blocks controlled signing re-verification: Maybe.
- Blocks archive dry-run planning: Yes.
- Blocks TestFlight upload planning: Yes.

## Step 8: watchOS App ID Check

- Goal: Confirm whether the watchOS App ID `com.easonsusu.StateWatch.watchapp` exists for the intended team.
- Where user checks manually: Apple Developer > Certificates, Identifiers & Profiles > Identifiers.
- Safe answer format: `Yes / No / Unsure`.
- What not to share: account screenshots with private team or profile details, profile UUIDs, certificates, private keys.
- Blocks controlled signing re-verification: Maybe.
- Blocks archive dry-run planning: Yes.
- Blocks TestFlight upload planning: Yes.

## Step 9: WidgetKit / Complications App ID Check

- Goal: Confirm whether the WidgetKit complications App ID `com.easonsusu.StateWatch.watchapp.StateWatchComplications` exists for the intended team.
- Where user checks manually: Apple Developer > Certificates, Identifiers & Profiles > Identifiers.
- Safe answer format: `Yes / No / Unsure`.
- What not to share: account screenshots with private team or profile details, profile UUIDs, certificates, private keys.
- Blocks controlled signing re-verification: Maybe.
- Blocks archive dry-run planning: Yes.
- Blocks TestFlight upload planning: Yes.

## Step 10: HealthKit Capability Check

- Goal: Confirm whether HealthKit is enabled only for the iOS App ID as needed for read-only local HealthKit use.
- Where user checks manually: Apple Developer identifier capability settings for `com.easonsusu.StateWatch`.
- Safe answer format: `Yes / No / Unsure`.
- What not to share: raw HealthKit data, screenshots with account details, profile contents, private identifiers beyond the bundle ID already in the repo.
- Blocks controlled signing re-verification: Maybe.
- Blocks archive dry-run planning: Yes.
- Blocks TestFlight upload planning: Yes.

## Step 11: App Group Existence And Attachment Check

- Goal: Confirm whether App Group `group.com.easonsusu.StateWatch` exists and is attached to the intended iOS, watchOS, and WidgetKit identifiers.
- Where user checks manually: Apple Developer App Groups and each relevant identifier's capability settings.
- Safe answer format: `Yes / No / Unsure` for existence and attachment.
- What not to share: profile contents, profile UUIDs unless redacted, account screenshots with private data.
- Blocks controlled signing re-verification: Maybe.
- Blocks archive dry-run planning: Yes.
- Blocks TestFlight upload planning: Yes.

## Step 12: Watch App Relationship Check

- Goal: Confirm whether the watchOS app relationship is valid for the iOS app and the intended team.
- Where user checks manually: Xcode target settings, Apple Developer identifiers, and App Store Connect app relationships if available.
- Safe answer format: `Yes / No / Unsure`.
- What not to share: account screenshots with private team data, profile contents, device UDIDs.
- Blocks controlled signing re-verification: Maybe.
- Blocks archive dry-run planning: Yes.
- Blocks TestFlight upload planning: Yes.

## Step 13: WidgetKit / Complications Relationship Check

- Goal: Confirm whether the WidgetKit complications extension relationship is valid for the watchOS app and intended team.
- Where user checks manually: Xcode extension target settings, Apple Developer identifiers, and App Store Connect relationship surfaces if available.
- Safe answer format: `Yes / No / Unsure`.
- What not to share: account screenshots with private team data, profile contents, device UDIDs.
- Blocks controlled signing re-verification: Maybe.
- Blocks archive dry-run planning: Yes.
- Blocks TestFlight upload planning: Yes.

## Step 14: App Store Connect Access Check

- Goal: Confirm whether the user can access App Store Connect for the intended team.
- Where user checks manually: App Store Connect home, Users and Access, or team/app switcher.
- Safe answer format: `Yes / No / Unsure`.
- What not to share: Apple ID email, account owner details, personal address, phone number, 2FA codes, screenshots with private data.
- Blocks controlled signing re-verification: No.
- Blocks archive dry-run planning: Maybe, if upload planning is combined with archive planning.
- Blocks TestFlight upload planning: Yes.

## Step 15: App Store Connect App Record Check

- Goal: Confirm whether a StateWatch app record exists in App Store Connect.
- Where user checks manually: App Store Connect > Apps.
- Safe answer format: `Yes / No / Unsure`.
- What not to share: account screenshots with private data, unreleased metadata screenshots, internal notes, personal account data.
- Blocks controlled signing re-verification: No.
- Blocks archive dry-run planning: Maybe, if upload planning is combined with archive planning.
- Blocks TestFlight upload planning: Yes.

## Step 16: Agreements / Compliance Blocker Check

- Goal: Confirm whether agreements, tax/banking, export compliance, or account prompts are blocking upload.
- Where user checks manually: App Store Connect agreements/tax/banking/compliance prompts and app-level compliance notices.
- Safe answer format: `Yes / No / Unsure`, where `Yes` means a blocker prompt exists.
- What not to share: tax details, banking details, personal address, phone number, account screenshots with private data.
- Blocks controlled signing re-verification: No.
- Blocks archive dry-run planning: Maybe, if upload planning is combined with archive planning.
- Blocks TestFlight upload planning: Yes.

## Step 17: TestFlight Availability Check

- Goal: Confirm whether TestFlight is visible and available for the StateWatch app record.
- Where user checks manually: App Store Connect > Apps > StateWatch > TestFlight.
- Safe answer format: `Yes / No / Unsure`.
- What not to share: tester emails, Apple ID emails, account screenshots with private data, unreleased external distribution details.
- Blocks controlled signing re-verification: No.
- Blocks archive dry-run planning: No, unless upload planning is combined with archive planning.
- Blocks TestFlight upload planning: Yes.

## Step 18: Provisioning/profile Resolution Check

- Goal: Confirm whether provisioning profiles are automatically resolvable or otherwise available for the app, watch app, and WidgetKit extension.
- Where user checks manually: Xcode signing settings, Apple Developer Profiles, or Xcode account profile download views.
- Safe answer format: `Yes / No / Unsure`.
- What not to share: provisioning profile contents, unredacted profile UUIDs, device UDIDs, certificates, private keys.
- Blocks controlled signing re-verification: Maybe.
- Blocks archive dry-run planning: Yes.
- Blocks TestFlight upload planning: Yes.

## Step 19: Authorization Decision Checklist For Future Phases

- Goal: Record whether the user authorizes any future mutable signing or archive actions after evidence is reviewed.
- Where user checks manually: This is a user decision, not an account setting.
- Safe answer format: `Yes / No` for future `DEVELOPMENT_TEAM`, certificate/profile actions, and non-upload archive dry-run authorization.
- What not to share: passwords, 2FA codes, tokens, private keys, certificates, profile contents, or account secrets.
- Blocks controlled signing re-verification: Yes, if a future phase would set `DEVELOPMENT_TEAM` or touch signing assets.
- Blocks archive dry-run planning: Yes.
- Blocks TestFlight upload planning: Yes.

## Step 20: Real-device QA Availability Check

- Goal: Confirm whether real Apple Watch VoiceOver/tap QA and real iPhone/Apple Watch HealthKit QA hardware are available later.
- Where user checks manually: User's available device inventory and Apple Health / Apple Watch setup.
- Safe answer format: `Yes / No / Unsure` for each QA setup.
- What not to share: device UDIDs, serial numbers, personal health data, raw HealthKit data, screenshots with private data.
- Blocks controlled signing re-verification: No.
- Blocks archive dry-run planning: No.
- Blocks TestFlight upload planning: No, but it remains a release-readiness limitation.

## Phase 9.40 User Setup Result Template

Copy and fill this template with non-secret answers only:

1. Apple Developer Program membership active:
Yes / No / Unsure

2. Apple Developer team role can manage Certificates, Identifiers & Profiles:
Yes / No / Unsure

3. Team ID intended for StateWatch:
[Team ID or partially redacted / Unsure]

4. Xcode Settings > Accounts shows correct team:
Yes / No / Unsure

5. Valid Apple Development identity available locally:
Yes / No / Unsure

6. Valid Apple Distribution identity available locally:
Yes / No / Unsure

7. iOS App ID com.easonsusu.StateWatch exists:
Yes / No / Unsure

8. watchOS App ID com.easonsusu.StateWatch.watchapp exists:
Yes / No / Unsure

9. WidgetKit App ID com.easonsusu.StateWatch.watchapp.StateWatchComplications exists:
Yes / No / Unsure

10. HealthKit enabled for iOS App ID only:
Yes / No / Unsure

11. App Group group.com.easonsusu.StateWatch exists:
Yes / No / Unsure

12. App Group attached to iOS/watchOS/WidgetKit identifiers:
Yes / No / Unsure

13. Watch app relationship valid:
Yes / No / Unsure

14. WidgetKit/complications relationship valid:
Yes / No / Unsure

15. App Store Connect access available:
Yes / No / Unsure

16. App Store Connect StateWatch app record exists:
Yes / No / Unsure

17. Agreements/compliance prompts blocking upload:
Yes / No / Unsure

18. TestFlight available for the app record:
Yes / No / Unsure

19. Provisioning profiles automatically resolvable or available:
Yes / No / Unsure

20. I explicitly authorize a future phase to set DEVELOPMENT_TEAM after evidence is reviewed:
Yes / No

21. I explicitly authorize future certificate/profile actions if required:
Yes / No

22. I explicitly authorize future non-upload archive dry-run after blockers are resolved:
Yes / No

23. Real Apple Watch available for VoiceOver/tap QA later:
Yes / No / Unsure

24. Real iPhone/Apple Watch HealthKit QA setup available later:
Yes / No / Unsure

Do not paste Apple ID email, passwords, 2FA codes, tokens, API keys, private keys, certificate serials/fingerprints, provisioning profile contents, profile UUIDs unless explicitly redacted, screenshots with private account/device data, device UDIDs, personal addresses, phone numbers, or raw HealthKit data.

## Screenshot Redaction Rules

Screenshots are optional. If the user chooses to provide screenshots later, redact before sharing:

- Apple ID email addresses.
- Team member names and emails.
- Personal addresses and phone numbers.
- Device UDIDs, serial numbers, and private device names.
- Certificate serials and fingerprints.
- Provisioning profile UUIDs unless explicitly redacted.
- Tokens, API keys, passwords, 2FA codes, private keys, and profile contents.
- Raw HealthKit data or personal health details.

## Secret Handling Rules

- Never paste passwords, 2FA codes, tokens, API keys, private keys, certificate files, provisioning profile contents, or unredacted account screenshots into issues, PRs, docs, or chat.
- Do not commit certificates, private keys, provisioning profiles, App Store Connect API keys, tokens, account emails, device UDIDs, personal addresses, phone numbers, or raw HealthKit data.
- Use `Yes / No / Unsure` wherever possible.
- If a value is useful but sensitive, provide a partially redacted form or say `Available but not shared`.
- Keep Apple Developer and App Store Connect changes user-controlled unless a future phase explicitly authorizes a narrow action.

## What Counts As Enough Evidence For Controlled Signing Re-verification

Controlled signing re-verification can be considered in a future phase only when the user has provided enough non-secret evidence that:

- Apple Developer Program membership active = Yes.
- Team role can manage Certificates, Identifiers & Profiles = Yes.
- Team ID intended for StateWatch is provided or safely partially redacted.
- Xcode Settings > Accounts shows correct team = Yes.
- Valid Apple Development identity available locally = Yes.
- Valid Apple Distribution identity available locally = Yes, or explicitly not required for a development-only re-check with the limitation documented.
- iOS App ID exists = Yes.
- watchOS App ID exists = Yes.
- WidgetKit App ID exists = Yes.
- HealthKit enabled for iOS App ID only = Yes.
- App Group exists = Yes.
- App Group attached to required identifiers = Yes.
- Provisioning profiles automatically resolvable or available = Yes.
- Future `DEVELOPMENT_TEAM` authorization = Yes, if a future phase would set it.
- Certificate/profile authorization = Yes, if a future phase would touch certificate or profile assets.

## What Counts As Enough Evidence For Archive Dry-run Planning

Archive dry-run planning can be considered in a future phase only when:

- Controlled signing re-verification evidence is mostly Yes.
- Valid Apple Development or Apple Distribution signing identity is available, depending on archive method.
- App IDs and capabilities are confirmed.
- App Group and app/extension relationships are confirmed.
- Provisioning/profile resolution is Yes.
- Future non-upload archive dry-run authorization = Yes.
- App Store Connect upload is not required for a non-upload archive dry-run, but limitations must be stated.

## What Counts As Enough Evidence For TestFlight Upload Planning

TestFlight upload planning can be considered in a future phase only when:

- Archive dry-run evidence is mostly Yes.
- Apple Distribution signing identity available = Yes.
- App Store Connect access available = Yes.
- App Store Connect app record exists = Yes.
- Agreements/compliance blockers are No.
- TestFlight available = Yes.
- Archive dry-run has succeeded in a prior phase, or upload planning explicitly remains blocked until it does.

## Privacy / HealthKit Review

- HealthKit remains read-only.
- HealthKit data remains local-first.
- No raw HealthKit samples are uploaded.
- No HealthKit write access or write authorization is added.
- No developer-accessible health database is added.
- No networking, cloud sync, iCloud sync, AI cloud analysis, analytics, account system, login, upload path, or remote config is added.
- Real-device HealthKit QA remains planned, not executed.

## Medical-safety Review

- StateWatch remains non-medical wellness/readiness software.
- No diagnosis, treatment, therapy, emergency, abnormal-state, warning, disease-detection, clinical-stress, medical-grade, or medical-advice claim is made.
- Low Check-ins remain subjective, non-medical, and non-warning.
- Missing Check-ins and missing HealthKit data remain neutral.
- Phase 9.27 validation was non-real-device validation only and does not replace real Apple Watch QA or real-device HealthKit QA.

## Watch Check-in MVP Review

- Watch Check-in remains Watch-only.
- Watch Check-in remains local-only.
- The four states remain `Energized`, `Stable`, `Tired`, and `Low`.
- Traditional Chinese reference labels remain `有活力`, `穩定`, `疲累`, and `低狀態`.
- Display modes remain `Icon + Text`, `Icon Only`, and `Text Only`.
- Check-ins do not affect State Score.
- No iPhone Check-in UI, history, deletion, or management is added.
- No WidgetKit Check-in display, summary, or direct read is added.
- No App Group raw Check-in history or propagation is added.
- No WatchConnectivity is added.
- Real-device Watch VoiceOver QA remains unresolved.
- Physical Apple Watch tap ergonomics remain unresolved.

## Items Not Included In Current MVP

- iPhone Check-in UI, history, deletion, or management.
- WidgetKit Check-in display, summary, or direct read.
- App Group raw Check-in history or Check-in propagation.
- WatchConnectivity.
- State Score integration from Check-ins.
- HealthKit write access.
- Networking, cloud sync, iCloud sync, analytics, AI cloud analysis, account system, login, upload path, or remote config.
- Notes, export, reminders, notifications, scheduling, trends, streaks, counts, causes, interpretations, pattern summaries, or insights.
- Clear-all UI or latest-five history.

## Prohibited Claims

Do not claim:

- Apple Developer configured.
- App Store Connect configured.
- Signing fixed.
- Signing fully verified.
- `DEVELOPMENT_TEAM` fixed.
- Certificates installed.
- Provisioning profiles created.
- Bundle IDs created or verified, unless actually verified with account evidence.
- Capabilities enabled.
- Archive-ready.
- Archive feasible.
- TestFlight-ready.
- Uploaded to TestFlight.
- App Store ready.
- Release ready.
- Fully validated on Apple Watch.
- VoiceOver verified on real Apple Watch.
- HealthKit QA complete on real devices.
- Medical-grade.
- Diagnoses stress, anxiety, depression, disease, or illness.
- Warns about abnormal state.
- Low means bad health.
- Check-ins change your score.
- Syncs Check-ins to iPhone, widgets, App Group, cloud, or WatchConnectivity.

## Allowed Claims

Allowed claims for this phase:

- Apple Developer account setup guide recorded.
- Manual user checks are documented.
- Secret handling and screenshot redaction rules are documented.
- Evidence needed for controlled signing re-verification is documented.
- Evidence needed for archive dry-run planning is documented.
- Evidence needed for TestFlight upload planning is documented.
- No Apple Developer or App Store Connect configuration was changed in this phase.
- No signing configuration was changed in this phase.
- No `DEVELOPMENT_TEAM` was set in this phase.
- No certificates, provisioning profiles, bundle identifiers, or capabilities were changed in this phase.
- No archive or upload was performed in this phase.
- Controlled signing re-verification remains blocked until the required non-secret evidence and authorization are provided.
- Archive dry-run planning remains blocked until signing blockers are resolved or explicitly accepted.
- TestFlight upload planning remains blocked until Apple Developer, App Store Connect, distribution signing, archive, upload, agreement, compliance, and TestFlight prerequisites are verified.
- Watch Check-in MVP is Watch-only and local-only.
- Real-device Watch VoiceOver and real-device HealthKit QA remain pending.
- HealthKit remains read-only.
- StateWatch remains non-medical wellness/readiness software.

## Work That May Continue

- Documentation-only release planning.
- Non-secret Apple Developer evidence collection by the user.
- Privacy and medical-safety documentation review.
- Internal TestFlight planning that explicitly preserves limitations.
- Real-device QA planning.
- Future controlled signing re-verification planning after enough non-secret evidence and authorization are provided.

## Work That Must Wait

- Apple Developer configuration execution.
- App Store Connect configuration execution.
- Signing configuration changes.
- Setting `DEVELOPMENT_TEAM`.
- Certificate/profile actions.
- Bundle ID or capability changes.
- `xcodebuild archive` and `xcodebuild -allowProvisioningUpdates`.
- `.xcarchive` creation, `.ipa` export, TestFlight upload, or App Store Connect release action.
- External App Store submission readiness claims.
- Broad Watch Check-in release-ready claims.
- Any claim that real Apple Watch VoiceOver QA or real-device HealthKit QA has passed.

## Non-blocking Follow-ups

- Keep known limitations, release notes, and TestFlight planning docs aligned with future evidence.
- Add a future Phase 9.41 follow-up after the user provides safe non-secret account setup answers.
- Revisit old iPhone `CheckInView` scaffold in a separate scoped phase only if requested.
- Continue real-device QA planning without claiming results before execution.

## Risks / Limitations

- Apple Developer membership, role, Team ID, App IDs, capabilities, App Group, profiles, and App Store Connect access remain unresolved unless the user manually confirms them.
- No local valid signing identities are currently available based on the latest local evidence.
- Archive feasibility remains unproven.
- TestFlight upload feasibility remains unproven.
- Real-device Watch VoiceOver QA remains unresolved.
- Physical Apple Watch tap ergonomics remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- This guide does not replace Apple Developer, App Store Connect, signing, archive, TestFlight, or real-device QA execution.

## Recommended Next Phase

If the user still cannot provide enough account evidence:

- Phase 9.41: Apple Developer Account Setup Follow-up

If the user provides enough non-secret evidence and authorization:

- Phase 9.41: Controlled Signing Re-verification Plan

If controlled signing re-verification eventually passes, a later phase may become Archive Dry-Run Plan, but not before evidence and authorization are sufficient.

## Changes Made

- Added this Phase 9.40 Apple Developer account setup guide.
- Added a Phase 9.40 checklist to `TEST_PLAN.md`.
- No Swift, Xcode project, entitlement, plist, CI workflow, signing, certificate, profile, bundle ID, capability, archive, upload, or product behavior changes were made.

## Final Phase 9.40 Checklist

- Confirm this document exists.
- Confirm this document is Apple Developer account setup guidance only.
- Confirm Phase 9.23 through Phase 9.39 were used as input.
- Confirm conservative Phase 9.39 evidence is carried forward.
- Confirm all 20 manual setup/check steps are documented.
- Confirm the safe user output template includes 24 answers.
- Confirm secret handling and screenshot redaction rules are documented.
- Confirm enough-evidence criteria are documented for controlled signing re-verification.
- Confirm enough-evidence criteria are documented for archive dry-run planning.
- Confirm enough-evidence criteria are documented for TestFlight upload planning.
- Confirm no Apple Developer configuration was performed.
- Confirm no App Store Connect configuration was performed.
- Confirm no signing configuration was changed.
- Confirm no controlled signing re-verification was performed.
- Confirm no `DEVELOPMENT_TEAM` was set.
- Confirm no certificates were installed, revoked, created, or modified.
- Confirm no provisioning profiles were created, downloaded, selected, or modified.
- Confirm no bundle identifiers were created or modified.
- Confirm no capabilities were enabled or disabled.
- Confirm no `xcodebuild archive` was run.
- Confirm no `xcodebuild -allowProvisioningUpdates` was run.
- Confirm no Xcode archive, `.xcarchive`, `.ipa`, TestFlight upload, or App Store Connect release work was performed.
- Confirm no secrets, certificates, private keys, provisioning profiles, tokens, account emails, device UDIDs, personal addresses, phone numbers, or raw HealthKit data were committed.
- Confirm Phase 9.22 remains deferred/blocked, not completed.
- Confirm real-device Watch VoiceOver QA remains unresolved.
- Confirm real-device HealthKit QA remains planned, not executed.
- Confirm Phase 9.27 validation remains non-real-device validation only.
- Confirm HealthKit remains read-only.
- Confirm StateWatch remains non-medical wellness/readiness software.
- Confirm Watch Check-in remains Watch-only and local-only.
- Confirm no prohibited product scope was added.
- Confirm recommended Phase 9.41 options are documented.
- Confirm no Phase 9.41 work was started.
