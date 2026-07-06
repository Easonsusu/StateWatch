# Phase 9.39 Signing Evidence Collection Follow-up

## Purpose

This is a signing evidence collection follow-up, not Apple Developer configuration execution, signing configuration execution, Xcode project signing changes, controlled signing re-verification, Xcode archive, TestFlight upload, App Store Connect release action, App Store submission, or release-ready claim.

Phase 9.39 records the conservative user evidence package selected after Phase 9.38 and explains what remains blocked before any future controlled signing re-verification, signing remediation, archive dry-run planning, TestFlight upload planning, or App Store Connect release work.

The user evidence package is conservative and does not provide enough evidence to proceed to controlled signing re-verification, signing remediation, archive dry-run planning, or TestFlight upload planning.

No Apple Developer configuration, signing change, DEVELOPMENT_TEAM setting, certificate installation, provisioning profile creation, bundle identifier creation, capability change, Xcode archive, .xcarchive creation, .ipa export, TestFlight upload, App Store Connect release work, App Store approval, App Store submission-readiness, or broad release-ready claim is made by this phase.

Apple Development and Apple Distribution signing identities are recorded as unavailable based on the current evidence package.

Archive dry-run planning remains blocked until Apple Developer membership, Team ID, Xcode account/team visibility, valid signing identities, App IDs, capabilities, App Group, provisioning/profile resolution, and required authorization are resolved or explicitly accepted as unresolved blockers.

TestFlight upload planning remains blocked until Apple Developer, App Store Connect, distribution signing, archive, upload, agreement, compliance, and TestFlight prerequisites are verified.

Phase 9.22 remains deferred/blocked, not completed.

Real-device Watch VoiceOver QA remains unresolved.

Real-device HealthKit QA remains planned, not executed.

Phase 9.27 validation was non-real-device validation only and does not replace real Apple Watch QA or real-device HealthKit QA.

## Scope

Included:

- Documentation-only follow-up to the Phase 9.38 evidence collection guide.
- Exact recording of the conservative user evidence package.
- Evidence answer classification and blocker mapping.
- Next manual evidence the user can collect without sharing secrets.
- Carry-forward of signing, archive, TestFlight, App Store Connect, real-device QA, privacy, HealthKit, medical-safety, and Watch Check-in MVP boundaries.
- A matching Phase 9.39 checklist in `TEST_PLAN.md`.

Not included:

- Apple Developer configuration execution.
- App Store Connect configuration execution.
- Signing configuration execution.
- Controlled signing re-verification.
- Xcode project signing changes.
- Setting `DEVELOPMENT_TEAM`.
- Certificate installation, revocation, creation, import, selection, or modification.
- Provisioning profile creation, download, installation, selection, or modification.
- Bundle identifier creation, verification, or modification in Apple Developer.
- Capability enablement or disablement.
- Entitlement, plist, CI workflow, Swift, or product behavior changes.
- `xcodebuild archive`.
- `xcodebuild -allowProvisioningUpdates`.
- Xcode archive, `.xcarchive` creation, `.ipa` export, TestFlight upload, or App Store Connect release action.
- App Store metadata, screenshot, privacy label, or review note changes.
- Phase 9.40 work.

## Current Baseline

