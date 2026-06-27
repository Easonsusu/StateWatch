# Phase 9.2 Watch Check-in Figma Mockups

Phase 9.2 defines the Figma-first design specification for the future Apple
Watch State Check-in flow. This phase is documentation and mockup planning
only. It does not implement SwiftUI, storage, reminders, notifications,
WidgetKit check-in display, App Group propagation, WatchConnectivity, HealthKit
write access, networking, cloud sync, analytics, remote config, or AI.

## Purpose

State Check-in should let a user quickly self-report their current subjective
state from Apple Watch. The check-in can later add user-entered context to
StateWatch's local wellness reflections, but it must remain optional,
low-anxiety, non-medical, and clearly separate from HealthKit-derived signals.

Phase 9.2 creates the design handoff for future Figma frames before Phase 9.3
implements any Watch UI.

## Scope

This document defines:

- Watch check-in entry point concept.
- Primary Watch check-in screen direction.
- Four-state selection layout options.
- Confirmation / saved state concept.
- Empty, unavailable, and no-check-in-yet wording.
- English and Traditional Chinese label behavior.
- Placeholder icon direction.
- Accessibility and small-screen constraints.
- Low-anxiety visual principles.
- Interaction flow.
- Safety and privacy boundaries.
- Future Phase 9.3 SwiftUI implementation notes.
- Figma handoff checklist.
- QA checklist for the mockups.

## What This Phase Does Not Do

- Does not edit Figma directly unless a connected, approved Figma workflow is
  used outside this repository documentation.
- Does not implement Watch UI in SwiftUI.
- Does not implement iPhone UI.
- Does not add check-in storage.
- Does not add reminders, notifications, scheduling, or background delivery.
- Does not add WidgetKit check-in display.
- Does not add App Group propagation.
- Does not add WatchConnectivity.
- Does not change HealthKit rollout behavior.
- Does not enable the HealthKit-backed Dashboard by default.
- Does not add HealthKit write access.
- Does not add networking, cloud sync, account systems, analytics, remote
  config, AI, or AI cloud analysis.
- Does not begin Phase 9.3, Phase 9.4, or later work.

## Figma-first Rule

Future Watch State Check-in implementation must inspect the Figma design system
and Phase 9.2 mockups before SwiftUI changes begin.

Codex should not invent final Watch layouts, icon choices, bilingual spacing,
or animation behavior directly in SwiftUI when Figma specs exist or are planned.
The repository documentation is the handoff plan; editable Figma frames should
be created from this spec before Phase 9.3 implementation.

Recommended Figma file:

- `StateWatch UI Design System`

Recommended page:

- `03 Watch App`

Recommended frame group:

- `[Phase 9.2] Watch State Check-in`

## Watch Design Goals

- Make the flow complete within a few seconds.
- Keep the first screen score-free and judgment-free.
- Use short labels that remain readable on small Apple Watch screens.
- Support English-only, Traditional Chinese-only, and bilingual review.
- Avoid color-only meaning.
- Keep all copy calm and optional.
- Avoid visual treatment that feels like an alarm, warning, or medical state.
- Use dark-mode-first StateWatch technology styling with restrained glow.
- Prefer large tap targets over dense ornament.
- Preserve a text-only fallback if icons are not ready.

## Approved State Labels

Use exactly these four initial State Check-in options:

| English | Traditional Chinese |
| --- | --- |
| Energized | 有活力 |
| Stable | 穩定 |
| Tired | 疲累 |
| Low | 低狀態 |

These labels are subjective self-report choices. They are not diagnoses,
clinical categories, medical conditions, symptoms, warnings, or HealthKit
detections.

## User Flow

```text
Watch Dashboard or future State Check-in entry
  -> Check in
  -> Select one of four subjective states
  -> Confirmation / saved state
  -> Return to Watch Dashboard or close
```

Future implementation may also allow the user to update the current check-in
later in the day. That behavior is not implemented in Phase 9.2.

## Screen Inventory

1. Entry point concept.
2. Primary selection screen.
3. Compact 2x2 state grid.
4. Vertical state list.
5. Confirmation / saved state.
6. Empty / no check-in-yet state.
7. Unavailable state if the future feature is disabled or cannot load.

