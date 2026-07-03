# Phase 9.23 Release Blocker Register

## Purpose

Phase 9.23 records the current release blockers, deferred blockers, non-blocking follow-ups, monitoring items, and already guarded boundaries for the Watch Check-in MVP and nearby StateWatch release-readiness work.

This register exists because Phase 9.22 could not proceed without real Apple Watch hardware. It preserves that limitation honestly while allowing non-real-device planning and documentation work to continue.

Phase 9.22 is deferred/blocked, not completed, because no real Apple Watch is currently available for real-device VoiceOver and physical tap-ergonomics QA.

No broad release-readiness claim should be made for Watch Check-in until real-device VoiceOver and small-screen hardware QA are completed or the release explicitly documents that limitation.

Internal planning and non-real-device validation may continue, but they do not replace real-device Watch QA.

## Scope

In scope:

- Classify true release blockers and deferred release blockers.
- Separate release blockers from non-blocking follow-ups.
- Record monitoring items for future release-readiness phases.
- Record already guarded boundaries that should not be reopened accidentally.
- Identify claims that must not be made yet.
- Define what work can continue despite unresolved real-device QA.

Out of scope:

- Swift implementation changes.
- Watch Check-in UI changes.
- iPhone Check-in UI, history, deletion, or management.
- WidgetKit Check-in display, summary, or direct reads.
- App Group raw Check-in history, Check-in propagation, or display preference propagation.
- WatchConnectivity.
- State Score integration.
- HealthKit write access or write authorization.
- Networking, cloud sync, iCloud sync, analytics, AI, account systems, login, upload paths, or remote config.
- Reminders, notifications, scheduling, notes, export, trends, streaks, counts, causes, interpretations, pattern summaries, or insights.
- Phase 9.24 work.

## Current Baseline

- Phase 9.21 is merged into `main`.
- Current baseline commit reviewed for this phase: `bfef461cdac53a5fa7129e027423a584b44c6dd2`.
- Phase 9.21 recorded honest Watch Check-in VoiceOver QA results and did not claim real-device execution.
- Phase 9.22 was attempted after Phase 9.21, but stopped before branch creation because `xcrun xctrace list devices` did not show a real Apple Watch.
- No Phase 9.22 branch, commit, PR, or duplicated results documentation was created.
- Watch Check-in remains Watch-only, local-only, latest-three, and not score-integrated.

## Phase 9.22 Deferred / Blocked Status

Phase 9.22 remains unresolved.

The unresolved items are not documentation gaps. They require actual hardware:

- Real Apple Watch launch behavior.
- Real VoiceOver spoken labels, hints, values, cadence, and focus order.
- Screen Curtain no-vision testing if practical.
- Icon Only mode with real VoiceOver.
- Selected and not selected selector announcements on real hardware.
- Recent history spoken behavior on real hardware.
- Per-record delete flow with real focus and activation.
- Physical tap ergonomics and wrist use.
- Haptic feel and real small-screen reliability.

Until those are tested or explicitly scoped as release limitations, Watch Check-in should not be described as broadly release-ready.

## Files Reviewed

All primary references requested for this phase were present and reviewed or source-checked at the register level:

- `Docs/phase-9-21-watch-checkin-voiceover-qa-results.md`
- `Docs/phase-9-20-watch-checkin-real-device-voiceover-qa-plan.md`
- `Docs/phase-9-19-watch-checkin-final-ux-polish-qa.md`
- `Docs/phase-9-18-watch-checkin-final-ux-polish.md`
- `Docs/phase-9-17-watch-checkin-final-ux-polish-design.md`
- `Docs/phase-9-16-mvp-checkin-boundary-qa.md`
- `Docs/phase-9-15-mvp-checkin-boundary-decision.md`
- `Docs/phase-9-14-watch-checkin-recent-history-deletion-qa.md`
- `Docs/phase-9-13-watch-checkin-recent-history-deletion-foundation.md`
- `Docs/phase-9-10-watch-checkin-display-preference-qa.md`
- `Docs/phase-9-9-watch-checkin-display-preference.md`
- `Docs/phase-9-7-watch-checkin-local-storage-foundation.md`
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
- `StateWatchApp/Models/StateCheckInOption.swift`
- `StateWatchWatchApp/Features/WatchCheckInView.swift`
- `StateWatchWatchApp/Features/WatchDashboardView.swift`
- `StateWatchWatchApp/Services/CheckIn/StateCheckInRecord.swift`
- `StateWatchWatchApp/Services/CheckIn/LocalStateCheckInStore.swift`
- `StateWatchWatchApp/Services/CheckIn/StateCheckInDisplayPreference.swift`
- `StateWatchTests/StateWatchThemeTests.swift`
- `StateWatchTests/StateCheckInStorageTests.swift`
- `StateWatch.xcodeproj/project.pbxproj`

