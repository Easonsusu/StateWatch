# Phase 9.30 Internal TestFlight Build Preparation Plan

## Purpose

This is an internal TestFlight build preparation plan, not an Xcode archive, TestFlight upload, App Store Connect release action, App Store submission, or release-ready claim.

Phase 9.30 uses the Phase 9.29 internal TestFlight distribution readiness
checklist to define the exact checks required before any future internal
TestFlight archive or upload phase for the current StateWatch / Watch Check-in
MVP state.

Internal TestFlight build preparation may continue only with explicit limitations.

No archive, TestFlight upload, App Store Connect release work, App Store approval, App Store submission-readiness, or broad release-ready claim is made by this phase.

## Scope

In scope:

- Document the internal TestFlight build preparation decision.
- Define required checks before a future archive phase.
- Define required checks before a future TestFlight upload phase.
- Provide templates for archive environment, scheme, target, bundle identifier,
  signing, provisioning, entitlements, build number, version, App Store Connect,
  internal tester, release-note, and known-limitation records.
- Carry forward privacy, HealthKit, Watch Check-in, accessibility, and
  medical-safety limitations from prior phases.
- Add a matching Phase 9.30 checklist to `TEST_PLAN.md`.

Out of scope:

- Xcode archive execution.
- TestFlight upload.
- TestFlight execution report.
- App Store Connect release action.
- App Store metadata, screenshots, bundle identifiers, signing settings,
  provisioning profiles, certificates, or release automation changes.
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
- Phase 9.31 work.

## Current Baseline

- Phase 9.29 was merged through PR #76.
- Baseline commit at the start of this phase:
  `cb5752fe8968ef9187eabe0b670516aee5c9f233`.
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
- Physical Apple Watch small-screen tap ergonomics remain unresolved.
- Real Watch VoiceOver spoken cadence and focus order remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 validation was non-real-device validation only and does not replace real Apple Watch QA or real-device HealthKit QA.
- Phase 9.28 created known-limitations and release-note guidance only.
- Phase 9.29 created an internal TestFlight distribution readiness checklist
  only.
- Broad Watch Check-in release-ready claims remain blocked.
- External App Store submission readiness is not claimed.

## Relationship To Phase 9.23 Through Phase 9.29

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

Phase 9.30 converts the distribution checklist into a build-preparation plan
for a future archive/upload phase. It does not perform the archive or upload.

## Explicit Limitations Carried Forward

- Phase 9.22 remains deferred/blocked, not completed.
- Real-device Watch Check-in VoiceOver QA remains unresolved.
- Physical Apple Watch small-screen tap ergonomics remain unresolved.
- Real Watch VoiceOver spoken cadence and focus order remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 completed only non-real-device validation.
- Non-real-device validation does not replace real Apple Watch QA or
  real-device HealthKit QA.
- Phase 9.28 created known-limitations and release-note guidance only.
- Phase 9.29 created an internal TestFlight distribution readiness checklist
  only.
- Broad Watch Check-in release-ready claims remain blocked.
- External App Store submission readiness is not claimed.
- Internal TestFlight preparation may continue only with explicit limitations.

## Files Reviewed

The following requested references were present and reviewed or source-checked
at the build-preparation level:

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

- Archive, xcodebuild archive, TestFlight, TestFlight upload, uploaded to
  TestFlight, App Store Connect, build number, version number, marketing
  version, bundle identifier, bundle ID, signing, provisioning, certificate,
  distribution profile, exportOptions, App Store ready, release ready,
  approval, real-device, real device, VoiceOver, HealthKit QA, and Phase 9.22
  through Phase 9.30.
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
examples, release-note guidance, limitation language, build-preparation
guidance, release blocker language, or clearly marked fail criteria. No product
behavior change was added in this phase.

## Preparation Labels

- Ready to plan
- Must verify before archive
- Must verify before upload
- Deferred pending hardware
- Future external-release blocker
- Not applicable to current MVP
- Non-blocking follow-up

## Build Preparation Summary Table

