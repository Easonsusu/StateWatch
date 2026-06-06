# Watch UI Guidelines

The StateWatch Watch app should be glanceable, dark, minimal, and score-first.
It should not try to show every dashboard detail. A user should understand the
main state within a few seconds.

## Overall Direction

- Dark technology style with restrained glow.
- Large score-first layouts.
- Short state labels.
- One-line suggestions.
- Minimal scrolling.
- Clear confidence and freshness when space allows.

## Full-Screen Watch Layout

Use a small set of focused screens rather than a dense dashboard.

- Screen 1: overall score.
- Screen 2: component summary.
- Screen 3: suggestion.
- Screen 4: confidence and last updated.

Each screen should have one primary job.

## Score-First Screen

Content:

- Score ring or large score number.
- Short state label.
- Optional confidence badge.
- Last updated only if space allows.

Avoid:

- Long explanations.
- Multiple competing charts.
- Small labels around the ring.

## Short State Label

Use labels that fit small screens:

- `Steady`
- `Mixed`
- `Low`
- `Rest`
- `Limited`

Do not use medical or alarming labels.

## One-Line Suggestion

Suggestion copy should be optional and short.

Examples:

- `Consider a lighter day.`
- `A steady bedtime may help.`
- `Check in to add context.`
- `Recent data is limited.`

## Component Summary Page

Show only the most important component signals.

Recommended format:

- Recovery: score or state
- Sleep: score or state
- Fatigue context: score or state
- Activity load: score or state

Use compact rows, small badges, and no long paragraphs.

## Confidence / Last Updated Page

This page explains estimate quality and freshness.

Content:

- Confidence: high, medium, low, or unavailable.
- Last updated: today, time ago, stale, or unavailable.
- Local-only note if space allows.

Example:

`Low confidence. Recent data is limited.`

## Typography Guidance

- Use large numeric score type.
- Use short labels with semibold weight.
- Use body text only for one-line suggestions.
- Avoid tiny supporting copy.
- Prefer dynamic type compatibility where practical.

## Spacing Guidance

- Keep generous top and bottom breathing room.
- Avoid placing text close to rounded screen edges.
- Keep row spacing consistent.
- Use compact cards only when they improve scanning.

## Dark Technology Style

- Use dark backgrounds with subtle surface contrast.
- Use glow only on the score ring or active state.
- Avoid decorative shapes and heavy gradients.
- Keep all text readable at small sizes.

## Avoid Information Overload

Do not show:

- Full reason lists.
- Detailed charts.
- Long HealthKit data explanations.
- Multiple suggestions at once.
- Medical-sounding alerts.

## Phase 5.7 Watch Frames

Use compact Watch frames around `198 x 242`. The design should be score-first,
dark, legible, and readable within a few seconds.

Create:

- `[Phase 5.7] Overall Score Screen`
- `[Phase 5.7] Component Summary Screen`
- `[Phase 5.7] Suggestion Screen`
- `[Phase 5.7] Confidence / Last Updated Screen`

Content:

- Overall score screen: `76`, `Mixed`, `Today looks mixed overall`
- Component summary screen: `Recovery 68`, `Sleep 81`, `Load 75`
- Suggestion screen: `Consider a lighter day if that matches how you feel.`
- Confidence screen: `Confidence: Medium`, `Updated 12:40`,
  `Local Apple Health estimate`

Use `Not medical advice` only if space allows. Prefer keeping that fuller
disclaimer on iPhone.

## TODO

- Validate Watch layouts in Figma at actual watch sizes.
- Test copy truncation on small Apple Watch screens.