- Current branch was created from `main` at `a088d61849d6e62d3faf6f0c291c2ba49e65ddd5`.
- Xcode observed locally: Xcode 26.6, build 17F113.
- `security find-identity -v -p codesigning` reported `0 valid identities found`.
- `DEVELOPMENT_TEAM = ""` remains visible in `StateWatch.xcodeproj/project.pbxproj` for inspected configurations.
- `CODE_SIGN_STYLE = Automatic` remains visible for relevant targets.
- `MARKETING_VERSION = 0.1.0` remains visible.
- `CURRENT_PROJECT_VERSION = 1` remains visible.
- iOS bundle ID observed locally: `com.easonsusu.StateWatch`.
- watchOS app bundle ID observed locally: `com.easonsusu.StateWatch.watchapp`.
- WidgetKit complications bundle ID observed locally: `com.easonsusu.StateWatch.watchapp.StateWatchComplications`.
- iOS HealthKit entitlement exists locally.
- App Group entitlement `group.com.easonsusu.StateWatch` exists locally for iOS app, watchOS app, and WidgetKit complications extension.
- iOS Info.plist includes `NSHealthShareUsageDescription`.
- No app plist key for `NSHealthUpdateUsageDescription` was observed in prior signing phases; matches remain documentation/test guardrails.
- Archive feasibility remains unproven.
- TestFlight upload feasibility remains unproven.

## Relationship To Phase 9.23 Through Phase 9.38

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
- Phase 9.39 records the conservative signing evidence collection follow-up only.

## User Evidence Package Recorded

The user-selected conservative current-evidence answer set is recorded exactly:

1. Apple Developer Program membership active: Unsure
2. Apple Developer team role can manage Certificates, Identifiers & Profiles: Unsure
3. Team ID intended for StateWatch: Unsure
4. Xcode Settings > Accounts shows correct team: Unsure
5. Valid Apple Development identity available locally: No
6. Valid Apple Distribution identity available locally: No
7. iOS App ID `com.easonsusu.StateWatch` exists: Unsure
8. watchOS App ID `com.easonsusu.StateWatch.watchapp` exists: Unsure
9. WidgetKit App ID `com.easonsusu.StateWatch.watchapp.StateWatchComplications` exists: Unsure
10. HealthKit enabled for iOS App ID only: Unsure
11. App Group `group.com.easonsusu.StateWatch` exists: Unsure
12. App Group attached to iOS/watchOS/WidgetKit identifiers: Unsure
13. Watch app relationship valid: Unsure
14. WidgetKit/complications relationship valid: Unsure
15. App Store Connect access available: Unsure
16. App Store Connect StateWatch app record exists: Unsure
17. Agreements/compliance prompts blocking upload: Unsure
18. TestFlight available for the app record: Unsure
19. Provisioning profiles automatically resolvable or available: Unsure
20. User explicitly authorizes a future phase to set DEVELOPMENT_TEAM after evidence is reviewed: No
21. User explicitly authorizes future certificate/profile actions if required: No
22. User explicitly authorizes future non-upload archive dry-run after blockers are resolved: No
23. Real Apple Watch available for VoiceOver/tap QA later: Unanswered / unresolved
24. Real iPhone/Apple Watch HealthKit QA setup available later: Unanswered / unresolved

## Evidence Answer Classification Labels

Phase 9.39 uses these labels:

- Confirmed Yes
- Confirmed No
- Unsure
- Unanswered
- Requires manual account verification
- Requires local Xcode/keychain verification
- Requires explicit authorization
- Blocks controlled signing re-verification
- Blocks archive dry-run planning
- Blocks TestFlight upload planning
- Deferred pending hardware
- Not applicable to current MVP
- Non-blocking follow-up

## Evidence Answer Classification Table

