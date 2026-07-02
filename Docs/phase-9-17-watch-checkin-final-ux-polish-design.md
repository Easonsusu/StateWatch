# Phase 9.17 Watch Check-in Final UX Polish Design

## Purpose

Phase 9.17 reviews the current Watch-only State Check-in MVP flow and defines the smallest safe UX polish scope for a later implementation phase.

This is a design and documentation phase only. It does not add product behavior, change Swift source, change project settings, or expand the Check-in data boundary.

## Scope

In scope:

- Review the existing Watch Check-in placement.
- Review labels, layout, save feedback, recent history, timestamps, delete flow, accessibility, and small-screen usability.
- Confirm the MVP remains Watch-only and local-only.
- Define acceptance criteria for a future Phase 9.18 implementation.

Out of scope:

- Swift implementation.
- iPhone Check-in UI, history, or deletion.
- WidgetKit Check-in display or summaries.
- App Group propagation of raw Check-in history.
- WatchConnectivity.
- State Score integration.
- HealthKit write access.
- Networking, cloud sync, analytics, AI, accounts, remote config, reminders, notifications, notes, export, trends, streaks, counts, causes, interpretations, pattern summaries, or insights.

## Files reviewed

- `Docs/phase-9-0-state-checkin-architecture.md`
- `Docs/phase-9-1-state-checkin-architecture-qa.md`
- `Docs/phase-9-2-watch-checkin-figma-mockups.md`
- `Docs/phase-9-3-watch-checkin-mock-ui.md`
- `Docs/phase-9-4-watch-checkin-mock-ui-qa.md`
- `Docs/phase-9-5-state-checkin-local-storage-design.md`
- `Docs/phase-9-6-state-checkin-local-storage-design-qa.md`
- `Docs/phase-9-7-watch-checkin-local-storage-foundation.md`
- `Docs/phase-9-8-watch-checkin-local-storage-foundation-qa.md`
- `Docs/phase-9-9-watch-checkin-display-preference.md`
- `Docs/phase-9-10-watch-checkin-display-preference-qa.md`
- `Docs/phase-9-11-watch-checkin-history-management-design.md`
- `Docs/phase-9-12-watch-checkin-history-management-design-qa.md`
- `Docs/phase-9-13-watch-checkin-recent-history-deletion-foundation.md`
- `Docs/phase-9-14-watch-checkin-recent-history-deletion-qa.md`
- `Docs/phase-9-15-mvp-checkin-boundary-decision.md`
- `Docs/phase-9-16-mvp-checkin-boundary-qa.md`
- `Docs/medical-safety-wording.md`
- `Docs/ui-copy-guidelines.md`
- `TEST_PLAN.md`
- `PRD.md`
- `PRIVACY_POLICY_DRAFT.md`
- `APP_STORE_CHECKLIST.md`
- `StateWatchApp/Models/StateCheckInOption.swift`
- `StateWatchWatchApp/Features/WatchDashboardView.swift`
- `StateWatchWatchApp/Features/WatchCheckInView.swift`
- `StateWatchWatchApp/Services/CheckIn/StateCheckInRecord.swift`
- `StateWatchWatchApp/Services/CheckIn/LocalStateCheckInStore.swift`
- `StateWatchWatchApp/Services/CheckIn/StateCheckInDisplayPreference.swift`
- `StateWatchTests/StateCheckInStorageTests.swift`
- `StateWatchTests/StateWatchThemeTests.swift`
- `StateWatch.xcodeproj/project.pbxproj`

## Search terms used

The audit searched for current Watch Check-in UI, state, boundary, privacy, and medical-safety terms, including:

- `WatchCheckInView`
- `WatchDashboardView`
- `State Check-in`
- `check-in`
- `Recent check-ins`
- `No check-in yet`
- `Check-ins are optional`
- `Delete check-in`
- `Remove this local check-in`
- `This removes it from this Watch`
- `display mode`
- `Icon + Text`
- `Icon Only`
- `Text Only`
- `Energized`
- `Stable`
- `Tired`
- `Low`
- `accessibility`
- `VoiceOver`
- `Dynamic Type`
- `small screen`
- `tap target`
- `history`
- `recent`
- `delete`
- `empty`
- `unavailable`
- `success`
- `saved`
- `optional`
- `WatchConnectivity`
- `WCSession`
- `WidgetKit check-in`
- `App Group raw`
- `State Score integration`
- `HealthKit write`
- `URLSession`
- `cloud`
- `iCloud`
- `analytics`
- `AI cloud`
- `diagnosis`
- `clinical`
- `medical advice`
- `treatment`
- `emergency`
- `warning`
- `abnormal`
- `health risk`
- `anxiety`
- `depression`
- `detected`
- `caused by`

Search results were consistent with existing guardrails, approved implementation, test coverage, and documentation. No issue found in this design phase required Swift changes.