| ID | Preparation item | Label | Current status | Required before archive/upload | Safe wording | Follow-up |
| --- | --- | --- | --- | --- | --- | --- |
| BP-001 | Build preparation planning | Ready to plan | Planning may continue with explicit limitations. | Keep this as a planning artifact only. | "Internal TestFlight build preparation plan with explicit limitations." | Use this plan as input to Phase 9.31. |
| BP-002 | Xcode archive execution | Must verify before archive | Not performed in this phase. | Separate explicit archive phase or instruction. | "Archive execution was not performed in Phase 9.30." | Verify archive command and environment later. |
| BP-003 | Xcode version and environment | Must verify before archive | Phase 9.27 recorded Xcode 26.6, build 17F113 for non-real-device validation. | Future archive phase must record Xcode version, macOS version if available, selected scheme, signing identity, and destination. | "Archive environment must be recorded before archive." | Inventory in Phase 9.31. |
| BP-004 | Scheme selection | Must verify before archive | Schemes exist for StateWatch, StateWatchWatchApp, and StateWatchComplications. | Future archive phase must verify whether the correct archive scheme is StateWatch, StateWatchWatchApp, or an iOS app scheme embedding the Watch app. | "Archive scheme remains to be verified." | Inspect schemes before archive. |
| BP-005 | Bundle identifiers | Must verify before archive | Not changed in this phase. | Future archive phase must verify iOS app, watch app, extension, widget, and complication bundle identifiers. | "Bundle identifiers must be verified before archive." | Record identifiers in Phase 9.31. |
| BP-006 | Signing and provisioning | Must verify before archive | Not changed in this phase. | Future archive phase must verify Apple Developer team, signing mode, certificates, provisioning profiles, and required capabilities. | "Signing and provisioning must be verified before archive." | Inventory signing settings later. |
| BP-007 | Entitlements and capabilities | Must verify before archive | Not changed in this phase. | Future archive phase must verify HealthKit, App Groups if applicable, WidgetKit/complications, Watch app, and any existing entitlements without adding new ones. | "Capabilities must match implemented behavior." | Review entitlements later. |
| BP-008 | Build number / version | Must verify before archive | Not changed in this phase. | Future phase must record marketing version, build number, branch, commit hash, date/time, and release candidate label. | "Version and build record required before archive." | Fill template before archive. |
| BP-009 | Privacy / HealthKit declarations | Must verify before upload | Draft privacy stance exists; App Store Connect answers not changed. | App Store Connect privacy answers must match actual local-first/read-only behavior. | "Privacy answers must match read-only local HealthKit behavior." | Verify before upload. |
| BP-010 | Export method / upload path | Must verify before upload | Not selected in this phase. | Future phase must define whether upload uses Xcode Organizer, Transporter, or other approved Apple tooling. | "Upload path must be chosen later." | Decide in upload phase. |
| BP-011 | TestFlight upload execution | Must verify before upload | Not performed in this phase. | Upload requires a separate explicit phase or instruction. | "TestFlight upload was not performed." | Do not upload without a future instruction. |
| BP-012 | App Store Connect app record | Must verify before upload | Not changed in this phase. | Future phase must verify app record, SKU/bundle linkage, platform targets, compliance prompts, encryption/export compliance, and tester groups. | "App Store Connect record must be verified later." | Verify before upload. |
| BP-013 | Internal tester groups | Must verify before upload | Template direction exists from Phase 9.29. | Future phase must define internal tester group, tester scope, and limitation disclosure. | "Internal tester scope must include known limitations." | Fill tester group template. |
| BP-014 | Internal release notes | Must verify before upload | Limitation-aware guidance exists from Phase 9.28 and Phase 9.29. | Must use Phase 9.28 / Phase 9.29 limitation-aware wording. | "Internal notes must disclose pending real-device QA." | Review before upload. |
| BP-015 | Known limitations disclosure | Must verify before upload | Existing limitations carried forward. | Must disclose unresolved real-device Watch VoiceOver, physical tap ergonomics, and real-device HealthKit QA. | "Known limitations remain pending." | Include in TestFlight notes. |
| BP-016 | Phase 9.27 validation | Ready to plan | Non-real-device simulator validation was recorded. | May cite simulator validation as passed, but must state it is non-real-device only. | "Simulator validation passed in the recorded Phase 9.27 environment." | Do not convert to real-device validation. |
| BP-017 | Real-device Watch VoiceOver QA | Deferred pending hardware | Unresolved. | Must not claim complete. | "Real-device Watch VoiceOver QA remains unresolved." | Execute with real Apple Watch hardware. |
| BP-018 | Physical Apple Watch tap ergonomics | Deferred pending hardware | Unresolved. | Must not claim complete. | "Physical Apple Watch tap ergonomics remain unresolved." | Test on real Watch hardware. |
| BP-019 | Real-device HealthKit QA | Deferred pending hardware / Future external-release blocker | Planned, not executed. | Must not claim complete. | "Real-device HealthKit QA remains planned, not executed." | Execute before production HealthKit rollout or external claims. |
| BP-020 | Watch Check-in MVP scope | Ready to plan | Watch-only, local-only, latest-three, single-record deletion only. | Keep release notes scoped to implemented behavior. | "Watch Check-in MVP is Watch-only and local-only." | Preserve scope in build notes. |
| BP-021 | iPhone Check-in | Not applicable to current MVP | Not included. | Do not present as supported. | "iPhone Check-in is not included in this MVP." | Separate future phase only. |
| BP-022 | WidgetKit Check-in | Not applicable to current MVP | Not included. | Do not present as supported. | "WidgetKit Check-in display is not included." | Separate future phase only. |
| BP-023 | WatchConnectivity | Not applicable to current MVP | Not included. | Do not present as supported. | "WatchConnectivity sync is not included." | Separate future phase only. |
| BP-024 | State Score integration | Not applicable to current MVP | Check-ins do not affect State Score, readiness, confidence, reasons, or suggestions. | Verify claims stay separated. | "Check-ins are separate from State Score." | Separate future design only. |
| BP-025 | Old iPhone `CheckInView` scaffold | Non-blocking follow-up | Existing scaffold was not addressed. | Do not mention as user-facing. Review separately. | "Not a current MVP feature." | Separate cleanup or design phase. |
| BP-026 | `StateWatchThemeTests.swift` size | Non-blocking follow-up | Internal test refactor only. | No release-blocking action in this phase. | "Internal test refactor follow-up." | Split in a later test refactor if useful. |

