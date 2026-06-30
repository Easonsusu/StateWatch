# Phase 9.11 Watch Check-in History Management Design

## Purpose

Phase 9.11 designs future Watch-only State Check-in history management before
any implementation begins.

The goal is to define a calm, local-only, non-medical direction for showing a
small recent check-in history and for deleting check-ins on Apple Watch. This
phase is documentation-only and does not change product behavior.

## Scope

This design covers:

- Whether the Watch app should show recent check-ins.
- How many recent check-ins should be shown.
- Whether the Watch app should support deleting one check-in.
- Whether the Watch app should support clear-all check-ins.
- Empty, missing, and sparse history behavior.
- How `Low` check-ins should be shown without alarm or medical meaning.
- Calm copy for history and deletion flows.
- Accessibility, privacy, storage, and App Store safety requirements.
- Boundaries for HealthKit, WidgetKit, App Group, WatchConnectivity, iPhone,
  State Score, networking, cloud, analytics, AI, and reminders.
- Future implementation and QA sequencing.

## Non-goals

Phase 9.11 does not:

- Implement history UI.
- Implement deletion UI.
- Implement clear-all UI.
- Add settings UI.
- Add export.
- Add reminders, notifications, scheduling, or background delivery.
- Add notes or free-form text.
- Add pattern summaries or trend analysis.
- Modify `WatchCheckInView`.
- Modify `StateCheckInRecord`.
- Modify `LocalStateCheckInStore`.
- Modify `StateCheckInDisplayPreference`.
- Modify Xcode project files.
- Add tests unless a concrete documentation consistency issue requires it.
- Add iPhone check-in UI or behavior.
- Add WidgetKit check-in display or direct check-in reads.
- Add App Group check-in propagation.
- Store raw check-in history in App Group.
- Store display preference in App Group.
- Add WatchConnectivity.
- Change HealthKit rollout behavior.
- Enable the HealthKit-backed Dashboard by default.
- Add HealthKit write access or write authorization.
- Store raw HealthKit samples in check-in records.
- Add networking, cloud sync, iCloud sync, analytics, remote config, accounts,
  AI, or AI cloud analysis.
- Let check-ins or missing check-ins affect State Score.

## Current Phase 9.7 Through 9.10 Baseline

Phase 9.7 added a Watch-only local storage foundation for subjective check-ins:

- `StateCheckInRecord`
- `StateCheckInStoring`
- `LocalStateCheckInStore`
- Local JSON storage in the Watch app container
- Newest-first `loadRecent(limit:)`
- Safe `loadAll()` empty-history behavior
- Safe corrupted-data fallback to empty history
- Safe unsupported-future-schema fallback
- `clearAll()` for future delete-all UI and tests

Phase 9.9 added a Watch-only display preference:

- `iconAndText`
- `iconOnly`
- `textOnly`

Phase 9.10 confirmed the display preference remains Watch-only, local-only,
non-medical, accessibility-preserving, and disconnected from HealthKit,
WidgetKit, App Group shared state, WatchConnectivity, iPhone behavior, and
State Score.

## Product Problem

After Watch check-ins can be saved locally, users may need a way to understand
what they recently selected and remove entries they no longer want to keep.

The history feature must stay narrow because check-ins are subjective wellness
context. The UI should not feel like a medical record, symptom tracker, mood
disorder log, diagnosis surface, treatment plan, risk monitor, or alerting
system.

## Design Recommendation

Use a small Watch-only recent history surface if implementation proceeds in a
later phase.

Recommended first version:

- Show the latest 3 check-ins by default.
- Permit a maximum of 5 recent check-ins only if the screen remains readable on
  smaller Apple Watch sizes.
- Use timestamp context only, such as `Today 12:40` or `Yesterday`.
- Show the selected subjective state label and optional icon.
- Do not show trends, counts, streaks, causes, or interpretations.
- Do not summarize patterns.
- Do not connect check-ins to State Score.
- Include deletion only after copy and accessibility QA are reviewed.

If the Watch screen feels crowded in implementation, defer the visible history
list and implement deletion in a separate simple management surface later.

## Watch-only Surface Decision

The first history management UI should be Watch-only because the existing
storage and entry flow are Watch-only.

Do not add iPhone read-only display, iPhone editing, iPhone deletion, or iPhone
settings in the same implementation phase. If iPhone check-in visibility is
needed later, it should have a separate design and QA phase.

## Recent History Display Design

