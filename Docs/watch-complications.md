# Watch Complications

This document defines future WidgetKit watch complication planning only. Do not
add WidgetKit targets or Swift models in this phase.

## Documentation-Only Model

Future complication planning can use this documentation-only shape:

```swift
ComplicationStateSummary:
- score
- stateLabel
- shortSuggestion
- confidence
- lastUpdated
- isStale
```

Do not implement this model in Swift yet.

## Shared Rules

- Complications should summarize wellness estimates, not medical status.
- Show less content when confidence is low.
- Do not show alarming copy.
- Do not show long explanations.
- Stale data should be obvious but calm.
- Tap behavior should open the Watch app dashboard or relevant summary screen.

## Phase 5.7 Visual Decisions

Create high-fidelity concepts for each family with variants for normal, low
confidence, stale data, and unavailable/no data.

Allowed state wording:

- `Mixed`
- `Steady`
- `Low data`
- `No data`

Avoid:

- `High stress`
- `Bad recovery`
- `Health risk`
- `Warning`

All family notes should include:

- `Tap opens StateWatch Watch app.`

## accessoryCircular

Allowed content:

- Score number.
- Small score ring.
- Very short state label if space allows.

Content that is too much:

- Reasons.
- Suggestions.
- Multiple component scores.
- Long confidence text.

Layout direction:

- Ring around score or score-only center.
- Use state color carefully.
- Low confidence can use a muted ring.

Example copy:

- `82`
- `Mix`
- `Low`

Fallback state:

- Show `--` with muted ring.

Stale data state:

- Show muted score with a small freshness marker if supported.

Low confidence state:

- Use subdued color and avoid strong score emphasis.

Tap behavior:

- Open the Watch app overall score screen.

Design constraints:

- Must remain legible at very small size.
- Do not rely on glow for readability.

Phase 5.7 variants:

- Normal: score `76`, optional small ring, optional `MIX`
- Low confidence: muted ring, `76`, `LOW`
- Stale data: muted score with tiny stale dot
- Unavailable: `--`, `No data`

## accessoryRectangular

Allowed content:

- Score.
- State label.
- One short suggestion or freshness note.
- Confidence badge if space allows.

Content that is too much:

- Full reason list.
- Mini trend chart plus suggestion plus confidence.
- Detailed HealthKit source text.

Layout direction:

- Left: score or small ring.
- Right: state label and one line of supporting copy.

Example copy:

- `82 Steady`
- `Mixed - consider lighter pace`
- `Limited data`

Fallback state:

- `StateWatch - no recent estimate`

Stale data state:

- `StateWatch - update pending`

Low confidence state:

- `Limited data - cautious estimate`

Tap behavior:

- Open the Watch app dashboard or confidence page.

Design constraints:

- Text must not overflow.
- Prefer one supporting line over two.
- Avoid medical or urgent phrasing.

Phase 5.7 variants:

- Normal: `State 76 - Mixed`, `Take it lighter today`
- Low confidence: `Low data`, `Cautious estimate`
- Stale data: `State 76`, `Update pending`
- Unavailable: `StateWatch`, `No data`

## accessoryInline

Allowed content:

- Very short text only.
- Score plus state label.
- Limited-data fallback.

Content that is too much:

- Suggestion plus confidence plus score.
- Any chart or ring.
- Long state explanation.

Layout direction:

- Single inline phrase.

Example copy:

- `StateWatch 82 Steady`
- `StateWatch Mixed`
- `StateWatch Limited data`

Fallback state:

- `StateWatch --`

Stale data state:

- `StateWatch update pending`

Low confidence state:

- `StateWatch cautious estimate`

Tap behavior:

- Open the Watch app dashboard.

Design constraints:

- Keep copy under a short phrase.
- Avoid punctuation-heavy text.

Phase 5.7 variants:

- Normal: `State 76 Mixed`
- Low confidence: `State low data`
- Stale data: `State update pending`
- Unavailable: `State no data`

## accessoryCorner

Allowed content:

- Score.
- Tiny curved progress cue.
- Very short state abbreviation.

Content that is too much:

- Reasons.
- Suggestions.
- Confidence sentences.
- Multiple values.

Layout direction:

- Use corner arc or compact score treatment.
- State can be implied by color if paired with score, but not as the only cue in
  full UI contexts.

Example copy:

- `82`
- `Mix`
- `--`

Fallback state:

- Muted `--`.

Stale data state:

- Muted score or `--`.

Low confidence state:

- Muted arc and score.

Tap behavior:

- Open the Watch app dashboard.

Design constraints:

- Must remain readable on curved placement.
- Use minimal glow.

Phase 5.7 variants:

- Normal: score `76` with tiny arc or dot
- Low confidence: muted score and dot
- Stale data: muted score
- Unavailable: `--`

## TODO

- Validate all complication families in Figma before WidgetKit implementation.
- Confirm exact WidgetKit family availability for the deployment target.