## Build Preparation Decision

Decision: internal TestFlight build preparation may continue with explicit
limitations.

This decision means a future phase may inventory archive/signing requirements
and prepare an archive/upload path. It does not mean this phase archived the
app, uploaded to TestFlight, configured App Store Connect, changed App Store
metadata, executed internal TestFlight QA, cleared hardware-dependent QA, or
made a broad release-ready claim.

Conditions for preparation:

- Archive and upload execution must remain separate from this plan.
- Release notes must use Phase 9.28 / Phase 9.29 limitation-aware wording.
- Known limitations must be visible before any internal upload.
- Build metadata must be recorded before any archive/upload.
- Real-device Watch VoiceOver and physical tap ergonomics must remain marked
  pending unless actually tested.
- Real-device HealthKit QA must remain marked pending unless actually tested.
- Watch Check-in must remain described as Watch-only, local-only, latest-three,
  and separate from State Score.

## Required Pre-archive Checklist

Before any future Xcode archive, confirm:

- Xcode version is recorded.
- macOS version is recorded if available.
- Branch and commit hash are recorded.
- Selected archive scheme is verified.
- Archive destination is verified.
- iOS app, watch app, extension, widget, and complication targets are verified.
- Bundle identifiers are recorded.
- Marketing version and build number are recorded.
- Apple Developer team is verified.
- Signing mode is verified.
- Signing certificate is verified.
- Provisioning profiles are verified.
- Existing entitlements and capabilities are verified without adding new ones.
- HealthKit remains read-only.
- App Group usage remains limited to existing mock/shared-state boundaries.
- WatchConnectivity remains absent.
- No iPhone Check-in, WidgetKit Check-in, State Score integration, networking,
  cloud, analytics, AI, account, remote config, or HealthKit write behavior is
  introduced.

## Required Pre-upload Checklist

Before any future TestFlight upload, confirm:

- Archive succeeded in a separate explicit phase.
- Upload path is selected: Xcode Organizer, Transporter, or another approved
  Apple tooling path.