Recommended future layout:

```text
Recent check-ins
Stable       Today 12:40
Tired        Today 09:15
Energized    Yesterday
```

Display rules:

- Keep the heading short: `Recent check-ins`.
- Show only user-selected subjective labels.
- Use derived labels from `StateCheckInOption`, not stored localized text.
- Keep timestamp text secondary and compact.
- Use neutral styling for all options.
- Use muted styling for `Low`, not red-alert styling.
- Avoid long explanations inside the Watch history list.
- Avoid pattern summaries such as "3 low check-ins this week".
- Avoid causal summaries such as "Low because you slept less".

Recommended visible limit:

- First choice: latest 3 check-ins.
- Optional later expansion: latest 5 check-ins if usability testing shows enough
  room.

The list should rely on the existing `LocalStateCheckInStore.loadRecent(limit:)`
behavior, which already returns newest-first records and safely handles empty or
corrupted storage as empty history.

## Single-record Deletion Design

Single-record deletion is useful if a user taps the wrong state or wants to
remove one entry.

Recommended future behavior:

- Prefer single-record deletion if the interaction can remain simple on Watch.
- Use a standard Watch interaction pattern such as a row action, detail sheet,
  or simple confirmation.
- Confirm before deleting if the action is not obviously reversible.
- Do not describe deletion as deleting a medical record.
- Do not add edit notes, reasons, symptoms, or interpretation fields.

Allowed copy:

```text
Delete check-in
Remove this local check-in?
This removes it from this Watch.
```

Avoid copy:

```text
Delete health record
Delete symptom history
Remove risk event
```

Storage impact:

- The current `LocalStateCheckInStore` does not expose `delete(id:)`.
- If single-record deletion is implemented later, add a minimal store method
  such as `delete(id:)`.
- Keep deletion local to the Watch app container.
- Preserve safe behavior if the record is already missing.

## Clear-all Design

Clear-all is privacy-useful but more destructive than single-record deletion.
It should be available only after confirmation copy is reviewed.

Recommended future behavior:

- Provide clear-all in a secondary management surface, not as a prominent
  primary action on the check-in screen.
- Use an explicit confirmation.
- Explain that this removes local Watch check-ins only.
- Do not imply cloud deletion, account deletion, or HealthKit deletion.
- Do not promise permanent erasure from device backups unless that has been
  verified and documented.

Allowed copy:

```text
Clear check-ins
This removes local check-ins from this Watch.
```

Avoid copy:

```text
Clear medical history
Erase health risk log
Delete clinical records
```

Storage impact:

- Existing `LocalStateCheckInStore.clearAll()` is enough for a later clear-all
  implementation.
- Do not move records to `UserDefaults`.
- Do not move records to App Group.
- Do not add cloud sync or export.

## Empty History Behavior

When there are no saved check-ins, use calm neutral copy:

```text
No check-ins yet
Check-ins are optional.
```

Empty history must not:

- Lower State Score.
- Lower readiness confidence by itself.
- Show a negative state.
- Suggest the user missed something important.
- Trigger warnings, reminders, notifications, or alerts.

## Low Check-in Display Behavior

`Low` remains a subjective self-report label.

Recommended behavior:

- Display `Low` with the same hierarchy as other check-in options.
- Use muted color or restrained styling.
- Do not use red, danger, emergency, risk, warning, or abnormal-state styling.
- Do not pair `Low` with medical explanations or treatment suggestions.
- Do not make `Low` affect State Score automatically.

Allowed copy:

```text
Low
You reported Low.
```

Avoid copy:

```text
Health warning
Abnormal state
Risk detected
Clinical stress
```

## Missing Check-in Behavior

Missing check-ins remain neutral.

A missing check-in must not:

- Reduce State Score.
- Reduce component scores.
- Reduce HealthKit-derived scoring.
- Reduce confidence by itself.
- Imply the user did something wrong.
- Create a warning or negative wellness conclusion.

Allowed copy:

```text
No check-ins yet
Check-ins are optional.
```

Avoid copy:

```text
Missing check-in lowered your score.
You need to check in.
```

## Copy Guidelines

Use:

- `Recent check-ins`
- `No check-ins yet`
- `Saved on this Watch`
- `Delete check-in`
- `Clear check-ins`
- `This removes local check-ins from this Watch.`
- `Check-ins are optional.`
- `Check-ins do not affect your State Score.`

Avoid:

- `Health warning`
- `Abnormal state`
- `Risk detected`
- `Anxiety detected`
- `Depression detected`
- `Clinical stress`
- `Symptom history`
- `Treatment suggestion`
- `Medical record`
- `Emergency`
- `Your score dropped because of this check-in`

Correlation wording must stay non-causal.

Allowed:

```text
On days with lower sleep, you more often reported feeling tired.
```

Not allowed:

```text
You feel tired because you slept less.
```

Pattern wording remains out of scope for Phase 9.11 and should not be added to
the first history management implementation.

## Accessibility Requirements

Future implementation should include:

- Clear accessibility labels for the history heading and each row.
- Full state labels even when a compact visual mode is selected.
- Date or relative-time context that is understandable with VoiceOver.
- Delete and clear-all actions with explicit labels.
- Confirmation copy that clearly states what will be removed.
- Touch targets appropriate for Apple Watch.
- Text that remains readable on smaller Watch sizes.
- No reliance on color alone to communicate state.

Example row accessibility label:

```text
Stable check-in, saved today at 12:40.
```

## Privacy Requirements

History management must remain:

- Local-only.
- Watch-only for the first implementation.
- Account-free.
- Cloud-free.
- Developer-inaccessible.
- AI-cloud-free.
- Analytics-free.
- Remote-config-free.
- Advertising-profile-free.
- HealthKit-write-free.

Deletion copy must be honest about scope. If data is stored only in the Watch app
container, copy should say local Watch check-ins, not Apple Health data, cloud
data, account data, or medical records.

## Data Model Impact

Prefer no `StateCheckInRecord` schema change for the first history UI.

Existing fields are enough for recent history display:

- `id`
- `option`
- `createdAt`
- `updatedAt`
- `sourceSurface`
- `schemaVersion`
- `noteStatus`

Do not add:

- Notes.
- Symptoms.
- Mood diagnosis fields.
- Health reason fields.
- Treatment fields.
- HealthKit sample references.
- Cloud identifiers.
- Account identifiers.
- Analytics identifiers.
- AI profile fields.

## Storage Impact

Existing `LocalStateCheckInStore` supports:

- `save(_:)`
- `loadRecent(limit:)`
- `loadAll()`
- `clearAll()`

For the first recent-history list, `loadRecent(limit:)` should be enough.

For clear-all, existing `clearAll()` should be enough.

For single-record deletion, a later implementation phase can add a minimal
method such as:

```swift
delete(id:)
```

Do not add that method in Phase 9.11.

Do not:

- Replace `LocalStateCheckInStore`.
- Move check-in history into `UserDefaults`.
- Move check-in history into App Group.
- Add SwiftData, CoreData, database storage, cloud sync, export, or account
  storage.

## HealthKit Boundary

Check-in history is user-entered subjective context.

It must not:

- Fetch HealthKit.
- Write to HealthKit.
- Request HealthKit write authorization.
- Store raw HealthKit samples.
- Store HealthKit object identifiers.
- Present check-ins as detected from Apple Health.
- Treat HealthKit-derived scoring as proof of a check-in.

HealthKit remains read-only for the MVP.

## WidgetKit Boundary

WidgetKit complications must not directly read check-in records.

Phase 9.11 does not add:

- WidgetKit check-in display.
- WidgetKit check-in timeline data.
- WidgetKit access to local check-in JSON.
- WidgetKit access to `LocalStateCheckInStore`.

Any future WidgetKit check-in idea must first define a compact, privacy-reviewed
summary model and deletion/freshness behavior. Raw check-in history should stay
out of WidgetKit.

## App Group Boundary

App Group shared state must not store raw check-in history or notes.

Phase 9.11 does not add:

- App Group check-in propagation.
- App Group storage for check-in records.
- App Group storage for display preference.
- App Group storage for deletion state.

Existing App Group shared readiness summary behavior remains separate and
mock/summary-oriented.

## WatchConnectivity Boundary

WatchConnectivity remains out of scope.

Do not add `WCSession`, iPhone-to-Watch check-in sync, Watch-to-iPhone check-in
sync, or conflict resolution in the first history management phase.

Cross-device check-in propagation requires a separate design, implementation,
and QA sequence.

## iPhone Boundary

The iPhone app remains outside the Watch Check-in history flow.

Phase 9.11 does not design or implement:

- iPhone check-in entry.
- iPhone check-in history.
- iPhone check-in deletion.
- iPhone check-in settings.
- iPhone check-in export.
- iPhone check-in scoring integration.

