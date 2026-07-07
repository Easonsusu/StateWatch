# Phase 9.42 Apple Developer Evidence Intake Checklist

## Purpose

This is an Apple Developer evidence intake checklist, not Apple Developer configuration execution, App Store Connect configuration execution, signing configuration execution, controlled signing re-verification, Xcode project signing changes, Xcode archive, TestFlight upload, App Store Connect release action, App Store submission, or release-ready claim.

Phase 9.42 records that Phase 9.41 is complete and that no new Apple Developer, App Store Connect, Xcode Accounts, signing identity, App ID, capability, App Group, provisioning/profile, TestFlight, authorization, or real-device QA evidence was provided after Phase 9.41, so the conservative evidence state remains unchanged.

This checklist converts the longer Phase 9.38 through Phase 9.41 evidence and setup guidance into one concise, copyable intake form for the user to fill before any future controlled signing re-verification plan.

This checklist does not authorize Codex to change Apple Developer settings, App Store Connect settings, Xcode signing settings, certificates, provisioning profiles, bundle identifiers, capabilities, entitlements, plists, or project files.

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

- Documentation-only Apple Developer evidence intake checklist.
- Carry forward Phase 9.41's conservative evidence state.
- Split required user evidence into controlled signing re-verification, archive dry-run planning, TestFlight upload planning, and broader external release claim gates.
- Provide safe answer formats and a minimal copyable evidence template.
- Preserve secret handling and screenshot redaction rules.
- Define decision rules for Phase 9.43.
- Preserve privacy, HealthKit, medical-safety, and Watch Check-in MVP boundaries.
- Add a matching Phase 9.42 checklist in `TEST_PLAN.md`.

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
- WatchConnectivity, networking, cloud sync, iCloud sync, AI cloud analysis, analytics, account systems, login, upload path, or remote config.
- HealthKit write access or write authorization.
- Notes, export, reminders, notifications, scheduling, trends, streaks, counts, causes, interpretations, pattern summaries, or insights.
- Phase 9.43 work.

## Current Baseline

- Current branch was created from `main` after Phase 9.41 was merged at `f73e3afaf5ca8b0eec088aa4bd6daf73f92e743d`.
- Xcode observed locally: Xcode 26.6, build 17F113.
- SDKs recorded in earlier signing phases include iOS 26.5, iOS Simulator 26.5, watchOS 26.5, and watchOS Simulator 26.5.
- Schemes observed locally: `StateWatch`, `StateWatchWatchApp`, and `StateWatchComplications`.
- `security find-identity -v -p codesigning` reported `0 valid identities found`.
- iOS app bundle ID observed locally: `com.easonsusu.StateWatch`.
- watchOS app bundle ID observed locally: `com.easonsusu.StateWatch.watchapp`.
- WidgetKit complications bundle ID observed locally: `com.easonsusu.StateWatch.watchapp.StateWatchComplications`.
- `MARKETING_VERSION = 0.1.0` remains visible.
- `CURRENT_PROJECT_VERSION = 1` remains visible.
- `CODE_SIGN_STYLE = Automatic` remains visible for relevant targets.
- `DEVELOPMENT_TEAM = ""` remains visible for inspected configurations.
- `PROVISIONING_PROFILE_SPECIFIER` was not visible in filtered local output.
- Local HealthKit entitlement exists for the iOS app.
- Local App Group entitlement `group.com.easonsusu.StateWatch` exists for the iOS app, watchOS app, and WidgetKit complications extension.
- iOS Info.plist includes `NSHealthShareUsageDescription`.
- No HealthKit write usage plist key is expected for the MVP.
- `StateWatchWidgets` directory is not present; current WidgetKit code is under `StateWatchComplications`.
- Archive feasibility remains unproven.
- TestFlight upload feasibility remains unproven.

## Relationship To Phase 9.23 Through Phase 9.41

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
- Phase 9.40 records the Apple Developer account setup guide only.
- Phase 9.41 records that no completed Phase 9.40 User Setup Result Template was returned and preserves the blocked state.
- Phase 9.42 records a concise evidence intake checklist only.

## No New User Evidence Received After Phase 9.41