## Entry Point Concept

The Watch app may later show a `Check in` entry from the existing Watch
Dashboard or a dedicated future State Check-in surface.

Suggested English entry copy:

- `Check in`

Suggested Traditional Chinese entry copy:

- `狀態回報`

Entry point rules:

- Do not imply the Watch detected a state.
- Do not show a negative badge for missing check-ins.
- Do not use red alert styling.
- Do not require HealthKit permission to use the check-in entry.
- Keep it clearly user-initiated.

## Primary Watch Check-in Screen

Suggested English copy:

- Title: `Check in`
- Subtitle: `How do you feel right now?`

Suggested Traditional Chinese copy:

- Title: `狀態回報`
- Subtitle: `你現在感覺如何？`

The primary screen should be direct and non-clinical. Avoid copy such as
`detected`, `diagnosed`, `warning`, `abnormal`, `clinical`, `stress detected`,
or `mental health issue`.

## Mockup A: Compact 2x2 State Grid

Purpose:

- Fast one-tap check-in.
- Best for users who already understand the four labels.
- Works well when icon direction is finalized and labels stay short.

Wireframe:

```text
+----------------------+
| Check in             |
| How do you feel now? |
|                      |
| [*] Energized [=] Stable |
|     有活力       穩定    |
|                      |
| [~] Tired     [.] Low    |
|     疲累        低狀態   |
|                      |
| Optional. Local only.|
+----------------------+
```

Strengths:

- Fastest interaction.
- Clear symmetry.
- Feels native to compact Watch tasks.

Risks:

- Tap targets may be small on smaller Watch sizes.
- Bilingual labels may be tight.
- `Low / 低狀態` must not feel alarming.

Design notes:

- Use equal-size cells.
- Keep labels centered and readable.
- Prefer subtle selected-state glow only after tap.
- Avoid red, alert, danger, or medical symbolism.
- Use text-only fallback if icons do not improve clarity.

## Mockup B: Vertical List With Larger Tap Targets

Purpose:

- Prioritizes accessibility and readability.
- Better for bilingual labels and VoiceOver.
- Safer default if the compact grid feels crowded.

Wireframe:

```text
+----------------------+
| Check in             |
| How do you feel now? |
|                      |
| [*] Energized        |
|     有活力           |
| [=] Stable           |
|     穩定             |
| [~] Tired            |
|     疲累             |
| [.] Low              |
|     低狀態           |
+----------------------+
```

Strengths:

- Larger tap targets.
- More readable on small watches.
- Easier bilingual support.

Risks:

- May require scrolling on smaller screens.
- Slightly slower than the 2x2 grid.

Design notes:

- Use full-width rows with minimum comfortable height.
- Keep row dividers subtle.
- Keep icon size secondary to label readability.
- Avoid treating `Low` as a failure state.

## Mockup C: Confirmation / Saved State

Purpose:

- Confirms the user action without implying improvement, treatment, or advice.
- Allows an easy return path.

Suggested English copy:

- `Saved`
- `Check-in saved`
- `You can update it later`

Suggested Traditional Chinese copy:

- `已儲存`
- `狀態回報已儲存`
- `之後可以再更新`

Wireframe:

```text
+----------------------+
|        Saved         |
|   Check-in saved     |
| You can update later |
|                      |
|       [Done]         |
+----------------------+
```

Rules:

- Do not imply the saved state improves health.
- Do not say the app learned, diagnosed, detected, or confirmed anything.
- Do not show medical advice.
- Keep the completion visual calm and brief.

## Empty / No Check-in-yet State

Suggested English copy:

- `No check-in yet`
- `Check-ins are optional.`

Suggested Traditional Chinese copy:

- `尚未回報`
- `狀態回報是選填的。`

Rules:

- Missing check-ins must not look like a bad state.
- Do not lower a readiness score because a check-in is missing.
- Do not shame the user for skipping.
- Do not prompt with urgency.

## Unavailable State

Suggested English copy:

- `Check-in is unavailable right now.`
- `You can keep using StateWatch without it.`

Suggested Traditional Chinese copy:

- `目前無法使用狀態回報。`
- `你仍可繼續使用 StateWatch。`

Rules:

