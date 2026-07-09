# Phase 9.44 Apple Developer Manual Setup Instructions

## Purpose

Phase 9.44 documents manual, user-facing Apple Developer, Xcode, and App Store Connect setup instructions for StateWatch. It helps the user move from the current conservative `Unsure` / `No` evidence state toward safe, non-secret evidence that can be reviewed in a future phase.

This is Apple Developer manual setup instruction documentation, not Apple Developer configuration execution, App Store Connect configuration execution, signing configuration execution, controlled signing re-verification, Xcode project signing changes, Xcode archive, TestFlight upload, App Store Connect release action, App Store submission, or release-ready claim.

## Scope

This phase is documentation-only.

Phase 9.44 does not authorize Codex to change Apple Developer settings, App Store Connect settings, Xcode signing settings, certificates, provisioning profiles, bundle identifiers, capabilities, entitlements, plists, project files, archives, uploads, or App Store metadata.

The user may manually inspect Apple Developer, Xcode, and App Store Connect and then report only non-secret Yes / No / Unsure evidence back to the project.

Included:

- Carry forward the conservative Phase 9.43 evidence result.
- Explain why controlled signing, signing remediation, archive, and TestFlight remain blocked.
- Provide manual Apple Developer, Xcode, and App Store Connect setup instructions for the user.
- Provide a safe evidence response template.
- Preserve privacy, HealthKit, medical-safety, and Watch Check-in MVP boundaries.
- Add a matching Phase 9.44 checklist in `TEST_PLAN.md`.

Not included:

- Apple Developer configuration by Codex.
- App Store Connect configuration by Codex.
- Signing configuration execution.
- Controlled signing re-verification.
- Setting `DEVELOPMENT_TEAM`.
- Certificate installation, creation, revocation, download, selection, or modification.
- Keychain item modification.
- Provisioning profile creation, download, installation, selection, or modification.
- Bundle identifier creation or modification.
- Capability enablement or disablement.
- Entitlement, plist, CI workflow, Swift, Xcode project, or product behavior changes.
- `xcodebuild archive`.
- `xcodebuild -allowProvisioningUpdates`.
- Xcode archive, `.xcarchive` creation, `.ipa` export, TestFlight upload, or App Store Connect release action.
- App Store metadata, screenshots, privacy labels, or review note changes.
- HealthKit write access or write authorization.
- WatchConnectivity, WidgetKit Check-in display, App Group raw Check-in history, State Score integration, networking, cloud, iCloud, analytics, AI, account system, login, upload path, or remote config.
- Phase 9.45 work.

## Current Baseline

- Phase 9.43 was merged through PR #90.
- Main was at `ec966225f406bcdb48c300ca470a0078be9b61bd` after Phase 9.43.
- The user selected conservative Phase 9.42 Evidence Intake answers.
- Phase 9.43 recorded that result exactly.
- Current evidence remains insufficient.
- Required authorizations remain No.

## Relationship To Phase 9.23 Through Phase 9.43

- Phase 9.23 documented release blockers.
- Phase 9.24 audited Check-in MVP release readiness.
- Phase 9.25 prepared an internal TestFlight QA checklist.
- Phase 9.26 audited App Store privacy and medical-safety status.
- Phase 9.27 recorded non-real-device validation only.
- Phase 9.28 documented known limitations and release note guidance.
- Phase 9.29 documented internal TestFlight distribution readiness constraints.
- Phase 9.30 documented internal TestFlight build preparation planning only.
- Phase 9.31 inventoried archive and signing environment state.
- Phase 9.32 planned Apple Developer signing verification.
- Phase 9.33 recorded that signing verification remained unresolved.
- Phase 9.34 documented a signing remediation plan.
- Phase 9.35 prepared signing remediation execution.
- Phase 9.36 recorded controlled signing remediation execution results without mutable signing changes.
- Phase 9.37 documented signing blocker follow-up planning.
- Phase 9.38 documented signing evidence collection guidance.
- Phase 9.39 recorded evidence follow-up and unresolved blockers.
- Phase 9.40 documented Apple Developer account setup guidance.
- Phase 9.41 recorded that no completed setup result template had been returned.
- Phase 9.42 documented the concise Apple Developer evidence intake checklist.
- Phase 9.43 recorded the user-selected conservative evidence intake result.
- Phase 9.44 documents manual user setup instructions only.

