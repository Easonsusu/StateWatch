# Phase 9.3 Watch Check-in Mock UI

Phase 9.3 adds a mock-only Apple Watch State Check-in screen. The screen lets
the user choose one subjective state and then shows a local confirmation state.

This phase does not add storage, reminders, notifications, WidgetKit check-in
display, App Group propagation, WatchConnectivity, HealthKit write access,
networking, cloud sync, analytics, remote config, or AI. It also does not change
the iPhone Dashboard, Watch score behavior, WidgetKit complications, or
HealthKit rollout behavior.

## Implemented UI

- Watch Dashboard includes a `Check in` tab.
- The check-in screen uses a vertical list for larger Apple Watch tap targets.
- The approved options are `Energized`, `Stable`, `Tired`, and `Low`.
- Traditional Chinese reference labels remain documented in the shared UI model:
  `有活力`, `穩定`, `疲累`, and `低狀態`.
- Tapping an option shows a local confirmation state with `Saved`,
  `Check-in saved`, and `You can update it later.`
- The `Done` button returns to the selection state.

## Data Behavior

- Selection state is held in Watch SwiftUI `@State` only.
- The selected state is not persisted.
- The selected state is not shared to the iPhone app.
- The selected state is not written to HealthKit.
- The selected state does not affect readiness score, state label, confidence,
  WidgetKit complications, App Group shared summary, or Watch Dashboard metrics.

## Safety Boundaries

- Check-in options are subjective self-report labels only.
- Missing check-ins are optional and do not lower confidence or score.
- Copy avoids medical, diagnostic, clinical, warning, emergency, treatment, or
  cause-and-effect claims.
- The screen does not imply StateWatch detected the user's state.

## Validation Focus

- Verify the Watch app still launches to the existing mock-backed dashboard.
- Verify the `Check in` tab appears on Apple Watch.
- Verify each of the four options can be tapped.
- Verify confirmation appears and `Done` returns to the option list.
- Verify no persistence or cross-device propagation is introduced.
- Verify iPhone Dashboard, Watch score pages, and WidgetKit complications remain
  mock-backed and unchanged.
