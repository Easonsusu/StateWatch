# Phase 9.9 Watch Check-in Display Preference

## Purpose

Phase 9.9 adds a small Watch-only display preference for the existing mock/local Watch Check-in surface. The preference lets the user choose how the four subjective check-in choices are shown on the Watch.

This phase is intentionally limited to presentation preference behavior. It does not add new check-in states, scoring behavior, HealthKit behavior, cross-device propagation, or production rollout changes.

## Approved Surface

- `WatchCheckInView`
- Watch-only local display preference storage
- XCTest coverage for display mode behavior and safety boundaries

No iPhone check-in UI, WidgetKit check-in display, App Group propagation, WatchConnectivity, HealthKit rollout, or State Score integration is included in this phase.

## What Changed

- Added `StateCheckInDisplayMode` with three stable modes:
  - `iconAndText`
  - `iconOnly`
  - `textOnly`
- Added `LocalStateCheckInDisplayPreferenceStore` for the Watch-only UI display preference.
- Added a compact segmented control to `WatchCheckInView`.
- Kept the default Watch Check-in presentation as icon plus text.
- Added tests for stable raw values, fallback behavior, persistence, and safety boundaries.

## Display Modes

### Icon + Text

Default mode. Shows the existing symbol and label for each subjective check-in option.

### Icon Only

Shows only the symbol for each option. Accessibility labels still include the full subjective state label.

### Text Only

Shows only the option label. This is useful if the user prefers clearer text over compact symbols.

## Default Behavior

The default display mode is `iconAndText`, so existing Watch Check-in behavior remains familiar unless the user changes the preference.

Invalid or missing stored values fall back to `iconAndText`.

## Preference Storage Behavior

The display preference stores only a small raw string value in Watch app `UserDefaults.standard`:

- key: `statewatch.watchCheckIn.displayMode.v1`
- values: `iconAndText`, `iconOnly`, or `textOnly`

This store does not save check-in records, notes, HealthKit data, raw HealthKit samples, score output, or user health history.

## Watch UI Behavior

The Watch Check-in surface still shows the same four approved subjective states:

- Energized
- Stable
- Tired
- Low

The display preference changes only whether each option row shows its icon, text, or both.

## Accessibility Behavior

Each check-in option keeps its existing full accessibility label regardless of visual display mode. Icon-only mode is therefore visual-only and does not remove the text meaning from assistive technologies.

## What Was Intentionally Not Changed

- No new check-in states were added.
- No check-in history UI was added.
- No iPhone check-in UI or behavior was added.
- No WidgetKit check-in display was added.
- No App Group propagation was added.
- No WatchConnectivity was added.
- No reminders, notifications, scheduling, or background delivery were added.
- No export, notes, pattern summaries, or trend analysis were added.
- No State Score, component score, confidence, suggestion, or reason logic was changed.

## HealthKit Boundaries

Phase 9.9 does not request, fetch, write, store, or display HealthKit samples. HealthKit-backed iPhone Dashboard behavior remains feature-flagged and default-off where applicable.

No HealthKit write access or HealthKit write authorization was added.

## WidgetKit, App Group, and WatchConnectivity Boundaries

The display preference is Watch-only and does not propagate through App Group shared state, WidgetKit timelines, WatchConnectivity, or any cross-device transport.

WidgetKit complications remain unaffected and do not read check-in state or display preference values.

## iPhone Boundary

The iPhone Dashboard remains unchanged. No iPhone check-in entry point, display preference, or check-in reader was added.

## Privacy Boundaries

This phase adds no networking, cloud sync, iCloud sync, analytics, account system, remote config, AI, upload path, developer-accessible database, or server-side storage.

## State Score Relationship

Check-in display preference does not affect State Score, component scores, confidence, reasons, suggestions, HealthKit-derived scoring, WidgetKit complications, App Group summary, iPhone Dashboard state, or Watch score state.

## Missing Check-in Behavior

Missing check-ins remain neutral. A missing check-in is not treated as a lower readiness state, lower confidence cause by itself, warning, or negative wellness signal.

## Low Check-in Behavior

`Low` remains subjective user-reported wording. It is not a diagnosis, warning, emergency state, abnormal-state claim, clinical stress claim, disease claim, treatment recommendation, or medical advice.

## Tests Added

XCTest coverage was added for:

- stable display mode raw values and labels
- default `iconAndText` fallback
- invalid stored value fallback
- save/load behavior
- storage of only the display mode raw value
- absence of check-in record data in display preference storage
- absence of forbidden propagation, upload, HealthKit write, networking, AI, account, and WidgetKit mechanisms in the display preference implementation
- non-medical display mode copy

## Validation Performed

Phase 9.9 should be validated with:

- `git diff --check origin/main...HEAD`
- `plutil -lint StateWatch.xcodeproj/project.pbxproj`
- iOS `StateWatch` build and XCTest
- watchOS `StateWatchWatchApp` build
- `StateWatchComplications` build

GitHub Actions should not be manually triggered as a debugging loop.

## Known Limitations

- The preference is local to the Watch app only.
- The preference is not synced to iPhone.
- The preference is not included in WidgetKit complications.
- The preference is not part of State Score, scoring, suggestions, or HealthKit-derived output.

## Future QA Phase

Phase 9.10 should audit the Watch check-in display preference after merge and verify the preference remains Watch-only, local-only, non-medical, and disconnected from scoring, WidgetKit, App Group shared state, and HealthKit rollout.

## Final Phase 9.9 Result Checklist

- Watch Check-in has icon plus text, icon-only, and text-only display modes.
- Icon plus text remains the default.
- Display preference storage is Watch-only and stores only a tiny raw preference value.
- Check-in history storage schema remains unchanged.
- Production iPhone, Watch score, WidgetKit, App Group, HealthKit, and scoring behavior remain unchanged.
- No prohibited networking, cloud, AI, HealthKit write, WatchConnectivity, App Group propagation, WidgetKit check-in display, or product behavior expansion was added.