## Conservative Result Carried Forward

- Apple Developer Program membership active: Unsure.
- Team role can manage Certificates, Identifiers & Profiles: Unsure.
- Team ID intended for StateWatch: Unsure.
- Xcode Settings > Accounts shows correct team: Unsure.
- Valid Apple Development identity available locally: No.
- Valid Apple Distribution identity available locally: No.
- Future `DEVELOPMENT_TEAM` authorization after evidence review: No.
- Future certificate/profile authorization if required: No.
- iOS App ID `com.easonsusu.StateWatch` exists: Unsure.
- watchOS App ID `com.easonsusu.StateWatch.watchapp` exists: Unsure.
- WidgetKit App ID `com.easonsusu.StateWatch.watchapp.StateWatchComplications` exists: Unsure.
- HealthKit enabled for iOS App ID only: Unsure.
- App Group `group.com.easonsusu.StateWatch` exists and is attached correctly: Unsure.
- Watch app and WidgetKit/complications relationships valid: Unsure.
- Provisioning profiles automatically resolvable or available: Unsure.
- Future non-upload archive dry-run after blockers are resolved: No.
- App Store Connect access available: Unsure.
- App Store Connect StateWatch app record exists: Unsure.
- Agreements/compliance prompts blocking upload: Unsure.
- TestFlight available for the app record: Unsure.
- Real Apple Watch available for VoiceOver/tap QA later: Unsure.
- Real iPhone/Apple Watch HealthKit QA setup available later: Unsure.

## Why This Is Manual Setup Guidance Only

This document gives the user careful manual instructions for checking Apple Developer, Xcode, and App Store Connect. It does not perform those checks through Codex and does not change any project, signing, portal, account, archive, upload, or release state.

Apple interfaces may change. These instructions intentionally use wording such as "look for", "confirm", and "report" instead of promising exact Apple UI labels or layout.

The user should report back only non-secret evidence. Codex must not infer readiness from missing, partial, or private evidence.

## What Remains Blocked

Controlled signing re-verification remains blocked until the user provides enough non-secret evidence for Apple Developer membership, team role, Team ID, Xcode account/team visibility, valid local signing identities, relevant App IDs, capabilities, App Group, provisioning/profile resolution, and explicit authorization.

Signing remediation remains blocked because DEVELOPMENT_TEAM authorization is No and certificate/profile authorization is No.

Archive dry-run planning remains blocked because archive authorization is No and signing, Team ID, App ID, capability, App Group, and provisioning/profile evidence remains insufficient.

TestFlight upload planning remains blocked because App Store Connect access, app record, agreements/compliance status, TestFlight availability, distribution signing, archive success, and upload prerequisites remain unverified.

External release-readiness claims remain blocked.

Phase 9.22 remains deferred/blocked, not completed.

Real-device Watch VoiceOver QA remains unresolved.

Real-device HealthKit QA remains planned, not executed.

Phase 9.27 validation was non-real-device validation only and does not replace real Apple Watch QA or real-device HealthKit QA.

## Manual Setup Overview

The user may manually inspect Apple Developer, Xcode, and App Store Connect. The goal is to answer the safe evidence template with `Yes`, `No`, `Unsure`, or a partially redacted Team ID.

Do not paste secrets or private account details into issues, pull requests, docs, or chat.

Do not change Xcode project signing settings in this phase.

Do not ask Codex to perform portal changes until a future phase explicitly authorizes and scopes the action.

## Step 1: Confirm Apple Developer Program Membership

1. Sign in to Apple Developer manually in a browser outside Codex.
2. Look for whether the relevant Apple Developer Program membership appears active.
3. Report only `Yes`, `No`, or `Unsure`.
4. Do not paste Apple ID email, account pages, billing details, or screenshots.

