# Phase 9.0 State Check-in Architecture

Phase 9.0 defines the architecture for State Check-in, a future local-only
subjective self-report system for StateWatch. This phase is planning-only: it
does not implement UI, storage, reminders, notifications, sync, or production
behavior.

## Purpose

State Check-in should let a user record how they feel at a point in the day so
StateWatch can later add user-entered context to daily readiness and wellness
reflections.

The feature should support personal reflection, not medical interpretation. A
check-in is the user's own subjective state, entered directly by the user. It is
not an emotion diagnosis, mental-health screen, clinical stress signal, disease
detection signal, or treatment recommendation.

## Scope

This architecture plan defines:

- Product purpose.
- Safety boundaries.
- User-facing terminology.
- Initial check-in state options.
- Future data model concept.
- Local-only storage direction.
- Future Watch, iPhone, WidgetKit, and App Group roles.
- Relationship with HealthKit scoring.
- Relationship with future local personal pattern analysis.
- Privacy expectations.
- Localization direction.
- Figma-first UI rule.
- Testing strategy.
- Non-goals and open questions for later phases.

## What This Phase Does Not Do

- Does not implement iPhone UI.
- Does not implement Watch UI.
- Does not add check-in storage.
- Does not add reminders, notifications, scheduling, or background delivery.
- Does not add WidgetKit or complication check-in display.
- Does not add App Group propagation.
- Does not add WatchConnectivity.
- Does not change HealthKit permissions.
- Does not add HealthKit write access.
- Does not enable the HealthKit-backed Dashboard by default.
- Does not propagate HealthKit-derived output to Watch, WidgetKit, or App Group.
- Does not add networking, cloud sync, account systems, analytics, remote
  config, AI, or AI cloud analysis.
- Does not begin Phase 9.1, 9.2, 9.3, or 9.4 implementation.

## Safety Boundaries

State Check-in is subjective self-report only.

It must not be positioned as:

- Mood diagnosis.
- Emotional diagnosis.
- Anxiety detection.
- Depression detection.
- Mental illness detection.
- Clinical stress detection.
- Disease or illness detection.
- Medical advice.
- Treatment guidance.
- Emergency alerting.
- Abnormal mental-state detection.
- Health warning.

Allowed copy should be calm, optional, and personal:

- `This is based on your own self-reported state.`
- `Your check-ins can help StateWatch show patterns over time.`
- `On days with lower sleep, you more often reported feeling tired.`
- `A check-in can add context to today's signals.`

Forbidden copy includes:

- `You are anxious.`
- `You are depressed.`
- `Your body is abnormal.`
- `Your tiredness is caused by poor sleep.`
- `StateWatch detected a mental health issue.`
- `Clinical stress detected.`
- `You need treatment.`
- `This is a medical recommendation.`

## User-Facing Terminology

Preferred terms:

- `State Check-in`
- `subjective state`
- `self-report`
- `check-in`
- `daily state context`
- `personal pattern`
- `local-only`
- `on-device`
- `user-entered context`

Avoid terms:

- `mood diagnosis`
- `emotional diagnosis`
- `anxiety detection`
- `depression detection`
- `mental illness detection`
- `clinical stress detection`
- `medical condition`
- `symptom tracking`
- `treatment`
- `therapy recommendation`
- `emergency alert`
- `abnormal mental state`
- `health warning`

## Check-in State Options

Phase 9.0 defines exactly four initial subjective check-in states:

| English | Traditional Chinese |
| --- | --- |
| Energized | 有活力 |
| Stable | 穩定 |
| Tired | 疲累 |
| Low | 低狀態 |

These labels describe the user's self-reported state at the moment of entry.
They are not diagnoses, clinical categories, medical conditions, or health
alerts.

## Timing Concept

Future check-ins may be useful around:

- Morning.
- Midday.
- Evening.

Phase 9.0 does not implement scheduling, reminders, notification permissions,
or any automatic prompt behavior. Any future reminder or notification work must
be scoped and reviewed separately.

## Proposed Data Model Concept

A future local model may look like:

```text
StateCheckIn
- id
- timestamp
- selectedState
- optionalNote
- sourceSurface
- schemaVersion
```

Suggested field meanings:

- `id`: stable local identifier.
- `timestamp`: local time the check-in was created.
- `selectedState`: one of `Energized`, `Stable`, `Tired`, or `Low`.
- `optionalNote`: optional user-entered context, if later phases include notes.
- `sourceSurface`: `watch` or `iPhone`.
- `schemaVersion`: stable migration marker for future local storage changes.