No referenced document was found missing.

## Search Terms Used

Pre-change searches covered:

- Blocker, deferred, pending, known limitation, follow-up, release readiness, TestFlight, real-device, VoiceOver, Apple Watch, Phase 9.22, Phase 9.21, and Phase 9.20.
- Watch Check-in, State Check-in, accessibility, small screen, tap target, Screen Curtain, Icon Only, Selected, Not selected, latest-three, latest five, and clear-all.
- iPhone Check-in, WidgetKit Check-in, App Group raw, WatchConnectivity, `WCSession`, State Score integration, HealthKit write, `HKHealthStore.save`, and `requestAuthorization(toShare`.
- `URLSession`, cloud, iCloud, analytics, remote config, AI cloud, account, login, upload path, developer database, and sync.
- Diagnosis, clinical, medical advice, treatment, therapy, emergency, warning, abnormal, health risk, anxiety, depression, detected, caused by, because you, symptom history, medical record, score dropped, low because, and bad health.

Matches were reviewed as existing source, existing tests, existing scope guardrails, forbidden-copy examples, release blocker language, or safety disclaimers. No new product behavior was identified.

## Classification Definitions

- Release Blocker: Must be resolved before broad external release or before making release-ready claims.
- Deferred Release Blocker: Blocked by unavailable hardware or external condition; not resolved, but documented and intentionally carried forward.
- Non-blocking Follow-up: Useful cleanup/refactor/documentation improvement that should not block internal QA or TestFlight planning.
- Monitoring Item: Not currently a blocker, but should be watched in future phases.
- Already Resolved / Guarded: Covered by previous implementation, QA docs, tests, or explicit scope guardrails.

## Release Blocker Summary Table

