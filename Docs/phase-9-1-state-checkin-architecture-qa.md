# Phase 9.1 State Check-in Architecture QA

Phase 9.1 audits the Phase 9.0 State Check-in architecture before any Figma,
Watch, iPhone, WidgetKit, App Group, or storage implementation begins.

This phase is QA and documentation only. It does not add product behavior.

## Purpose

The purpose of this audit is to confirm that the State Check-in architecture is:

- Subjective self-report only.
- Local-only for the MVP.
- Non-medical and non-diagnostic.
- Optional for users.
- Safe for missing or sparse check-in history.
- Sequenced through Figma before SwiftUI implementation.
- Properly scoped before Phase 9.2 Figma Watch check-in mockups.

## Scope

Reviewed scope:

- Phase 9.0 architecture document.
- StateWatch safety and UI copy guidance.
- Privacy and App Store planning docs.
- Roadmap and rollout docs that mention State Check-in.
- TEST_PLAN coverage for Phase 9.0.
- Source and docs searches for prohibited mechanisms and unsafe wording.

Out of scope for Phase 9.1:

- Watch UI implementation.
- iPhone UI implementation.
- Figma mockups.
- Check-in storage.
- Reminders, notifications, scheduling, or background delivery.
- WidgetKit check-in display.
- App Group propagation of check-in data.
- WatchConnectivity.
- HealthKit write access.
- HealthKit Dashboard rollout changes.
- Networking, cloud sync, analytics, account systems, remote config, or AI cloud
  analysis.
- Phase 9.2, 9.3, 9.4, or later implementation work.

## Documents And Areas Reviewed

Primary document:

- `Docs/phase-9-0-state-checkin-architecture.md`

Related documents reviewed:

- `TEST_PLAN.md`
- `README.md`
- `PRD.md`
- `APP_STORE_CHECKLIST.md`
- `PRIVACY_POLICY_DRAFT.md`
- `Docs/medical-safety-wording.md`
- `Docs/ui-copy-guidelines.md`
- `Docs/scoring-rules.md`
- `Docs/phase-8-9-real-device-healthkit-qa-plan.md`
- `Docs/healthkit-dashboard-rollout-plan.md`
- Existing source paths found by scope searches, including HealthKit,
  App Group, Watch, WidgetKit, and feature-flag files.

## Search Terms Used

Broad architecture search:

```text
Phase 9|State Check-in|check-in|check in|self-report|subjective|mood|emotion|stress|fatigue|tired|low|Energized|Stable|Tired|Low|有活力|穩定|疲累|低狀態|HealthKit|App Group|WidgetKit|WatchConnectivity|local-only|privacy|diagnosis|clinical|medical|anxiety|depression|treatment|emergency|warning|abnormal|cloud|AI|analytics|remote config|notification|reminder|storage
```

Focused safety search:

```text
mood diagnosis|emotional diagnosis|anxiety detection|depression detection|mental illness|clinical stress|disease detection|medical advice|treatment|therapy|emergency alert|abnormal mental|health warning|symptom|caused by|because you|detected
```

Focused scope search:

```text
UserDefaults|@AppStorage|FileManager|CoreData|SwiftData|NotificationCenter|UNUserNotificationCenter|WidgetKit|App Group|WCSession|WatchConnectivity|URLSession|analytics|remote config|HealthKit write|HKHealthStore.save|requestAuthorization\(toShare
```

Additional focused searches reviewed Phase 9 mentions, approved labels,
HealthKit write paths, networking paths, remote config, analytics, AI cloud
analysis, WatchConnectivity, and developer-accessible storage references.

## Architecture Findings

Phase 9.0 clearly defines State Check-in as a future local-only subjective
self-report system. It does not implement UI, storage, reminders,
notifications, scheduling, WidgetKit display, App Group propagation,
WatchConnectivity, HealthKit write access, networking, cloud sync, analytics,
remote config, or AI.

The architecture correctly positions a check-in as the user's own reported state
at a moment in time. It does not position check-ins as measurements,
diagnostics, symptoms, clinical categories, or medical signals.

Phase 9.2, Phase 9.3, and Phase 9.4 remain future work:

- Phase 9.2: Figma Watch check-in mockups.
- Phase 9.3: Watch check-in mock UI implementation.
- Phase 9.4: Check-in local storage foundation.

## Safety Wording Findings

The audit found no production-facing State Check-in wording that claims:

- Emotion diagnosis.
- Mental-health diagnosis.
- Anxiety detection.
- Depression detection.
- Clinical stress detection.
- Disease or illness detection.
- Treatment guidance.
- Therapy recommendation.
- Emergency alerting.
- Abnormal-state warning.
- Medical advice.

Phase 9.0 uses high-risk phrases only inside explicit avoid/forbidden examples
or disclaimer-style guardrails. That usage is acceptable because the document is
defining what StateWatch must not say.

Safe State Check-in wording is centered on:

- `subjective self-report`
- `user-entered context`
- `local-only`
- `personal pattern`
- `optional`
- `not enough check-ins to show a pattern yet`

## Check-in State Label Findings

The approved initial State Check-in labels are exactly:

| English | Traditional Chinese |
| --- | --- |
| Energized | 有活力 |
| Stable | 穩定 |
| Tired | 疲累 |
| Low | 低狀態 |

The labels are documented as self-reported states only. They are not diagnoses,
clinical categories, medical conditions, warnings, or health alerts.

Older planning and privacy wording referred to optional check-ins as mood,
fatigue, felt strain, and notes. That wording was broad and could drift from
the approved Phase 9.0 label set. Phase 9.1 updates those docs to reference the
approved State Check-in labels and keeps notes as future optional context only
if approved in a later privacy review.