## Step 2: Confirm Role And Certificates, Identifiers & Profiles Access

1. In Apple Developer, check whether the account role can manage Certificates, Identifiers & Profiles.
2. Account Holder/Admin-level access or an equivalent permission set may be relevant for certificates, identifiers, profiles, App IDs, and provisioning work.
3. Report only `Yes`, `No`, or `Unsure`.
4. If access is missing or unclear, report `No` or `Unsure`.
5. Do not paste team member names, emails, role pages, or screenshots with private account data.

## Step 3: Confirm Team ID Without Exposing Secrets

1. Locate the Team ID intended for StateWatch.
2. Report only a partially redacted value or `Unsure`.
3. Safe example format: `ABCD****XY`.
4. Do not paste full account pages, full team lists, Apple ID emails, or team member personal data.

## Step 4: Confirm Xcode Account/Team Visibility Without Changing Project Settings

1. Open Xcode manually.
2. Go to Xcode Settings > Accounts.
3. Confirm whether the intended Apple Developer team is visible.
4. Report only `Yes`, `No`, or `Unsure`.
5. Do not change project signing settings yet.
6. Do not set `DEVELOPMENT_TEAM`.
7. Do not enable automatic signing changes through Codex.

## Step 5: Confirm Local Signing Identities Without Pasting Certificate Details

1. Check whether an Apple Development signing identity is available locally.
2. Check whether an Apple Distribution signing identity is available locally.
3. Report only `Yes`, `No`, or `Unsure` for each.
4. Do not paste certificate serial numbers, certificate fingerprints, private key details, keychain screenshots, certificate exports, or private key paths.
5. Do not install, create, revoke, import, select, or modify certificates in this Codex phase.

## Step 6: Confirm App IDs For iOS, watchOS, And WidgetKit/Complications

1. In Apple Developer, confirm whether explicit App IDs exist for:
   - `com.easonsusu.StateWatch`
   - `com.easonsusu.StateWatch.watchapp`
   - `com.easonsusu.StateWatch.watchapp.StateWatchComplications`
2. Explicit App IDs should match the bundle IDs configured in Xcode before provisioning or distribution work proceeds.
3. Report only `Yes`, `No`, or `Unsure` for each App ID.
4. Do not create or modify App IDs in this Codex phase.
5. If the user manually creates or modifies App IDs outside Codex later, report that separately in a future evidence phase.

## Step 7: Confirm HealthKit Capability For iOS App ID Only

1. Confirm whether HealthKit is enabled for the iOS App ID `com.easonsusu.StateWatch`, if appropriate.
2. Confirm that HealthKit is not being expanded into write access.
3. Report only `Yes`, `No`, or `Unsure`.
4. Do not enable HealthKit write access.
5. Do not add `NSHealthUpdateUsageDescription`.
6. Do not add HealthKit write permissions.
7. Do not paste raw HealthKit data, personal health data, or health screenshots.

## Step 8: Confirm App Group Exists And Is Attached Correctly

1. Confirm whether App Group `group.com.easonsusu.StateWatch` exists.
2. Confirm whether it is attached to the appropriate iOS, watchOS, and WidgetKit/complications identifiers.
3. Report only `Yes`, `No`, or `Unsure` for App Group existence and attachment.
4. Do not paste provisioning profile UUIDs, profile contents, account pages, or screenshots.
5. This does not authorize Check-in propagation, WidgetKit Check-in display, WatchConnectivity, or HealthKit-derived production rollout.

## Step 9: Confirm Watch App And WidgetKit/Complications Relationships

1. Confirm whether the watch app relationship is recognized for `com.easonsusu.StateWatch.watchapp`.
2. Confirm whether the WidgetKit/complications extension relationship is recognized for `com.easonsusu.StateWatch.watchapp.StateWatchComplications`.
3. Report only `Yes`, `No`, or `Unsure`.
4. Do not add WidgetKit Check-in display, WidgetKit Check-in summary, direct HealthKit reads, live HealthKit timelines, App Group raw Check-in history, or WatchConnectivity.