| ID | Evidence item | User answer | Classification | Current implication | Blocks controlled signing re-verification? | Blocks archive dry-run planning? | Blocks TestFlight upload planning? | Next user action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| EV-001 | Apple Developer Program membership active | Unsure | Unsure; Requires manual account verification; Blocks controlled signing re-verification; Blocks archive dry-run planning; Blocks TestFlight upload planning | Cannot prove Apple Developer access or signing eligibility. | Yes | Yes | Yes | Manually confirm membership status in Apple Developer without sharing credentials. |
| EV-002 | Team role can manage Certificates, Identifiers & Profiles | Unsure | Unsure; Requires manual account verification; Blocks controlled signing re-verification; Blocks archive dry-run planning; Blocks TestFlight upload planning | Cannot prove permission to manage signing assets. | Yes | Yes | Yes | Manually confirm role/capability management permission. |
| EV-003 | Team ID intended for StateWatch | Unsure | Unsure; Requires manual account verification; Requires explicit authorization; Blocks controlled signing re-verification; Blocks archive dry-run planning; Blocks TestFlight upload planning | No Team ID can be safely placed into project settings. | Yes | Yes | Yes | Identify intended Team ID, redacted if desired, and separately authorize any future use. |
| EV-004 | Xcode Settings > Accounts shows correct team | Unsure | Unsure; Requires local Xcode/keychain verification; Blocks controlled signing re-verification; Blocks archive dry-run planning; Blocks TestFlight upload planning | Local Xcode account/team state is not proven. | Yes | Yes | Yes | Manually verify Xcode account/team visibility with private account details redacted. |
| EV-005 | Valid Apple Development identity available locally | No | Confirmed No; Requires local Xcode/keychain verification; Blocks archive dry-run planning; Blocks TestFlight upload planning | Development signing identity is unavailable. | Maybe | Yes | Yes | Confirm after user-controlled certificate/account setup in a future authorized phase. |
| EV-006 | Valid Apple Distribution identity available locally | No | Confirmed No; Requires local Xcode/keychain verification; Blocks archive dry-run planning; Blocks TestFlight upload planning | Distribution signing identity is unavailable. | Maybe | Yes | Yes | Confirm after user-controlled distribution signing setup in a future authorized phase. |
| EV-007 | iOS App ID `com.easonsusu.StateWatch` exists | Unsure | Unsure; Requires manual account verification; Blocks archive dry-run planning; Blocks TestFlight upload planning | App ID account-level existence is not proven. | Maybe | Yes | Yes | Manually confirm App ID exists in Apple Developer. |
| EV-008 | watchOS App ID `com.easonsusu.StateWatch.watchapp` exists | Unsure | Unsure; Requires manual account verification; Blocks archive dry-run planning; Blocks TestFlight upload planning | Watch App ID account-level existence is not proven. | Maybe | Yes | Yes | Manually confirm Watch App ID exists in Apple Developer. |
| EV-009 | WidgetKit App ID `com.easonsusu.StateWatch.watchapp.StateWatchComplications` exists | Unsure | Unsure; Requires manual account verification; Blocks archive dry-run planning; Blocks TestFlight upload planning | WidgetKit extension App ID account-level existence is not proven. | Maybe | Yes | Yes | Manually confirm WidgetKit App ID exists in Apple Developer. |
| EV-010 | HealthKit enabled for iOS App ID only | Unsure | Unsure; Requires manual account verification; Blocks archive dry-run planning; Blocks TestFlight upload planning | Account-level HealthKit capability alignment is not proven. | Maybe | Yes | Yes | Manually confirm HealthKit is enabled only where needed for read-only iOS use. |
| EV-011 | App Group `group.com.easonsusu.StateWatch` exists | Unsure | Unsure; Requires manual account verification; Blocks archive dry-run planning; Blocks TestFlight upload planning | Account-level App Group existence is not proven. | Maybe | Yes | Yes | Manually confirm App Group exists in Apple Developer. |
| EV-012 | App Group attached to iOS/watchOS/WidgetKit identifiers | Unsure | Unsure; Requires manual account verification; Blocks archive dry-run planning; Blocks TestFlight upload planning | App Group membership alignment is not proven. | Maybe | Yes | Yes | Manually confirm App Group attachment for intended identifiers. |
| EV-013 | Watch app relationship valid | Unsure | Unsure; Requires manual account verification; Blocks archive dry-run planning; Blocks TestFlight upload planning | Watch relationship is not proven at account/project-signing level. | Maybe | Yes | Yes | Manually confirm watch app relationship in Apple Developer/Xcode/App Store Connect as applicable. |
| EV-014 | WidgetKit/complications relationship valid | Unsure | Unsure; Requires manual account verification; Blocks archive dry-run planning; Blocks TestFlight upload planning | WidgetKit relationship is not proven at account/project-signing level. | Maybe | Yes | Yes | Manually confirm extension relationship. |
| EV-015 | App Store Connect access available | Unsure | Unsure; Requires manual account verification; Blocks TestFlight upload planning | Upload planning cannot proceed without access evidence. | No | Maybe | Yes | Manually confirm App Store Connect access. |
| EV-016 | App Store Connect StateWatch app record exists | Unsure | Unsure; Requires manual account verification; Blocks TestFlight upload planning | App record availability is not proven. | No | Maybe | Yes | Manually confirm whether the app record exists. |
| EV-017 | Agreements/compliance prompts blocking upload | Unsure | Unsure; Requires manual account verification; Blocks TestFlight upload planning | Upload blockers may exist. | No | Maybe | Yes | Manually check agreements, tax/banking, compliance, and upload prompts. |
| EV-018 | TestFlight available for the app record | Unsure | Unsure; Requires manual account verification; Blocks TestFlight upload planning | TestFlight path is not proven. | No | Maybe | Yes | Manually confirm TestFlight availability for the app record. |
| EV-019 | Provisioning profiles automatically resolvable or available | Unsure | Unsure; Requires manual account verification; Requires local Xcode/keychain verification; Blocks archive dry-run planning; Blocks TestFlight upload planning | Profile resolution is not proven. | Maybe | Yes | Yes | Manually confirm profile availability or future automatic signing feasibility. |
| EV-020 | Authorization to set `DEVELOPMENT_TEAM` in a future phase | No | Confirmed No; Requires explicit authorization; Blocks controlled signing re-verification; Blocks archive dry-run planning; Blocks TestFlight upload planning | Codex must not set `DEVELOPMENT_TEAM`. | Yes | Yes | Yes | Provide explicit future authorization only after evidence review if desired. |
| EV-021 | Authorization for future certificate/profile actions | No | Confirmed No; Requires explicit authorization; Blocks controlled signing re-verification; Blocks archive dry-run planning; Blocks TestFlight upload planning | Codex must not install, create, download, select, or modify certs/profiles. | Yes | Yes | Yes | Provide explicit future authorization only after evidence review if desired. |
| EV-022 | Authorization for future non-upload archive dry-run | No | Confirmed No; Requires explicit authorization; Blocks archive dry-run planning; Blocks TestFlight upload planning | Codex must not run a non-upload archive dry-run. | No | Yes | Yes | Provide explicit future authorization only after blockers are resolved. |
| EV-023 | Real Apple Watch available for VoiceOver/tap QA later | Unanswered / unresolved | Unanswered; Deferred pending hardware | Real Watch VoiceOver and physical tap ergonomics remain unresolved; this is a future external-release blocker. | No | No | No | Answer whether a real Apple Watch will be available for QA later. |
| EV-024 | Real iPhone/Apple Watch HealthKit QA setup available later | Unanswered / unresolved | Unanswered; Deferred pending hardware | Real-device HealthKit QA remains planned, not executed; this is a future external-release blocker. | No | No | No | Answer whether a real HealthKit QA setup will be available later. |

