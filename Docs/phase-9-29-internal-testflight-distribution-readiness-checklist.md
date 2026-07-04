# Phase 9.29 Internal TestFlight Distribution Readiness Checklist

## Purpose

This is an internal TestFlight distribution readiness checklist, not a TestFlight upload, App Store Connect release action, App Store submission, or release-ready claim.

Phase 9.29 uses the Phase 9.28 known limitations and release-note guidance to
define whether an internal TestFlight distribution may be prepared with explicit
limitations for the current StateWatch / Watch Check-in MVP state.

Internal TestFlight distribution may be prepared only with explicit limitations.

No TestFlight upload, App Store Connect release work, App Store approval, App Store submission-readiness, or broad release-ready claim is made by this phase.

## Scope

In scope:

- Document the internal TestFlight distribution readiness decision.
- Define required pre-distribution checklist items.
- Provide templates for build/version records, internal tester groups, internal
  release notes, and known limitation disclosure.
- Identify App Store Connect and TestFlight upload items to verify later.
- Carry forward privacy, HealthKit, Watch Check-in, and medical-safety
  limitations from prior phases.
- Add a matching Phase 9.29 checklist to `TEST_PLAN.md`.

Out of scope:

- TestFlight upload.
- TestFlight execution report.
- App Store Connect release action.
- App Store metadata, screenshots, bundle identifiers, signing, provisioning,
  or release automation changes.
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
- Phase 9.30 work.

## Current Baseline

- Phase 9.28 was merged through PR #75.
- Baseline commit at the start of this phase:
  `6966786fe6ea7b2fb077cced2c58afe644838d4b`.
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
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 validation was non-real-device validation only and does not replace real Apple Watch QA or real-device HealthKit QA.
- Phase 9.28 created known-limitations and release-note guidance only.
- Internal TestFlight planning may continue only with explicit limitations.
- Broad external release-readiness, App Store approval, and App Store
  submission readiness are not claimed.

## Relationship To Phase 9.23 Through Phase 9.28

Phase 9.23 records release blockers and deferred blockers, including unresolved
real-device Watch VoiceOver QA, physical Apple Watch tap ergonomics, and real
Watch spoken cadence / focus order.

Phase 9.24 allows Watch Check-in MVP to proceed only to internal TestFlight
planning with explicit limitations and blocks broad release-ready claims unless
real-device QA is completed or limitations are explicit.

Phase 9.25 defines the internal TestFlight QA planning checklist. It does not
upload a build, execute TestFlight, or claim real-device QA passed.

Phase 9.26 audits App Store, privacy, HealthKit, and medical-safety boundaries.
It does not submit to App Store Review and does not claim App Store approval or
external submission readiness.

Phase 9.27 records non-real-device validation only. It reports simulator
build/test results while preserving unresolved real Apple Watch and
real-device HealthKit limitations.

Phase 9.28 translates those limitations into release-note and known-limitation
guidance. It is not a TestFlight upload, App Store submission, or release-ready
claim.

Phase 9.29 converts that guidance into a readiness checklist for preparing a
future internal TestFlight distribution with explicit limitations.

## Explicit Limitations Carried Forward

- Phase 9.22 remains deferred/blocked, not completed.
- Real-device Watch Check-in VoiceOver QA remains unresolved.
- Physical Apple Watch small-screen tap ergonomics remain unresolved.
- Real Watch VoiceOver spoken cadence and focus order remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 completed only non-real-device validation.
- Non-real-device validation does not replace real-device Watch QA or
  real-device HealthKit QA.
- Phase 9.28 created known-limitations and release-note guidance only.
- Broad Watch Check-in release-ready claims remain blocked.
- External App Store submission readiness is not claimed.
- Internal TestFlight distribution may be prepared only with explicit
  limitations.

## Files Reviewed

The following requested references were present and reviewed or source-checked
at the readiness level:

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
- `TEST_PLAN.md`
- `PRD.md`
- `PRIVACY_POLICY_DRAFT.md`
- `APP_STORE_CHECKLIST.md`
- `Docs/medical-safety-wording.md`
- `Docs/ui-copy-guidelines.md`
- `README.md`
- `StateWatchApp/Models/StateCheckInOption.swift`
- `StateWatchWatchApp/Features/WatchCheckInView.swift`
- `StateWatchWatchApp/Features/WatchDashboardView.swift`
- `StateWatchWatchApp/Services/CheckIn/StateCheckInRecord.swift`
- `StateWatchWatchApp/Services/CheckIn/LocalStateCheckInStore.swift`
- `StateWatchWatchApp/Services/CheckIn/StateCheckInDisplayPreference.swift`
- `StateWatchTests/StateWatchThemeTests.swift`
- `StateWatchTests/StateCheckInStorageTests.swift`
- `StateWatch.xcodeproj/project.pbxproj`