- App Store Connect app record is verified.
- SKU / bundle linkage is verified.
- Platform targets are verified.
- Compliance prompts are reviewed.
- Encryption/export compliance answers are reviewed.
- Internal tester group is defined.
- Internal tester scope is documented.
- Internal release notes use limitation-aware wording.
- Known limitations disclosure includes unresolved real-device Watch VoiceOver,
  physical tap ergonomics, and real-device HealthKit QA.
- App Store Connect privacy answers match actual local-first/read-only behavior.
- No App Store approval, external release readiness, or real-device QA pass
  claim is made.

## Xcode Archive Environment Template

Use this template in the future archive/signing inventory phase:

| Field | Value to record |
| --- | --- |
| Phase | Phase 9.31 or later |
| Date / time | TBD |
| Operator | TBD |
| Machine | TBD |
| macOS version | TBD |
| Xcode version | TBD |
| Xcode build version | TBD |
| Repository branch | TBD |
| Commit hash | TBD |
| Release candidate label | TBD |
| Archive command or UI path | TBD |
| Archive destination | TBD |
| Archive result | Not recorded by Phase 9.30 |
| Upload result | Not recorded by Phase 9.30 |

## Scheme And Target Verification Template

| Item | Verification status | Notes |
| --- | --- | --- |
| iOS app scheme: `StateWatch` | TBD | Verify whether this is the correct archive scheme. |
| Watch app scheme: `StateWatchWatchApp` | TBD | Verify archive role and embedding behavior. |
| Complications scheme: `StateWatchComplications` | TBD | Verify extension archive behavior. |
| iOS app target | TBD | Verify target membership and product. |
| Watch app target | TBD | Verify target membership and product. |
| Widget / complications target | TBD | Verify target membership and product. |
| XCTest target | TBD | Build/test only; not a distribution product. |

## Bundle Identifier Verification Template

| Product | Bundle identifier | Status | Notes |
| --- | --- | --- | --- |
| iOS app | TBD | Must verify before archive | Do not change in Phase 9.30. |
| watchOS app | TBD | Must verify before archive | Do not change in Phase 9.30. |
| Watch extension if present | TBD | Must verify before archive | Verify actual project structure. |
| WidgetKit / complications extension | TBD | Must verify before archive | Do not add Check-in display. |
| XCTest bundle | TBD | Non-distribution target | Verify only if needed. |

## Signing And Provisioning Verification Template

| Item | Status | Notes |
| --- | --- | --- |
| Apple Developer team | TBD | Must verify before archive. |
| Automatic/manual signing mode | TBD | Must verify before archive. |
| iOS app certificate | TBD | Must verify before archive. |
| watchOS app certificate | TBD | Must verify before archive. |
| Widget/complication certificate | TBD | Must verify before archive. |
| iOS app provisioning profile | TBD | Must verify before archive. |
| watchOS provisioning profile | TBD | Must verify before archive. |
| Widget/complication provisioning profile | TBD | Must verify before archive. |
| App Group capability provisioning | TBD | Verify existing capability only; do not add new scope here. |
| HealthKit capability provisioning | TBD | Verify read-only behavior remains aligned. |

## Entitlements And Capabilities Verification Template

| Capability / entitlement | Expected treatment | Status |
| --- | --- | --- |
| HealthKit | Read-only, no write authorization. | Must verify before archive. |
| App Groups | Existing mock/shared-state usage only where already configured. | Must verify before archive. |
| WidgetKit / complications | Existing mock/shared-state complication behavior only. | Must verify before archive. |
| Watch app | Existing Watch Check-in MVP behavior only. | Must verify before archive. |
| WatchConnectivity | Not included in current MVP. | Must remain absent. |
| Networking / cloud / analytics / AI | Not included in current MVP. | Must remain absent. |
| HealthKit write access | Not included. | Must remain absent. |

## Build Number / Version Record Template

| Field | Value |
| --- | --- |
| Marketing version | TBD |
| Build number | TBD |
| Branch | TBD |
| Commit hash | TBD |
| Date / time | TBD |
| Release candidate label | TBD |
| Internal tester group | TBD |
| Known limitations disclosure attached | TBD |
| Archive performed | No, not in Phase 9.30 |
| TestFlight upload performed | No, not in Phase 9.30 |