## Blocking Summary

- Items EV-001 through EV-004 are Unsure and block controlled signing re-verification.
- Items EV-005 and EV-006 are Confirmed No and block archive and TestFlight paths.
- Items EV-007 through EV-019 are Unsure and block archive and TestFlight planning.
- Items EV-020 through EV-022 are Confirmed No and block any future mutable signing, project, certificate/profile, or archive action.
- Items EV-023 and EV-024 are Unanswered and keep real-device QA unresolved.

## What Is Currently Proven

- Phase 9.38 was merged into `main`.
- This Phase 9.39 branch was created from `main` at `a088d61849d6e62d3faf6f0c291c2ba49e65ddd5`.
- The conservative evidence package records no valid local Apple Development signing identity and no valid local Apple Distribution signing identity.
- The local project file still shows empty `DEVELOPMENT_TEAM` values.
- Local project markers still show the expected StateWatch iOS, watchOS, and WidgetKit bundle identifiers.
- HealthKit remains read-only in the documented MVP stance.
- Watch Check-in remains Watch-only and local-only.

## What Is Currently Not Proven

- Apple Developer Program membership status is not proven.
- Apple Developer role permission is not proven.
- Team ID is not proven.
- Xcode account/team visibility is not proven.
- Apple Developer App IDs are not proven.
- HealthKit capability state in Apple Developer is not proven.
- App Group existence and attachment are not proven.
- Watch app and WidgetKit relationship validity are not proven.
- App Store Connect access and app record state are not proven.
- Agreements, compliance prompts, and TestFlight availability are not proven.
- Provisioning profile availability or automatic signing resolution is not proven.
- Real-device Watch VoiceOver/tap QA availability is not answered.
- Real-device HealthKit QA availability is not answered.

