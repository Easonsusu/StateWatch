# Phase 9.6 State Check-in Local Storage Design QA

Phase 9.6 audits the Phase 9.5 local-only State Check-in storage design before
any persistence implementation begins.

This phase is QA and documentation only. It does not add storage, product
behavior, Swift source changes, Xcode project changes, entitlement changes, or
CI workflow changes.

## Purpose

Confirm that the Phase 9.5 storage design is ready for a later scoped
implementation phase while preserving StateWatch's local-first, low-anxiety,
non-medical, and privacy-preserving boundaries.

The audit focuses on whether the future storage design is narrow enough to
support optional self-reported check-ins without becoming a diagnosis surface,
HealthKit write path, shared raw-history channel, cloud profile, analytics
signal, or cross-device sync feature.

## Scope

Reviewed:

- Phase 9.0 State Check-in architecture.
- Phase 9.1 State Check-in architecture QA.
- Phase 9.2 Watch Check-in Figma mockup planning.
- Phase 9.3 Watch Check-in mock UI documentation.
- Phase 9.4 Watch Check-in mock UI QA.
- Phase 9.5 local storage design.
- Current TEST_PLAN coverage.
- Privacy, App Store, and medical-safety wording docs.
- Current Watch check-in UI model and Watch check-in view.
- Existing State Check-in XCTest coverage.

Out of scope:

- Check-in storage implementation.
- Persisting selected check-ins.
- `UserDefaults`, `@AppStorage`, SwiftData, CoreData, FileManager, database
  files, schema migration code, or storage services for check-ins.
- iPhone check-in UI.
- Watch check-in behavior changes.
- WidgetKit check-in display.
- App Group check-in propagation.
- WatchConnectivity.
- Reminders, notifications, scheduling, or background delivery.
- HealthKit write access.
- HealthKit Dashboard rollout changes.
- Networking, cloud sync, iCloud sync, accounts, analytics, remote config, AI,
  or AI cloud analysis.
- Phase 9.7 or later implementation work.

## Files Reviewed

- `Docs/phase-9-0-state-checkin-architecture.md`
- `Docs/phase-9-1-state-checkin-architecture-qa.md`
- `Docs/phase-9-2-watch-checkin-figma-mockups.md`
- `Docs/phase-9-3-watch-checkin-mock-ui.md`
- `Docs/phase-9-4-watch-checkin-mock-ui-qa.md`
- `Docs/phase-9-5-state-checkin-local-storage-design.md`
- `Docs/medical-safety-wording.md`
- `Docs/ui-copy-guidelines.md`
- `TEST_PLAN.md`
- `PRD.md`
- `PRIVACY_POLICY_DRAFT.md`
- `APP_STORE_CHECKLIST.md`
- `StateWatchApp/Models/StateCheckInOption.swift`
- `StateWatchWatchApp/Features/WatchCheckInView.swift`
- `StateWatchWatchApp/Features/WatchDashboardView.swift`
- `StateWatchTests/StateWatchThemeTests.swift`

## Search Terms Used

Broad Phase 9 and storage search:

```text
Phase 9|State Check-in|check-in|self-report|subjective|Energized|Stable|Tired|Low|有活力|穩定|疲累|低狀態|Watch|watchOS|WidgetKit|App Group|WatchConnectivity|local-only|on-device|privacy|storage|persist|history|retention|delete|clear all|export|schema|migration|UserDefaults|AppStorage|SwiftData|CoreData|FileManager|database|HealthKit|diagnosis|clinical|medical|anxiety|depression|treatment|warning|notification|reminder|sync|cloud|iCloud|analytics|AI
```

Focused safety search:

```text
mood diagnosis|emotional diagnosis|anxiety detection|depression detection|mental illness|clinical stress|disease detection|medical advice|treatment|therapy|emergency alert|abnormal mental|health warning|symptom|caused by|detected|diagnosed|warning|abnormal
```

Focused storage and propagation search:

```text
UserDefaults|@AppStorage|SwiftData|CoreData|FileManager|database|schema|migration|App Group|group\.|WCSession|WatchConnectivity|WidgetKit|TimelineProvider|UNUserNotificationCenter|NotificationCenter|URLSession|analytics|remote config|cloud|iCloud|sync|HKHealthStore.save|requestAuthorization\(toShare
```

Focused Phase 9.5 design search:

```text
StateCheckInRecord|local JSON|lightweight local store|repository|service abstraction|excluded fields|raw HealthKit|retention|deletion|clear-all|missing check-ins|Low check-ins|non-medical|WidgetKit|App Group|WatchConnectivity|HealthKit remains read-only|schemaVersion|migration
```

## Phase 9.5 Design Summary

Phase 9.5 designs a future local-only State Check-in storage foundation without
implementing persistence.

The design:

- Defines a future `StateCheckInRecord` concept.
- Keeps the current Watch Check-in UI in-memory only.
- Recommends a small local JSON file or equivalent lightweight local store for
  the first storage implementation.
- Requires a narrow repository/service abstraction before SwiftUI views depend
  on storage details.
- Excludes raw HealthKit samples, medical labels, cloud identifiers, analytics
  identifiers, remote config variants, precise location, unnecessary device
  identifiers, and hidden AI profile information.
- Keeps WidgetKit, App Group raw history, and WatchConnectivity out of scope.
- Documents deletion, clear-all, retention, corruption handling, and schema
  versioning expectations for the future implementation phase.

## Data Model Findings

The proposed `StateCheckInRecord` concept is narrow enough for a first local
history store.

Recommended fields are limited to:

- `id`
- `option`
- `createdAt`
- `updatedAt`
- `sourceSurface`
- `schemaVersion`
- `noteStatus`

The audit found this field set appropriate because it stores only user-entered
check-in metadata needed for a local history. It does not require HealthKit
samples, inferred health state, medical categories, cloud identity, analytics
identity, or cross-device sync metadata.

The design also correctly recommends storing the option as a stable enum raw
value rather than localized display text.

## Included Fields Findings

Included fields are minimal and justified:

- `id` supports local record identity.
- `option` stores one approved self-reported state.
- `createdAt` supports local ordering and pattern review.
- `updatedAt` remains optional until an edit flow is approved.
- `sourceSurface` supports clear origin tracking without cross-device sync.
- `schemaVersion` supports future local migration decisions.
- `noteStatus` allows explicit note deferral without storing note text.

No included field creates a HealthKit write path, medical interpretation, cloud
profile, analytics profile, remote config hook, or shared raw-history channel.

## Excluded Fields Findings

The excluded-field list is comprehensive for this stage.

Phase 9.5 explicitly excludes:

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
- User-entered notes until a later privacy-reviewed phase approves them.

This protects the storage design from becoming a medical, behavioral profiling,
advertising, analytics, or cloud identity surface.

## Storage Technology Recommendation Findings

The storage comparison is fair and appropriate:

- `UserDefaults` is documented as simple but a poor fit for user-entered record
  history.
- Local JSON is documented as local-only, account-free, inspectable, and clear
  for schema versioning and deletion.
- SwiftData is documented as useful later if richer local queries become
  necessary.
- CoreData is documented as mature but heavier than the first check-in storage
  phase needs.

The audit agrees that raw `UserDefaults` arrays should not become an accidental
check-in database.

## Local JSON / Lightweight Store Findings

Local JSON is appropriate for the first check-in history storage implementation
if the future implementation follows the Phase 9.5 constraints.

The design explicitly requires or implies the necessary safeguards:

- Atomic writes are called out as required care for a local JSON file.
- Decode-failure handling is called out.
- Corruption recovery decisions are required.
- Unknown future schema versions should fail safely.
- Corrupted local data should show a calm unavailable or empty state.
- Migration should never upload records.
- Unit tests should cover schema version stability and decode failure behavior
  before UI depends on persisted records.

The future implementation should treat these as required acceptance criteria,
not optional polish.

## Repository / Service Abstraction Findings