No new Apple Developer, App Store Connect, Xcode Accounts, signing identity, App ID, capability, App Group, provisioning/profile, TestFlight, authorization, or real-device QA evidence was provided after Phase 9.41. No evidence item is upgraded by this phase.

## Conservative Evidence Carried Forward

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

## What This Intake Checklist Is For

This intake checklist gives the user one concise form to answer with non-secret `Yes`, `No`, `Unsure`, or redacted evidence values before any future controlled signing re-verification plan. It is designed to reduce repeated long-form signing evidence prompts while keeping blockers explicit.

## What This Intake Checklist Is Not For

This intake checklist is not permission to change Apple Developer, App Store Connect, Xcode signing, certificates, provisioning profiles, bundle identifiers, capabilities, entitlements, plists, project files, CI workflows, app behavior, archives, uploads, or App Store metadata.

## Required Evidence Before Controlled Signing Re-verification

Before controlled signing re-verification can be planned, the user must provide enough non-secret evidence for:

1. Active Apple Developer Program membership.
2. Team role that can manage Certificates, Identifiers & Profiles.
3. Team ID intended for StateWatch.
4. Xcode Settings > Accounts visibility for the correct team.
5. Valid Apple Development identity availability.
6. Valid Apple Distribution identity availability.
7. Explicit authorization for a future phase to set `DEVELOPMENT_TEAM` after evidence review.
8. Explicit authorization for future certificate/profile actions if required.

## Required Evidence Before Archive Dry-run Planning

Before archive dry-run planning can proceed, the controlled signing evidence above must be resolved or explicitly accepted as unresolved blockers, and the user must provide enough non-secret evidence for:

1. iOS App ID `com.easonsusu.StateWatch` existence.
2. watchOS App ID `com.easonsusu.StateWatch.watchapp` existence.
3. WidgetKit App ID `com.easonsusu.StateWatch.watchapp.StateWatchComplications` existence.
4. Read-only HealthKit enabled for the iOS App ID only.
5. App Group `group.com.easonsusu.StateWatch` existence and correct attachment.
6. Watch app and WidgetKit/complications relationships.
7. Provisioning profiles automatically resolvable or available.
8. Explicit authorization for a future non-upload archive dry run after blockers are resolved.

## Required Evidence Before TestFlight Upload Planning

Before TestFlight upload planning can proceed, controlled signing and archive prerequisites must be verified, and the user must provide enough non-secret evidence for:

1. App Store Connect access.
2. App Store Connect StateWatch app record existence.
3. Agreements/compliance prompt status.
4. TestFlight availability for the app record.
5. Distribution signing, archive, upload, agreement, compliance, and TestFlight prerequisites.

## Required Evidence Before Broader External Release Claims

Before broader external release claims can be considered, the user must provide evidence that:

1. Real Apple Watch VoiceOver and tap ergonomics QA can be performed and later recorded.
2. Real iPhone/Apple Watch HealthKit QA setup is available and can later be recorded.
3. Phase 9.27 non-real-device validation is not being treated as a substitute for real-device QA.
4. App Store privacy, medical-safety, signing, archive, TestFlight, and real-device limitations are resolved or explicitly documented.

## Safe Answer Formats

- Use `Yes`, `No`, or `Unsure` for most answers.
- Use `[Team ID or partially redacted / Unsure]` for Team ID.
- Use a short text note only when it does not contain secrets or personal data.
- Do not paste screenshots unless they are redacted first.
- Do not paste raw provisioning profile contents, raw HealthKit samples, private account identifiers, or device identifiers.

## Minimal Copyable Evidence Intake Template