## Why Signing Remediation Remains Blocked

Signing remediation remains blocked because the current evidence package does not identify a valid Apple Developer team, does not prove Xcode account/team visibility, records no valid local signing identities, does not prove App ID/capability/profile readiness, and explicitly does not authorize `DEVELOPMENT_TEAM`, certificate/profile, or archive actions.

## Why Controlled Signing Re-verification Remains Premature

Controlled signing re-verification remains premature because the user has not provided enough non-secret account/team evidence to verify the intended signing context. Running local checks without Apple Developer membership, role, Team ID, Xcode account/team visibility, valid identities, and explicit authorization would only repeat the known blocked state.

## Why Archive Dry-run Planning Remains Blocked

Archive dry-run planning remains blocked until Apple Developer membership, Team ID, Xcode account/team visibility, valid signing identities, App IDs, capabilities, App Group, provisioning/profile resolution, and required authorization are resolved or explicitly accepted as unresolved blockers.

This phase does not run `xcodebuild archive`, does not run `xcodebuild -allowProvisioningUpdates`, does not create an `.xcarchive`, and does not export an `.ipa`.

## Why TestFlight Upload Planning Remains Blocked

TestFlight upload planning remains blocked until Apple Developer, App Store Connect, distribution signing, archive, upload, agreement, compliance, and TestFlight prerequisites are verified.

This phase does not upload to TestFlight, does not create App Store Connect builds, and does not change App Store metadata, screenshots, privacy labels, or review notes.

## Next Manual Apple Developer Evidence To Collect

The user can manually collect these non-secret answers later:

- Whether Apple Developer Program membership is active.
- Whether the user's team role can manage Certificates, Identifiers & Profiles.
- The intended Team ID for StateWatch, redacted if desired.
- Whether the iOS, watchOS, and WidgetKit App IDs exist.
- Whether HealthKit is enabled only for the iOS App ID as needed for read-only HealthKit use.
- Whether App Group `group.com.easonsusu.StateWatch` exists.
- Whether the App Group is attached to the intended iOS, watchOS, and WidgetKit identifiers.

## Next Manual App Store Connect Evidence To Collect

The user can manually collect these non-secret answers later:

- Whether App Store Connect access is available.
- Whether a StateWatch app record exists.
- Whether agreements, compliance prompts, or account setup items block upload.
- Whether TestFlight is visible and available for the app record.

## Next Xcode Account/team Evidence To Collect

The user can manually check whether Xcode Settings > Accounts shows the intended Apple Developer team. Screenshots are optional and must redact Apple ID email, team member emails, personal account data, device identifiers, and private account details.

## Next Local Signing Identity Evidence To Collect

The next useful local evidence is whether valid Apple Development and Apple Distribution identities are available locally after the user handles account/certificate setup outside this phase. The user must not share certificate private keys, serial numbers, fingerprints, keychain details, or unredacted screenshots.