Phase 9.5 requires a narrow store/repository API before SwiftUI views interact
with persisted check-ins.

This is sufficient and important. SwiftUI views should not receive file paths,
raw JSON, or storage implementation details. A future implementation should
expose only narrow operations such as:

- Save a check-in record.
- Load recent records.
- Delete one record.
- Clear all records.

This boundary keeps storage reviewable and lowers the risk that product code
grows direct file, database, migration, or App Group behavior.

## Retention And Deletion Findings

Deletion and clear-all expectations are clear enough for the next
implementation phase.

Phase 9.5 documents:

- Local app-container storage only.
- Single-record deletion if an edit/history UI exists.
- A future clear-all action before broad rollout.
- No permanent-history promise.
- No export until a later privacy-reviewed phase.
- App uninstall removes local app-container records.
- No cloud backup or account restore promises unless explicitly verified and
  documented later.

The audit recommends Phase 9.7 treat clear-all behavior as a requirement before
any broad rollout, even if the first UI surface is small.

## Corruption And Migration Findings

Corruption and migration expectations are sufficient for a design phase.

Phase 9.5 requires:

- Stable `schemaVersion`.
- Unknown future schema versions fail safely.
- Decode failures do not crash.
- Corrupted data shows a calm unavailable or empty state.
- Migration never uploads records.
- Migration preserves deletion intent.

Future implementation tests should cover corrupted JSON, unknown option values,
unknown schema versions, missing optional fields, empty history, sparse history,
and deletion behavior.

## Missing Check-in Behavior Findings

Missing check-ins remain neutral.

The design explicitly says a missing check-in must not:

- Reduce State Score.
- Lower HealthKit-derived scoring.
- Imply the user did something wrong.
- Show a negative state.
- Trigger warning copy.

Approved copy remains optional and calm:

- `No check-ins yet.`
- `Check-ins are optional.`
- `Not enough check-ins to show a pattern yet.`

This satisfies the non-punitive missing-data requirement.

## Low Check-in Behavior Findings

`Low` remains a subjective self-report label, not a warning, diagnosis, health
risk label, or automatic score penalty.

The design explicitly says a `Low` check-in must not automatically reduce State
Score, trigger an alert, create a health risk label, or imply diagnosis.

The example copy is gentle and optional:

```text
You reported feeling low today. Keep the day simple if that matches how you feel.
```

The audit finds this safe for future implementation as long as UI styling also
avoids alarm, danger, emergency, and medical-device treatment.

## State Score Relationship Findings

The State Score relationship remains non-medical and non-punitive.

Phase 9.5 correctly states:

- A missing check-in must not reduce State Score.
- A `Low` check-in must not automatically reduce State Score.
- Check-ins must not be treated as proof of health status.
- Check-ins should not be used to create medical conclusions.
- Score-context copy must remain optional and cautious.

This prevents user-entered check-ins from becoming medical signals or hidden
inputs that punish sparse participation.

## HealthKit Boundary Findings

HealthKit remains read-only for the MVP.

Future check-in storage must not:

- Write to HealthKit.
- Request HealthKit write permissions.
- Store raw HealthKit samples.
- Store HealthKit objects inside check-in records.
- Treat HealthKit-derived scoring as proof of the user's self-reported state.

The audit found no Phase 9.5 design language that turns check-ins into detected
HealthKit states.

## WidgetKit / App Group / WatchConnectivity Boundary Findings

The shared-surface boundaries are explicit and sufficient:

- WidgetKit must not read raw check-in records directly.
- App Group must not store raw check-in history or user-entered notes.
- A future shared display phase may use only a compact reviewed summary with
  documented freshness, stale, unavailable, and deletion behavior.
- WatchConnectivity remains out of scope until a separate design and QA phase
  approves cross-device check-in propagation.

This prevents Phase 9.7 from silently expanding into WidgetKit, App Group, or
WatchConnectivity behavior.

## Privacy And App Store Wording Findings

The design remains consistent with the privacy policy draft, App Store
checklist, medical-safety wording, and UI copy guidelines.

