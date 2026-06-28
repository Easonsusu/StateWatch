# Phase 9.5 State Check-in Local Storage Design

Phase 9.5 designs the future local-only State Check-in storage foundation before
any persistence is implemented. This phase is architecture and documentation
only.

## Purpose

State Check-in should eventually let a user keep a small local history of their
own subjective state entries. That history can later provide context for
wellness reflection, but it must not become a diagnosis, clinical signal,
treatment recommendation, HealthKit write path, or cloud profile.

## Scope

This document defines:

- A future `StateCheckInRecord` concept.
- Fields to include and fields to exclude.
- Storage technology options.
- A recommended first implementation approach.
- Watch and iPhone storage boundaries.
- WidgetKit, App Group, and WatchConnectivity boundaries.
- HealthKit, privacy, retention, deletion, and migration rules.
- Future implementation and QA sequencing.

## What This Phase Does Not Do

- Does not implement check-in storage.
- Does not persist selected Watch check-ins.
- Does not add `UserDefaults`, `@AppStorage`, SwiftData, CoreData, FileManager,
  database files, schema migration code, or storage services for check-ins.
- Does not add iPhone check-in UI.
- Does not change Watch check-in UI behavior.
- Does not add WidgetKit check-in display.
- Does not add App Group check-in propagation.
- Does not add WatchConnectivity.
- Does not add reminders, notifications, scheduling, or background delivery.
- Does not change HealthKit permissions or rollout behavior.
- Does not add HealthKit write access.
- Does not add networking, cloud sync, iCloud sync, accounts, analytics, remote
  config, AI, or AI cloud analysis.

## Current State Check-in Behavior

The current Watch Check-in screen is mock UI only. `WatchCheckInView` stores the
selected option in private SwiftUI `@State` and clears it when the confirmation
flow finishes. The selected value does not leave the view, does not affect
scores, does not write to HealthKit, does not update WidgetKit, and does not
write App Group shared state.

The approved states remain:

| English | Traditional Chinese |
| --- | --- |
| Energized | 有活力 |
| Stable | 穩定 |
| Tired | 疲累 |
| Low | 低狀態 |

## Storage Design Goals

Future storage must remain:

- Local-only.
- On-device.
- Account-free.
- Cloud-free.
- Developer-inaccessible.
- AI-cloud-free.
- Analytics-free.
- Remote-config-free.
- HealthKit-write-free.
- Advertising-profile-free.

The first implementation should be small, inspectable, and easy to delete. It
should avoid overbuilding cross-device sync or long-term history before the user
experience and privacy wording are validated.

## Data Model Proposal

A future documentation-level model can be named `StateCheckInRecord`.

Recommended fields:

| Field | Purpose |
| --- | --- |
| `id` | Stable local identifier for one user-entered record. |
| `option` | One approved `StateCheckInOption` value. |
| `createdAt` | Local timestamp for when the user created the check-in. |
| `updatedAt` | Optional timestamp only if a later edit flow is approved. |
| `sourceSurface` | Narrow enum such as `watchMockUI`, `watchUI`, or `iPhoneUI`. |
| `schemaVersion` | Integer version for future local migration decisions. |
| `noteStatus` | Optional metadata such as `none`; do not add note text yet. |

The first implementation should store the option as the stable enum raw value,
not as localized display text. Display labels can be derived at render time so
English and Traditional Chinese wording can evolve without rewriting history.

## Fields Explicitly Excluded

Check-in records must not store:

- Raw HealthKit samples.
- Inferred diagnoses.
- Inferred emotions.
- Anxiety labels.
- Depression labels.
- Clinical stress labels.
- Disease or illness labels.
- Medical symptoms.
- Treatment recommendations.
- Cloud identifiers.
- Account identifiers.
- Advertising identifiers.
- Analytics identifiers.
- Remote config variants.
- Precise location.
- Unnecessary device identifiers.
- Hidden AI profile information.
- User-entered notes until a later privacy-reviewed phase explicitly approves
  them.

## Storage Technology Options

### UserDefaults

Pros:

- Simple for one small setting.
- Already familiar in the project for feature flags and mock shared summary
  storage.

Cons:

- Poor fit for user-entered record history.
- Deletion, schema versioning, corruption recovery, and migration are less
  explicit for arrays of records.
- Easy to accidentally treat as a general database.

Recommendation: do not use raw `UserDefaults` arrays for check-in history in
the first storage implementation.