## App Store Connect Verification Template

| Item | Required status before upload | Notes |
| --- | --- | --- |
| App record | Verified | No App Store Connect release work in Phase 9.30. |
| SKU / bundle linkage | Verified | Must match actual bundle identifiers. |
| Platform targets | Verified | Include iOS, watchOS, and complications as applicable. |
| Compliance prompts | Reviewed | Include encryption/export compliance as applicable. |
| Privacy answers | Reviewed | Must match local-first/read-only HealthKit behavior. |
| Internal tester groups | Defined | Include limitation disclosure. |
| Internal release notes | Reviewed | Use safe wording from Phase 9.28 / Phase 9.29. |
| App Review metadata | Not changed by Phase 9.30 | Separate external submission phase only. |

## TestFlight Upload Path Options To Verify Later

The future upload phase must choose and document one approved path:

- Xcode Organizer upload.
- Transporter upload.
- Another approved Apple tooling path, if explicitly selected and reviewed.

Phase 9.30 does not choose an upload path, perform an upload, or create an App
Store Connect build.

## Internal Tester Group And Release Notes Carry-forward

Internal tester planning should carry forward these constraints:

- Testers are internal only.
- Tester scope must mention known hardware-dependent limitations.
- Release notes must not claim real-device Watch VoiceOver or HealthKit QA
  passed.
- Release notes must not imply iPhone Check-in, WidgetKit Check-in,
  WatchConnectivity, State Score integration, cloud sync, AI, analytics,
  accounts, or HealthKit write behavior.
- Release notes may describe Watch Check-in as Watch-only, local-only, and
  subjective.

## Known Limitations Disclosure Carry-forward

Any future internal TestFlight build notes should disclose:

- Real-device Watch VoiceOver QA remains unresolved.
- Physical Apple Watch small-screen tap ergonomics remain unresolved.
- Real Watch VoiceOver spoken cadence and focus order remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 validation was non-real-device validation only.
- Watch Check-in is Watch-only and local-only.
- Check-ins do not affect State Score.
- iPhone Check-in and WidgetKit Check-in display are not included.

## Privacy / HealthKit Preparation Review

Current status: ready to plan with explicit limitations.

- HealthKit remains read-only.
- No HealthKit write access or write authorization was added.
- No raw HealthKit upload or developer-accessible health database is
  introduced.
- HealthKit-derived production rollout remains separate from this build
  preparation plan.
- Real-device HealthKit QA remains planned, not executed.
- App Store Connect privacy answers must be checked before any upload and must
  match actual behavior.

## Medical-safety Preparation Review

Current status: ready to plan with explicit limitations.

StateWatch remains non-medical wellness/readiness software. This phase does not
add diagnosis, treatment, therapy, emergency, abnormal-state, warning,
disease-detection, clinical-stress, or medical-advice claims.

`Low` remains a subjective self-report. It is not a medical warning, health
risk, score penalty, diagnosis, or instruction to seek treatment.

Missing Check-ins and missing HealthKit data remain neutral. Missing or sparse
data should reduce confidence, stay unavailable, or use safe fallback behavior,
not create a negative health conclusion.

## Watch Check-in MVP Preparation Review

Current status: ready to plan with explicit limitations.

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

## Prohibited Build-preparation Claims

Do not use these claims in build-preparation, internal release-note, upload, or
App Store Connect materials:

- Release ready.
- App Store ready.
- Approved for external release.
- Archived and uploaded.
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

## Allowed Build-preparation Claims

Allowed claims:

- Internal build preparation plan with explicit limitations.
- Archive/upload not performed in this phase.
- Simulator build/test validation passed for the recorded Phase 9.27
  environment.
- Watch Check-in MVP is Watch-only and local-only.
- Real-device Watch VoiceOver and real-device HealthKit QA remain pending.
- HealthKit remains read-only.
- StateWatch remains non-medical wellness/readiness software.

## Work That May Continue

- Phase 9.31 archive and signing environment inventory.
- Documentation-only build preparation refinement.
- Internal release-note review.
- Internal tester group planning.
- App Store Connect item checklist planning without making App Store Connect
  changes.