## Step 10: Confirm Provisioning/Profile Resolution Possibility

1. Confirm whether provisioning profiles are automatically resolvable or available for the intended targets.
2. Report only `Yes`, `No`, or `Unsure`.
3. Do not download provisioning profiles in this phase.
4. Do not commit provisioning profiles.
5. Do not paste provisioning profile contents, full profile UUIDs, certificate details, or device UDIDs.

## Step 11: Confirm App Store Connect Access And App Record

1. Sign in to App Store Connect manually outside Codex.
2. Confirm whether App Store Connect access is available.
3. Confirm whether a StateWatch app record exists for the intended iOS app.
4. Report only `Yes`, `No`, or `Unsure` for each.
5. Do not create builds, upload archives, change metadata, change screenshots, change privacy labels, or edit review notes in this phase.

## Step 12: Confirm Agreements/Compliance Prompts

1. Check whether agreements, compliance, tax, banking, export, or similar prompts appear to block upload.
2. Report `Yes` if prompts or blockers exist.
3. Report `No` if no prompt or blocker is visible.
4. Report `Unsure` if not checked.
5. Do not accept legal agreements through Codex.
6. Do not paste legal, tax, banking, address, phone, account, or personal details.

## Step 13: Confirm TestFlight Availability

1. Confirm whether TestFlight is available for the StateWatch app record.
2. Report only `Yes`, `No`, or `Unsure`.
3. Do not upload builds.
4. Do not create App Store Connect builds.
5. Do not claim TestFlight readiness.

## Step 14: Confirm Real-device QA Hardware Availability

1. Report whether a real Apple Watch will be available later for Watch VoiceOver and tap ergonomics QA.
2. Report whether a real iPhone / Apple Watch HealthKit setup will be available later for real-device HealthKit QA.
3. Report only `Yes`, `No`, or `Unsure`.
4. Do not fabricate real-device QA results.
5. Do not paste device UDIDs, serial numbers, personal health data, or raw HealthKit data.

## What The User Should Report Back

- `Yes`, `No`, or `Unsure` answers in the safe evidence response template.
- A partially redacted Team ID if available.
- Short non-secret notes only when useful.
- Whether future `DEVELOPMENT_TEAM`, certificate/profile, or non-upload archive dry-run authorization is explicitly `Yes` or `No`.

## What The User Must Not Report Back

No Apple ID emails, passwords, 2FA codes, tokens, API keys, private keys, certificate serials, certificate fingerprints, provisioning profile contents, unredacted profile UUIDs, unredacted screenshots, device UDIDs, personal addresses, phone numbers, or raw HealthKit data should be pasted, collected, or committed.

Also avoid:

- Full account pages.
- Team member names or emails.
- Tax, banking, billing, or legal agreement details.
- Private keychain screenshots.
- Certificate exports.
- Provisioning profile files.
- Personal health screenshots.
- App Store Connect user lists.

## Safe Evidence Response Template

