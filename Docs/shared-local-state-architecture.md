# Shared Local State Architecture

Phase 6.6 defined how StateWatch should eventually share local wellness summary state across the iPhone app, watchOS app, and WidgetKit complications.

Phase 6.8 adds a mock-only App Group shared state foundation for WidgetKit complications. It does not enable WatchConnectivity, live HealthKit-backed timelines, production HealthKit-backed dashboards, or raw HealthKit sample sharing.

Phase 7.0 connects the production iPhone mock dashboard summary to that shared state. The publisher still writes mock summary data only and does not use HealthKit-derived scoring.

## Current State

StateWatch currently has three production-facing surfaces:

- iPhone Dashboard: visually refreshed and mock-backed.
- Watch app: visually refreshed and mock-backed.
- WidgetKit complications: implemented as a dedicated extension that can read a mock shared readiness summary and falls back to static mock data.

HealthKit permission handling, local HealthKit fetching, baseline calculation, and rule-based scoring already exist. HealthKit-derived scoring remains limited to debug-only preview flows until a later gated rollout.

## Goals

The future shared state layer should:

- Let the iPhone app publish a small local readiness summary for WidgetKit and companion surfaces.
- Keep HealthKit data local-only.
- Store summary data only, not raw Apple Health samples.
- Make unavailable, stale, partial, and low-confidence states explicit.
- Preserve mock and demo fallbacks for development, previews, and tests.
- Keep UI copy calm, wellness-oriented, and confidence-aware.

## Phase 6.6 Non-Goals

The original architecture phase did not:

- Add an App Group entitlement.
- Add WatchConnectivity.
- Add local persistence.
- Add live WidgetKit timelines.
- Wire production dashboards or complications to HealthKit-derived scoring.
- Add networking, server sync, upload paths, AI features, login, subscriptions, or HealthKit write access.
- Add medical or alarming product claims.

## Phase 6.8 Mock Foundation

The current mock foundation adds:

- App Group entitlement `group.com.easonsusu.StateWatch` for iOS, watchOS, and WidgetKit complication targets.
- A compact mock readiness summary model.
- A `UserDefaults(suiteName:)` store keyed by `statewatch.shared.readiness.summary.v1`.
- iOS app seeding for a static mock summary, later refined in Phase 7.0 to publish the current mock dashboard summary.
- WidgetKit complication fallback behavior when shared data is missing, unavailable, stale, or cannot be decoded.

The mock foundation still does not:

- Store raw Apple Health samples.
- Store HealthKit-derived production scoring output.
- Fetch HealthKit data from WidgetKit.
- Add WatchConnectivity.
- Add networking, upload paths, AI features, or HealthKit write access.
- Replace the mock-backed iPhone Dashboard or Watch app data source.

## Proposed Shared Summary

The future shared state should store only a compact summary.

Suggested model shape:

```swift
struct SharedReadinessState: Codable, Equatable {
    var schemaVersion: Int
    var generatedAt: Date
    var source: SharedReadinessSource
    var overallScore: Int?
    var stateLabel: String
    var confidence: SharedReadinessConfidence
    var updatedText: String
    var componentSummaries: [SharedReadinessComponent]
    var primaryReason: String?
    var suggestion: String?
    var staleAfter: Date
    var privacyMode: SharedReadinessPrivacyMode
}

struct SharedReadinessComponent: Codable, Equatable {
    var id: String
    var title: String
    var valueText: String
    var confidence: SharedReadinessConfidence
}

enum SharedReadinessSource: String, Codable {
    case mock
    case debugPreview
    case localHealthKitDerived
}

enum SharedReadinessConfidence: String, Codable {
    case high
    case medium
    case low
    case unavailable
}

enum SharedReadinessPrivacyMode: String, Codable {
    case summaryOnly
}
```

Rules:

- `overallScore` may be `nil` when data is unavailable.
- `source` must be explicit so production surfaces do not imply live HealthKit data by accident.
- `privacyMode` should remain `summaryOnly`.
- `generatedAt` and `staleAfter` are required so widgets can show stale or demo states clearly.