```markdown
# Phase 9.42 Evidence Intake

## A. Controlled signing re-verification prerequisites

1. Apple Developer Program membership active:
Yes / No / Unsure

2. Team role can manage Certificates, Identifiers & Profiles:
Yes / No / Unsure

3. Team ID intended for StateWatch:
[Team ID or partially redacted / Unsure]

4. Xcode Settings > Accounts shows correct team:
Yes / No / Unsure

5. Valid Apple Development identity available locally:
Yes / No / Unsure

6. Valid Apple Distribution identity available locally:
Yes / No / Unsure

7. I authorize a future phase to set DEVELOPMENT_TEAM after evidence review:
Yes / No

8. I authorize future certificate/profile actions if required:
Yes / No

## B. Archive dry-run planning prerequisites

9. iOS App ID com.easonsusu.StateWatch exists:
Yes / No / Unsure

10. watchOS App ID com.easonsusu.StateWatch.watchapp exists:
Yes / No / Unsure

11. WidgetKit App ID com.easonsusu.StateWatch.watchapp.StateWatchComplications exists:
Yes / No / Unsure

12. HealthKit enabled for iOS App ID only:
Yes / No / Unsure

13. App Group group.com.easonsusu.StateWatch exists and is attached correctly:
Yes / No / Unsure

14. Watch app and WidgetKit/complications relationships valid:
Yes / No / Unsure

15. Provisioning profiles automatically resolvable or available:
Yes / No / Unsure

16. I authorize future non-upload archive dry-run after blockers are resolved:
Yes / No

## C. TestFlight upload planning prerequisites

17. App Store Connect access available:
Yes / No / Unsure

18. App Store Connect StateWatch app record exists:
Yes / No / Unsure

19. Agreements/compliance prompts blocking upload:
Yes / No / Unsure

20. TestFlight available for the app record:
Yes / No / Unsure

## D. External release QA prerequisites

21. Real Apple Watch available for VoiceOver/tap QA later:
Yes / No / Unsure

22. Real iPhone/Apple Watch HealthKit QA setup available later:
Yes / No / Unsure

## Do not paste or commit

Do not paste Apple ID emails, passwords, 2FA codes, tokens, API keys, private keys, certificate serials, certificate fingerprints, provisioning profile contents, unredacted profile UUIDs, unredacted screenshots, device UDIDs, personal addresses, phone numbers, or raw HealthKit data.
```

## Secret Handling Rules

The user must not paste Apple ID emails, passwords, 2FA codes, tokens, API keys, private keys, certificate serials, certificate fingerprints, provisioning profile contents, unredacted profile UUIDs, unredacted screenshots, device UDIDs, personal addresses, phone numbers, or raw HealthKit data.

## Screenshot Redaction Rules

If screenshots are used later, redact account email addresses, team member names, phone numbers, addresses, serials, fingerprints, profile UUIDs, device UDIDs, tokens, private identifiers, and any personal health data before sharing. Prefer text answers over screenshots whenever possible.

## Decision Rules For Phase 9.43

- If the user still cannot provide enough account evidence: recommended next phase remains Phase 9.43: Apple Developer Evidence Intake Follow-up.
- If the user provides mostly Yes for Section A plus explicit authorization: recommended next phase becomes Phase 9.43: Controlled Signing Re-verification Plan.
- If Section A and Section B are mostly Yes and archive authorization is Yes: a later phase may become Archive Dry-Run Plan, but only after controlled signing re-verification is planned or completed.
- If Section C is incomplete: TestFlight upload planning remains blocked.
- If Section D is incomplete: external release-readiness claims remain blocked.

## Privacy / HealthKit Review

- HealthKit remains read-only.
- No HealthKit write access or write authorization is added.
- No HealthKit sample upload, cloud sync, iCloud sync, analytics, AI cloud analysis, advertising profile, developer database, or remote config is added.
- Local HealthKit entitlement and `NSHealthShareUsageDescription` are visible for the iOS app, but account-level HealthKit capability evidence remains unresolved.
- Real-device HealthKit QA remains planned, not executed.

## Medical-safety Review

StateWatch remains non-medical wellness/readiness software. This phase does not add diagnosis, treatment, therapy, emergency, abnormal-state, warning, disease-detection, clinical-stress, medical-grade, or medical-advice claims.

## Watch Check-in MVP Review

- Watch Check-in remains Watch-only and local-only.
- Check-ins do not affect State Score.
- Missing Check-ins remain neutral.
- Low Check-ins remain non-medical and non-warning.
- No iPhone Check-in UI, history, deletion, or management is added.
- No WidgetKit Check-in display, summary, or direct read is added.
- No App Group raw Check-in history or propagation is added.
- No WatchConnectivity is added.

## Items Not Included In Current MVP

- iPhone Check-in UI, history, deletion, or management.
- WidgetKit Check-in display, summary, or direct read.
- App Group raw Check-in history or propagation.
- WatchConnectivity.
- State Score integration from Check-ins.
- HealthKit write access.
- Networking, cloud sync, iCloud sync, analytics, AI, account system, login, upload path, or remote config.
- Notes, export, reminders, notifications, scheduling, trends, streaks, counts, causes, interpretations, pattern summaries, or insights.