| ID | Item | Classification | Status | Evidence | Required next action | Blocks what |
| --- | --- | --- | --- | --- | --- | --- |
| DRB-001 | Real-device Watch Check-in VoiceOver QA | Deferred Release Blocker | Unresolved | Phase 9.21 records no real Apple Watch; Phase 9.22 stopped before branch creation. | Connect paired real Apple Watch and execute Phase 9.20 cases. | Broad Watch Check-in release-ready claim. |
| DRB-002 | Physical Apple Watch small-screen tap ergonomics | Deferred Release Blocker | Unresolved | VO-007 remains blocked in Phase 9.21. | Test on real Watch hardware, ideally the smallest available screen. | Claims about physical usability and tap comfort. |
| DRB-003 | VoiceOver spoken cadence and focus order on real Watch | Deferred Release Blocker | Unresolved | Source review cannot validate spoken cadence or real focus behavior. | Run VoiceOver on real Watch and record VO-001 through VO-009 outcomes. | Accessibility pass claims for VoiceOver users. |
| RB-001 | Broad release-readiness claim for Watch Check-in | Release Blocker | Blocked until limited or resolved | Real-device Watch QA is unresolved. | Complete real-device QA or explicitly limit release notes and readiness language. | Public or broad external release-ready messaging. |
| MON-001 | Internal TestFlight planning with documented limitation | Monitoring Item | Allowed with limitation | Docs allow planning while preserving unresolved blockers. | Keep release notes honest and carry deferred blockers forward. | Does not block limited internal planning. |
| FU-001 | `StateWatchThemeTests.swift` size / future test refactor | Non-blocking Follow-up | Open | Previous QA docs identify it as a known follow-up. | Split in a later test refactor phase. | Does not block Watch Check-in MVP planning. |
| FU-002 | Old iPhone `CheckInView` scaffold | Non-blocking Follow-up | Open | Phase 9.16 notes this as an existing scaffold risk; it is not routed into the Watch MVP. | Revisit in a separate iPhone Check-in design/removal phase. | Does not block Watch-only MVP if it stays unreachable. |
| GRD-001 | iPhone Check-in UI/history/deletion | Already Resolved / Guarded | Guarded out of MVP | Repeated Phase 9 docs and TEST_PLAN checks forbid adding it. | Keep out of scope until separately designed. | Not a blocker for Watch-only MVP. |
| GRD-002 | WidgetKit Check-in display/summary/direct read | Already Resolved / Guarded | Guarded out of MVP | Repeated Phase 9 docs and TEST_PLAN checks forbid adding it. | Keep out of scope until separately designed. | Not a blocker for Watch-only MVP. |
| GRD-003 | App Group raw Check-in history / Check-in propagation | Already Resolved / Guarded | Guarded out of MVP | Phase 9 docs exclude raw Check-in history from App Group. | Keep out of scope until privacy-reviewed. | Not a blocker for Watch-only MVP. |
| GRD-004 | WatchConnectivity | Already Resolved / Guarded | Guarded out of MVP | Repeated searches show no `WCSession` implementation, only guardrails/tests. | Keep out of scope until separately designed. | Not a blocker for Watch-only MVP. |
| GRD-005 | State Score integration | Already Resolved / Guarded | Guarded out of MVP | Docs state Check-ins remain neutral and non-score-lowering. | Keep Check-ins detached from scoring. | Not a blocker for Watch-only MVP. |
| GRD-006 | HealthKit write access | Already Resolved / Guarded | Guarded | HealthKit write remains prohibited; read-only permission path exists. | Keep HealthKit read-only. | Not a blocker unless write behavior is introduced. |
| GRD-007 | Cloud / networking / AI / analytics / account system | Already Resolved / Guarded | Guarded | Searches show guardrails and tests; no new implementation in this phase. | Keep StateWatch local-first and account-free. | Not a blocker unless introduced. |
| GRD-008 | Medical / warning / diagnosis wording | Already Resolved / Guarded | Guarded | Production wording and Phase 9 docs keep Check-ins subjective and non-medical. | Keep future copy within safety rules. | Not a blocker unless unsafe copy is introduced. |
| MON-002 | Real-device HealthKit QA | Monitoring Item | Planned, not executed in reviewed docs | Phase 8.9 is a plan and does not claim execution. | Execute before production HealthKit rollout claims. | Production HealthKit-backed release claims. |
| MON-003 | App Store privacy / medical safety final audit | Monitoring Item | Needed before final submission | Prior safety docs exist; final submission audit still needed. | Run final App Store readiness audit before external submission. | App Store submission readiness. |

## Detailed Blocker Register

### DRB-001 Real-device Watch Check-in VoiceOver QA

Classification: Deferred Release Blocker.

Status: Unresolved.

Reason: Phase 9.21 explicitly records that no real Apple Watch was available. Phase 9.22 was attempted and blocked before branch creation because no real Apple Watch appeared in the device inventory.

Required next action: Connect a paired real Apple Watch and execute VO-001 through VO-009 from the Phase 9.20 plan. Record the actual device model, watchOS version, paired iPhone model, iOS version, VoiceOver status, Screen Curtain status if used, observed behavior, and limitations.

Blocks: Any broad Watch Check-in VoiceOver pass claim.

### DRB-002 Physical Apple Watch Small-screen Tap Ergonomics

Classification: Deferred Release Blocker.

Status: Unresolved.

Reason: Physical tap comfort, wrist use, scroll reliability, haptic feel, and the true smallest-screen experience cannot be proven through source review or simulator builds.

Required next action: Run physical tap and scroll checks on real Watch hardware. If the smallest available Watch is not available, record that limitation.

Blocks: Claims that the Watch Check-in UI is physically comfortable or fully validated on small Watch hardware.

### DRB-003 VoiceOver Spoken Cadence / Focus Order On Real Watch

Classification: Deferred Release Blocker.

Status: Unresolved.

Reason: Source review confirms labels and hints exist, but it cannot validate actual spoken cadence, pronunciation, focus order, rotor behavior, or real device activation behavior.

Required next action: Run VoiceOver on real Watch hardware and listen to the actual output before marking VoiceOver cases passed.

Blocks: Full VoiceOver accessibility pass claims.

### RB-001 Broad Release-readiness Claim For Watch Check-in

Classification: Release Blocker.

Status: Blocked until real-device QA is completed or the release explicitly documents the limitation.

Reason: The product may continue internal planning, but broad release-readiness language would overstate the state of real-device VoiceOver and physical tap validation.