## Storage Boundary

Phase 6.8 uses an App Group container so the iPhone app and WidgetKit extension can share a mock readiness summary. Production HealthKit-derived summary sharing remains deferred.

Proposed future file:

```text
group.<bundle>.statewatch/shared-readiness-state.json
```

Allowed contents:

- Compact score summary.
- Confidence label.
- State label.
- Component summaries.
- Short reason and suggestion text.
- Generated-at and stale-after timestamps.
- Source marker such as `mock` or `localHealthKitDerived`.

Disallowed contents:

- Raw Apple Health samples.
- Per-sample heart rate, HRV, sleep, step, workout, or energy records.
- User identifiers.
- Device identifiers.
- Network endpoints or tokens.
- Any data intended for advertising, marketing, profiling, or data mining.

## Data Flow Plan

### Phase 6.8 mock-only shared state

1. iPhone app writes a mock `SharedReadinessState` to local shared storage.
2. WidgetKit extension reads that mock summary.
3. Complications render the summary or a calm fallback.
4. Watch app remains mock-backed unless a later phase explicitly changes it.

### Phase 7.0 iPhone mock dashboard publishing

1. iPhone app maps `StateAssessment.mock` into `SharedReadinessSummary`.
2. iPhone app writes that mock dashboard summary to App Group `UserDefaults`.
3. WidgetKit extension reads the iPhone-published mock summary when available.
4. WidgetKit keeps the static mock fallback for missing, stale, unavailable, or corrupted shared state.
5. Watch app remains mock-backed.

### Later HealthKit-derived rollout

1. iPhone app requests read-only HealthKit access.
2. iPhone app fetches local HealthKit samples.
3. iPhone app computes baseline and scoring locally.
4. iPhone app writes only the compact summary to shared state.
5. WidgetKit reads only the summary.
6. WidgetKit never fetches HealthKit directly.

## Freshness and Fallback Rules

Suggested states:

- Fresh: `Date() <= staleAfter` and confidence is not unavailable.
- Stale: `Date() > staleAfter`.
- Low data: confidence is low.
- Unavailable: score is nil or confidence is unavailable.
- Mock or demo: source is mock.

Fallback copy examples:

- Mock: `Demo data`.
- Low data: `Limited recent data`.
- Stale: `Update pending`.
- Unavailable: `No recent estimate`.

Avoid alarming wording. Missing data should reduce confidence or show a fallback, not create a negative wellness conclusion.

## WidgetKit Rules

WidgetKit complications should:

- Read compact mock summary state from the App Group foundation.
- Fall back to static mock or unavailable content when no shared state exists.
- Never request HealthKit permissions.
- Never fetch HealthKit samples.
- Never upload data.
- Keep copy short and glanceable.
- Support accessory circular, rectangular, inline, and corner families when practical.

## Watch App Rules

The Watch app should remain mock-backed until a later explicit phase. If shared state is introduced for Watch later, it should:

- Prefer summary-only data.
- Avoid raw Apple Health samples.
- Display low-data and stale states calmly.
- Avoid implying live monitoring.

## Privacy Guardrails

Shared state must preserve existing StateWatch rules:

- HealthKit data stays local-only.
- HealthKit write access remains absent.
- Missing or partial data lowers confidence instead of producing negative wellness conclusions.
- No networking, upload path, AI feature, profiling, marketing, advertising, or data-mining use.
- StateWatch remains a wellness tool and must not be framed as a clinical product.

## Open Questions Before Production Rollout

- Whether WidgetKit should refresh on a fixed schedule or only when the app writes state.
- Whether Watch app should read shared state in the same phase as WidgetKit.
- How long summaries should remain fresh before showing a stale state.
- Whether a user-facing reset or debug control is needed for shared state.

## Recommended Next Phase

Phase 7.1 should audit iPhone mock dashboard shared-state publishing before any production HealthKit-derived shared-state rollout.