### Local JSON File

Pros:

- Local-only and account-free.
- Small and inspectable.
- Clear schema versioning and explicit migration path.
- Straightforward clear-all deletion.
- Narrow repository abstraction can hide file details from UI code.

Cons:

- Requires careful atomic writes and decode-failure handling.
- Requires explicit retention and corruption recovery decisions.

Recommendation: preferred first implementation direction, provided it is hidden
behind a narrow store/repository API and covered by tests.

### SwiftData

Pros:

- Native modern Apple persistence option.
- Good fit if StateWatch later needs richer local queries and relationships.

Cons:

- More framework surface than needed for four-option check-ins.
- Adds migration and platform behavior to understand before the UX is proven.
- Could make the first storage phase harder to review.

Recommendation: defer unless check-in history grows beyond a small local log.

### CoreData

Pros:

- Mature local persistence.
- Strong migration and query capabilities.

Cons:

- Heavier than needed for the first implementation.
- Higher review complexity for a small local-only record list.

Recommendation: defer unless future requirements clearly need it.

## Recommended First Implementation Approach

For the first real storage implementation, prefer a small local JSON file or
equivalent lightweight local store in the app container behind a narrow
repository/service abstraction.

Reasons:

- Check-ins are user-entered records, not simple preferences.
- Schema versioning is clearer than a raw `UserDefaults` array.
- Deletion and corruption fallback can be explicit.
- No cloud, account, or developer-accessible database is needed.
- Future migration can be deliberate and testable.
- It avoids overbuilding SwiftData or CoreData before the product behavior is
  validated.

The first store should expose only narrow operations such as save, load recent,
delete record, and clear all. It should not expose file paths, raw JSON, or
storage implementation details to SwiftUI views.

## Watch / iPhone Boundary Design

Current Phase 9.3 Watch behavior remains in-memory only. Phase 9.5 does not
change that behavior.

Future persistence can first be implemented on one approved surface only. If the
first storage phase targets the Watch app, it should store only local Watch
records and avoid silently syncing them to iPhone. If the first storage phase
targets iPhone, the Watch mock UI should remain unchanged until a later scoped
Watch phase.

Cross-device propagation must be a separate future phase. WatchConnectivity must
not be silently added as part of storage.

## WidgetKit / App Group / WatchConnectivity Boundaries

WidgetKit must not read raw check-in records directly.

App Group must not store raw check-in history or user-entered notes. If a later
phase approves shared display, it should use a compact reviewed summary only,
with documented freshness, stale, unavailable, and deletion behavior.

WatchConnectivity remains out of scope. It should not be added until there is a
separate design and QA phase for cross-device check-in propagation.

## HealthKit Boundaries

State Check-in is not detected from HealthKit.

Future check-in storage must not:

- Write to HealthKit.
- Request HealthKit write permissions.
- Store raw HealthKit samples.
- Store HealthKit objects inside check-in records.
- Treat HealthKit-derived scoring as proof of the user's self-reported state.

HealthKit remains read-only for the MVP.

## Privacy Boundaries

Privacy wording must remain true after future implementation:

- Check-ins stay local for the MVP.
- No account is required.
- No developer can access check-in history.
- No cloud health database is added.
- No cloud check-in database is added.
- No advertising, marketing, profiling, or data mining use is added.
- No AI cloud profiling is added.
- No analytics or remote-config targeting is added.

If any future export, sync, account, or cloud feature is proposed, the privacy
policy and App Store review notes must be updated before implementation.

## Retention and Deletion Design

The first implementation should keep retention local and simple.

Recommended first version:

- Store local records in the app container only.
- Support deleting a single record if an edit/history UI exists.
- Support a future clear-all action before broad rollout.
- Avoid promising permanent history.
- Avoid exposing export until a later privacy-reviewed phase.
- Treat app uninstall as removing local app-container records.
- Do not promise cloud backup or account restore unless the implementation is
  explicitly verified and documented.

Retention windows can remain conservative at first, such as keeping recent local
history only if the UI only needs recent context. Longer history should wait for
clear user value, deletion controls, and QA.

## Missing Check-in Behavior

Missing check-ins are neutral.

A missing check-in must not:

- Reduce State Score.
- Lower HealthKit-derived scoring.
- Imply the user did something wrong.
- Show a negative state.
- Trigger warning copy.

Preferred copy:

- `No check-ins yet.`
- `Check-ins are optional.`
- `Not enough check-ins to show a pattern yet.`