Do not implement this model in Swift during Phase 9.0.

## Local-Only Storage Direction

Future storage should be:

- Local-only.
- On-device.
- Available without an account.
- Separate from raw HealthKit samples.
- Separate from HealthKit write APIs.
- Designed for deletion/export decisions in a later privacy review.

For the MVP, State Check-in must not use:

- Cloud sync.
- Server storage.
- Developer-accessible databases.
- Advertising profiles.
- Marketing profiles.
- Data mining.
- AI cloud profiling.
- Analytics rollout.

## Future Watch App Architecture

The Watch app is a natural future entry point because check-ins should be quick.

Future Watch implementation should:

- Use a glanceable, low-text flow.
- Prefer one-tap entry after the user opens the check-in view.
- Support the four safe states only at first.
- Avoid long explanations on small screens.
- Keep copy non-medical and non-alarming.
- Avoid implying that Watch sensor data diagnosed the selected state.

Phase 9.0 does not implement Watch UI. Phase 9.2 should produce Figma Watch
mockups before Phase 9.3 implements any Watch check-in UI.

## Future iPhone App Architecture

The iPhone app may later support:

- Reviewing recent check-ins.
- Editing or deleting local check-ins.
- Adding an optional note if approved for a later phase.
- Showing calm personal patterns over time.
- Explaining that check-ins are optional and local-only.

Phase 9.0 does not implement iPhone UI or storage.

## Future WidgetKit / Complication Considerations

WidgetKit and complications should not become the first State Check-in surface.

Future WidgetKit work may consider:

- Displaying a compact last-check-in summary.
- Showing only low-detail, user-approved display state.
- Avoiding raw check-in history.
- Avoiding sensitive notes.
- Avoiding medical or mental-health wording.

Phase 9.0 does not add WidgetKit check-in display, timelines, or complication
content.

## App Group Boundary

App Group use should remain cautious for Phase 9.x.

Rules:

- Do not store raw check-in histories in App Group shared state.
- Do not store notes in App Group shared state.
- Do not store raw HealthKit samples in App Group shared state.
- If App Group is used later, store only a compact display summary needed by a
  specific surface.
- Document freshness, stale, unavailable, and deletion behavior before any App
  Group propagation.

Phase 9.0 does not implement App Group writes or propagation.

## HealthKit Relationship

State Check-in should complement HealthKit-derived readiness, not replace it.

Rules:

- A check-in is subjective user-entered context.
- HealthKit scoring remains a local wellness estimate based on available data.
- State Check-in should not override HealthKit scoring as a medical signal.
- State Check-in should not be used to claim causality.
- Missing check-ins must not reduce a wellness score or imply a bad state.

Allowed future wording:

- `On days with lower sleep, you more often reported feeling tired.`
- `Your check-ins can help StateWatch show patterns over time.`
- `This is based on your own self-reported state.`

Forbidden future wording:

- `Your tiredness is caused by poor sleep.`
- `StateWatch detected clinical stress.`
- `Your check-in indicates a medical condition.`

## Personal Pattern Analysis Relationship

Future personal pattern analysis should start with local, transparent summaries:

- Counts by state over time.
- Time-of-day patterns.
- Gentle correlations with local readiness context.
- Optional check-in frequency context.

Pattern analysis should not:

- Diagnose mood, anxiety, depression, or clinical stress.
- Infer a medical condition.
- Rank the user negatively for not checking in.
- Use cloud AI or developer-accessible analysis for the MVP.
- Use check-ins for advertising, profiling, marketing, or data mining.

## Privacy Model

State Check-ins are personal user-entered context and should remain local-only
for the MVP.

Privacy requirements:

- No account required.
- No cloud database.
- No developer access to check-in history.
- No ad profile.
- No AI cloud profiling.
- No analytics rollout.
- No networking or upload path.
- No HealthKit write access.
- Clear future deletion behavior before storage implementation.

## Low-Data / Missing-Data Behavior

Check-ins must be optional.

If no check-ins exist:

- Do not imply the user did something wrong.
- Do not show a negative wellness state.
- Do not lower HealthKit-derived scores.
- Show neutral wording such as `No check-ins yet` or `Check-ins are optional.`

If check-in data is sparse:

- Lower confidence for personal pattern summaries.
- Avoid broad conclusions.
- Prefer wording such as `Not enough check-ins to show a pattern yet.`

## Localization Direction

State Check-in should be planned for English and Traditional Chinese together.

Initial labels:

| English | Traditional Chinese |
| --- | --- |
| Energized | 有活力 |
| Stable | 穩定 |
| Tired | 疲累 |
| Low | 低狀態 |

