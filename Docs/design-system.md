# Design System

StateWatch should feel like a premium, minimal technology product for personal
wellness reflection. The visual system is dark-mode first, data-centric, calm,
and Apple-like. It can use subtle neon, glow, and glass-panel treatments, but it
should never feel noisy, cyberpunk-heavy, decorative for its own sake, or
medical.

## Product Visual Identity

- Quiet technology, not fitness hype.
- Personal signal dashboard, not medical instrumentation.
- Premium dark interface with high legibility.
- Soft dimensional panels, restrained glow, and precise typography.
- Cautious wellness wording that supports reflection without alarm.

## Design Principles

- Lead with the user's current wellness state and confidence.
- Make data limits visible without making missing data feel negative.
- Use calm hierarchy: one primary score, a few supporting signals, then reasons
  and suggestions.
- Keep HealthKit privacy visible through copy and settings, not decoration.
- Prefer simple Apple-native patterns that can translate cleanly into SwiftUI.

## Dark-Mode-First Direction

The default palette should use deep neutral backgrounds with cool, luminous
accents. Panels may feel glassy, but the UI should remain crisp and readable.
Avoid heavy gradients, busy effects, and high-saturation full-screen color.

Recommended foundation:

- App background: near-black blue-gray.
- Primary surface: translucent charcoal panel.
- Secondary surface: slightly lighter charcoal panel.
- Hairline border: low-opacity blue-gray.
- Primary text: cool near-white.
- Secondary text: muted blue-gray.
- Accent: cyan or mint used sparingly.

## Color System

Use semantic roles first. Exact values should be finalized in Figma tokens.

- `background.primary`: main app background.
- `surface.glass`: primary dashboard cards and grouped panels.
- `surface.raised`: selected, focused, or high-priority panels.
- `border.subtle`: 1 px panel borders and dividers.
- `text.primary`: headings and primary values.
- `text.secondary`: descriptions, captions, and confidence notes.
- `accent.cyan`: primary technology accent.
- `accent.mint`: steady or supportive wellness accent.
- `accent.amber`: mixed or limited-data state.
- `accent.rose`: low-energy state, used gently and never as an alarm.

## Phase 5.7 Token Values

These values are the current high-fidelity Figma token target and are reflected
in the editable Phase 5.7 Figma frames.

### Core Colors

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

- `80-100`: `recoveryGreen` with optional `accentCyan`
- `60-79`: `accentCyan`
- `40-59`: `cautionAmber`
- `below 40`: `softRed`, used gently and without alarm styling
- `unavailable`: `textMuted`

### Confidence State Colors

- `high`: `recoveryGreen`
- `medium`: `accentCyan`
- `low`: `cautionAmber`
- `unavailable`: `textMuted`

### Typography Tokens

Inter is acceptable for Figma mockups. SwiftUI should use system fonts unless a
product font decision is made later.

- Hero Score: 72, semibold
- Screen Title: 28, semibold
- Section Title: 15, semibold
- Card Title: 16, semibold
- Metric Value: 22, semibold
- Body: 15, regular
- Caption: 12, regular
- Badge: 12, medium

### Spacing Tokens

- `4`
- `8`
- `12`
- `16`
- `20`
- `24`
- `32`

### Radius Tokens

- Small: `12`
- Medium: `18`
- Large: `24`
- Pill: `999`

## Typography Hierarchy

Use Apple-like system typography in SwiftUI and mirror it in Figma.

- Display score: large, monospaced digit style when practical.
- Screen title: compact title size, not oversized marketing type.
- Section heading: semibold, small, easy to scan.
- Metric value: semibold with monospaced digits.
- Supporting copy: regular weight, high line-height, muted color.
- Watch text: shorter, bolder, and glanceable within a few seconds.

## Spacing Scale

Use a compact, consistent scale.

- `4`: micro gaps inside badges or small rows.
- `8`: compact row spacing.
- `12`: card inner rhythm.
- `16`: standard card padding and section gaps.
- `24`: large panel padding and screen group spacing.
- `32`: hero spacing.

## Corner Radius Scale

Keep radii restrained and consistent.

- `6`: tiny badges and pills.
- `8`: standard compact cards.
- `12`: larger dashboard panels.
- `16`: hero glass panel or score container.
- `24`: only for large, soft glass surfaces.

## Card Style

Cards should be dense but readable.

- Use subtle glass fill with a thin border.
- Do not nest decorative cards inside other cards.
- Keep text hierarchy clear: title, value, one short supporting line.
- Avoid ornamental backgrounds inside cards.
- Use icons only when they clarify scanning.

## Score Ring Style

The score ring is the primary visual anchor.

- Use a thin to medium circular stroke.
- Pair the ring with a clear numeric score and state label.
- Use glow only around the active score arc, at low opacity.
- Use score color semantically, not as decoration.
- Show lower confidence with subdued opacity or a confidence badge, not a harsh
  warning treatment.

## Glass / Panel Style

Glass panels should feel premium and calm.

- Use translucent dark fills with subtle borders.
- Background blur may be used if performance remains smooth.
- Keep glow low and localized to important data elements.
- Avoid broad decorative orbs, bokeh, or unrelated gradients.

## Glow Usage Rules

- Glow should reinforce focus or score state.
- One primary glow area per screen is enough.
- Do not use glow behind long text.
- Do not use glow to create urgency.
- Keep glow accessible against dark backgrounds.
- Phase 5.7 allows glow only on score rings, active progress, and tiny accents.
- Avoid heavy cyberpunk neon and medical-device alarm styling.

## Icon Style

- Prefer SF Symbols in SwiftUI.
- Use thin or regular weight symbols.
- Avoid filled, playful, or overly complex icons.
- Icons should support recognition, not replace necessary labels.

## State Color Rules

State colors should be supportive and non-alarming.

- Steady: mint or cyan.
- Mixed: amber with calm copy.
- Low: muted rose or amber-rose blend, used sparingly.
- Needs rest: subdued warm tone with gentle recommendation language.
- Missing data: neutral blue-gray, never red.

## Confidence Color Rules

- High: primary text or mint accent.
- Medium: muted cyan or blue-gray.
- Low: amber with calm copy.
- Unavailable: neutral gray-blue.

Missing data should lower confidence. It should not imply that the user is in a
negative wellness state.

## Light Mode Fallback

Light mode can be supported later, but dark mode is the design source of truth.
If light mode is added:

- Use soft off-white backgrounds.
- Preserve semantic state colors.
- Reduce glow and use shadow/border instead.
- Maintain contrast for score rings and small Watch text.

## Accessibility Notes

- Verify color contrast for all text and score labels.
- Do not rely on color alone for score or confidence.
- Keep dynamic type behavior in mind before SwiftUI implementation.
- Ensure Watch screens remain readable at small sizes.
- Keep tap targets aligned with Apple platform guidance.

## Forbidden Visual Styles

- Heavy cyberpunk treatment.
- Loud neon gradients across entire screens.
- Decorative bokeh or orb backgrounds.
- Medical-device styling or clinical alarm colors.
- Marketing landing-page hero composition.
- Dense analytics dashboards that hide the primary state.
- Red warning UI for missing data.

## TODO

- Convert these semantic choices into Figma variables.
- Review contrast in Figma before SwiftUI implementation.
- Validate score colors with low-data and unavailable states.