## Local-only Privacy Findings

Phase 9.0 keeps State Check-ins local-only for the MVP.

Confirmed boundaries:

- No account requirement.
- No cloud database.
- No developer access to check-in history.
- No advertising profile.
- No marketing profile.
- No data mining.
- No AI cloud profiling.
- No analytics rollout.
- No networking or upload path.
- No HealthKit write access.

Future storage is documented as local-only and deferred. Deletion, export,
retention, and optional-note decisions remain open questions for a later scoped
storage phase.

## HealthKit Relationship Findings

The HealthKit relationship remains complementary and non-causal.

Confirmed:

- A check-in is subjective user-entered context.
- HealthKit scoring remains a local wellness estimate based on available data.
- Check-ins do not override HealthKit scoring as a medical signal.
- Check-ins are not used to claim causality.
- Missing check-ins do not reduce wellness scores or imply a bad state.

Allowed pattern wording remains correlation-oriented:

```text
On days with lower sleep, you more often reported feeling tired.
```

Forbidden causal wording remains out of bounds:

```text
Your tiredness is caused by poor sleep.
```

## App Group / WidgetKit / WatchConnectivity Boundary Findings

Phase 9.0 correctly keeps shared-surface rollout deferred.

Confirmed boundaries:

- No App Group check-in propagation is implemented.
- Raw check-in history must not be stored in App Group shared state.
- User-entered notes must not be stored in App Group shared state.
- Raw HealthKit samples must not be stored in App Group shared state.
- WidgetKit should not become the first State Check-in surface.
- WidgetKit check-in display, timelines, and complication content remain
  deferred.
- WatchConnectivity remains out of scope.
- The Watch app remains a future entry surface only after Figma mockups and
  scoped implementation work.

## Figma-first UI Sequencing Findings

Figma-first sequencing is preserved.

Future UI work must follow this sequence:

1. Phase 9.2: Figma Watch check-in mockups.
2. Phase 9.3: Watch check-in mock UI implementation.
3. Phase 9.4: Check-in local storage foundation.

Codex should not invent final Watch layouts, icon choices, bilingual UI, or
complication treatments directly in SwiftUI while Figma specs are planned or
available.

## Missing Check-in / Low-data Behavior Findings

Phase 9.0 treats check-ins as optional.

Confirmed behavior expectations:

- No check-ins must not imply the user did something wrong.
- No check-ins must not show a negative wellness state.
- No check-ins must not lower HealthKit-derived scores.
- Sparse check-in history should lower confidence for pattern summaries.
- Sparse check-in history should avoid broad conclusions.

Approved neutral wording:

- `No check-ins yet`
- `Check-ins are optional.`
- `Not enough check-ins to show a pattern yet.`

## Testing Strategy Findings

Future QA should cover:

- Approved labels only.
- English and Traditional Chinese copy parity.
- No clinical, diagnostic, treatment, emergency, warning, or abnormal-state
  wording.
- Optional check-ins.
- Missing check-in behavior.
- Sparse check-in behavior.
- Local-only storage.
- No networking, cloud sync, analytics, remote config, account dependency, or
  AI cloud analysis.
- No App Group raw check-in history or notes.
- No HealthKit write access.
- No WatchConnectivity.
- Figma-first UI review before SwiftUI implementation.

## Risks Found

No implementation-level risks were introduced by Phase 9.0.

Documentation risks found:

| Risk | Resolution |
| --- | --- |
| Older PRD and privacy wording used broad examples such as mood, fatigue, felt strain, and notes. | Updated those references to align with the four approved State Check-in labels and later optional-note review. |
| Future App Group or WidgetKit work could expose too much user-entered context. | Phase 9.0 already excludes raw check-in history and notes from App Group shared state. Keep this as a pass criterion for later phases. |
| Future pattern summaries could imply causality. | Keep using pattern wording such as `more often reported`, not causal language such as `caused by`. |
| Future UI work could bypass Figma. | Phase 9.0 preserves Figma-first sequencing before SwiftUI implementation. |

## Changes Made

Phase 9.1 made documentation-only changes:

- Added this QA audit document.
- Updated `PRD.md` so the data categories reference the approved State Check-in
  labels instead of broad mood/fatigue/felt-strain examples.
- Updated `PRIVACY_POLICY_DRAFT.md` so optional check-ins reference the
  approved State Check-in labels and keep optional notes behind later privacy
  review.
- Added a `TEST_PLAN.md` reference for Phase 9.1 QA.

No Swift files, Xcode project files, entitlements, assets, Figma files, CI
workflow files, or product behavior were changed.

## Final Phase 9.1 Result

Phase 9.1 passes if this PR remains documentation-only and confirms:

- State Check-in remains subjective self-report only.
- The four approved states are exactly `Energized`, `Stable`, `Tired`, and
  `Low`.
- Traditional Chinese labels are exactly `有活力`, `穩定`, `疲累`, and `低狀態`.
- No diagnosis or mental-health detection language is introduced.
- No anxiety, depression, disease, illness, or clinical stress detection claim
  exists.
- No treatment, therapy, emergency, warning, abnormal-state, or medical-advice
  wording is introduced as product behavior.
- Missing check-ins are optional and not treated as negative.
- Future storage remains local-only.
- No cloud or developer-accessible database is planned for MVP.
- No analytics, AI cloud profiling, or ad profile is introduced.
- HealthKit relationship remains complementary and non-causal.
- App Group, WidgetKit, WatchConnectivity, and HealthKit write remain out of
  scope.
- Figma-first sequencing is preserved before UI implementation.
- Phase 9.2, Phase 9.3, and Phase 9.4 remain future work.