A later iPhone read-only display decision should be a separate phase after the
Watch-only behavior is proven.

## State Score Relationship

Check-ins must remain disconnected from State Score until a separate scoring
design and QA phase explicitly approves otherwise.

Rules:

- Missing check-ins do not lower State Score.
- `Low` check-ins do not automatically lower State Score.
- Deleting check-ins does not change State Score.
- Clearing check-ins does not change State Score.
- Check-ins do not alter component scores, confidence, reasons, suggestions,
  HealthKit-derived output, WidgetKit complications, App Group summary, iPhone
  Dashboard state, or Watch score state.

## App Store Safety Considerations

The history surface should feel like optional private reflection, not a medical
tool.

It must not imply:

- Diagnosis.
- Disease detection.
- Clinical stress detection.
- Anxiety or depression detection.
- Symptom logging.
- Treatment guidance.
- Health risk monitoring.
- Emergency alerting.
- Abnormal-state detection.
- Medical recordkeeping.

The safest positioning is:

```text
Check-ins are optional.
Check-ins do not affect your State Score.
```

## Risks And Mitigations

| Risk | Mitigation |
| --- | --- |
| History feels like a medical record. | Use subjective labels, short timestamps, and no symptom or diagnosis fields. |
| `Low` feels alarming. | Use muted styling and non-warning copy. |
| Deletion copy overpromises data removal. | Say local Watch check-ins only. |
| Single-record deletion makes Watch UI crowded. | Defer deletion or use a separate management surface. |
| Clear-all is too easy to tap by accident. | Use secondary placement and confirmation. |
| History is accidentally shared to WidgetKit or App Group. | Keep raw history out of WidgetKit and App Group. |
| Check-ins become score inputs too early. | Require separate score integration design and QA. |
| Future copy implies causality. | Use non-causal wording only and avoid pattern summaries in the first implementation. |

## Future Implementation Phases

Recommended sequence:

1. Phase 9.12: QA audit for Watch check-in history management design.
2. Phase 9.13: Implement minimal Watch-only recent history view and deletion
   foundation.
3. Phase 9.14: QA audit for recent history and deletion implementation.
4. Phase 9.15: Decide whether iPhone read-only display needs a separate design.
5. Phase 9.16: Decide whether WidgetKit compact summary is appropriate, with
   strict App Group privacy design first.

Do not start these phases in Phase 9.11.

## QA Checklist For Future Implementation

Before any history management implementation ships, verify:

- Recent history shows no more than the approved limit.
- Empty history uses neutral optional copy.
- `Low` remains subjective, non-medical, and non-warning.
- Missing check-ins remain neutral and non-score-lowering.
- Single-record deletion is safe when a record is already missing.
- Clear-all removes local Watch check-ins only.
- Corrupted local JSON still loads as empty history and does not crash.
- Unsupported future schema versions are ignored safely.
- Deletion and clear-all copy is honest about local scope.
- History rows are accessible with VoiceOver.
- No HealthKit writes or write authorization are added.
- No raw HealthKit samples are stored in check-in records.
- No WidgetKit direct check-in read is added.
- No App Group raw check-in history is added.
- No WatchConnectivity is added.
- No networking, cloud, iCloud, analytics, AI, remote config, accounts,
  reminders, notifications, scheduling, export, notes, or pattern summaries are
  added.
- State Score and HealthKit-derived scoring remain unaffected.

## Final Phase 9.11 Design Checklist

- Phase 9.11 design document exists.
- Phase 9.11 is design/documentation-only.
- No production Swift files changed.
- No Xcode project files changed.
- No entitlements changed.
- No CI workflows changed.
- No product behavior changed.
- Watch-only recent history direction is documented.
- Latest 3 check-ins is the recommended first visible limit.
- Latest 5 check-ins is documented only as a later readability-dependent limit.
- Single-record deletion is documented as future behavior requiring a minimal
  `delete(id:)` store addition.
- Clear-all is documented as future behavior using existing `clearAll()`.
- Empty history is neutral.
- Missing check-ins remain neutral.
- `Low` remains subjective, non-medical, and non-warning.
- Raw check-in history stays out of App Group and WidgetKit.
- WatchConnectivity remains deferred.
- HealthKit remains read-only.
- Check-ins remain disconnected from State Score.
- Future implementation requires separate implementation and QA phases.