- Do not imply data loss or risk.
- Do not suggest HealthKit permission is required.
- Do not use alert styling.

## English Copy Set

Primary:

- `Check in`
- `How do you feel right now?`
- `Energized`
- `Stable`
- `Tired`
- `Low`

Confirmation:

- `Saved`
- `Check-in saved`
- `You can update it later`

Empty:

- `No check-in yet`
- `Check-ins are optional.`

Unavailable:

- `Check-in is unavailable right now.`
- `You can keep using StateWatch without it.`

## Traditional Chinese Copy Set

Primary:

- `狀態回報`
- `你現在感覺如何？`
- `有活力`
- `穩定`
- `疲累`
- `低狀態`

Confirmation:

- `已儲存`
- `狀態回報已儲存`
- `之後可以再更新`

Empty:

- `尚未回報`
- `狀態回報是選填的。`

Unavailable:

- `目前無法使用狀態回報。`
- `你仍可繼續使用 StateWatch。`

## Label Behavior

For Figma exploration:

- Test English-only labels.
- Test Traditional Chinese-only labels.
- Test compact bilingual labels only if space remains readable.
- Prefer one language per user locale in production.
- Do not rely on abbreviations unless reviewed for clarity.
- Keep `Low / 低狀態` calm, not alarming.

## Icon Direction

Icons are placeholders in Phase 9.2. Do not finalize assets in this phase.

Possible icon concepts:

| State | Placeholder direction | Avoid |
| --- | --- | --- |
| Energized | Spark, sun, upward mark | Medical lightning, intense warning glow |
| Stable | Circle, balance, calm line | Clinical monitor symbol |
| Tired | Moon, soft line, low battery-like shape | Shaming depleted-battery treatment |
| Low | Gentle dot, soft cloud, subtle downward mark | Red alert, danger triangle, siren, medical cross |

Icon rules:

- Icons must be supportive, not diagnostic.
- Each option must work without color.
- Icons must not resemble medical warning symbols.
- Use SF Symbols direction only after Figma review.

## Accessibility Notes

- Use large tap targets appropriate for Apple Watch.
- Keep labels short and readable.
- Avoid color-only meaning.
- Support VoiceOver-friendly labels:
  - `Energized, self-reported state`
  - `Stable, self-reported state`
  - `Tired, self-reported state`
  - `Low, self-reported state`
- Avoid shame or negative scoring language.
- Avoid motion-dependent meaning.
- Ensure selected state has non-color affordance such as border, checkmark, or
  label change.
- Review bilingual text length on small Apple Watch sizes.
- Keep confirmation visible long enough to understand, but do not require a
  long reading task.

## Apple Watch Layout Constraints

- Design for a few-second glance.
- Keep one primary action per screen.
- Avoid tiny paragraphs.
- Avoid dense cards inside cards.
- Use minimal vertical chrome.
- Prefer vertical list if 2x2 grid tap targets are too small.
- Keep title and subtitle compact.
- Avoid placing essential text near rounded screen corners.
- Validate on small and large Watch frames in Figma.

## Low-anxiety Visual Safety

State Check-in should feel like a simple reflection, not a score judgment.

Visual rules:

- Use the existing dark technology style.
- Use subtle cyan, blue, green, or neutral accents.
- Avoid red alert styling for `Low`.
- Avoid alarm shapes and emergency symbolism.
- Avoid clinical monitor visuals.
- Avoid making missing check-ins look like a failure.
- Keep all state options visually balanced.
- Avoid ranking the four states from best to worst in a way that shames the
  user.

## Safety Boundaries

State Check-in is subjective self-report only.

It must not claim or imply:

- Mood diagnosis.
- Emotional diagnosis.
- Anxiety detection.
- Depression detection.
- Mental illness detection.
- Clinical stress detection.
- Disease or illness detection.
- Medical advice.
- Treatment guidance.
- Therapy recommendation.
- Emergency alerting.
- Abnormal mental-state detection.
- Health warning.
- HealthKit-derived state detection.

Allowed framing:

- `Your check-in is user-entered context.`
- `A check-in can add context to today's signals.`
- `Check-ins are optional.`
- `Not enough check-ins to show a pattern yet.`

Forbidden framing:

- `StateWatch detected your mood.`
- `Clinical stress detected.`
- `You are at risk.`
- `Your state is abnormal.`
- `You need treatment.`
- `Your tiredness is caused by poor sleep.`

## Privacy Boundaries

Phase 9.2 does not store check-ins.

Future storage must remain:

- Local-only.
- On-device.
- Available without an account.
- Separate from raw HealthKit samples.
- Separate from HealthKit write APIs.
- Free from developer access.
- Free from cloud sync, analytics, remote config, advertising profiles, data
  mining, or AI cloud profiling.

## Relationship To HealthKit

State Check-in is user-entered context.

It is not:

- Detected from HealthKit.
- A HealthKit write operation.
- A medical signal.
- A replacement for HealthKit scoring.
- A cause of readiness score changes.

Future pattern copy must remain correlation-oriented:

- Allowed: `On days with lower sleep, you more often reported feeling tired.`
- Not allowed: `You feel tired because you slept less.`

## Future Phase 9.3 Implementation Guidance

Phase 9.3 should not start until Figma mockups are reviewed.

When implementation begins:

- Implement Watch UI only.
- Keep labels exactly aligned with the approved four states.
- Keep the first implementation mock-only if storage is still deferred.
- Do not add storage unless Phase 9.4 explicitly approves it.
- Do not add reminders or notifications.
- Do not add WidgetKit check-in display.
- Do not add App Group check-in propagation.
- Do not add WatchConnectivity.
- Do not change HealthKit Dashboard rollout behavior.
- Do not add HealthKit write access.
- Add tests for labels, wording, and no prohibited mechanisms if code is
  introduced.

## Figma Handoff Checklist

Create editable frames for:

- `[Phase 9.2] Watch Check-in Entry`
- `[Phase 9.2] Check-in 2x2 Grid`
- `[Phase 9.2] Check-in Vertical List`
- `[Phase 9.2] Check-in Confirmation`
- `[Phase 9.2] No Check-in Yet`
- `[Phase 9.2] Check-in Unavailable`

Each frame should include:

- English copy.
- Traditional Chinese copy or a paired localization frame.
- Placeholder icon direction.
- Tap target notes.
- VoiceOver label notes.
- Low-anxiety visual notes.
- Safety boundary note that states are self-reported only.

Figma review should confirm:

- Four approved labels only.
- No diagnostic or clinical language.
- `Low / 低狀態` is calm and non-alarming.
- Text fits on small Apple Watch screens.
- The layout does not rely only on color.
- The implementation handoff is clear enough for SwiftUI.

## QA Checklist

- Confirm this phase is documentation-only.
- Confirm no Swift source files changed.
- Confirm no Xcode project files changed.
- Confirm no image or Figma binary assets were added.
- Confirm no storage, reminders, notifications, scheduling, WidgetKit display,
  App Group propagation, WatchConnectivity, networking, cloud, analytics,
  remote config, AI, or HealthKit write behavior was added.
- Confirm the approved states are exactly `Energized`, `Stable`, `Tired`, and
  `Low`.
- Confirm Traditional Chinese labels are exactly `有活力`, `穩定`, `疲累`, and
  `低狀態`.
- Confirm empty and unavailable states are calm.
- Confirm missing check-ins are optional and not negative.
- Confirm copy avoids diagnosis, clinical stress, disease detection, treatment,
  emergency, warning, abnormal-state, and medical-advice claims.
- Confirm Figma-first sequencing remains intact before Phase 9.3.

## Final Phase 9.2 Result Checklist

Phase 9.2 passes when:

- Watch check-in mockup spec exists.
- Four approved states are used exactly.
- English and Traditional Chinese labels are documented.
- At least two layout options are documented.
- Confirmation / saved state copy is documented.
- Empty and unavailable state copy is documented.
- Low-anxiety safety wording is documented.
- Icon direction remains placeholder-level only.
- Figma handoff checklist exists.
- Phase 9.3 implementation guidance exists.
- TEST_PLAN references Phase 9.2.
- No storage, notification, WidgetKit, App Group, WatchConnectivity, HealthKit
  write, networking, cloud, analytics, remote config, AI, or HealthKit rollout
  behavior is added.