## Low Check-in Behavior

`Low` is a subjective self-report label, not a medical warning.

A `Low` check-in must not automatically reduce State Score, trigger an alert,
create a health risk label, or imply diagnosis. It may later provide context in
gentle summaries, such as:

```text
You reported feeling low today. Keep the day simple if that matches how you feel.
```

Avoid wording such as:

```text
StateWatch detected a problem.
Your health is abnormal.
You are at risk.
```

## Relationship To State Score

Check-ins may later add user-entered context, but they must not override
HealthKit-derived scoring as a medical signal.

Rules:

- A missing check-in must not reduce State Score.
- A `Low` check-in must not automatically reduce State Score.
- Check-ins must not be treated as proof of health status.
- Check-ins should not be used to create medical conclusions.
- Any score-context copy must remain optional and cautious.

## Relationship To Future Local-only Pattern Analysis

Future pattern analysis can summarize local records transparently:

- Counts by selected state.
- Time-of-day patterns.
- Gentle non-causal associations with local readiness context.
- Check-in frequency, only as optional usage context.

Pattern analysis must use non-causal wording:

Allowed:

```text
On days with lower sleep, you more often reported feeling tired.
```

Not allowed:

```text
You feel tired because you slept less.
```

Pattern analysis must remain local-only and must not use cloud AI, developer
review, advertising profiles, analytics profiles, or medical labels.

## Migration And Schema Versioning Considerations

The first stored record should include a `schemaVersion` so future local
migrations are explicit. Migration should be small and testable:

- Unknown future schema versions should fail safely.
- Decode failures should not crash.
- Corrupted local data should show a calm unavailable or empty state.
- Migration should never upload records.
- Migration should preserve deletion intent.

The first implementation should include unit tests for schema version stability
and decode failure behavior before any UI depends on persisted records.

## Testing Requirements For Future Implementation

Before storage implementation ships, tests should cover:

- Encoding and decoding one record.
- Approved option values only.
- Stable schema version.
- Missing optional fields.
- Unknown option handling.
- Corrupted JSON handling.
- Empty history.
- Sparse history.
- Single-record deletion.
- Clear-all deletion.
- Retention window behavior if a window is implemented.
- Missing check-ins staying neutral.
- `Low` check-ins staying non-medical and non-warning.
- No HealthKit writes.
- No raw HealthKit samples in records.
- No App Group raw history.
- No WidgetKit direct check-in reads.
- No WatchConnectivity.
- No networking, cloud sync, analytics, remote config, accounts, or AI cloud
  analysis.

## Risks And Mitigations

| Risk | Mitigation |
| --- | --- |
| Storage begins before privacy controls are clear. | Require clear deletion behavior before implementation. |
| UserDefaults becomes an accidental database. | Prefer a narrow local JSON store abstraction for record history. |
| Check-ins are interpreted as diagnosis. | Keep labels subjective and copy non-medical. |
| `Low` feels alarming. | Use calm styling and never treat it as a warning. |
| Missing check-ins feel punitive. | Keep missing data neutral and non-score-lowering. |
| App Group exposes sensitive context. | Exclude raw history and notes from App Group. |
| Cross-device sync is added silently. | Keep WatchConnectivity in a separate future phase. |
| Future summaries imply causality. | Use non-causal pattern wording only. |

## Future Implementation Phases

Recommended sequence:

1. Phase 9.6: QA audit for local storage design.
2. Phase 9.7: Implement local-only check-in storage foundation on one approved
   surface.
3. Phase 9.8: QA audit for storage implementation.
4. Phase 9.9: Display preference / icon-text behavior, if still needed.
5. Phase 9.10: UX QA audit before pattern analysis.

Do not silently start storage implementation in Phase 9.5.

## Final Phase 9.5 Result Checklist

- Local-only storage design exists.
- Future `StateCheckInRecord` concept is defined.
- Fields to include are documented.
- Fields explicitly excluded are documented.
- Storage options are compared.
- First implementation recommendation is documented.
- Retention and deletion rules are documented.
- Missing check-ins remain neutral.
- `Low` check-ins remain non-medical and non-warning.
- State Score relationship is non-medical and non-punitive.
- HealthKit remains read-only.
- Check-in records exclude raw HealthKit samples.
- WidgetKit, App Group, and WatchConnectivity remain out of scope.
- No Swift source files changed.
- No storage implementation was added.
- No product behavior changed.