Confirmed:

- Check-ins stay local for the MVP.
- No account is required.
- No developer can access check-in history.
- No cloud check-in database is added.
- No cloud HealthKit database is added.
- No advertising, marketing, profiling, or data mining use is added.
- No AI cloud profiling is added.
- No analytics or remote-config targeting is added.
- StateWatch remains a wellness reflection product, not a medical device.

High-risk terms appear only in boundary or forbidden-wording contexts. That is
appropriate for documentation because the docs are defining what StateWatch
must not claim.

## Future Implementation Readiness

The design is ready for a later Phase 9.7 implementation, provided Phase 9.7
remains narrow.

Recommended Phase 9.7 requirements:

- Implement storage on one approved surface only.
- Keep the current Watch and iPhone production behavior unchanged unless the
  Phase 9.7 scope explicitly names that surface.
- Keep raw check-in history out of App Group.
- Keep WidgetKit away from direct check-in reads.
- Keep WatchConnectivity out of scope.
- Implement atomic write behavior if local JSON is used.
- Implement safe decode-failure and corrupted-data behavior.
- Include stable schema-version tests.
- Include deletion and clear-all behavior before broad rollout.
- Keep notes and export deferred until later privacy review.

## Risks Found

No blocking design issues were found.

Residual risks for future implementation:

| Risk | Mitigation |
| --- | --- |
| Local JSON is implemented without atomic writes. | Make atomic writes a Phase 9.7 acceptance criterion. |
| Decode failures crash the UI. | Require corrupted JSON and unknown schema tests before merge. |
| UserDefaults becomes an accidental record database. | Keep raw `UserDefaults` arrays out of check-in history storage. |
| App Group gets raw check-in history. | Restrict App Group to compact reviewed summaries only in a later phase. |
| WidgetKit reads check-ins directly. | Keep WidgetKit direct reads forbidden. |
| WatchConnectivity is added silently. | Require a separate design and QA phase before cross-device propagation. |
| `Low` is styled as an alert. | Keep copy and visual styling calm, subjective, and non-medical. |
| Pattern summaries imply causation. | Require non-causal wording only. |

## Changes Made

- Added this Phase 9.6 QA audit document.
- Added a Phase 9.6 checklist to `TEST_PLAN.md`.

No Phase 9.5 design clarification was required.

## Final Phase 9.6 Result Checklist

- Phase 9.6 QA audit document exists.
- TEST_PLAN includes Phase 9.6 coverage.
- Phase 9.5 remains design-only.
- Future `StateCheckInRecord` remains narrow and privacy-safe.
- Included fields are minimal and justified.
- Excluded fields are comprehensive.
- Raw HealthKit samples remain excluded.
- Diagnoses, clinical labels, medical symptoms, treatment recommendations,
  anxiety labels, depression labels, inferred emotions, and health-risk labels
  remain excluded.
- Cloud, account, advertising, analytics, remote config, precise location,
  unnecessary device, and hidden AI profile fields remain excluded.
- Local JSON or equivalent lightweight local storage remains appropriate for a
  first implementation only behind a narrow repository/service abstraction.
- Atomic writes, decode-failure behavior, corruption handling, and schema
  versioning are required for future implementation.
- Deletion and clear-all expectations are documented.
- Retention avoids permanent-history and cloud-backup promises.
- Notes remain deferred until a later privacy-reviewed phase.
- Export remains deferred until a later privacy-reviewed phase.
- Missing check-ins remain neutral and non-score-lowering.
- `Low` check-ins remain subjective, non-medical, and non-warning.
- State Score relationship remains non-medical and non-punitive.
- HealthKit remains read-only.
- WidgetKit direct check-in reads remain forbidden.
- App Group raw check-in history remains forbidden.
- WatchConnectivity remains deferred.
- Future pattern summaries must remain local-only and non-causal.
- No Swift source files changed.
- No Xcode project files changed.
- No entitlements changed.
- No CI workflows changed.
- No storage implementation was added.
- No product behavior changed.
