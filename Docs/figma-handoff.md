# Figma Handoff

StateWatch future UI work should be based on Figma design specs rather than
generic generated UI. Codex should inspect the Figma design system and screen
specs before making SwiftUI UI changes when those specs exist.

## Figma File

Required file name:

- `StateWatch UI Design System`

Current Figma setup status:

- A Figma design file was created through the connected Figma MCP.
- File URL: https://www.figma.com/design/5Fwk817dLos6IGQJ1w8dJw
- The file contains the required page structure and editable Phase 5.7
  high-fidelity frames.
- Phase 5.7 high-fidelity frame details are specified in
  `Docs/figma-phase-5-7-mockups.md`.
- Figma access was restored after the previous Codex attempt, and the canvas
  has been updated across all required pages.

If the file is unavailable in another environment, recreate it manually with
the pages and frame lists below. Figma setup requires manual creation or a
connected Figma MCP/connector. This repository now contains the required Figma
page structure, frame list, and design token plan.

## Required Pages

- `00 References`
- `01 Design Tokens`
- `02 iPhone Dashboard`
- `03 Watch App`
- `04 Watch Complications`
- `05 Components`
- `06 Handoff Notes`

## Phase 5.7 High-Fidelity Mockup Status

Target file:

- Name: `StateWatch UI Design System`
- URL: https://www.figma.com/design/5Fwk817dLos6IGQJ1w8dJw

Status:

- Required page structure exists from Phase 5.6.
- Editable Phase 5.7 high-fidelity frames are present in the Figma canvas.
- Updated pages: `00 References`, `01 Design Tokens`, `02 iPhone Dashboard`,
  `03 Watch App`, `04 Watch Complications`, `05 Components`, and
  `06 Handoff Notes`.
- High-fidelity Phase 5.7 frame specifications remain documented in
  `Docs/figma-phase-5-7-mockups.md`.
- Phase 5.8 SwiftUI implementation should inspect the actual Figma frames
  before changing SwiftUI.

Phase 5.7 frame groups present or to verify in Figma:

- `[Phase 5.7] Design Tokens / High Fidelity`
- `[Phase 5.7] Main Dashboard / Normal State`
- `[Phase 5.7] Low Data State`
- `[Phase 5.7] Loading State`
- `[Phase 5.7] HealthKit Unavailable State`
- `[Phase 5.7] Permission Needed State`
- `[Phase 5.7] Debug Preview Entry State`
- `[Phase 5.7] Overall Score Screen`
- `[Phase 5.7] Component Summary Screen`
- `[Phase 5.7] Suggestion Screen`
- `[Phase 5.7] Confidence / Last Updated Screen`
- `[Phase 5.7] accessoryCircular`
- `[Phase 5.7] accessoryRectangular`
- `[Phase 5.7] accessoryInline`
- `[Phase 5.7] accessoryCorner`
- `[Phase 5.7] Score Ring`
- `[Phase 5.7] Metric Card`
- `[Phase 5.7] Glass Card`
- `[Phase 5.7] State Pill`
- `[Phase 5.7] Confidence Badge`
- `[Phase 5.7] Reason Row`
- `[Phase 5.7] Suggestion Card`
- `[Phase 5.7] Mini Trend Chart`
- `[Phase 5.7] Watch Score Module`
- `[Phase 5.7] Complication Score Module`
- `[Phase 5.7] SwiftUI Handoff`

## 00 References

Create placeholders for:

- Apple iOS / iPadOS UI Kit
- Apple watchOS UI Kit
- Apple WidgetKit / watch complication references
- StateWatch visual references
- Dark-mode dashboard references

Manual imports should come from official Apple design resources where possible.
Do not commit Apple templates or Figma exports into the repository unless the
license allows it.

## 01 Design Tokens

Create token sections for:

- Colors
- Typography
- Spacing
- Corner radius
- Shadows / glow
- Glass panels
- Score states
- Confidence states

Each token should include a semantic name, intended use, dark-mode value,
light-mode fallback if known, accessibility notes, and SwiftUI mapping notes.

## 02 iPhone Dashboard Frames

Required frame placeholders:

- Main Dashboard / normal state
- Low data state
- HealthKit unavailable state
- Loading state
- Permission needed state
- Debug preview entry state

## 03 Watch App Frames

Required frame placeholders:

- Overall score screen
- Component summary screen
- Suggestion screen
- Confidence / last updated screen

## 04 Watch Complications Frames

Required frame placeholders:

- `accessoryCircular`
- `accessoryRectangular`
- `accessoryInline`
- `accessoryCorner`

## 05 Components

Required component placeholders:

- Score ring
- Metric card
- Glass card
- State pill
- Confidence badge
- Reason row
- Suggestion card
- Mini trend chart
- Watch score ring
- Complication score module

## Design Token Checklist

- Define dark-mode semantic colors first.
- Define state colors for steady, mixed, low, needs rest, missing data, stale
  data, and unavailable HealthKit.
- Define confidence colors for high, medium, low, and unavailable.
- Define typography styles for iPhone, Watch, and complications.
- Define spacing and radius values that map cleanly to SwiftUI constants.
- Define shadow and glow styles with restrained opacity.
- Define glass panel fills and borders.
- Validate contrast before implementation.

## Apple References To Import Manually

- Apple iOS and iPadOS UI Kit for Figma.
- Apple watchOS UI Kit for Figma.
- Apple Human Interface Guidelines for Health, widgets, typography, SF Symbols,
  and accessibility.
- WidgetKit and watch complication documentation.

## Handoff Rules For Codex And SwiftUI

- Check this document and the Figma file before SwiftUI UI changes.
- Do not invent a generic UI if Figma specs exist.
- Use Figma layout, colors, typography, spacing, and component structure as the
  source of truth.
- For Phase 5.8, inspect the Phase 5.7 Figma frames before coding.
- Keep HealthKit data local-only in UI copy and interaction notes.
- Preserve cautious wellness wording.
- Do not add SwiftUI implementation until the design phase is approved.
- Do not add assets, WidgetKit targets, or Xcode project changes in this docs
  planning phase.

## Credentials

Do not add Figma API tokens, personal access tokens, or connector credentials to
the repository. If future automation needs authentication, document the setup
steps outside committed source files or use the connected MCP/connector.
