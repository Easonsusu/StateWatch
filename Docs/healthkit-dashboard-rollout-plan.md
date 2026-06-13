# HealthKit Dashboard Rollout Plan

Phase 8.0 defines the safe rollout path for connecting the production iPhone Dashboard to local HealthKit-derived scoring behind a feature flag. Phase 8.1 audits and strengthens that plan before implementation begins. These phases are planning and QA only. They do not change app behavior, data sources, HealthKit behavior, Watch behavior, WidgetKit behavior, entitlements, or UI implementation.

## Current State

StateWatch currently has a complete mock-backed production surface chain:

- iPhone Dashboard is the production UI and remains backed by mock `StateAssessment` data.
- The iPhone app publishes the current mock dashboard summary into App Group shared state.
- The Watch app can read the shared mock App Group summary and falls back to static mock Watch values.
- WidgetKit complications can read the shared mock App Group summary and fall back to static mock complication values.
- HealthKit permission handling, local HealthKit fetching, baseline calculation, and rule-based scoring already exist.
- HealthKit-derived scoring is available only in debug or preview paths, including the HealthKit Scoring Preview.
- App Group shared state is currently mock-only.
- No production iPhone, Watch, or WidgetKit surface is connected to real HealthKit-derived scoring.

## Future Data Flow

The intended HealthKit-backed dashboard flow is local-only and iPhone-led:

```text
Read-only HealthKit data
  -> HealthKit data fetcher
  -> baseline and scoring engine
  -> HealthKit-derived StateAssessment
  -> feature-flagged iPhone Dashboard
  -> optional App Group shared summary
  -> WidgetKit and Watch only after additional QA
```

Rules for this flow:

- The iPhone app should remain the only place that reads HealthKit samples.
- WidgetKit should never fetch HealthKit samples directly.
- The Watch app should not be connected directly to HealthKit for this rollout.
- The App Group should carry only a compact summary, not raw HealthKit samples.
- HealthKit-derived summary sharing to WidgetKit and Watch should wait until the iPhone rollout is stable.

## Feature Flag Strategy

The production Dashboard must stay mock-backed by default until the HealthKit-backed path is explicitly enabled for internal testing.

Feature flag requirements:

- Default state: mock dashboard.
- Initial HealthKit-backed state: explicit internal or debug local-only feature flag.
- The flag must be local-only. Do not use remote config, networking, login, cloud sync, subscriptions, or AI.
- The flag must be safe to disable instantly.
- The app must fall back to the mock dashboard, a setup-needed state, or a low-data state when HealthKit is unavailable, denied, empty, partial, or too sparse to score confidently.
- The flag should not change Watch or WidgetKit behavior in the first implementation phase.

Suggested early flag names:

- `useHealthKitDashboardPreview`
- `enableLocalHealthKitDashboard`

The exact implementation should be decided in Phase 8.2. This document is not an implementation decision.

## Rollout Phases

### Phase 8.0: Planning Only

Document the intended rollout, privacy boundaries, fallback behavior, wording rules, and deferred work. No production behavior changes.

### Phase 8.1: QA Audit for Rollout Plan

Review the rollout plan for safety, privacy, wording, testability, and implementation risk before adding a feature flag.

### Phase 8.2: Internal Feature Flag Foundation

Add a local-only feature flag surface for internal testing. The flag should default off and must not fetch HealthKit data unless explicitly enabled in a debug or internal path.

### Phase 8.3: Feature-Flagged HealthKit-Backed iPhone Dashboard

Connect the iPhone Dashboard to local HealthKit-derived `StateAssessment` only when the local feature flag is enabled. Keep mock fallback behavior available.

### Phase 8.4: HealthKit Dashboard QA Audit

Audit build stability, simulator behavior, unavailable HealthKit behavior, denied permissions, empty data, partial data, sparse scoring, and user-facing copy.

### Phase 8.5: Low-Data and Missing-Data Safety Audit

Stress test nil-heavy histories, no sleep data, no HRV, no recent workouts, stale summaries, and partial authorization. Missing data should lower confidence or show low-data states, not create negative wellness conclusions.

### Phase 8.6: Production Wording and App Store Safety Audit

Review all production-facing copy, Info.plist privacy descriptions, onboarding, settings, App Store checklist, and privacy policy draft before broader release readiness work.

### Later: Shared Production Summary Propagation

Only after the iPhone HealthKit-backed dashboard is stable, evaluate whether to publish a compact HealthKit-derived summary to App Group shared state for WidgetKit and Watch. WidgetKit and Watch should continue using safe mock or fallback behavior until that phase is explicitly approved.

## Rollout Gate Checklist

Phase 8.3 implementation should not begin until these gates are true:

- Phase 8.2 internal feature flag foundation is complete.
- Feature flag default is off.
- Debug or internal-only control path exists.
- The control path is local-only and does not depend on remote config, login, cloud sync, networking, subscriptions, or AI.
- HealthKit read-only permissions are confirmed.
- No HealthKit write permission is requested.
- HealthKit authorization missing, denied, unavailable, empty, partial, and revoked states have defined user-facing behavior.
- Scoring fallback behavior is defined for unavailable, sparse, nil-heavy, stale, and cannot-score histories.
- Low-data and unavailable copy has been reviewed for calm wellness wording.
- Missing data is documented to lower confidence or show a low-data state, not create a negative health status.
- No production Watch or WidgetKit HealthKit propagation is included in Phase 8.3.
- WidgetKit and Watch are documented as summary readers for later phases, not direct HealthKit fetchers.
- App Group storage is limited to compact summary data.
- Raw HealthKit samples are explicitly excluded from App Group storage.
- Local-only privacy promise remains accurate in README, privacy docs, onboarding, and settings copy.

## Risk Register

| Risk | Mitigation |
| --- | --- |
| HealthKit authorization is denied, revoked, or incomplete. | Keep the dashboard mock-backed by default, show setup-needed or unavailable state behind the feature flag, and avoid blocking app launch. |
| Sleep, HRV, or resting heart rate data is incomplete. | Treat metrics as optional, lower confidence, and avoid negative conclusions from missing values. |
| Weak data produces a misleading score. | Require confidence display, low-data copy, and fallback behavior before Phase 8.3 ships. |
| HealthKit samples are stale. | Show last-updated context, avoid implying live monitoring, and fall back when freshness rules fail. |
| User misunderstands score as diagnosis. | Use wellness wording, show confidence, and avoid diagnosis, disease, clinical stress, treatment, warning, emergency, or alert language. |
| WidgetKit displays outdated state. | Keep WidgetKit on mock/shared fallback until later QA and require stale-state handling before production summary propagation. |
| Watch shows inconsistent state compared with iPhone. | Keep Watch mock-backed/shared-mock-backed until iPhone HealthKit rollout is stable, then define freshness and source labels before propagation. |
| Privacy concerns around health data. | Keep HealthKit processing local-only, avoid developer access, avoid uploads, and store only compact summaries in App Group. |
| App Store review questions wellness claims or privacy copy. | Review wording, Info.plist strings, onboarding, privacy policy, and App Store checklist before broader release readiness. |

## Privacy Audit

The HealthKit-backed Dashboard rollout must preserve this privacy promise:

- Health data stays on device.
- No account is required for MVP HealthKit processing.
- No cloud health database is introduced.
- Developers do not have access to user HealthKit data.
- Health data is not uploaded, sold, used for advertising, profiling, marketing, or data mining.
- No AI cloud health profiling is introduced.
- App Group storage contains only compact summary data.
- Raw HealthKit samples stay out of App Group storage.
- WidgetKit and Watch should receive only summary-level data in later phases, and only after the iPhone rollout is stable.

## Language and Wording Audit

Approved wording should stay calm, contextual, and wellness-oriented. Examples:

- "state"
- "readiness"
- "confidence"
- "low data"
- "not enough data"
- "recent signals"
- "wellness estimate"
- "生活管理參考"
- "非醫療用途"

Forbidden wording and claims:

- diagnosis
- detect disease
- detect illness
- clinical stress
- treatment
- warning
- emergency
- alert
- abnormal health alert
- medical recommendation
- mental health diagnosis
- health risk prediction
- monitoring for disease

Review rule: if a phrase sounds like the app is detecting a condition, predicting medical risk, providing treatment guidance, or escalating an emergency, it should be removed or rewritten as cautious wellness context.

## Visual and Figma Gate

Future UI-facing HealthKit Dashboard work must use the existing Figma design system as source of truth before SwiftUI implementation when it affects:

- Dashboard layout.
- State imagery.
- Visual-first UI.
- Icon assets.
- Check-in UI.
- Complication layout.
- Bilingual UI.
- Traditional Chinese and English copy layout.

Phase 8.1 does not implement visual UI, icon assets, check-in UI, bilingual UI, localization files, or WidgetKit layout changes. It only documents the gate for later design-driven implementation.

## State Check-In and Personalization Safety Note

Future State Check-in and personal pattern analysis should remain local-only. User self-report should be treated as subjective feedback, not a medical signal.

Safe labels remain:

| English | Traditional Chinese |
| --- | --- |
| Energized | 有活力 |
| Stable | 穩定 |
| Tired | 疲累 |
| Low | 低狀態 |

Safety requirements:

- Do not diagnose mood, stress, anxiety, depression, disease, or illness.
- Start with local statistics and personal baseline comparisons.
- Do not require cloud AI.
- Do not use self-report data for advertising, profiling, marketing, or data mining.
- Use self-report only to help the user understand patterns in their own local wellness context.