## Current Watch Check-in UX summary

The current MVP flow is:

1. The Watch dashboard opens with the score page first.
2. The Check-in page appears as the second page in the Watch `TabView`.
3. The Check-in page asks, "How do you feel right now?"
4. The user can select one of four subjective states: `Energized`, `Stable`, `Tired`, or `Low`.
5. The display preference selector controls whether rows show icon and text, icon only, or text only.
6. Saving a Check-in writes a Watch-local record and shows a short confirmation.
7. The Watch shows the latest three local records.
8. The user can delete one local record at a time.

This flow is appropriately small for MVP. It treats Check-ins as optional context and does not connect them to the score, HealthKit, iPhone, WidgetKit, App Group, or WatchConnectivity.

## Dashboard placement review

`WatchDashboardView` keeps the score page first, then presents `WatchCheckInView` as the second page.

This placement is acceptable for MVP because:

- The main score remains the first glance.
- Check-in is reachable without replacing or competing with the score surface.
- The flow feels optional because it is a separate page rather than a blocking prompt.
- No iPhone or WidgetKit surface is introduced.

Recommendation:

- Keep the Check-in page as the second Watch page for MVP.
- Do not add a new entry point in Phase 9.18 unless real-device QA shows discoverability is poor.
- If any placement polish is needed, limit it to wording or spacing within the existing Watch page.

## Check-in option review

The approved states are:

- `Energized`
- `Stable`
- `Tired`
- `Low`

The labels are subjective and user-reported. They do not imply diagnosis, clinical status, treatment advice, or a score change.

The current vertical option layout is appropriate because:

- It preserves readable labels.
- It keeps each choice visually distinct.
- It avoids compressing four states into a cramped horizontal layout.
- It remains understandable in `Text Only` mode.
- It can remain accessible in `Icon Only` mode through accessibility labels.

`Low` is currently visually muted rather than urgent. That is the correct tone. It should not use warning-style copy, emergency styling, or red alarm treatment.

Recommendation:

- Keep all four labels unchanged.
- Keep `Low` calm, muted, and subjective.
- Keep the vertical option layout.
- In Phase 9.18, only adjust row spacing, padding, or text scaling if real-device review shows cramped layout on smaller Watch screens.

## Display preference selector review

The current display modes are:

- `Icon + Text`
- `Icon Only`
- `Text Only`

The compact selector labels are:

- `Both`
- `Icon`
- `Text`

This is acceptable for MVP because:

- The full mode labels remain available in code and accessibility labels.
- The default mode is `Icon + Text`, which is the most understandable option.
- The preference remains Watch-local.
- The preference does not propagate through App Group, iPhone, WidgetKit, or WatchConnectivity.

Potential polish:

- The selector may visually compete with the option list on small screens.
- Phase 9.18 may make the selector visually lighter, while keeping it in the existing Watch Check-in page.
- Phase 9.18 should not move this preference to iPhone or propagate it outside the Watch app.

Recommendation:

- Keep the current modes and labels.
- Keep the Watch-local storage boundary.
- Consider lighter visual emphasis only if real-device QA shows the selector feels too prominent.

## Save feedback review

Current success copy:

- `Saved`
- `Check-in saved`
- `You can update it later.`

Current unavailable copy:

- `Unavailable`
- `Check-in unavailable`
- `Try again later.`

This copy is calm, short, and non-medical. It avoids implying that a Check-in changes the user's state, score, HealthKit data, or dashboard interpretation.

Recommendation:

- Keep the success flow brief.
- Keep failure copy calm and non-alarming.
- Do not add a score, suggestion, HealthKit, WidgetKit, or iPhone side effect after save.
- If Phase 9.18 changes copy, keep it equally short and optional.

## Recent history review

The current recent history scope is latest three records.

Current empty copy:

- `No check-in yet`
- `Check-ins are optional.`

Current history row content:

- State label.
- Timestamp.
- Optional icon depending on display preference.
- Per-record delete button.

Latest-three is the right MVP boundary because:

- It gives short-term context without creating a long-term record surface.
- It fits Watch glanceability better than latest-five or longer history.
- It avoids trends, streaks, counts, causes, pattern summaries, or interpretations.
- It keeps deletion understandable and local.

Recommendation:

- Keep latest-three.
- Do not add latest-five.
- Do not add long-term history.
- Do not add counts, streaks, trend lines, or pattern summaries.
- Keep empty history copy neutral.

## Timestamp review

The current timestamp behavior uses:

- `Today` plus a shortened time for same-day records.
- `Yesterday` for prior-day records.
- Numeric date for older records.

This is enough for a latest-three MVP list. It keeps context readable without creating analysis or interpretation.

Recommendation:

- Keep timestamp formatting unchanged for Phase 9.18 unless real-device QA shows truncation.
- Do not add elapsed-time analysis, duration, trend inference, or cause language.

## Delete flow review

Current delete prompt:

- `Remove this local check-in?`
- `This removes it from this Watch.`

Current actions:

- `Delete`
- `Keep`

The flow is aligned with the privacy boundary because it clearly says the record is local to this Watch. It also avoids implying medical record deletion or cloud deletion.

Recommendation:

- Keep per-record deletion.
- Do not add clear-all.
- Do not add iPhone deletion.
- Do not add WidgetKit, App Group, WatchConnectivity, or cloud deletion behavior.
- Phase 9.18 may only tune button sizing, spacing, or accessibility labels if manual Watch QA shows tap issues.

## Accessibility review

Current strengths:

- Option buttons use accessibility labels such as "`Energized`, self-reported state".
- The display selector exposes full mode labels through accessibility.
- Empty history combines the title and optional-message copy.
- Delete buttons include the record label.
- Icon-only mode should remain understandable to assistive technologies.

Potential areas for Phase 9.18:

- Verify VoiceOver reading order for recent history rows and delete buttons.
- Confirm the display preference selector reads as a control group.
- Confirm the delete confirmation reads the prompt, detail, and actions clearly.
- Confirm `Icon Only` mode does not become icon-only for accessibility users.

Recommendation:

- Treat VoiceOver QA as a required Phase 9.18 acceptance criterion.
- Any accessibility change should stay within the existing Watch Check-in view.

## Small-screen usability review

The current Check-in page uses a `ScrollView`, compact text sizes, and minimum scale factors. That is appropriate for Watch screens because the page includes a selector, four options, recent history, and possible delete confirmation.

Potential risk:

- On smaller Watch screens, the selector plus four options plus latest-three history may require careful scrolling.
- The delete button target should be checked on device or simulator.
- History rows should remain readable when text-only mode or icon-only mode is active.

Recommendation:

- Phase 9.18 should verify the flow on the smallest supported Watch simulator or device available.
- Keep polish limited to spacing, text scaling, row padding, and accessibility labels.
- Do not add new content to the page.

## Error and unavailable state review

The current local store returns an empty list when history is missing or unreadable. Save and delete failures use calm unavailable copy.

This is acceptable because:

- Missing data is neutral.
- A missing Check-in history does not become a negative state.
- There is no upload, retry loop, or remote dependency.
- The flow remains usable without prior records.

Recommendation:

- Keep unavailable states brief and calm.
- Do not add alarming wording.
- Do not add cloud recovery, account recovery, or sync language.

## Privacy and non-medical safety review

The current Watch Check-in flow is aligned with StateWatch safety rules:

- Check-ins are subjective self-reports.
- Check-ins stay Watch-local.
- Check-ins do not affect the State Score.
- Missing Check-ins remain neutral.
- `Low` is not treated as a warning, diagnosis, or score-lowering signal.
- No HealthKit write access is used.
- No networking, cloud, iCloud, analytics, AI, accounts, or remote config are involved.
- No WidgetKit, App Group, WatchConnectivity, or iPhone Check-in propagation is added.

Future implementation must preserve these boundaries.

## Final UX polish recommendations

Recommended Phase 9.18 scope:

1. Keep Watch Dashboard page order unchanged unless real-device QA shows a clear issue.
2. Keep the four Check-in labels unchanged.
3. Keep the display preference modes unchanged.
4. Keep latest-three history unchanged.
5. Keep per-record deletion unchanged.
6. Verify and, if needed, lightly tune Watch-only spacing and tap targets.
7. Verify and, if needed, lightly tune VoiceOver labels and reading order.
8. Verify small-screen readability for option rows, selector labels, history rows, timestamps, and delete confirmation.
9. Keep save, empty, unavailable, and delete copy calm and non-medical.
10. Add or update tests only for copy, boundaries, or accessibility-related constants that are practical to test without fragile layout assertions.

## Recommended Phase 9.18 implementation scope

Phase 9.18 should be a small Watch-only UX polish implementation. It may include:

- Minor spacing or padding adjustments in `WatchCheckInView`.
- Minor text scaling or line-limit adjustments in `WatchCheckInView`.
- Minor visual de-emphasis of the display selector if needed.
- Accessibility label or grouping refinements.
- Documentation and TEST_PLAN updates.
- Focused tests for copy or boundary constants if existing tests make that practical.

Phase 9.18 should not include:

- New Check-in states.
- New storage behavior.
- New surfaces.
- New sync behavior.
- New HealthKit, scoring, WidgetKit, App Group, or iPhone integration.

## Explicit non-goals

