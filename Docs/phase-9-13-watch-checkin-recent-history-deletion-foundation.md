# Phase 9.13 Watch Check-in Recent History and Deletion Foundation

## Purpose

Phase 9.13 implements the first narrow Watch-only recent history and
single-record deletion foundation for State Check-in.

The goal is to let the Watch app show the latest few subjective check-ins and
let a user remove one local check-in if it was entered by mistake. This phase
does not interpret check-ins, connect them to State Score, or propagate them to
other app surfaces.

## Scope

Implemented:

- Latest 3 recent check-ins shown in the Watch Check-in screen.
- Empty history copy that keeps check-ins optional.
- Single-record deletion from the Watch-local JSON store.
- Calm local-only delete confirmation copy.
- Tests for newest-first history, latest-three behavior, single-record delete,
  missing-record delete no-op behavior, and safe copy.
- This documentation and the Phase 9.13 `TEST_PLAN.md` checklist.

Out of scope:

- iPhone check-in UI, history, deletion, or settings.
- WidgetKit check-in display or direct check-in reads.
- App Group check-in propagation or raw history storage.
- WatchConnectivity.
- HealthKit write access or HealthKit write authorization.
- HealthKit-derived check-in interpretation.
- State Score, readiness score, component score, confidence, reason, or
  suggestion changes.
- Reminders, notifications, scheduling, export, notes, streaks, trends, counts,
  causes, interpretations, pattern summaries, or clear-all UI.
- Networking, cloud sync, iCloud sync, analytics, remote config, accounts,
  login, AI, or AI cloud analysis.

## Files Changed

- `StateWatchWatchApp/Features/WatchCheckInView.swift`
- `StateWatchWatchApp/Services/CheckIn/LocalStateCheckInStore.swift`
- `StateWatchApp/Models/StateCheckInOption.swift`
- `StateWatchTests/StateCheckInStorageTests.swift`
- `StateWatchTests/StateWatchThemeTests.swift`
- `Docs/phase-9-13-watch-checkin-recent-history-deletion-foundation.md`
- `TEST_PLAN.md`

## Implementation Summary

`WatchCheckInView` now reloads recent Watch-local check-ins from
`LocalStateCheckInStore.loadRecent(limit:)` and displays the latest 3 records
below the existing check-in options.

The list is intentionally compact:

- Subjective state label.
- Optional icon when the current display preference shows icons.
- Compact local timestamp text.
- A small delete affordance for each row.

The save flow remains unchanged from a product perspective: selecting a state
saves a local Watch check-in and shows the existing confirmation screen. After a
successful save, the recent list is refreshed.

## Recent History Behavior

Recent history uses:

```swift
LocalStateCheckInStore.loadRecent(limit: 3)
```

The store normalizes records newest-first and ignores unsupported future schema
records. If storage is empty, missing, corrupted, or unreadable, the history
falls back to an empty list.

Visible history is capped at 3 records for this first implementation. Phase
9.11 intentionally left latest 5 as a future readability-dependent option, not
part of this implementation.

## Single-record Deletion Behavior

`StateCheckInStoring` now includes:

```swift
func delete(id: UUID) throws
```

`LocalStateCheckInStore.delete(id:)` removes only matching records and rewrites
the normalized local history. If the record is already missing, deletion is a
safe no-op.

The Watch UI asks for confirmation with local-only wording:

```text
Remove this local check-in?
This removes it from this Watch.
```

Deletion refreshes the latest-three list after success. If deletion cannot be
completed, the Watch UI uses calm fallback copy:

```text
Delete unavailable
Try again later.
```

## Empty History Behavior

Empty history uses neutral copy:

```text
No check-in yet
Check-ins are optional.
```

Empty or missing history does not lower State Score, component scores,
confidence, reasons, suggestions, HealthKit-derived scoring, iPhone Dashboard
state, Watch score state, WidgetKit complications, or App Group summary.

## Low Check-in Behavior

`Low` remains a subjective self-report only. It is not a warning, emergency,
abnormal state, diagnosis, treatment signal, risk indicator, or HealthKit
derived signal.

The Watch UI uses muted styling for `Low` instead of alarm styling.

## Missing Check-in Behavior

Missing check-ins are neutral. They are not treated as a negative wellness
signal, scoring penalty, confidence penalty, or reason to prompt the user.

This phase does not add reminders, notifications, scheduling, background
delivery, streaks, or completion pressure.

## Accessibility

The history section keeps text labels visible for the recent check-in rows and
uses explicit accessibility labels for delete actions.

Icon-only display preference still keeps meaningful accessibility labels for
check-in option buttons. Recent history keeps the state label visible because
history is a review surface and should remain understandable at a glance.

## Storage

