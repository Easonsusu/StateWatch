# Phase 9.7 Watch Check-in Local Storage Foundation

Phase 9.7 implements the first local-only State Check-in storage foundation on
one approved surface: the Apple Watch check-in flow.

This phase keeps State Check-in narrow, optional, subjective, and local-only. It
does not connect check-ins to scoring, HealthKit, WidgetKit, App Group shared
state, WatchConnectivity, networking, cloud sync, analytics, remote config, or
AI.

## Purpose

The purpose of Phase 9.7 is to move the Watch check-in flow from in-memory-only
selection to a small local history store that can safely save the user's own
subjective check-in entries on the Watch app surface.

The storage foundation exists so later QA phases can verify local retention,
delete behavior, and future pattern-summary requirements before any broader
rollout.

## Scope

Implemented:

- `StateCheckInRecord` for one local Watch check-in entry.
- `LocalStateCheckInStore` behind a narrow `StateCheckInStoring` protocol.
- Local JSON encode/decode using a stable schema version.
- Atomic local file writes through `FileManager`.
- Safe empty-history behavior.
- Safe corrupted-data behavior.
- Safe unknown-future-schema behavior.
- Watch check-in save flow with calm unavailable fallback copy.
- XCTest coverage for record coding, storage behavior, schema safety, and
  boundary checks.

## Storage Model

`StateCheckInRecord` stores only minimal user-entered check-in metadata:

| Field | Purpose |
| --- | --- |
| `id` | Stable local identifier for one record. |
| `option` | One approved `StateCheckInOption` value. |
| `createdAt` | Local timestamp for when the check-in was created. |
| `updatedAt` | Reserved for a later edit flow; currently optional. |
| `sourceSurface` | Narrow source enum. Phase 9.7 uses `watch` only. |
| `schemaVersion` | Stable local schema version. Phase 9.7 starts at `1`. |
| `noteStatus` | Reserved metadata. Phase 9.7 stores `none` only. |

The approved check-in options remain exactly:

| English | Traditional Chinese reference |
| --- | --- |
| Energized | 有活力 |
| Stable | 穩定 |
| Tired | 疲累 |
| Low | 低狀態 |

## Local Store Behavior

`LocalStateCheckInStore` writes a JSON array to a local Application Support
directory using the file name:

```text
statewatch-watch-checkins-v1.json
```

The store:

- Creates the local directory when saving.
- Writes atomically.
- Sorts records newest first when loading.
- Replaces records with the same local `id`.
- Returns an empty history when no file exists.
- Returns an empty history if JSON is corrupted or cannot be decoded.
- Ignores records from unsupported future schema versions.
- Ignores records not sourced from the Watch surface.
- Provides `clearAll()` for future delete-all UI and tests.

## Watch UI Behavior

The Watch Check-in UI still uses the same approved labels and calm confirmation
copy.

When a save succeeds, the confirmation remains:

```text
Saved
Check-in saved
You can update it later.
```

If local storage is unavailable, the Watch app shows calm fallback copy:

```text
Unavailable
Check-in unavailable
Try again later.
```

The fallback does not describe the user as being in a bad state and does not
make medical, diagnostic, emergency, or warning claims.

## Safety Boundaries

Phase 9.7 intentionally does not add:

- iPhone check-in UI.
- Production Dashboard behavior changes.
- HealthKit-backed Dashboard default-on behavior.
- Check-in effects on score, state label, confidence, metrics, suggestions, or
  HealthKit-derived output.
- HealthKit writes or write authorization.
- Raw HealthKit samples in check-in records.
- WidgetKit check-in display.
- WidgetKit reads of check-in records.
- App Group check-in propagation.
- Raw check-in history in App Group shared state.
- WatchConnectivity.
- Reminders, notifications, scheduling, or background delivery.
- Networking, cloud sync, iCloud sync, accounts, analytics, remote config, AI,
  or AI cloud analysis.
- Notes, export, sharing, or pattern summaries.

## Missing And Sparse Check-ins

Missing check-ins remain neutral.

A missing check-in must not:

- Reduce State Score.
- Lower HealthKit-derived scoring.
- Lower readiness confidence by itself.
- Imply the user did something wrong.
- Create a warning, risk, abnormal-state, medical, or emergency message.

Sparse history remains insufficient for pattern summaries until a later
privacy-reviewed phase defines those summaries and tests their wording.

## Tests Added

Phase 9.7 adds XCTest coverage for:

- Encoding and decoding one Watch check-in record.
- Stable schema version.
- Approved option raw values and labels.
- Record JSON excluding HealthKit, medical, cloud, account, advertising,
  analytics, remote config, location, device identifier, and AI fields.
- Empty local history behavior.
- Save and load behavior.
- Newest-first recent history.
- Clear-all behavior.
- Corrupted JSON fallback.
- Unknown future schema fallback.
- Store source boundary checks for WidgetKit, App Group, WatchConnectivity,
  HealthKit write, networking, cloud, analytics, remote config, and account
  mechanisms.

## Validation Expectations

Before merge, validate:

- `git diff --check origin/main...HEAD`
- `plutil -lint StateWatch.xcodeproj/project.pbxproj`
- iOS build and XCTest for the `StateWatch` scheme.
- watchOS build for the `StateWatchWatchApp` scheme.
- WidgetKit complication build for the `StateWatchComplications` scheme.

GitHub Actions should not be manually triggered as a debugging loop.

## Next Recommended Task

Phase 9.8: QA audit for Watch check-in local storage foundation.
