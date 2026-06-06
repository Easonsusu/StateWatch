# Phase 5.7 Figma High-Fidelity Mockup Spec

Phase 5.7 is design-only. It must not change SwiftUI, Xcode project settings,
app assets, WidgetKit targets, HealthKit logic, dashboard behavior, Watch app
behavior, networking, AI features, or HealthKit write access.

## Figma Canvas Status

Target Figma file:

- Name: `StateWatch UI Design System`
- Key: `5Fwk817dLos6IGQJ1w8dJw`
- URL: https://www.figma.com/design/5Fwk817dLos6IGQJ1w8dJw

Current canvas status:

- Figma access was restored after the previous Codex attempt.
- The existing Figma file now contains editable Phase 5.7 high-fidelity frames.
- Updated pages: `00 References`, `01 Design Tokens`, `02 iPhone Dashboard`,
  `03 Watch App`, `04 Watch Complications`, `05 Components`, and
  `06 Handoff Notes`.
- This document remains the review checklist and implementation reference for
  future Phase 5.8 SwiftUI work.

Phase 5.8 implementation should inspect the actual Figma frames before coding
and should not treat this as a documentation-only handoff.

## Required Pages

Update these existing pages and keep useful Phase 5.6 scaffold content:

- `00 References`
- `01 Design Tokens`
- `02 iPhone Dashboard`
- `03 Watch App`
- `04 Watch Complications`
- `05 Components`
- `06 Handoff Notes`

Add a visible `[Phase 5.7]` label to new boards, frames, and components.

## 01 Design Tokens

Create a high-fidelity token board named:

- `[Phase 5.7] Design Tokens / High Fidelity`

### Colors

Create editable color swatches with name, hex, semantic use, and SwiftUI mapping
notes:

- `backgroundPrimary`: `#080B12`
- `backgroundSecondary`: `#0E1320`
- `panel`: `#141B2A`
- `panelElevated`: `#182033`
- `border`: `#28344A`
- `textPrimary`: `#F4F8FF`
- `textSecondary`: `#AAB7CC`
- `textMuted`: `#65738C`
- `accentCyan`: `#35E7FF`
- `accentBlue`: `#4D7CFF`
- `accentViolet`: `#8E6CFF`
- `recoveryGreen`: `#5CF2B1`
- `cautionAmber`: `#FFCA63`
- `softRed`: `#FF6B6B`

### Score State Colors

- 80-100: `recoveryGreen` with optional `accentCyan`
- 60-79: `accentCyan`
- 40-59: `cautionAmber`
- Below 40: `softRed`, subdued and never alarm-styled
- Unavailable: `textMuted`

### Confidence State Colors

- High: `recoveryGreen`
- Medium: `accentCyan`
- Low: `cautionAmber`
- Unavailable: `textMuted`

### Typography

Use Inter for Figma mockups. Future SwiftUI should use system fonts unless a
product font decision is made later.

- Hero Score: 72 / semibold / tight numeric display
- Screen Title: 28 / semibold
- Section Title: 15 / semibold / uppercase or compact label optional
- Card Title: 16 / semibold
- Metric Value: 22 / semibold / monospaced digits if available
- Body: 15 / regular
- Caption: 12 / regular
- Badge: 12 / medium

### Spacing

Create spacing tokens:

- `4`
- `8`
- `12`
- `16`
- `20`
- `24`
- `32`

### Corner Radius

- Small: `12`
- Medium: `18`
- Large: `24`
- Pill: `999`

### Effects

Create effect cards for:

- Subtle glow: low-opacity cyan or green blur for score arcs only.
- Dark glass panel: translucent panel fill with thin border.
- Thin border: 1 px `border`.
- Restrained shadow: soft dark shadow under elevated panels.

Rules:

- Glow only on score ring, active progress, and tiny accents.
- No heavy cyberpunk neon.
- No medical-device alarm styling.
- No large red warning states unless absolutely necessary.

## 02 iPhone Dashboard

Use iPhone-sized frames, `393 x 852`, dark background, glass cards, large score
ring, and restrained cyan/blue/green accents.

Create these frames:

### `[Phase 5.7] Main Dashboard / Normal State`

Content:

- Title: `Today`
- Overall score: `76`
- State label: `Mixed`
- Confidence: `Medium`
- Last updated: `Updated 12:40`
- Large score ring
- Component cards:
  - `Recovery 68`
  - `Sleep 81`
  - `Fatigue Context 64`
  - `Activity Load 75`
- Reasons:
  - `Your recent signals look mixed.`
  - `Sleep is close to your recent pattern.`
  - `Recovery signals are slightly softer than your baseline.`
- Suggestion:
  - `Consider a lighter day if that matches how you feel.`
- 7-day mini trend with editable line or bar layers.

Visual direction:

- Hero score occupies the upper third.
- Component cards use two-column grid or compact stacked rows.
- Reasons and suggestions use glass panels.
- Trend uses a subtle cyan line and muted dots.

### `[Phase 5.7] Low Data State`

Content:

- Dimmed or cautious score treatment.
- Confidence: `Low data`
- Message: `Recent data is limited, so this estimate is cautious.`
- No alarming language.

Visual direction:

- Use muted amber and textMuted.
- Show empty metric placeholders as neutral, not negative.

### `[Phase 5.7] Loading State`

Content:

- `Analyzing recent signals...`
- `This stays on device and uses Apple Health data only when available.`

Visual direction:

- Static mockup may show a subtle ring skeleton or pulse direction.
- Keep local-only note visible but secondary.

### `[Phase 5.7] HealthKit Unavailable State`

Content:

- `Apple Health data is unavailable.`
- `StateWatch can keep showing demo data until local Health data is available.`

Visual direction:

- Neutral state, no red.
- Provide clear settings path visually if space allows.

### `[Phase 5.7] Permission Needed State`

Content:

- `Connect Apple Health`
- `StateWatch requests read-only access to selected Apple Health signals for local wellness summaries.`
- No write-access wording.
- No medical claims.

Visual direction:

- Use a single primary action style.
- Include local-only privacy note.

### `[Phase 5.7] Debug Preview Entry State`

Content:

- Settings surface with `Developer Preview`.
- `HealthKit Scoring Preview`.
- Make clear this is not the production dashboard.

Visual direction:

- Treat as a settings/developer panel, not a dashboard state.

## 03 Watch App

Use compact Watch-sized frames, approximately `198 x 242`. Use dark background,
score-first layout, very few words, and minimal glow.

Create these screens:

### `[Phase 5.7] Overall Score Screen`

- Score: `76`
- State: `Mixed`
- Copy: `Today looks mixed overall`
- Optional compact score ring.

### `[Phase 5.7] Component Summary Screen`

- `Recovery 68`
- `Sleep 81`
- `Load 75`
- Keep it glanceable.

### `[Phase 5.7] Suggestion Screen`

- `Consider a lighter day if that matches how you feel.`
- One or two lines only.

### `[Phase 5.7] Confidence / Last Updated Screen`

- `Confidence: Medium`
- `Updated 12:40`
- `Local Apple Health estimate`
- `Not medical advice` only if space allows.

## 04 Watch Complications

Create concept groups for each WidgetKit family and include normal, low
confidence, stale data, and unavailable variants.

Tap behavior note for all families:

- `Tap opens StateWatch Watch app.`

Use only:

- `Mixed`
- `Steady`
- `Low data`
- `No data`

Avoid:

- `High stress`
- `Bad recovery`
- `Health risk`
- `Warning`

### `[Phase 5.7] accessoryCircular`

- Normal: score `76`, optional small ring, optional `MIX`.
- Low confidence: muted ring, `76`, `LOW`.
- Stale data: muted score with tiny stale dot.
- Unavailable: `--`, `No data`.

### `[Phase 5.7] accessoryRectangular`

- Normal: `State 76 - Mixed`, `Take it lighter today`.
- Low confidence: `Low data`, `Cautious estimate`.
- Stale data: `State 76`, `Update pending`.
- Unavailable: `StateWatch`, `No data`.

### `[Phase 5.7] accessoryInline`

- Normal: `State 76 Mixed`
- Low confidence: `State low data`
- Stale data: `State update pending`
- Unavailable: `State no data`

### `[Phase 5.7] accessoryCorner`

- Normal: score `76` with tiny arc or dot.
- Low confidence: muted score and dot.
- Stale data: muted score.
- Unavailable: `--`.

### Documentation-Only Future Data Shape

Do not implement this in Swift in Phase 5.7:

```swift
ComplicationStateSummary:
- score
- stateLabel
- shortSuggestion
- confidence
- lastUpdated
- isStale
```

## 05 Components

Create editable component-like frames or Figma components named with
`[Phase 5.7]`.

### Score Ring

Variants:

- `92 Steady`
- `76 Mixed`
- `52 Cautious`
- `No data`

### Metric Card

Variants:

- Recovery
- Sleep
- Fatigue Context
- Activity Load

### Glass Card

Variants:

- Normal
- Elevated
- Accent glow

### State Pill

Variants:

- Steady
- Mixed
- Cautious
- Low data
- No data

### Confidence Badge

Variants:

- High
- Medium
- Low data
- Unavailable

### Supporting Components

- Reason Row: `Sleep is close to your recent pattern.`
- Suggestion Card: `Consider a lighter day if that matches how you feel.`
- Mini Trend Chart: 7-day trend line.
- Watch Score Module: compact score-first component.
- Complication Score Module: small score plus arc, dot, or label.

Component requirements:

- All layers editable.
- Consistent naming.
- Use the token values from `01 Design Tokens`.
- Name layers so future Codex SwiftUI implementation can map them to reusable
  SwiftUI views.

## 06 Handoff Notes

Create a board named:

- `[Phase 5.7] SwiftUI Handoff`

Include:

- Figma is source of truth for Phase 5.8 implementation.
- Implement design tokens first.
- Then reusable SwiftUI components.
- Then iPhone Dashboard refresh.
- Then Watch App refresh.
- Then WidgetKit complications.
- Production dashboard must remain mock-backed until the real-data dashboard
  toggle phase.
- Do not invent generic UI if Figma specs exist.
- Preserve cautious non-medical wording.
- Keep HealthKit data local-only.

## Verification Checklist

- Confirm high-fidelity frames exist on pages `01` through `06`.
- Confirm all layers are editable, not screenshots.
- Confirm dark mode contrast.
- Confirm score rings are readable on iPhone and Watch sizes.
- Confirm low-data and unavailable states are calm.
- Confirm complication text does not overflow.
- Confirm no medical or alarming UI copy appears.