Storage remains Watch-local JSON in the Watch app container:

```text
statewatch-watch-checkins-v1.json
```

The schema remains:

- `id`
- `option`
- `createdAt`
- `updatedAt`
- `sourceSurface`
- `schemaVersion`
- `noteStatus`

No notes, symptoms, HealthKit sample identifiers, raw HealthKit samples, device
identifiers, account identifiers, analytics identifiers, cloud identifiers, or
AI profile fields were added.

## HealthKit Boundary

Phase 9.13 does not fetch HealthKit, write to HealthKit, request HealthKit
write authorization, store raw HealthKit samples, or connect subjective
check-ins to HealthKit-derived scoring.

HealthKit data remains read-only for the MVP.

## WidgetKit Boundary

WidgetKit complications remain unchanged. They do not read check-in history,
show check-in selections, fetch HealthKit, receive check-in propagation, or use
live check-in timelines.

## App Group Boundary

The App Group shared readiness summary remains separate from raw check-in
history. Phase 9.13 does not store check-in records, deletion state, display
preference, or check-in-derived summaries in App Group storage.

## WatchConnectivity Boundary

Phase 9.13 does not add WatchConnectivity. Check-ins remain local to the Watch
app container.

## iPhone Boundary

Phase 9.13 does not add iPhone check-in UI, iPhone history display, iPhone
deletion, iPhone settings, or iPhone shared-state propagation.

The iPhone Dashboard behavior remains unchanged.

## State Score Boundary

Check-ins and missing check-ins do not affect State Score, component scores,
confidence, reasons, suggestions, HealthKit-derived scoring, or mock dashboard
state.

This phase intentionally avoids trends, counts, streaks, causes,
interpretations, and pattern summaries.

## Privacy and App Store Safety

Phase 9.13 remains low-anxiety, local-first, and non-diagnostic. Product-facing
copy stays subjective and avoids diagnosis, disease detection, clinical stress
detection, treatment advice, therapy framing, emergency language, abnormal-state
language, and causal claims.

The feature does not add networking, cloud sync, iCloud sync, analytics, remote
config, accounts, login, developer-accessible databases, upload paths, AI, or
AI cloud analysis.

## Tests

Added or strengthened XCTest coverage for:

- Latest 3 records returned newest-first.
- Single-record deletion removes only the matching record.
- Missing-record deletion is a safe no-op.
- Recent history updates correctly after deletion.
- Check-in history and delete copy remains calm, local-only, and non-medical.
- `AI` wording checks avoid false positives inside ordinary words such as
  `unavailable` while still preventing standalone AI feature claims.

Existing tests continue to cover:

- Check-in record coding.
- Approved state labels.
- Stable schema version.
- Forbidden record fields.
- Empty history.
- Save/load behavior.
- Corrupted JSON fallback.
- Future schema fallback.
- Forbidden propagation and upload mechanisms.

## Validation

Required validation before merge:

- `git diff --check origin/main...HEAD`
- `git diff --cached --check`
- `plutil -lint StateWatch.xcodeproj/project.pbxproj`
- iOS `StateWatch` build and tests on `iPhone 17 Pro`
- watchOS `StateWatchWatchApp` build on `Apple Watch Series 11 (46mm)`
- `StateWatchComplications` build on `Apple Watch Series 11 (46mm)`

GitHub Actions should not be manually triggered as a debugging loop.

## Known Limitations

- No iPhone history or deletion UI.
- No clear-all UI.
- No export.
- No notes.
- No reminders or notifications.
- No trend, streak, count, or pattern summaries.
- No WidgetKit check-in display.
- No App Group check-in propagation.
- No WatchConnectivity sync.
- No State Score integration.

These are intentional boundaries for the first implementation.

## Future QA Gate

Phase 9.14 should audit the Watch-only recent history and deletion foundation
before any broader rollout.

That QA pass should verify:

- Small-screen Watch readability.
- VoiceOver labels for recent rows and delete actions.
- Empty, corrupted, missing, and deleted data behavior.
- No clear-all UI was added.
- No propagation to iPhone, WidgetKit, App Group, WatchConnectivity, or
  HealthKit-derived scoring was added.
- Copy remains calm, subjective, and non-medical.

## Final Checklist

- Latest 3 recent check-ins only.
- Single-record deletion only.
- Empty history is neutral.
- Missing check-ins are neutral.
- `Low` remains subjective and non-warning.
- Watch-only local storage.
- No clear-all UI.
- No iPhone check-in UI.
- No WidgetKit check-in display.
- No App Group check-in propagation.
- No WatchConnectivity.
- No HealthKit write access.
- No HealthKit-derived scoring connection.
- No networking, cloud, analytics, accounts, remote config, or AI.