## Prohibited Claims

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

- Apple Developer evidence intake checklist recorded.
- No new evidence was provided after Phase 9.41.
- Conservative evidence state remains unchanged.
- Minimal copyable evidence intake template is documented.
- Secret handling and screenshot redaction reminders are documented.
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

- Documentation-only planning.
- Non-secret evidence intake.
- Privacy, medical-safety, and QA checklist refinement.
- Real-device QA planning that does not claim execution.
- Future controlled signing re-verification planning only after enough Section A evidence and explicit authorization are provided.

## Work That Must Wait

- Apple Developer configuration.
- App Store Connect configuration.
- Xcode signing setting changes.
- Setting `DEVELOPMENT_TEAM`.
- Certificate/profile actions.
- Bundle identifier or capability changes.
- Archive dry run.
- TestFlight upload.
- External release-readiness claims.
- Real-device Watch VoiceOver/tap QA claims.
- Real-device HealthKit QA completion claims.

## Non-blocking Follow-ups

- Keep docs concise as signing blockers are resolved or carried forward.
- Collect non-secret evidence in the Phase 9.42 template.
- Preserve the old iPhone `CheckInView` scaffold for a separately scoped future phase.
- Continue avoiding broad release-ready language until real-device and signing blockers are resolved.

## Risks / Limitations

- The checklist depends on user-provided evidence and cannot prove Apple Developer account state by itself.
- The local machine still has no valid signing identities based on the latest read-only check.
- Archive and TestFlight feasibility remain unproven.
- Real-device Watch VoiceOver/tap QA and real-device HealthKit QA remain unresolved.
- Because this phase is docs-only, simulator builds are not required unless future code or project files change.

## Recommended Next Phase

If the user still cannot provide enough account evidence: Phase 9.43: Apple Developer Evidence Intake Follow-up.

If the user provides enough non-secret Section A evidence and explicit authorization: Phase 9.43: Controlled Signing Re-verification Plan.

If controlled signing re-verification later passes and Section B evidence is sufficient: a later phase may become Archive Dry-Run Plan.

## Changes Made

- Added `Docs/phase-9-42-apple-developer-evidence-intake-checklist.md`.
- Added Phase 9.42 checklist entries to `TEST_PLAN.md`.
- No Swift, Xcode project, entitlement, plist, CI workflow, or product behavior files were changed.

## Final Phase 9.42 Checklist

- Phase 9.42 Apple Developer evidence intake checklist document exists.
- The document is evidence intake checklist guidance only.
- Phase 9.23 through Phase 9.41 were used as input.
- No new evidence was provided after Phase 9.41.
- Conservative evidence state remains unchanged.
- Minimal copyable evidence intake template is documented.
- Secret handling rules are documented.
- Optional screenshot redaction rules are documented.
- Decision rules for Phase 9.43 are documented.
- Controlled signing re-verification remains blocked.
- Signing remediation remains blocked.
- Archive dry-run planning remains blocked.
- TestFlight upload planning remains blocked.
- No Apple Developer configuration was performed.
- No App Store Connect configuration was performed.
- No signing configuration was changed.
- No controlled signing re-verification was performed.
- No `DEVELOPMENT_TEAM` was set.
- No certificates were installed, revoked, created, or modified.
- No provisioning profiles were created, downloaded, selected, or modified.
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
- No secrets/certificates/private keys/provisioning profiles/tokens/account emails/device UDIDs/personal addresses/phone numbers/raw HealthKit data were committed.
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
- HealthKit remains read-only.
- No HealthKit write access or write authorization was added.
- No diagnosis, treatment, therapy, emergency, abnormal-state, warning, disease-detection, clinical-stress, medical-grade, or medical-advice claim is made.
- Watch Check-in remains Watch-only.
- Watch Check-in remains local-only.
- Check-ins do not affect State Score.
- No iPhone Check-in UI, history, deletion, or management added.
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
- Recommended next phase is defined.
- Local validation commands pass.
- GitHub Actions status is reviewed.
- No Phase 9.43 work started.