```markdown
# Phase 9.44 Manual Setup Evidence Response

## A. Account and signing access

1. Apple Developer Program membership active:
Yes / No / Unsure

2. Role can manage Certificates, Identifiers & Profiles:
Yes / No / Unsure

3. Team ID intended for StateWatch:
[Partially redacted Team ID / Unsure]

4. Xcode Settings > Accounts shows correct team:
Yes / No / Unsure

5. Apple Development signing identity available locally:
Yes / No / Unsure

6. Apple Distribution signing identity available locally:
Yes / No / Unsure

7. I authorize a future phase to set DEVELOPMENT_TEAM after evidence review:
Yes / No

8. I authorize future certificate/profile actions if required:
Yes / No

## B. App IDs, capabilities, and provisioning

9. iOS App ID com.easonsusu.StateWatch exists:
Yes / No / Unsure

10. watchOS App ID com.easonsusu.StateWatch.watchapp exists:
Yes / No / Unsure

11. WidgetKit App ID com.easonsusu.StateWatch.watchapp.StateWatchComplications exists:
Yes / No / Unsure

12. HealthKit enabled for iOS App ID only:
Yes / No / Unsure

13. App Group group.com.easonsusu.StateWatch exists:
Yes / No / Unsure

14. App Group attached to iOS/watchOS/WidgetKit identifiers:
Yes / No / Unsure

15. Watch app and WidgetKit/complications relationships valid:
Yes / No / Unsure

16. Provisioning profiles automatically resolvable or available:
Yes / No / Unsure

17. I authorize future non-upload archive dry-run after blockers are resolved:
Yes / No

## C. App Store Connect and TestFlight

18. App Store Connect access available:
Yes / No / Unsure

19. App Store Connect StateWatch app record exists:
Yes / No / Unsure

20. Agreements/compliance prompts blocking upload:
Yes / No / Unsure

21. TestFlight available for the app record:
Yes / No / Unsure

## D. Real-device QA availability

22. Real Apple Watch available for VoiceOver/tap QA later:
Yes / No / Unsure

23. Real iPhone/Apple Watch HealthKit QA setup available later:
Yes / No / Unsure

## Do not paste or commit

Do not paste Apple ID emails, passwords, 2FA codes, tokens, API keys, private keys, certificate serials, certificate fingerprints, provisioning profile contents, unredacted profile UUIDs, unredacted screenshots, device UDIDs, personal addresses, phone numbers, or raw HealthKit data.
```

## Decision Rules After Manual Setup

- If Section A is mostly Yes and items 7 and 8 are Yes, the recommended next phase may become Phase 9.45: Controlled Signing Re-verification Plan.
- If Section A remains Unsure/No, controlled signing re-verification remains blocked.
- If Section A and B are mostly Yes and item 17 is Yes, archive dry-run planning may be considered after controlled signing re-verification is planned/completed.
- If Section C remains incomplete, TestFlight upload planning remains blocked.
- If Section D remains incomplete, external release-ready and real-device QA completion claims remain blocked.

## Privacy / HealthKit Review

- HealthKit remains read-only.
- No HealthKit write access was added.
- No HealthKit write authorization was added.
- No `NSHealthUpdateUsageDescription` was added.
- No raw HealthKit data or HealthKit samples should be shared as evidence.
- No HealthKit data upload, cloud sync, iCloud sync, analytics, AI cloud analysis, account system, upload path, developer-accessible health database, advertising profile, data mining, or remote config was added.
- Real-device HealthKit QA remains planned, not executed.

## Medical-safety Review

StateWatch remains non-medical wellness/readiness software.

This phase does not add diagnosis, treatment, therapy, emergency, abnormal-state, warning, disease-detection, clinical-stress, medical-grade, or medical-advice claims.

Manual setup evidence should not be used to claim medical readiness or health outcome validation.

## Watch Check-in MVP Review

- Watch Check-in remains Watch-only.
- Watch Check-in remains local-only.
- Check-ins do not affect State Score.
- No iPhone Check-in UI, history, deletion, or management was added.
- No WidgetKit Check-in display, summary, or direct read was added.
- No App Group raw Check-in history was added.
- No App Group Check-in propagation was added.
- No WatchConnectivity was added.
- No reminders, notifications, trends, streaks, notes, exports, pattern summaries, or State Score integration were added.

## Prohibited Claims

Do not claim any of the following based on this phase:

- Apple Developer configured.
- App Store Connect configured.
- Signing fixed.
- Signing verified.
- `DEVELOPMENT_TEAM` fixed.
- Certificates installed.
- Provisioning profiles created.
- Bundle IDs verified.
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

The following claims are supported by this phase:

- Manual setup instructions documented.
- User-facing non-secret evidence response template documented.
- Current conservative evidence remains insufficient until the user reports updated answers.
- Codex did not change Apple Developer, App Store Connect, Xcode signing, certificates, profiles, bundle IDs, capabilities, entitlements, plists, archives, uploads, or App Store metadata.
- Controlled signing re-verification remains blocked.
- Signing remediation remains blocked.
- Archive dry-run planning remains blocked.
- TestFlight upload planning remains blocked.
- HealthKit remains read-only.
- StateWatch remains non-medical wellness/readiness software.
- Watch Check-in remains Watch-only and local-only.