Future localization work should:

- Keep labels short for Watch.
- Avoid clinical or diagnostic nuance in either language.
- Review copy in both languages before SwiftUI implementation.
- Move UI strings to localization resources only in a scoped localization phase.

## Figma-First Design Rule

State Check-in affects UI, icon buttons, Watch layout, bilingual layout, and
possibly future complication surfaces. Future UI work must go through Figma
before SwiftUI implementation.

Sequence:

1. Phase 9.1: QA audit for State Check-in architecture.
2. Phase 9.2: Figma Watch check-in mockups.
3. Phase 9.3: Watch check-in mock UI implementation.
4. Phase 9.4: QA audit for the Watch check-in mock UI.
5. Phase 9.5: Scoped local-only check-in storage design.
6. Phase 9.6: QA audit for local storage design.
7. Phase 9.7: Implement local-only check-in storage foundation on one approved
   surface.
8. Phase 9.8: QA audit for storage implementation.
9. Phase 9.9: Display preference / icon-text behavior, if still needed.
10. Phase 9.10: UX QA audit before pattern analysis.

Codex should not invent final icon, layout, or bilingual UI directly in SwiftUI
if Figma specs exist or are planned for the phase.

## Testing Strategy

Future QA should verify:

- State labels remain exactly the approved safe labels unless a later product
  decision changes them.
- English and Traditional Chinese labels are reviewed together.
- Copy avoids medical, mental-health diagnosis, clinical stress, disease,
  treatment, warning, emergency, and abnormal-state language.
- Check-ins remain optional.
- Missing check-in data does not imply a bad state.
- Sparse check-in history lowers confidence for pattern summaries.
- No networking, cloud sync, analytics, account dependency, remote config,
  WatchConnectivity, AI cloud analysis, or HealthKit write access is introduced.
- App Group does not expose raw check-in history or notes.
- HealthKit scoring remains local-only and is not treated as medical causality.

## Pass / Fail Criteria For Phase 9.0

Phase 9.0 passes if:

- This architecture document exists.
- Safe terminology is defined.
- The four initial check-in states are defined in English and Traditional
  Chinese.
- The local-only privacy model is defined.
- Non-goals are explicit.
- Figma-first future UI sequencing is clear.
- TEST_PLAN references the Phase 9.0 architecture review.
- No source behavior changes were added.
- No prohibited scope was added.

Phase 9.0 fails if:

- It implements UI, storage, notifications, scheduling, or sync.
- It introduces medical, mental-health diagnostic, treatment, emergency, or
  clinical-stress wording.
- It adds networking, cloud sync, AI, analytics, remote config, WatchConnectivity,
  App Group propagation, or HealthKit write behavior.
- It starts Phase 9.1 or later implementation work.

## Risks And Mitigations

| Risk | Mitigation |
| --- | --- |
| Users interpret check-ins as diagnosis. | Keep labels subjective and add wellness-only copy. |
| Missing check-ins feel punitive. | Treat check-ins as optional and avoid score penalties for missing entries. |
| Watch UI becomes too complex. | Use Figma first and keep the Watch flow one-tap and glanceable. |
| App Group exposes too much context. | Store only compact display summaries if App Group is approved later. |
| Pattern copy implies causality. | Use correlation wording such as `more often reported`, not `caused by`. |
| Bilingual labels drift in meaning. | Review English and Traditional Chinese together before implementation. |

## Open Questions

- Should a future storage phase support optional notes, or should notes wait until a later
  privacy review?
- Should check-ins be editable or deletable in the first storage phase?
- What retention window is appropriate for local-only check-in history?
- Should Watch check-in entry require confirmation or save immediately?
- Should future pattern summaries appear on iPhone only before Watch display?
- What compact summary, if any, is safe for WidgetKit or App Group later?
- Should notification reminders remain out of MVP entirely?

## Final Phase 9.0 Result Checklist

- State Check-in architecture is documented.
- State Check-in is defined as subjective self-report only.
- Initial states are `Energized`, `Stable`, `Tired`, and `Low`.
- Traditional Chinese labels are `有活力`, `穩定`, `疲累`, and `低狀態`.
- Local-only privacy boundaries are documented.
- HealthKit relationship is complementary, not causal or medical.
- Figma-first future UI rule is documented.
- App Group, WatchConnectivity, WidgetKit, storage, notifications, networking,
  AI, analytics, remote config, and HealthKit write access remain unimplemented.
- Later State Check-in implementation phases remain future work until scoped.