Required next action: Either clear DRB-001 through DRB-003 or make any internal release documentation explicitly say that real-device Watch VoiceOver and physical tap QA remain unresolved.

Blocks: Unqualified "release-ready" messaging for Watch Check-in.

## Deferred Release Blockers

- Real-device Watch Check-in VoiceOver QA.
- Physical Apple Watch small-screen tap ergonomics.
- VoiceOver spoken cadence, focus order, selected/not selected values, and Icon Only behavior on real Watch hardware.

These are deferred because the required hardware is unavailable, not because the work is optional.

## Non-blocking Follow-ups

- Split `StateWatchThemeTests.swift` in a later test refactor phase.
- Revisit the old iPhone `CheckInView` scaffold in a separate iPhone Check-in design or cleanup phase.
- Continue improving release documentation clarity as phases accumulate.

These follow-ups should not be bundled into this phase.

## Monitoring Items

- Internal TestFlight planning can continue only with explicit limitation language.
- Real-device HealthKit QA remains planned, not executed in the reviewed docs, and must not be claimed complete.
- A final App Store privacy and medical-safety audit remains necessary before final external submission.
- GitHub Actions should run normally after PR creation, but Actions should not become a debugging loop for this docs-only phase.

## Already Resolved / Guarded Items

The following boundaries are already guarded by previous docs, tests, source structure, or explicit Phase 9 scope:

- Watch Check-in remains Watch-only.
- Watch Check-in remains local-only.
- The approved states remain `Energized`, `Stable`, `Tired`, and `Low`.
- Traditional Chinese reference labels remain `有活力`, `穩定`, `疲累`, and `低狀態`.
- Display modes remain `Icon + Text`, `Icon Only`, and `Text Only`.
- Default display remains `Icon + Text`.
- Recent history remains latest-three.
- Missing Check-ins remain neutral.
- `Low` remains subjective, non-medical, non-warning, and non-score-lowering.
- No iPhone Check-in UI, history, deletion, or management is in the Watch MVP.
- No WidgetKit Check-in display, summary, or direct read is in the Watch MVP.
- No App Group raw Check-in history, Check-in propagation, or display preference propagation is in the Watch MVP.
- No WatchConnectivity is in the Watch MVP.
- No State Score integration is in the Watch MVP.
- No HealthKit write access or write authorization is in scope.
- No networking, cloud sync, iCloud sync, analytics, AI, account system, login, upload path, or remote config is in scope.
- No reminders, notifications, scheduling, notes, export, trends, streaks, counts, causes, interpretations, pattern summaries, or insights are in scope.

## Claims That Must Not Be Made Yet

Do not claim:

- Phase 9.22 is complete.
- Real-device Watch Check-in VoiceOver QA passed.
- A real Apple Watch was tested for Phase 9.22.
- VoiceOver spoken output was heard on a real Apple Watch.
- Screen Curtain testing was performed.
- Physical tap ergonomics passed on real Watch hardware.
- Icon Only mode is fully validated with real VoiceOver.
- Watch Check-in is broadly release-ready without limitations.
- Real-device HealthKit QA has been executed if only the Phase 8.9 plan exists.
- Check-ins sync to iPhone, WidgetKit, App Group, WatchConnectivity, cloud, iCloud, analytics, AI, or an account system.
- Check-ins affect State Score, HealthKit-derived scoring, readiness, or suggestions.
- `Low` means warning, abnormal state, health risk, diagnosis, clinical stress, treatment need, or score penalty.

## Work That May Continue Despite Blockers

The following work can continue because it does not replace real-device Watch QA:

- Documentation-only release-readiness audits.
- Internal TestFlight planning with explicit unresolved real-device QA limitations.
- Local simulator builds and source review.
- Privacy and medical-safety documentation review.
- App Store checklist refinement.
- Test plan organization and non-product documentation cleanup.

This work must continue to carry forward the deferred Watch hardware QA blockers.

## Required Conditions To Clear Deferred Blockers

To clear DRB-001 through DRB-003:

1. A real Apple Watch must be connected, paired, visible through Xcode or `xcrun xctrace list devices`, and usable for testing.
2. The tester must run VO-001 through VO-009 on real hardware where practical.
3. The result document must name the actual Apple Watch model, watchOS version, paired iPhone model, and iOS version.
4. VoiceOver must be enabled and actual spoken output must be listened to before spoken-output cases are marked passed.
5. Physical tap ergonomics must be tested on real hardware before VO-007 is marked passed.
6. Any failed, partial, blocked, or not-run case must remain labeled honestly.
7. Any required Swift fixes must be filed or implemented in a separate scoped phase.

