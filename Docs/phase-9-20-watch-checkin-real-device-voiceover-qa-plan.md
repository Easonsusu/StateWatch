# Phase 9.20 Watch Check-in Real-device VoiceOver QA Plan

## Purpose

Phase 9.20 defines a manual QA plan for verifying the Watch-only State Check-in MVP with VoiceOver and on small Apple Watch screens.

This is a QA planning and documentation phase only. It does not run or claim completed real-device QA.

## Scope

In scope:

- Define real-device VoiceOver QA setup.
- Define simulator-only checks and their limitations.
- Define test cases for the Watch Check-in flow.
- Define pass/fail criteria.
- Define evidence collection requirements.
- Define issue reporting expectations.
- Define the recommended Phase 9.21 execution scope.

Out of scope:

- Swift implementation changes.
- WatchCheckInView changes.
- StateCheckInOption changes.
- LocalStateCheckInStore, StateCheckInRecord, or StateCheckInDisplayPreference changes.
- WatchDashboardView changes.
- Xcode project, entitlement, or CI workflow changes.
- iPhone Check-in UI, history, deletion, or management.
- Removing or addressing the old iPhone CheckInView scaffold.
- WidgetKit Check-in display, summary, or direct reads.
- App Group raw Check-in history, Check-in propagation, or display preference propagation.
- WatchConnectivity.
- State Score integration.
- HealthKit write access or write authorization.
- Networking, cloud sync, iCloud sync, analytics, AI cloud analysis, accounts, login, upload paths, or remote config.
- Clear-all UI, notes, export, reminders, notifications, scheduling, trends, streaks, counts, causes, interpretations, pattern summaries, or insights.
- Real-device QA execution.
- Phase 9.21 work.

## Files Reviewed

- `Docs/phase-9-19-watch-checkin-final-ux-polish-qa.md`
- `Docs/phase-9-18-watch-checkin-final-ux-polish.md`
- `Docs/phase-9-17-watch-checkin-final-ux-polish-design.md`
- `Docs/phase-9-16-mvp-checkin-boundary-qa.md`
- `Docs/phase-9-15-mvp-checkin-boundary-decision.md`
- `Docs/phase-9-14-watch-checkin-recent-history-deletion-qa.md`
- `Docs/phase-9-13-watch-checkin-recent-history-deletion-foundation.md`
- `Docs/phase-9-10-watch-checkin-display-preference-qa.md`
- `Docs/phase-9-9-watch-checkin-display-preference.md`
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

## Search Terms Used

Pre-write searches reviewed:

- VoiceOver, accessibility, accessibilityHint, accessibilityLabel, accessibilityValue.
- Selected, Not selected, self-reported, local Watch, local check-in, this Watch.
- Tap target, small screen, Apple Watch, real-device, real device, manual QA.
- WatchCheckInView, WatchDashboardView, State Check-in, check-in, Recent check-ins.
- No check-in yet, Check-ins are optional, Delete check-in, Remove this local check-in.
- This removes it from this Watch, Delete unavailable, Try again later.
- Display style, Icon + Text, Icon Only, Text Only, Both, Icon, Text.
- Energized, Stable, Tired, Low.
- iPhone Check-in, WidgetKit Check-in, check-in display, check-in summary.
- App Group raw, App Group Check-in, WatchConnectivity, WCSession.
- State Score integration, HealthKit write, HKHealthStore.save, requestAuthorization(toShare.
- URLSession, cloud, iCloud, analytics, remote config, AI cloud, account, login, sign in, upload path, developer database, sync.
- Diagnosis, clinical, medical advice, treatment, therapy, emergency, warning, abnormal, health risk, anxiety, depression, detected, caused by, because you, symptom history, medical record, score dropped, low because, bad health.

Search matches were used to shape this QA plan and were reviewed as existing implementation, documentation, tests, guardrails, or forbidden-copy examples.

## What This Plan Does Not Claim

This document does not claim:

- Real-device VoiceOver QA has been performed.
- A real Apple Watch has been tested.
- VoiceOver pass/fail results are known.
- Small-screen physical-device usability has passed.
- Any production issue has been fixed.
- Phase 9.21 has started.

Real-device QA remains to be executed in a later phase.

## Required Test Environment

Record the following before each real-device QA session:

- Apple Watch hardware model.
- watchOS version.
- Paired iPhone model.
- iOS version.
- StateWatch build identifier or commit hash.
- Whether the app was installed through Xcode, TestFlight, or another approved local test path.
- Whether VoiceOver is enabled.
- Whether Screen Curtain is enabled for no-vision simulation.
- Whether testing uses the smallest supported Watch screen available.
- Whether Reduced Motion is enabled.
- Whether Bold Text is enabled.
- Text size setting.
- Whether the Watch is on wrist or tabletop.
- Whether the tester is using touch exploration, swipe navigation, or both.

Simulator-only checks may use a named Apple Watch simulator and must record that the result is simulator-only.

## Evidence Template

Use this template for each test case:

```text
Date:
Tester:
Device:
OS version:
Paired iPhone:
iOS version:
Build / commit:
Test case ID:
Environment:
VoiceOver enabled:
Screen Curtain enabled:
Text size / accessibility settings:
Pass / fail:
Observed behavior:
VoiceOver spoken phrase notes:
Screenshot or screen recording:
Issue link:
Notes:
```

Do not include personal health data in public issues, screenshots, recordings, or comments.

## Test Matrix

| Area | Real Apple Watch | watchOS simulator | Source review |
| --- | --- | --- | --- |
| App launches and score page appears first | Required | Useful | Partial |
| Check-in page is reachable as second page | Required | Useful | Partial |
| VoiceOver spoken labels and hints | Required | Limited | Partial |
| Screen Curtain no-vision simulation | Recommended | Not sufficient | Not applicable |
| Icon Only accessibility | Required | Useful | Partial |
| Selected / not selected selector state | Required | Useful | Partial |
| Small-screen touch target feel | Required | Limited | Not applicable |
| Latest-three recent history behavior | Required | Useful | Partial |
| Per-record delete flow | Required | Useful | Partial |
| Error/unavailable fallback copy | Useful if practical | Useful if practical | Partial |
| Non-medical copy review | Required | Useful | Strong |
| Privacy boundary review | Required | Useful | Strong |

## Manual QA Cases

Each case should be run on a real Apple Watch in Phase 9.21 if hardware is available. If a real device is unavailable, mark the case as simulator-only and record the limitation.

### VO-001 Watch App Launch And Placement

Steps:

1. Launch the StateWatch Watch app.
2. Confirm the score page appears first.
3. Navigate to the next Watch page.
4. Confirm the Check-in page appears second.
5. Confirm Check-in is not shown as a blocking prompt.

Pass criteria:

- The score page remains primary.
- The Check-in page is reachable without confusion.
- No copy implies the user must check in.
- No score, HealthKit, iPhone, WidgetKit, App Group, WatchConnectivity, cloud, or AI behavior is implied.

Fail criteria:

- Check-in blocks access to the score.
- The user cannot discover the Check-in page.
- Copy makes Check-in feel mandatory.

### VO-002 Check-in Option VoiceOver Labels

Steps:

1. Enable VoiceOver.
2. Navigate to each option: `Energized`, `Stable`, `Tired`, and `Low`.
3. Record the spoken label and hint for each option.
4. Repeat in Screen Curtain mode if available.

Pass criteria:

- Every option is understandable without sight.
- Each option is described as a self-reported state.
- The hint says it saves this state on this Watch.
- `Low` is not spoken as a warning, abnormal state, danger state, diagnosis, health risk, or score penalty.

Fail criteria:

- An option cannot be identified.
- Icon Only mode removes meaningful spoken labels.
- Any spoken copy suggests diagnosis, treatment, emergency, health risk, or causality.

### VO-003 Display Preference Selector

Steps:

1. Navigate to the display style selector.
2. Move VoiceOver focus across `Both`, `Icon`, and `Text`.
3. Confirm the full display style is announced.
4. Confirm selected and not selected states are clear.
5. Change from `Icon + Text` to `Icon Only`.
6. Navigate the option list again.
7. Change from `Icon Only` to `Text Only`.
8. Navigate the option list again.

Pass criteria:

- The tester understands the selector controls display style.
- Selected and not selected states are spoken clearly.
- Icon Only remains accessible because VoiceOver still exposes full state labels.
- The selector does not imply iPhone, WidgetKit, App Group, WatchConnectivity, cloud, or cross-device sync.

Fail criteria:

- The selected state is ambiguous.
- Icon Only becomes unusable with VoiceOver.
- The selector sounds like it syncs or changes app data outside the Watch.

### VO-004 Save Feedback

Steps:

1. Select `Energized`.
2. Listen to the confirmation.
3. Return to the Check-in page.
4. Repeat for `Stable`, `Tired`, and `Low`.
5. Confirm recent history updates after each save.

Pass criteria:

- Save feedback is brief and calm.
- Save feedback does not imply score change, HealthKit write, diagnosis, treatment, emergency, or health risk.
- Recent history updates are understandable.
- Selecting `Low` remains subjective and non-warning.

Fail criteria:

- Save feedback suggests a medical or score interpretation.
- Save feedback suggests cloud or cross-device sync.
- Recent history is confusing or inaccessible.

### VO-005 Empty And Recent History States

Steps:

1. Start with no recent Check-ins if practical.
2. Confirm empty copy:
   - `No check-in yet`
   - `Check-ins are optional.`
3. Save one Check-in.
4. Confirm one recent row.
5. Save three Check-ins.
6. Confirm three recent rows.
7. Save more than three Check-ins.
8. Confirm only the latest three are visible.

Pass criteria:

- Empty state is neutral and optional.
- Latest-three boundary is preserved.
- Rows are understandable through VoiceOver.
- Timestamps are context only.
- No trend, streak, count, pattern, cause, insight, interpretation, score, or medical meaning is shown.

Fail criteria:

- More than three recent rows appear.
- Empty history feels negative.
- History appears as a medical log or score input.

### VO-006 Per-record Delete Flow

Steps:

1. Navigate to a recent Check-in row.
2. Focus the delete control.
3. Confirm the delete control identifies which Check-in it deletes.
4. Activate delete.
5. Listen to confirmation copy.
6. Choose `Keep`.
7. Confirm the record remains.
8. Repeat and choose `Delete`.
9. Confirm only that local record is removed.

Pass criteria:

- Delete is understandable without sight.
- Confirmation says local removal from this Watch.
- Keep preserves the selected record.
- Delete removes one local Watch record.
- No cloud deletion, iPhone deletion, WidgetKit deletion, App Group deletion, or score effect is implied.

Fail criteria:

- Delete target is unclear.
- Delete sounds cross-device.
- Delete appears to affect score, HealthKit, iPhone, WidgetKit, App Group, or cloud data.

### VO-007 Small-screen Usability

Steps:

1. Test on the smallest available Apple Watch screen.
2. Repeat with normal text size.
3. Repeat with larger text size if available.
4. Scroll through the Check-in page.
5. Tap options, selector chips, recent rows, delete controls, Keep, and Delete.
6. Record truncation, clipping, hidden controls, or difficult tap targets.

Pass criteria:

- Important text remains usable.
- Controls are tappable.
- VoiceOver focus order is logical.
- No hidden or unreachable control is required for the MVP flow.

Fail criteria:

- A required control is unreachable.
- Important copy is unusably truncated.
- Tap targets are too small to use reliably.

### VO-008 Error And Unavailable States

Steps:

1. If practical in a simulator or debug environment, simulate save unavailable.
2. If practical in a simulator or debug environment, simulate delete unavailable.
3. If practical and safe, inspect behavior with missing or corrupt local history.
4. Do not perform unsafe device setup or destructive changes.

Pass criteria:

- Failure copy remains calm.
- Missing data remains neutral.
- No warning, diagnosis, score penalty, treatment, or emergency meaning is implied.
- The app remains usable.

Fail criteria:

- Failure copy sounds alarming.
- Missing data is treated as a bad health state.
- The app blocks normal Watch use.

### VO-009 Privacy And Non-medical Safety

Steps:

1. Read all visible Watch Check-in copy.
2. Listen to all VoiceOver labels, hints, and values.
3. Confirm the flow does not imply:
   - Check-ins affect State Score.
   - `Low` lowers score.
   - Missing Check-ins are bad.
   - Developers can see Check-ins.
   - Check-ins upload to cloud.
   - Check-ins sync to iPhone or WidgetKit.
   - Check-ins write to HealthKit.
4. Confirm no medical diagnosis, clinical wording, treatment, emergency, abnormal state, health risk, anxiety/depression, symptom history, disease detection, or causal score wording appears.

Pass criteria:

- All copy remains subjective, optional, local-only, and non-medical.
- Privacy boundaries are not overstated or weakened.

Fail criteria:

- Copy suggests diagnosis, clinical stress detection, treatment, health risk, emergency, causality, upload, sync, or HealthKit write behavior.

## Watch Dashboard Placement QA

The Watch app should preserve this order:

1. Score page.
2. Check-in page.
3. Component summary.
4. Suggestion.
5. Confidence / updated context.

The tester should verify Check-in is available but not dominant. It should not block the score page, require completion, or feel like an onboarding gate.

## Check-in Option VoiceOver QA

Approved options:

- `Energized`
- `Stable`
- `Tired`
- `Low`

VoiceOver should announce each as a self-reported state and should use the local save hint. `Low` must remain calm and subjective.

## Display Preference Selector QA

Approved display modes:

- `Icon + Text`
- `Icon Only`
- `Text Only`

Compact selector labels:

- `Both`
- `Icon`
- `Text`

The selector should clearly announce display style and selected state. Changing the selector should only affect how options appear on this Watch.

## Save Feedback QA

Approved save copy remains:

- `Saved`
- `Check-in saved`
- `You can update it later.`

The tester should confirm the feedback is short, optional, local-only in context, and non-medical.

## Recent History QA

Approved empty copy:

- `No check-in yet`
- `Check-ins are optional.`

Recent history should show only the latest three records. The timestamp should read as context only, not as a trend, score, or medical log.

## Delete Flow QA

Approved delete copy:

- `Delete check-in`
- `Remove this local check-in?`
- `This removes it from this Watch.`
- `Delete`
- `Keep`

The tester should confirm deletion is per-record, local to the Watch, and not connected to score, HealthKit, iPhone, WidgetKit, App Group, WatchConnectivity, cloud, or AI behavior.

## Small-screen Usability QA

Prioritize:

- Smallest available Watch size.
- VoiceOver focus order.
- Tappable option rows.
- Tappable selector chips.
- Tappable delete controls.
- Confirmation buttons.
- Scroll reachability.
- Larger text where available.

Record any text truncation, focus traps, repeated labels, ambiguous controls, or hidden required actions.

## Error And Unavailable State QA

Error-state testing is optional if it requires unsafe setup. If practical, verify:

- `Delete unavailable`
- `Try again later.`
- Save unavailable confirmation copy.
- Missing or corrupt local history fallback.

No unavailable state should imply a bad health state or score penalty.

## Privacy And Non-medical Safety QA

Check-ins should remain:

- Subjective.
- Optional.
- Local-only.
- Watch-only.
- Non-medical.
- Non-causal.
- Not score-integrated.
- Not HealthKit-writing.
- Not synced to iPhone, WidgetKit, App Group, WatchConnectivity, cloud, AI, analytics, or accounts.

## Regression Guardrails

Confirm:

- Four states remain exactly `Energized`, `Stable`, `Tired`, and `Low`.
- Traditional Chinese reference labels remain exactly `有活力`, `穩定`, `疲累`, and `低狀態`.
- Display modes remain exactly `Icon + Text`, `Icon Only`, and `Text Only`.
- Default display remains `Icon + Text`.
- Latest-three remains the visible recent history limit.
- No latest-five history appears.
- No clear-all UI appears.
- No iPhone Check-in UI, history, deletion, or management appears.
- Old iPhone CheckInView scaffold is not addressed in this phase.
- No WidgetKit Check-in display, summary, or direct read appears.
- No App Group raw Check-in history, propagation, or display preference propagation appears.
- No WatchConnectivity appears.
- No State Score integration appears.
- No HealthKit write appears.
- No networking, cloud, iCloud, analytics, AI, account, remote config, reminders, notifications, notes, export, trends, streaks, counts, causes, interpretations, pattern summaries, or insights appear.

## Pass/fail Criteria

Pass:

- Every required test case has evidence.
- No case claims real-device coverage without a real device.
- VoiceOver users can identify and use each Check-in option.
- Icon Only remains accessible.
- Display selected state is clear.
- Recent history remains latest-three and neutral.
- Delete remains per-record and local.
- Copy remains calm, optional, subjective, local-only, and non-medical.
- No prohibited behavior or scope appears.

Fail:

- VoiceOver cannot identify a required control.
- Icon Only hides meaning from VoiceOver users.
- Selector selected state is unclear.
- Recent history implies trend, score, count, cause, or medical meaning.
- Delete target is unclear or sounds cross-device.
- `Low` sounds like warning, diagnosis, abnormal state, or score penalty.
- Any copy implies HealthKit write, iPhone sync, WidgetKit display, App Group propagation, WatchConnectivity, cloud upload, AI analysis, analytics, or developer access to Check-ins.

## Issue Reporting Template

```text
Title:
Phase:
Test case ID:
Environment:
Device / simulator:
OS version:
Build / commit:
VoiceOver setting:
Screen Curtain setting:
Steps to reproduce:
Expected result:
Actual result:
Pass/fail impact:
Privacy or medical-safety concern:
Screenshot / recording:
Suggested next phase:
Notes:
```

Do not include personal health data in public issues.

## Recommended Phase 9.21 Execution Scope

Phase 9.21 should execute this real-device VoiceOver QA plan.

Phase 9.21 should:

- Record actual results from a real Apple Watch if available.
- Clearly identify the Apple Watch model and watchOS version.
- Clearly identify paired iPhone and iOS version if real-device testing is used.
- Use the evidence template in this document.
- Clearly mark simulator-only checks if a real device is unavailable.
- Record limitations if Screen Curtain, small-screen hardware, or larger text settings are unavailable.
- Avoid fixing Swift issues unless a separate implementation phase is opened.
- Recommend small, separate follow-up PRs for any production fixes.

Phase 9.21 should not:

- Add product behavior.
- Change storage or schema.
- Add iPhone Check-in UI.
- Add WidgetKit Check-in display.
- Add App Group Check-in propagation.
- Add WatchConnectivity.
- Add State Score integration.
- Add HealthKit write access.
- Add networking, cloud, AI, analytics, accounts, remote config, reminders, notifications, notes, exports, trends, streaks, counts, causes, interpretations, pattern summaries, or insights.

## Explicit Non-goals

- This plan does not validate medical efficacy.
- This plan does not validate clinical meaning.
- This plan does not validate HealthKit scoring.
- This plan does not validate iPhone Check-in.
- This plan does not validate WidgetKit Check-in.
- This plan does not validate App Group Check-in sharing.
- This plan does not validate WatchConnectivity.
- This plan does not validate cloud sync.
- This plan does not authorize implementation changes.

## Risks / Limitations

- Source review cannot confirm real VoiceOver spoken cadence.
- Simulator testing cannot fully confirm physical tap ergonomics.
- A larger Apple Watch simulator cannot stand in for the smallest physical screen.
- Screen Curtain no-vision simulation may not be available in every test environment.
- If a real Apple Watch is unavailable, Phase 9.21 must clearly record simulator-only limitations.
- Real-device results may require a later Swift fix phase, but fixes should not be bundled into QA execution unless explicitly approved.

## Changes Made

- Added this Phase 9.20 real-device VoiceOver QA plan.
- Added Phase 9.20 checklist coverage to `TEST_PLAN.md`.

No production Swift, Xcode project, entitlement, CI workflow, or product behavior changes were made.

## Validation Results

- `git diff --check origin/main...HEAD` passed.
- `git diff --cached --check` passed.
- `plutil -lint StateWatch.xcodeproj/project.pbxproj` passed.
- Post-change boundary searches were run and reviewed.
- Simulator builds were not required because Phase 9.20 changed only documentation and TEST_PLAN coverage.

## Final Phase 9.20 Checklist

- Phase 9.20 QA plan document exists.
- Phase 9.20 is QA planning/documentation-only.
- No real-device QA result is claimed.
- No Swift files changed.
- No Xcode project files changed.
- No entitlement files changed.
- No CI workflow files changed.
- No product behavior changed.
- Watch Check-in remains Watch-only.
- Watch Check-in remains local-only.
- Four states remain `Energized`, `Stable`, `Tired`, and `Low`.
- Traditional Chinese reference labels remain `有活力`, `穩定`, `疲累`, and `低狀態`.
- Display modes remain `Icon + Text`, `Icon Only`, and `Text Only`.
- Default display remains `Icon + Text`.
- Latest-three recent history remains unchanged.
- No latest-five history was added.
- No clear-all UI was added.
- No long-term history was added.
- No notes, export, reminders, notifications, trends, streaks, counts, causes, interpretations, pattern summaries, or insights were added.
- No iPhone Check-in UI, history, deletion, or management was added.
- Old iPhone CheckInView scaffold was not addressed.
- No WidgetKit Check-in display, summary, or direct read was added.
- No App Group raw Check-in history, Check-in propagation, or display preference propagation was added.
- No WatchConnectivity was added.
- No State Score integration was added.
- No HealthKit write access or write authorization was added.
- No networking, cloud sync, iCloud sync, analytics, AI, accounts, login, upload path, or remote config was added.
- Manual real-device VoiceOver test cases are defined.
- Pass/fail criteria are defined.
- Evidence template is defined.
- Issue reporting template is defined.
- Recommended Phase 9.21 execution scope is defined but not started.
- Local validation passed.
- GitHub Actions status should be reviewed after PR creation.
- No Phase 9.21 work was started.
