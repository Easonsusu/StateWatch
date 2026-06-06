# iPhone Dashboard Design

The future iPhone Dashboard should be a dark-mode-first, score-led wellness
screen. It should feel premium, calm, and data-centric without becoming a dense
analytics tool or a medical screen.

## Layout Order

Recommended top-to-bottom order:

1. Hero section
2. Overall score
3. State label
4. Confidence and last updated
5. Score ring
6. Component cards
7. Reasons section
8. Suggestions section
9. 7-day mini trend section
10. Safe empty or low-data states when needed

## Hero Section

The hero should show the user's current wellness estimate in one glance.

- Use a large score ring or score number as the anchor.
- Show one short state label such as `Steady`, `Mixed`, or `Low`.
- Include confidence in a small badge.
- Include `Last updated` in subdued text.
- Avoid marketing copy or large decorative hero art.

## Overall Score

- Range: 0 to 100.
- Use monospaced digits if available.
- Pair the numeric score with a calm label.
- Do not imply medical status.
- Low confidence should visually soften the score instead of making it alarming.

## State Label

State labels should be short and non-medical.

- `Steady`
- `Mixed`
- `Low`
- `Needs rest`
- `Limited data`

Avoid labels such as `Sick`, `At risk`, `Detected stress`, or `Abnormal`.

## Confidence

Show confidence near the score so users understand data completeness.

- High: enough recent local signals.
- Medium: useful but incomplete signal set.
- Low: limited recent data.
- Unavailable: not enough usable data.

Confidence is about estimate quality, not user health.

## Last Updated

Use a small freshness label:

- `Updated today`
- `Updated 2h ago`
- `No recent update`
- `Waiting for Apple Health data`

If data is stale, use calm wording and do not imply danger.

## Score Ring

- Use a thin to medium circular ring.
- Keep the center text readable.
- Use subtle glow on the active arc only.
- Include state and confidence nearby.
- Do not rely on color alone.

## Component Cards

Component cards should summarize:

- Recovery
- Sleep
- Stress/fatigue context
- Activity load

Each card should include:

- Component title
- Score or limited-data label
- One short summary
- Confidence indicator

## Reasons Section

Reasons explain the main contributors behind the estimate.

- Use short rows with optional SF Symbol icons.
- Keep copy factual and cautious.
- Mention missing data as limited confidence only.
- Avoid medical claims and alarming interpretations.

## Suggestions Section

Suggestions should be optional and gentle.

- Use one primary suggestion first.
- Keep suggestions short enough for mobile scanning.
- Include `if that matches how you feel` when suggesting lighter activity.
- Do not prescribe treatment or medical action.

## 7-Day Mini Trend

The trend section should help users understand recent movement.

- Show a compact sparkline or mini bar chart.
- Avoid dense axes.
- Indicate limited data with gaps or muted markers.
- Do not turn missing data into a low score.

## Empty State

Use when no preview or dashboard data is available.

Example copy:

`No recent wellness estimate is available yet. StateWatch can continue with mock data while Apple Health access is set up.`

## Low-Data State

Use when there is some data, but not enough for confidence.

Example copy:

`Recent data is limited, so this estimate is cautious. More local history can make the summary steadier.`

## HealthKit Unavailable State

Use when HealthKit is unavailable on the current device.

Example copy:

`Apple Health data is not available on this device. The dashboard can still show a safe mock preview.`

## Permission-Needed State

Use when the app needs read-only Apple Health permission.

Example copy:

`StateWatch reads selected Apple Health signals locally to summarize wellness trends. No HealthKit data is uploaded in the MVP.`

## Debug Preview Entry State

The HealthKit scoring preview should remain developer-only until production
readiness is approved.

- Keep it under Settings.
- Label it clearly as a developer preview.
- Do not replace production dashboard data yet.

## Phase 5.7 Figma Frames

Use `393 x 852` iPhone frames with dark background, premium glass cards, a large
score ring, high-contrast text, and restrained cyan, blue, and green accents.

Create:

- `[Phase 5.7] Main Dashboard / Normal State`
- `[Phase 5.7] Low Data State`
- `[Phase 5.7] Loading State`
- `[Phase 5.7] HealthKit Unavailable State`
- `[Phase 5.7] Permission Needed State`
- `[Phase 5.7] Debug Preview Entry State`

Normal state content:

- `Today`
- Score `76`
- State label `Mixed`
- Confidence `Medium`
- `Updated 12:40`
- Component cards for `Recovery 68`, `Sleep 81`, `Fatigue Context 64`, and
  `Activity Load 75`
- Reasons:
  - `Your recent signals look mixed.`
  - `Sleep is close to your recent pattern.`
  - `Recovery signals are slightly softer than your baseline.`
- Suggestion:
  - `Consider a lighter day if that matches how you feel.`
- 7-day mini trend

State copy:

- Low data: `Recent data is limited, so this estimate is cautious.`
- Loading: `Analyzing recent signals...`
- Loading note: `This stays on device and uses Apple Health data only when available.`
- Unavailable: `Apple Health data is unavailable.`
- Unavailable note: `StateWatch can keep showing demo data until local Health data is available.`
- Permission: `Connect Apple Health`
- Permission note: `StateWatch requests read-only access to selected Apple Health signals for local wellness summaries.`

Do not use red warning styling for low-data or unavailable states.

## TODO

- Convert this layout into detailed Figma frames.
- Review with realistic low-data and unavailable states before SwiftUI changes.