- Real-device Watch QA planning.
- Real-device HealthKit QA planning.
- Documentation-only release planning with explicit limitations.

## Work That Must Wait

- Xcode archive execution unless explicitly requested in a separate phase.
- TestFlight upload unless explicitly requested in a separate phase.
- App Store Connect release work.
- App Store metadata changes.
- Bundle identifier changes.
- Signing setting changes.
- Provisioning profile changes.
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
- Continue refining internal release-note, known-limitation, and App Review
  language as future QA results arrive.

## Risks / Limitations

- This phase is documentation-only.
- It does not run an Xcode archive.
- It does not upload to TestFlight.
- It does not configure App Store Connect.
- It does not change signing, provisioning, certificates, bundle identifiers,
  screenshots, release automation, or App Store metadata.
- It does not execute internal TestFlight QA.
- It does not clear Phase 9.22.
- It does not prove real-device Watch accessibility, tap ergonomics, or
  HealthKit behavior.
- It does not update App Store metadata.

## Recommended Next Phase

Phase 9.31: Archive and Signing Environment Inventory.

Phase 9.31 should:

- Use this Phase 9.30 build preparation plan as input.
- Inventory the local Xcode archive/signing environment without uploading to
  TestFlight.
- Record Xcode version, schemes, bundle identifiers, signing settings, team IDs
  if visible, provisioning status if visible, and archive feasibility.
- Optionally run non-upload archive-related dry checks only if safe and
  explicitly instructed.
- Preserve unresolved real-device Watch VoiceOver and real-device HealthKit QA
  limitations.
- Avoid broad release-ready language unless limitations are explicit.
- Remain docs-only unless a separate implementation or upload phase is
  explicitly opened.

## Changes Made

- Added this Phase 9.30 internal TestFlight build preparation plan.
- Added a matching Phase 9.30 checklist to `TEST_PLAN.md`.
- No Swift files, Xcode project files, entitlement files, CI workflows, App
  Store metadata, TestFlight uploads, Xcode archives, App Store Connect release
  work, signing settings, provisioning profiles, bundle identifiers, or product
  behavior were changed.

## Final Phase 9.30 Checklist

- Phase 9.30 internal TestFlight build preparation plan document exists.
- The document is build preparation plan only, not Xcode archive or TestFlight
  upload.
- Phase 9.23 through Phase 9.29 were used as input.
- Explicit limitations are carried forward.
- Phase 9.22 remains deferred/blocked, not completed.
- Real-device Watch Check-in VoiceOver QA remains unresolved.
- Physical Apple Watch tap ergonomics remains unresolved.
- Real Watch VoiceOver spoken cadence and focus order remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 validation is described as non-real-device validation only.
- Non-real-device validation is not treated as real-device QA.
- Internal TestFlight build preparation may continue only with explicit
  limitations.
- No Xcode archive was performed.
- No TestFlight upload was performed.
- No App Store Connect release work was performed.
- No App Store metadata was changed.
- No bundle identifiers were changed.
- No signing settings were changed.
- No provisioning profiles were changed.
- No broad release-ready claim is made.
- No App Store approval or external submission-readiness claim is made.
- Required pre-archive checklist is documented.
- Required pre-upload checklist is documented.
- Xcode archive environment template is documented.
- Scheme and target verification template is documented.
- Bundle identifier verification template is documented.
- Signing and provisioning verification template is documented.
- Entitlements and capabilities verification template is documented.
- Build number / version record template is documented.
- App Store Connect verification template is documented.
- TestFlight upload path options to verify later are documented.
- Internal tester group and release notes carry-forward is documented.
- Known limitations disclosure carry-forward is documented.
- Privacy / HealthKit preparation review is documented.
- Medical-safety preparation review is documented.
- Watch Check-in MVP preparation review is documented.
- Items not included in current MVP are documented.
- Prohibited build-preparation claims are documented.
- Allowed build-preparation claims are documented.
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
- Recommended next phase is Phase 9.31: Archive and Signing Environment
  Inventory.
- Local validation commands pass.
- GitHub Actions status is reviewed after PR creation.
- No Phase 9.31 work started.