## Safety Rules

The rollout must preserve these boundaries:

- No HealthKit write access.
- No networking.
- No cloud upload.
- No AI feature or cloud AI processing.
- No developer access to user health data.
- No remote config, login, cloud sync, or server-side flag dependency for the first HealthKit Dashboard flag.
- No WatchConnectivity in this rollout.
- WidgetKit must not fetch HealthKit samples directly.
- Watch app must not be connected directly to HealthKit in this rollout.
- No medical diagnosis wording.
- No disease, illness, clinical stress, treatment, emergency, or health alert claims.
- No scary language for missing or partial data.
- Missing data should lower confidence or show a low-data state, not produce negative health conclusions.
- The production iPhone Dashboard remains mock-backed by default until the feature flag is explicitly enabled.
- The feature flag must be easy to disable without data migration or backend changes.

## Low-Data and Fallback Behavior

Expected state handling:

- Missing authorization: show setup-needed or permission-needed guidance.
- HealthKit unavailable: show unavailable messaging and keep mock or safe fallback behavior.
- Empty HealthKit results: show calm low-data copy.
- Partial data: compute only from available optional values and lower confidence.
- Sparse history: avoid confident scoring and show a cautious estimate if possible.
- Cannot score: fall back to mock, low-data, or unavailable state depending on the feature flag stage.
- Stale App Group summary: WidgetKit and Watch should use safe fallback behavior until a later production sharing phase.

Safe copy examples:

- "Recent data is limited, so this estimate is cautious."
- "Apple Health data is unavailable right now."
- "StateWatch can keep showing demo data until local Health data is available."
- "Consider a lighter day if that matches how you feel."

Avoid wording that implies diagnosis, monitoring, detection, warning, emergency handling, or medical advice.

## Privacy Positioning

StateWatch should remain local-first for the MVP:

- Health data stays on device.
- No account is required for MVP HealthKit processing.
- No cloud health database is introduced.
- Developers should not have access to user health data.
- Health data should not be uploaded, sold, used for advertising, profiling, marketing, or data mining.
- No AI cloud health profiling is included.
- App Group shared state should contain only a compact summary, not raw HealthKit samples.
- The HealthKit-backed Dashboard should be understandable and useful without exposing raw personal health data outside the device.

## Future State Check-In and Personalization Roadmap

A future State Check-in feature may let users add local self-report context. This is not part of Phase 8.0 and should not be implemented in this PR.

Potential check-in schedule:

- Morning.
- Midday.
- Evening.

Safe state labels:

| English | Traditional Chinese |
| --- | --- |
| Energized | 有活力 |
| Stable | 穩定 |
| Tired | 疲累 |
| Low | 低狀態 |

Personalization boundaries:

- Prefer local-only personal pattern analysis.
- Use on-device statistics first.
- Consider optional future on-device ML only after the rule-based MVP is stable.
- Do not require cloud AI.
- Do not use mental-health diagnosis wording.
- Do not imply the app can detect clinical conditions from self-report data.

## Future Visual-First UI and Localization Roadmap

Future UI work should reduce excessive text and make state, confidence, reasons, and suggestions easier to scan.

Future design directions:

- Visual-first UI with clear hierarchy and fewer paragraphs.
- State Check-in can support icon-only, text-only, and icon plus text modes.
- Traditional Chinese and English support should be planned together.
- UI strings should eventually move to localization keys.
- Future icons, state imagery, check-in layout, complication layout, and bilingual UI should use the existing Figma design system as the source of truth first.

Phase 8.0 does not implement visual UI, icon assets, localization files, SwiftUI changes, or WidgetKit layout changes.

## Implementation Risk Notes

Risks to address before Phase 8.3:

- HealthKit authorization may be denied, partial, revoked, or unavailable.
- Simulators often lack representative Apple Health data.
- Sparse data can make scores look more certain than they are if confidence is not displayed clearly.
- Production copy must distinguish demo data, low data, and local HealthKit-derived estimates.
- App Group shared state can be stale or unavailable.
- WidgetKit timelines should not become the first production HealthKit surface.
- The Watch app should not imply live HealthKit-backed state before the iPhone dashboard rollout is stable.

## Acceptance Criteria for Future Implementation

Before enabling a HealthKit-backed production Dashboard beyond internal testing:

- Feature flag defaults off.
- Mock fallback remains available.
- Permission denied, unavailable, empty, partial, and sparse data states are tested.
- Low confidence is visible and calm.
- No production surface requests HealthKit write access.
- No networking or upload path is introduced.
- No WidgetKit or Watch direct HealthKit fetching is introduced.
- No medical diagnosis, disease, clinical stress, treatment, emergency, or alert claims are introduced.
- Real-device QA is documented.
- App Store privacy and onboarding copy are reviewed.