## Next App ID / Capability / App Group Evidence To Collect

The next useful account-level evidence is whether App IDs, HealthKit, App Group, watch app relationship, and WidgetKit extension relationship are correctly present for the intended Apple Developer team. This phase does not create identifiers, enable capabilities, or modify entitlements.

## Next Real-device QA Evidence To Collect

The next useful real-device QA evidence is whether a real Apple Watch is available for VoiceOver/tap ergonomics QA and whether a real iPhone/Apple Watch HealthKit QA setup is available later. No real-device QA result is claimed until the checks are actually executed.

## Secret Handling Reminder

The user must not provide:

- Apple ID email.
- Passwords.
- 2FA codes.
- Tokens.
- API keys.
- Private keys.
- Certificate serials/fingerprints.
- Provisioning profile contents.
- Profile UUIDs unless explicitly redacted.
- Screenshots with private account/device data.
- Raw HealthKit data.

## Codex Re-verification Readiness Criteria

Codex should not begin controlled signing re-verification until the user provides enough non-secret evidence to answer at least these points:

- Apple Developer membership is active.
- Role can manage Certificates, Identifiers & Profiles or the user will perform those actions manually.
- Intended Team ID is known.
- Xcode can see the intended team.
- Valid local signing identities are available or the user authorizes a specific future setup path.
- App IDs, capabilities, App Group, watch relationship, and WidgetKit relationship are confirmed.
- Provisioning/profile resolution is available or explicitly accepted as unresolved.
- The user gives explicit authorization for the exact future action, such as setting `DEVELOPMENT_TEAM`, re-running local signing checks, or planning a non-upload archive dry-run.

## Privacy / HealthKit Review

HealthKit remains read-only. This phase does not add HealthKit write access, write authorization, raw HealthKit storage, raw HealthKit upload, developer-accessible health databases, networking paths, cloud sync, analytics paths, AI cloud analysis, account systems, or remote config.

Real-device HealthKit QA remains planned, not executed.

## Medical-safety Review

StateWatch remains non-medical wellness/readiness software. This phase does not introduce diagnosis, treatment, therapy, emergency, abnormal-state, warning, disease-detection, clinical-stress, medical-grade, medical-advice, or risk-claim product behavior.

Missing HealthKit data and missing Check-ins remain neutral and must not be interpreted as a negative wellness state.

## Watch Check-in MVP Review

Watch Check-in remains Watch-only and local-only. The four states remain `Energized`, `Stable`, `Tired`, and `Low`; Traditional Chinese reference labels remain `有活力`, `穩定`, `疲累`, and `低狀態`; display modes remain `Icon + Text`, `Icon Only`, and `Text Only`; default display remains `Icon + Text`; latest-three history remains unchanged.

Check-ins do not affect State Score, readiness, confidence, reasons, suggestions, iPhone surfaces, WidgetKit complications, App Group summaries, WatchConnectivity, HealthKit, networking, cloud, analytics, AI, accounts, reminders, notifications, trends, streaks, counts, causes, interpretations, pattern summaries, or insights.

## Items Not Included In Current MVP

- iPhone Check-in UI, history, deletion, or management.
- WidgetKit Check-in display, summary, or direct read.
- App Group raw Check-in history or display preference propagation.
- WatchConnectivity.
- State Score integration.
- Latest-five history.
- Clear-all UI.
- Long-term Check-in history.
- Notes, export, reminders, notifications, trends, streaks, counts, causes, interpretations, pattern summaries, or insights.

## Prohibited Claims

Do not claim:

- Apple Developer configured.
- App Store Connect configured.
- `DEVELOPMENT_TEAM` fixed.
- Certificates installed.
- Provisioning profiles created.
- Bundle IDs created.
- Capabilities enabled.
- Signing fixed.
- Signing fully verified.
- Archive-ready.
- Archive feasible.
- Archived successfully.
- `.xcarchive` created.
- IPA exported.
- Uploaded to TestFlight.
- TestFlight-ready.
- App Store ready.
- Release ready.
- Fully validated.
- VoiceOver verified on real device.
- HealthKit QA complete.
- Check-ins sync to iPhone, widgets, App Group, cloud, or WatchConnectivity.
- Check-ins change State Score.

## Allowed Claims

Allowed claims for this phase:

- The conservative user evidence package was recorded.
- Current evidence is insufficient for controlled signing re-verification.
- Current evidence is insufficient for signing remediation.
- Current evidence is insufficient for archive dry-run planning.
- Current evidence is insufficient for TestFlight upload planning.
- The next safe user evidence items are documented.
- Secret handling and redaction rules are carried forward.
- Phase 9.40 is recommended as a documentation-only Apple Developer Account Setup Guide unless explicitly authorized otherwise.

## Work That May Continue

- Documentation-only planning.
- Non-secret evidence collection by the user.
- Future read-only local verification after enough non-secret evidence exists.
- Watch Check-in QA documentation with explicit limitations.
- Privacy and medical-safety documentation reviews.

## Work That Must Wait

- Controlled signing re-verification.
- Signing remediation.
- Setting `DEVELOPMENT_TEAM`.
- Certificate or provisioning profile actions.
- Bundle identifier or capability changes.
- Archive dry-run planning.
- TestFlight upload planning.
- App Store Connect release work.
- App Store submission.
- Real-device QA result claims.

## Non-blocking Follow-ups

- Old iPhone `CheckInView` scaffold remains a separate future review item.
- `StateWatchThemeTests.swift` size remains a separate future test-maintenance refactor.
- Known documentation duplication across late Phase 9 release/signing docs can be consolidated later without changing product behavior.

## Risks / Limitations

- The evidence package is intentionally conservative and leaves most signing/account state unknown.
- No explicit authorization exists for mutable signing actions.
- No valid local signing identities are available based on the current evidence package.
- Real-device Watch VoiceOver and tap ergonomics QA remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Archive feasibility and TestFlight upload feasibility remain unproven.

## Recommended Next Phase

Recommended next phase: Phase 9.40: Apple Developer Account Setup Guide.

Phase 9.40 should be documentation-only unless the user explicitly authorizes otherwise. It should explain how the user can manually check Apple Developer Program membership, team role, Team ID, Xcode Accounts, and signing identities; continue to avoid secret collection; not set `DEVELOPMENT_TEAM`; not install certificates; not create profiles; not archive; and not upload.

## Changes Made

- Added `Docs/phase-9-39-signing-evidence-collection-follow-up.md`.
- Added a Phase 9.39 checklist to `TEST_PLAN.md`.
- No Swift files, Xcode project files, entitlements, plist files, CI workflows, or product behavior were changed.

## Final Phase 9.39 Checklist

- Phase 9.39 signing evidence collection follow-up document exists.
- Conservative user evidence package is recorded exactly.
- Evidence answer classification table is documented.
- Current evidence is insufficient for controlled signing re-verification.
- Current evidence is insufficient for signing remediation.
- Current evidence is insufficient for archive dry-run planning.
- Current evidence is insufficient for TestFlight upload planning.
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
- No App Store metadata, screenshots, privacy labels, or review notes were changed.
- No secrets/certificates/private keys/provisioning profiles/tokens/account emails were committed.
- No broad release-ready, App Store approval, external submission-readiness, signing-fixed, archive-ready, or TestFlight-ready claim was made.
- Phase 9.22 remains deferred/blocked, not completed.
- Real-device Watch VoiceOver QA remains unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 validation remains non-real-device validation only.
- HealthKit remains read-only.
- Watch Check-in remains Watch-only and local-only.
- Check-ins do not affect State Score.
- No prohibited product scope was added.
- Phase 9.40 not started.