## Privacy And Non-medical Safety Review

This phase adds documentation only.

The blocker register reinforces the existing StateWatch safety posture:

- Check-ins are subjective self-reports.
- Check-ins are optional.
- Check-ins stay local to the Watch app.
- Missing Check-ins remain neutral.
- `Low` remains subjective, non-medical, non-warning, and non-score-lowering.
- StateWatch does not diagnose, treat, cure, or prevent disease.
- StateWatch does not claim disease detection, clinical stress detection, treatment advice, emergency handling, abnormal health warnings, or health-risk prediction.
- StateWatch does not add HealthKit write access.
- StateWatch does not add developer-accessible cloud storage, upload paths, analytics, AI cloud profiling, account systems, or remote config.

High-risk words in this document appear only as blocker definitions, safety guardrails, forbidden claim examples, or release-readiness constraints.

## Technical Boundary Review

Phase 9.23 is documentation-only.

Confirmed scope:

- No Swift files changed.
- No Xcode project files changed.
- No entitlement files changed.
- No CI workflow files changed.
- No product behavior changed.
- No iPhone Check-in UI, history, deletion, or management was added.
- No WidgetKit Check-in display, summary, or direct read was added.
- No App Group raw Check-in history, Check-in propagation, or display preference propagation was added.
- No WatchConnectivity was added.
- No State Score integration was added.
- No HealthKit write access or write authorization was added.
- No networking, cloud sync, iCloud sync, analytics, AI, account system, login, upload path, or remote config was added.
- No reminders, notifications, scheduling, notes, export, trends, streaks, counts, causes, interpretations, pattern summaries, or insights were added.

## Recommended Next Phase

Phase 9.24: Check-in MVP Release Readiness Audit.

Phase 9.24 should:

- Use this release blocker register as input.
- Audit whether the Watch Check-in MVP is ready for internal TestFlight planning with limitations.
- Preserve unresolved real-device QA as a blocker or deferred blocker.
- Avoid broad release-readiness claims.
- Remain documentation-only unless a specific implementation issue is found and explicitly separated into a future phase.

## Changes Made

- Added this Phase 9.23 release blocker register.
- Added Phase 9.23 checklist coverage to `TEST_PLAN.md`.

## Final Phase 9.23 Checklist

- Phase 9.23 release blocker register document exists.
- Phase 9.22 is recorded as deferred/blocked, not completed.
- Real-device Watch Check-in VoiceOver QA remains unresolved.
- Physical Apple Watch tap ergonomics remain unresolved.
- Broad release-readiness claims are blocked until real-device QA is completed or explicitly limited.
- Blockers, deferred blockers, non-blocking follow-ups, monitoring items, and guarded items are classified.
- Claims that must not be made yet are documented.
- Work that may continue despite blockers is documented.
- Required conditions to clear blockers are documented.
- No Swift files changed.
- No Xcode project files changed.
- No entitlements changed.
- No CI workflows changed.
- No product behavior changed.
- Watch Check-in remains Watch-only.
- Watch Check-in remains local-only.
- Four states remain `Energized`, `Stable`, `Tired`, and `Low`.
- Traditional Chinese reference labels remain `有活力`, `穩定`, `疲累`, and `低狀態`.
- Display modes remain `Icon + Text`, `Icon Only`, and `Text Only`.
- Default display remains `Icon + Text`.
- Latest-three recent history remains unchanged.
- No latest-five history added.
- No clear-all UI added.
- No long-term history added.
- No notes, export, reminders, notifications, trends, streaks, counts, causes, interpretations, pattern summaries, or insights added.
- No iPhone Check-in UI, history, or deletion added.
- Old iPhone CheckInView scaffold was not addressed.
- No WidgetKit Check-in display, summary, or direct read added.
- No App Group raw Check-in history, propagation, or display preference propagation added.
- No WatchConnectivity added.
- No State Score integration added.
- No HealthKit write added.
- No networking, cloud, iCloud, analytics, AI, accounts, or remote config added.
- Recommended next phase is Phase 9.24.
- Local documentation validation passes.
- GitHub Actions status should be reviewed after PR creation.
- No Phase 9.24 work was started.