- No Swift implementation in Phase 9.17.
- No change to `WatchCheckInView`.
- No change to `LocalStateCheckInStore`.
- No change to `StateCheckInRecord`.
- No change to `StateCheckInOption`.
- No change to Xcode project files.
- No change to entitlements.
- No change to CI workflows.
- No iPhone Check-in UI, history, or deletion.
- No removal or refactor of the old iPhone `CheckInView` scaffold.
- No WidgetKit Check-in display, summary, or direct read.
- No App Group raw Check-in history or display preference propagation.
- No WatchConnectivity.
- No State Score integration.
- No HealthKit write access.
- No networking, cloud sync, iCloud sync, analytics, AI, accounts, or remote config.
- No clear-all UI.
- No notes, export, reminders, notifications, trends, streaks, counts, causes, interpretations, pattern summaries, or insights.

## Acceptance criteria for Phase 9.18

Phase 9.18 should be accepted only if:

- The implementation remains Watch-only and local-only.
- The Watch score page remains first.
- The Check-in page remains optional.
- The four labels remain `Energized`, `Stable`, `Tired`, and `Low`.
- Traditional Chinese reference labels remain `有活力`, `穩定`, `疲累`, and `低狀態`.
- Display modes remain `Icon + Text`, `Icon Only`, and `Text Only`.
- The default display mode remains `Icon + Text`.
- Recent history remains latest-three.
- Delete remains per-record only.
- Missing history remains neutral.
- `Low` remains subjective, non-medical, non-warning, and non-score-lowering.
- No new iPhone, WidgetKit, App Group, WatchConnectivity, State Score, HealthKit write, networking, cloud, AI, analytics, account, or remote config behavior is added.
- VoiceOver can identify the screen, selector, options, saved state, recent rows, timestamps, delete button, and delete confirmation.
- Small-screen layout remains readable and tappable.
- Copy remains calm, subjective, and non-medical.
- Local validation passes before PR creation.

## Manual real-device QA notes

When Phase 9.18 is implemented, manual QA should include:

- Open the Watch app and confirm the score page remains first.
- Swipe to Check-in and confirm entry feels optional.
- Confirm all four state rows are readable.
- Confirm `Low` does not look like an alert or warning.
- Change display preference to each mode and confirm the options remain understandable.
- Save each state and confirm save feedback is brief and calm.
- Confirm latest-three recent history updates after saves.
- Confirm timestamps are readable.
- Delete one record and confirm only that record is removed.
- Confirm delete prompt says the record is local to this Watch.
- Confirm no clear-all action appears.
- Confirm VoiceOver reads options and recent history clearly.
- Confirm the page is usable on a small Watch screen.
- Confirm iPhone dashboard, WidgetKit complications, State Score, App Group summary, and HealthKit behavior are unchanged.

## Risks / open questions

- The display preference selector may be useful but visually prominent on smaller Watch screens.
- The delete button may need real-device tap-target validation.
- VoiceOver reading order should be verified with the actual Watch UI.
- The old iPhone `CheckInView` scaffold remains out of scope and should not be addressed in Phase 9.18 unless separately approved.
- Any future iPhone, WidgetKit, App Group, WatchConnectivity, or State Score Check-in work needs its own design, privacy, deletion, consistency, and QA phase.

## Changes made

Phase 9.17 changes are documentation-only:

- Added this UX polish design document.
- Added a Phase 9.17 checklist to `TEST_PLAN.md`.

No Swift source, Xcode project, entitlement, CI workflow, asset, or product behavior changes were made.

## Final Phase 9.17 checklist

- Confirm this document exists.
- Confirm Phase 9.17 is design/documentation-only.
- Confirm no Swift files changed.
- Confirm no Xcode project files changed.
- Confirm no entitlement files changed.
- Confirm no CI workflow files changed.
- Confirm no product behavior changed.
- Confirm Watch Check-in remains Watch-only.
- Confirm Watch Check-in remains local-only.
- Confirm latest-three history remains the MVP boundary.
- Confirm no latest-five history was added.
- Confirm no clear-all UI was added.
- Confirm no iPhone Check-in UI, history, or deletion was added.
- Confirm no old iPhone `CheckInView` scaffold work was done.
- Confirm no WidgetKit Check-in display, summary, or direct read was added.
- Confirm no App Group raw Check-in history or display preference propagation was added.
- Confirm no WatchConnectivity was added.
- Confirm no State Score integration was added.
- Confirm no HealthKit write access or write authorization was added.
- Confirm no networking, cloud sync, iCloud sync, analytics, AI, account system, login, upload path, or remote config was added.
- Confirm no notes, export, reminders, notifications, trends, streaks, counts, causes, interpretations, pattern summaries, or insights were added.
- Confirm missing Check-ins remain neutral.
- Confirm `Low` remains subjective, non-medical, non-warning, and non-score-lowering.
- Confirm Phase 9.18 scope is limited to Watch-only UX polish.
- Confirm no Phase 9.18 implementation work was started.