No requested reference was found missing.

## Search Terms Used

Pre-change searches covered:

- TestFlight, distribution, internal distribution, internal testing, internal
  tester, build number, build version, archive, upload, App Store Connect,
  release notes, known limitation, release-ready, App Store ready, approval,
  real-device, real device, VoiceOver, HealthKit QA, and Phase 9.22 through
  Phase 9.29.
- Watch Check-in, State Check-in, check-in, latest-three, latest five,
  clear-all, Icon + Text, Icon Only, Text Only, Energized, Stable, Tired, Low,
  有活力, 穩定, 疲累, 低狀態, self-reported, local Watch, local-only,
  Watch-only, single-record, and delete.
- iPhone Check-in, WidgetKit Check-in, check-in display, check-in summary,
  App Group raw, App Group Check-in, WatchConnectivity, WCSession, State Score
  integration, HealthKit write, HKHealthStore.save, requestAuthorization(toShare,
  and toShare.
- URLSession, cloud, iCloud, analytics, remote config, AI cloud, account,
  login, sign in, upload path, developer database, sync, and network.
- Diagnosis, clinical, medical advice, treatment, therapy, emergency, warning,
  abnormal, health risk, anxiety, depression, disease, detected, caused by,
  because you, symptom history, medical record, score dropped, low because, bad
  health, doctor, physician, care provider, regulatory, FDA, and clearance.

Matches were reviewed as existing source, tests, guardrails, forbidden-copy
examples, release-note guidance, limitation language, release blocker language,
or clearly marked fail criteria. No product behavior change was added in this
phase.

## Readiness Labels

- Ready with explicit limitations
- Must complete before distribution
- Deferred pending hardware
- Future external-release blocker
- Non-blocking follow-up
- Not applicable to current internal distribution

## Distribution Readiness Summary Table

| ID | Readiness item | Label | Current status | Required before internal distribution | Safe wording | Follow-up |
| --- | --- | --- | --- | --- | --- | --- |
| RDY-001 | Internal TestFlight distribution preparation | Ready with explicit limitations | May be prepared only if limitations are disclosed. | Confirm limitation-aware notes, tester scope, build metadata, and no broad release-ready claim. | "Internal QA candidate with explicit limitations." | Use this checklist before any upload phase. |
| RDY-002 | TestFlight upload | Must complete before distribution | Not performed in this phase. | Separate explicit phase or instruction to archive and upload. | "Upload is not performed by Phase 9.29." | Plan in Phase 9.30 before any execution. |
| RDY-003 | App Store Connect configuration | Must complete before distribution | Not performed in this phase. | Verify app record, bundle IDs, build metadata, TestFlight group, compliance prompts, and reviewer notes separately. | "App Store Connect setup must be verified later." | Include in Phase 9.30 build preparation plan. |
| RDY-004 | Build number and version record | Must complete before distribution | Template added by this phase. | Record build number, version, branch, commit hash, date, and tester group. | "Distribution record is required before upload." | Fill template in future upload phase. |
| RDY-005 | Internal tester release notes | Must complete before distribution | Safe template added by this phase. | Use Phase 9.28 limitation-aware wording. | "Internal build prepared for limited QA with known limitations." | Review copy before upload. |
| RDY-006 | Known limitations disclosure | Must complete before distribution | Template added by this phase. | Disclose unresolved real-device Watch VoiceOver, physical tap ergonomics, and real-device HealthKit QA. | "Real-device Watch VoiceOver and real-device HealthKit QA remain pending." | Keep disclosure in tester notes. |
| RDY-007 | Phase 9.27 validation | Ready with explicit limitations | Non-real-device validation passed in recorded environment. | Cite only as simulator/non-real-device validation. | "Simulator build/test validation passed for the recorded Phase 9.27 environment." | Do not convert to real-device certification. |
| RDY-008 | Real-device Watch VoiceOver QA | Deferred pending hardware | Unresolved. | Not required for limited internal distribution if disclosed; required before pass claims. | "Real-device Watch VoiceOver QA remains pending." | Execute Phase 9.20 / Phase 9.22 on real Watch hardware. |
| RDY-009 | Physical Apple Watch tap ergonomics | Deferred pending hardware | Unresolved. | Not required for limited internal distribution if disclosed; required before physical ergonomics claims. | "Physical Apple Watch tap ergonomics remain pending." | Test on real hardware. |
| RDY-010 | Real-device HealthKit QA | Future external-release blocker | Planned, not executed. | Not required for Watch-only Check-in internal distribution if disclosed; required before HealthKit production claims. | "Real-device HealthKit QA remains pending." | Execute real-device HealthKit QA before production HealthKit release claims. |
| RDY-011 | HealthKit write access | Ready with explicit limitations | HealthKit remains read-only. | Confirm no write access or write authorization is introduced. | "HealthKit remains read-only." | Keep write access out of scope. |
| RDY-012 | Privacy / local-first claims | Ready with explicit limitations | Local-first boundaries remain guarded. | Confirm wording matches actual behavior and avoids cloud, account, upload, analytics, and AI cloud claims. | "StateWatch remains local-first for this MVP." | Recheck before any metadata or upload phase. |
| RDY-013 | Medical-safety framing | Ready with explicit limitations | Non-medical wellness/readiness framing remains guarded. | Keep copy non-diagnostic and non-treatment-oriented. | "StateWatch remains non-medical wellness/readiness software." | Review all future release copy. |
| RDY-014 | Watch Check-in MVP scope | Ready with explicit limitations | Watch-only, local-only, latest-three, single-record deletion only. | Keep release notes scoped to implemented behavior. | "Watch Check-in MVP is Watch-only and local-only." | Preserve scope in tester notes. |
| RDY-015 | iPhone Check-in | Not applicable to current internal distribution | Not included. | Do not present as supported. | "iPhone Check-in is not included in this MVP." | Design separately if needed. |
| RDY-016 | WidgetKit Check-in | Not applicable to current internal distribution | Not included. | Do not present as supported. | "WidgetKit Check-in display is not included." | Design separately if needed. |
| RDY-017 | App Group Check-in propagation | Not applicable to current internal distribution | Not included. | Do not present as supported. | "Check-in history is not propagated through App Group." | Privacy-review before any future propagation. |
| RDY-018 | WatchConnectivity | Not applicable to current internal distribution | Not included. | Do not present as supported. | "WatchConnectivity sync is not included." | Design separately if needed. |
| RDY-019 | State Score integration | Not applicable to current internal distribution | Not included. | Confirm Check-ins do not affect State Score, readiness, confidence, reasons, or suggestions. | "Check-ins are separate from State Score." | Design separately before any integration. |
| RDY-020 | Old iPhone `CheckInView` scaffold | Non-blocking follow-up | Existing scaffold is not a user-facing release item. | Do not mention as user-facing; leave untouched in this phase. | "Not a current internal distribution feature." | Review separately. |
| RDY-021 | `StateWatchThemeTests.swift` size | Non-blocking follow-up | Internal test refactor follow-up only. | No distribution blocker. | "Internal test refactor follow-up." | Split in later test refactor if useful. |

## Internal TestFlight Distribution Decision

Decision: internal TestFlight distribution may be prepared with explicit limitations.

This decision means a future phase may prepare build/archive/upload steps and
internal tester notes. It does not mean this phase uploaded to TestFlight,
configured App Store Connect, executed internal TestFlight QA, cleared
hardware-dependent QA, or made a broad release-ready claim.

Conditions for preparation:

- Release notes must use Phase 9.28 limitation-aware wording.
- Known limitations must be visible to internal testers.
- Build metadata must be recorded before upload.
- Real-device Watch VoiceOver and physical tap ergonomics must remain marked
  pending unless actually tested.
- Real-device HealthKit QA must remain marked pending unless actually tested.
- Watch Check-in must remain described as Watch-only, local-only, latest-three,
  and separate from State Score.

## Required Pre-distribution Checklist

Before any future internal TestFlight upload, confirm:

- Build number, version, branch, commit hash, date, and tester group are
  recorded.
- App Store Connect app record and bundle identifiers are verified.
- Xcode archive/signing/provisioning requirements are verified.
- Internal tester group and tester scope are defined.
- Internal release notes use the template in this document or equivalent safe
  wording.
- Known limitations disclosure is included.
- HealthKit remains read-only.
- No raw HealthKit upload or developer-accessible health database is introduced.
- No diagnosis, treatment, therapy, emergency, abnormal-state, warning,
  disease-detection, clinical-stress, or medical-advice claim is included.
- No iPhone Check-in, WidgetKit Check-in, App Group Check-in propagation,
  WatchConnectivity, State Score integration, networking, cloud, analytics, AI,
  account system, or remote config is claimed.

## Build And Version Record Template

| Field | Value |
| --- | --- |
| Internal distribution session ID |  |
| Date |  |
| Prepared by |  |
| App version |  |
| Build number |  |
| Branch |  |
| Commit hash |  |
| Xcode version |  |
| iOS deployment target |  |
| watchOS deployment target |  |
| Archive path or Xcode organizer reference |  |
| Signing team |  |
| Provisioning status |  |
| App Store Connect app record verified | Yes / No |
| Internal tester group |  |
| Release notes reviewed | Yes / No |
| Known limitations included | Yes / No |
| Real-device Watch VoiceOver QA status | Pending / Complete with evidence |
| Physical Apple Watch tap ergonomics status | Pending / Complete with evidence |
| Real-device HealthKit QA status | Pending / Complete with evidence |
| Notes |  |

## Internal Tester Group Template

| Field | Value |
| --- | --- |
| Tester group name |  |
| Tester purpose |  |
| Number of testers |  |
| Required iPhone hardware |  |
| Required Apple Watch hardware |  |
| Required watchOS version |  |
| Required iOS version |  |
| VoiceOver testers included | Yes / No |
| Real HealthKit data testers included | Yes / No |
| TestFlight invitation notes reviewed | Yes / No |
| Privacy reminder included | Yes / No |
| Medical-safety reminder included | Yes / No |
| Known limitations acknowledged | Yes / No |

## Internal Release Notes Template

```text
StateWatch internal QA build for limited testing.

This build includes the Watch-only, local-only Watch Check-in MVP. Check-ins are subjective, stored locally on Apple Watch, show the latest three local entries, and do not provide medical advice.

Known limitations:
- Real-device Watch VoiceOver QA remains pending.
- Physical Apple Watch tap ergonomics remain pending.
- Real-device HealthKit QA remains pending.
- Phase 9.27 validation was simulator/non-real-device validation only.
- Check-ins do not sync to iPhone, WidgetKit, App Group, cloud, or WatchConnectivity.
- Check-ins do not affect State Score, readiness, confidence, reasons, or suggestions.
```

## Known Limitations Disclosure Template

```text
Known limitations for this internal QA build:

- This is an internal QA candidate with explicit limitations.
- Phase 9.22 remains deferred/blocked, not completed.
- Real-device Watch VoiceOver QA remains unresolved.
- Physical Apple Watch tap ergonomics remain unresolved.
- Real Watch VoiceOver spoken cadence and focus order remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 validation was non-real-device validation only.
- Watch Check-in is Watch-only and local-only.
- Check-ins do not sync to iPhone, WidgetKit, App Group, cloud, or WatchConnectivity.
- Check-ins do not affect State Score.
- StateWatch is non-medical wellness/readiness software and does not provide medical advice.
```

## App Store Connect Items To Verify Later

Future App Store Connect work must verify:

- App record exists and matches the intended bundle IDs.
- iOS app, watchOS app, and WidgetKit extension identifiers are correct.
- Signing team and provisioning profiles are valid.
- Export compliance, content rights, privacy questions, and TestFlight
  compliance prompts are answered accurately.
- Internal tester group exists and contains only intended testers.
- Release notes match current behavior and explicit limitations.
- App Review Notes do not overclaim real-device QA, HealthKit behavior, or
  release readiness.

None of those items were changed or completed in this phase.

## TestFlight Upload Items To Verify Later

Future TestFlight upload work must verify:

- Xcode archive succeeds for the intended scheme and configuration.
- Build number is incremented and recorded.
- Version number is recorded.
- Upload target and team are correct.
- TestFlight processing status is recorded.
- Internal tester group is assigned intentionally.
- Internal release notes and known limitations are included.
- No failed validation is marked passed.

No upload was performed in this phase.

## Privacy / HealthKit Readiness Review

Current readiness: ready with explicit limitations.

HealthKit remains read-only. This phase does not add HealthKit write access,
write authorization, raw HealthKit upload, developer-accessible health
database, networking, cloud sync, iCloud sync, analytics, AI cloud analysis,
account systems, login, upload paths, or remote config.

Internal distribution notes must not imply that real-device HealthKit QA has
been completed. Any HealthKit-backed production rollout, App Group propagation,
WidgetKit display, or Watch app integration remains outside this phase.

## Medical-safety Readiness Review

Current readiness: ready with explicit limitations.

StateWatch remains non-medical wellness/readiness software. Internal
distribution copy must not claim diagnosis, clinical stress detection,
treatment, therapy, emergency handling, abnormal-state detection,
disease-detection, medical advice, medical-grade accuracy, or clinical decision
support.

`Low` remains a subjective self-report. It is not a medical warning, health
risk, score penalty, diagnosis, or instruction to seek treatment.

## Watch Check-in MVP Readiness Review

Current readiness: ready with explicit limitations.

Watch Check-in may be described as:

- Watch-only.
- Local-only.
- Subjective.
- Latest-three recent history.
- Single-record local deletion.
- Separate from State Score.
- Non-medical.

Watch Check-in must not be described as:

- Available on iPhone.
- Synced to WidgetKit, App Group, cloud, or WatchConnectivity.
- Connected to State Score, readiness, confidence, reasons, or suggestions.
- A symptom tracker, health risk detector, clinical stress detector, or
  medical advice feature.

## Items Not Included In Current MVP

- iPhone Check-in UI, history, deletion, or management.
- WidgetKit Check-in display, summary, or direct Check-in reads.
- App Group raw Check-in history, Check-in propagation, or display preference
  propagation.
- WatchConnectivity / WCSession sync.
- State Score integration.
- HealthKit write access.
- Cloud sync, iCloud sync, analytics, AI cloud analysis, account systems,
  login, upload paths, or remote config.
- Latest-five history, clear-all UI, long-term history, notes, export,
  reminders, notifications, scheduling, trends, streaks, counts, causes,
  interpretations, pattern summaries, or insights.

## Prohibited Internal Distribution Claims

Do not use these claims in internal distribution notes:

- Release ready.
- App Store ready.
- Approved for external release.
- Fully validated on Apple Watch.
- VoiceOver verified on real Apple Watch.
- HealthKit QA complete on real devices.
- Medical-grade.
- Diagnoses stress, anxiety, depression, disease, or illness.
- Warns about abnormal state.
- Low means bad health.
- Check-ins change your score.
- Syncs Check-ins to iPhone, widgets, App Group, cloud, or WatchConnectivity.

## Allowed Internal Distribution Claims

Allowed claims:

- Internal QA candidate with explicit limitations.
- Simulator build/test validation passed for the recorded Phase 9.27
  environment.
- Watch Check-in MVP is Watch-only and local-only.
- Real-device Watch VoiceOver and real-device HealthKit QA remain pending.
- HealthKit remains read-only.
- StateWatch remains non-medical wellness/readiness software.

## Work That May Continue

- Phase 9.30 build preparation planning.
- Internal release-note review.
- Internal tester group planning.
- App Store Connect item checklist planning.
- Real-device Watch QA planning.
- Real-device HealthKit QA planning.
- Documentation-only release-readiness planning with explicit limitations.

## Work That Must Wait

- TestFlight upload unless explicitly requested in a separate phase.
- App Store Connect release work.
- App Store metadata changes.
- Broad release-ready claims.
- App Store approval or external submission-readiness claims.
- Real-device Watch VoiceOver pass claims.
- Physical Apple Watch ergonomics pass claims.
- Real-device HealthKit QA completion claims.
- Check-in propagation to iPhone, WidgetKit, App Group, cloud, or
  WatchConnectivity.
- Check-in integration into State Score.

## Non-blocking Follow-ups

- Split `StateWatchThemeTests.swift` in a later test refactor phase.
- Revisit the old iPhone `CheckInView` scaffold in a separate iPhone Check-in
  design or cleanup phase.
- Continue refining internal release-note and App Review language as future QA
  results arrive.

## Risks / Limitations

- This phase is documentation-only.
- It does not upload to TestFlight.
- It does not configure App Store Connect.
- It does not create an archive, change signing, or change provisioning.
- It does not execute internal TestFlight QA.
- It does not clear Phase 9.22.
- It does not prove real-device Watch accessibility, tap ergonomics, or
  HealthKit behavior.
- It does not update App Store metadata.

## Recommended Next Phase

Phase 9.30: Internal TestFlight Build Preparation Plan.

Phase 9.30 should:

- Use this Phase 9.29 distribution readiness checklist as input.
- Prepare a build/archive/upload preparation plan without actually uploading
  unless explicitly requested.
- Define required Xcode archive, signing, bundle, build number, App Store
  Connect, and TestFlight metadata checks.
- Preserve unresolved real-device Watch VoiceOver and real-device HealthKit QA
  limitations.
- Avoid broad release-ready language unless limitations are explicit.
- Remain documentation-only unless a separate implementation or upload phase is
  explicitly opened.

## Changes Made

- Added this Phase 9.29 internal TestFlight distribution readiness checklist.
- Added a matching Phase 9.29 checklist to `TEST_PLAN.md`.
- No Swift files, Xcode project files, entitlement files, CI workflows, App
  Store metadata, TestFlight uploads, App Store Connect release work, or product
  behavior were changed.

## Final Phase 9.29 Checklist

- Phase 9.29 internal TestFlight distribution readiness checklist document
  exists.
- The document is readiness checklist only, not TestFlight upload or App Store
  Connect release action.
- Phase 9.23 through Phase 9.28 were used as input.
- Explicit limitations are carried forward.
- Phase 9.22 remains deferred/blocked, not completed.
- Real-device Watch Check-in VoiceOver QA remains unresolved.
- Physical Apple Watch tap ergonomics remains unresolved.
- Real Watch VoiceOver spoken cadence and focus order remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 validation is described as non-real-device validation only.
- Non-real-device validation is not treated as real-device QA.
- Internal TestFlight distribution may be prepared only with explicit
  limitations.
- No TestFlight upload was performed.
- No App Store Connect release work was performed.
- No App Store metadata was changed.
- No broad release-ready claim is made.
- No App Store approval or external submission-readiness claim is made.
- Build and version record template is documented.
- Internal tester group template is documented.
- Internal release notes template is documented.
- Known limitations disclosure template is documented.
- App Store Connect items to verify later are documented.
- TestFlight upload items to verify later are documented.
- Privacy / HealthKit readiness review is documented.
- Medical-safety readiness review is documented.
- Watch Check-in MVP readiness review is documented.
- Items not included in current MVP are documented.
- Prohibited internal distribution claims are documented.
- Allowed internal distribution claims are documented.
- Work that may continue is documented.
- Work that must wait is documented.
- Non-blocking follow-ups are documented.
- No real-device QA result was fabricated.
- HealthKit remains read-only.
- No HealthKit write access or write authorization was added.
- No raw HealthKit upload or developer-accessible health database is
  introduced.
- No diagnosis, treatment, therapy, emergency, abnormal-state, warning,
  disease-detection, clinical-stress, or medical-advice claim is made.
- `Low` remains subjective, non-medical, non-warning, and non-score-lowering.
- Missing Check-ins and missing HealthKit data remain neutral.
- Check-ins do not affect State Score.
- No Swift files changed.
- No Xcode project files changed.
- No entitlements changed.
- No CI workflows changed.
- No product behavior changed.
- Watch Check-in remains Watch-only.
- Watch Check-in remains local-only.
- Four states remain `Energized`, `Stable`, `Tired`, and `Low`.
- Traditional Chinese reference labels remain `有活力`, `穩定`, `疲累`, and
  `低狀態`.
- Display modes remain `Icon + Text`, `Icon Only`, and `Text Only`.
- Default display remains `Icon + Text`.
- Latest-three recent history remains unchanged.
- No latest-five history added.
- No clear-all UI added.
- No long-term history added.
- No notes, export, reminders, notifications, trends, streaks, counts, causes,
  interpretations, pattern summaries, or insights added.
- No iPhone Check-in UI, history, deletion, or management added.
- Old iPhone `CheckInView` scaffold was not addressed.
- No WidgetKit Check-in display, summary, or direct read added.
- No App Group raw Check-in history, propagation, or display preference
  propagation added.
- No WatchConnectivity added.
- No State Score integration added.
- No networking, cloud sync, iCloud sync, analytics, AI, account system, login,
  upload path, or remote config added.
- Recommended next phase is Phase 9.30: Internal TestFlight Build Preparation
  Plan.
- Local validation commands are expected for this docs-only phase.
- GitHub Actions should be reviewed after PR creation without manually
  rerunning Actions as a debugging loop.
- No Phase 9.30 work started.