## Risks / Limitations

- Apple Developer and App Store Connect UI may change, so users should treat these as cautious manual instructions rather than exact UI guarantees.
- Evidence remains user-reported until a future phase verifies it.
- The current conservative evidence result remains insufficient.
- Required authorizations remain No until the user explicitly changes them in a future evidence response.
- Controlled signing re-verification, signing remediation, archive dry-run planning, TestFlight upload planning, external release-ready claims, real-device Watch QA claims, and real-device HealthKit QA claims remain blocked.

## Recommended Next Phase

If the user reports mostly Yes for Section A and explicitly changes items 7 and 8 to Yes, the recommended next phase may become Phase 9.45: Controlled Signing Re-verification Plan.

If Section A remains Unsure/No or authorizations remain No, Phase 9.45 should remain documentation-only follow-up or evidence clarification, not controlled signing execution.

## Changes Made

- Added this Phase 9.44 manual setup instruction document.
- Added Phase 9.44 checklist entries to `TEST_PLAN.md`.

## Final Phase 9.44 Checklist

- Phase 9.44 Apple Developer manual setup instructions document exists.
- The document is manual setup instruction documentation only.
- Phase 9.23 through Phase 9.43 were used as input.
- Conservative Phase 9.43 result is carried forward.
- Manual user instructions are documented.
- Safe evidence response template is documented.
- Secret handling instructions are documented.
- Decision rules after manual setup are documented.
- Controlled signing re-verification remains blocked.
- Signing remediation remains blocked.
- Archive dry-run planning remains blocked.
- TestFlight upload planning remains blocked.
- External release-readiness claims remain blocked.
- No Apple Developer configuration was performed by Codex.
- No App Store Connect configuration was performed by Codex.
- No signing configuration was changed.
- No controlled signing re-verification was performed.
- No `DEVELOPMENT_TEAM` was set.
- No certificates were installed, revoked, created, or modified.
- No provisioning profiles were created, downloaded, selected, or modified.
- No bundle identifiers were created or modified.
- No capabilities were enabled or disabled.
- No xcodebuild archive was run.
- No xcodebuild `-allowProvisioningUpdates` was run.
- No Xcode archive was performed.
- No `.xcarchive` was created.
- No `.ipa` was exported.
- No TestFlight upload was performed.
- No App Store Connect release work was performed.
- No App Store metadata was changed.
- No secrets/certificates/private keys/provisioning profiles/tokens/account emails/device UDIDs/personal addresses/phone numbers/raw HealthKit data were committed.
- No broad release-ready claim is made.
- No App Store approval or external submission-readiness claim is made.
- Phase 9.22 remains deferred/blocked, not completed.
- Real-device Watch VoiceOver QA remains unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 validation remains non-real-device validation only.
- HealthKit remains read-only.
- No HealthKit write access or write authorization was added.
- No diagnosis, treatment, therapy, emergency, abnormal-state, warning, disease-detection, clinical-stress, medical-grade, or medical-advice claim is made.
- Watch Check-in remains Watch-only.
- Watch Check-in remains local-only.
- Check-ins do not affect State Score.
- No iPhone Check-in UI/history/deletion/management added.
- No WidgetKit Check-in display/summary/direct read added.
- No App Group raw Check-in history/propagation/display preference propagation added.
- No WatchConnectivity added.
- No State Score integration added.
- No networking/cloud/iCloud/analytics/AI/account/login/upload path/remote config added.
- No Swift files changed.
- No Xcode project files changed.
- No entitlements changed.
- No plist files changed.
- No CI workflows changed.
- No product behavior changed.
- Recommended next phase is defined.
- Local validation commands pass.
- GitHub Actions status is reviewed.
- No Phase 9.45 work started.
