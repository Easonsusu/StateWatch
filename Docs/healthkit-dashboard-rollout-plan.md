# HealthKit Dashboard Rollout Plan

Phase 8.0 defines the safe rollout path for connecting the production iPhone Dashboard to local HealthKit-derived scoring behind a feature flag. Phase 8.1 audits and strengthens that plan before implementation begins. Phase 8.2 adds the local default-off feature flag foundation. Phase 8.3 adds the feature-flagged iPhone Dashboard loading path while preserving the mock-backed default behavior.

## Current State

StateWatch currently has a complete mock-backed production surface chain:

- iPhone Dashboard is the production UI and remains backed by mock `StateAssessment` data by default.
- The iPhone app publishes the current mock dashboard summary into App Group shared state.
- The Watch app can read the shared mock App Group summary and falls back to static mock Watch values.
- WidgetKit complications can read the shared mock App Group summary and fall back to static mock complication values.
- HealthKit permission handling, local HealthKit fetching, baseline calculation, and rule-based scoring already exist.
- HealthKit-derived scoring is available in debug/previews and in the iPhone Dashboard only when the local default-off feature flag is enabled.
- App Group shared state is currently mock-only.
- No Watch or WidgetKit surface is connected to real HealthKit-derived scoring, and no HealthKit-derived output is written to App Group shared state.

## Future Data Flow

The intended HealthKit-backed dashboard flow is local-only and iPhone-led:

```text
Read-only HealthKit data
  -> HealthKit data fetcher
  -> baseline and scoring engine
  -> HealthKit-derived StateAssessment
  -> feature-flagged iPhone Dashboard
  -> App Group summary propagation only in a later phase
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

Phase 8.2 chose `HealthKitDashboardFeatureFlag` with the local storage key `statewatch.feature.healthkitDashboard.enabled`. Phase 8.3 uses that default-off flag to gate the iPhone Dashboard HealthKit-backed path.

## Rollout Phases

### Phase 8.0: Planning Only

Document the intended rollout, privacy boundaries, fallback behavior, wording rules, and deferred work. No production behavior changes.

### Phase 8.1: QA Audit for Rollout Plan

Review the rollout plan for safety, privacy, wording, testability, and implementation risk before adding a feature flag.

### Phase 8.2: Internal Feature Flag Foundation

Add a local-only feature flag surface for internal testing. The flag defaults off, uses stable local storage, can be reset locally, and does not fetch HealthKit data. Production Dashboard behavior remains mock-backed in this phase; actual HealthKit-backed Dashboard implementation is deferred to Phase 8.3. The flag foundation must not add remote config, networking, AI, WidgetKit HealthKit propagation, Watch HealthKit propagation, or HealthKit write access.

### Phase 8.3: Feature-Flagged HealthKit-Backed iPhone Dashboard

Implemented: the iPhone Dashboard loads through a small provider that returns mock `StateAssessment` while the local flag is off. When the flag is enabled, it attempts local HealthKit snapshot loading and rule-based scoring, then falls back to mock data for unavailable, empty, sparse, low-confidence, or failed loads. The default user experience remains mock-backed.

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

## Phase 8.2 Foundation Status

Phase 8.2 adds only the local feature flag foundation:

- `HealthKitDashboardFeatureFlag` stores a local boolean value.
- Storage key: `statewatch.feature.healthkitDashboard.enabled`.
- Default state is off.
- The flag can be enabled, disabled, or reset locally.
- Production iPhone Dashboard remains mock-backed.
- HealthKit-backed Dashboard implementation remains deferred to Phase 8.3.
- No remote config, networking, cloud sync, account requirement, analytics rollout, or AI is introduced.
- No WidgetKit or Watch HealthKit propagation is introduced.

## Phase 8.3 Implementation Status

Phase 8.3 adds the feature-flagged iPhone Dashboard HealthKit path:

- `DashboardAssessmentProvider` keeps the default-off path mock-backed.
- When the local flag is enabled, the provider attempts to fetch recent local HealthKit snapshots and build a `StateAssessment` with the existing rule-based scoring engine.
- Empty HealthKit data, unavailable data, sparse histories, low-confidence output, and loading failures fall back to mock `StateAssessment` data.
- The iPhone Dashboard does not publish HealthKit-derived summaries into App Group shared state in this phase.
- The Watch app remains mock/shared-mock-backed.
- WidgetKit complications remain mock/shared-mock-backed with static fallback.
- Raw HealthKit samples remain out of App Group storage.
- No WatchConnectivity, networking, AI, remote config, HealthKit write access, or live WidgetKit HealthKit timelines are added.

## Phase 8.4 QA Audit Scope

Phase 8.4 audits the Phase 8.3 path without adding new product behavior:

- The feature flag remains local-only and default-off.
- The default iPhone Dashboard remains mock-backed.
- The HealthKit-backed path runs only when the local flag is enabled.
- HealthKit unavailable, unauthorized, empty, sparse, low-confidence, and failed loading states must stay calm and safe.
- Missing data must not be treated as a negative wellness signal.
- HealthKit-derived Dashboard output must not be written to App Group shared state in this phase.
- Watch, WidgetKit, and App Group HealthKit propagation remain deferred.
- Raw HealthKit samples must not enter App Group shared state.
- Local Xcode simulator validation should be used for the QA loop; GitHub Actions should not be manually triggered for debugging.

## Phase 8.5 Low-Data Safety Audit Scope

Phase 8.5 narrows the audit to low-data and missing-data safety:

- Missing HealthKit authorization must not crash the Dashboard provider.
- HealthKit unavailable or denied states must fall back safely.
- Empty sleep, HRV, resting heart rate, and activity/load inputs must not be treated as negative health status.
- Sparse or partial data should lower confidence or fall back safely, not produce overconfident recommendations.
- Stale data should not produce strong current-state claims.
- Scoring failure or impossible inputs must not crash and any produced score must remain display-safe.
- Watch, WidgetKit, and App Group HealthKit propagation remain deferred.
- HealthKit-derived Dashboard output must not be written into App Group shared state in this phase.
- Raw HealthKit samples must not enter App Group shared state.

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
- The production iPhone Dashboard remains mock-backed by default until the feature flag is explicitly enabled for internal validation.
- The feature flag must be easy to disable without data migration or backend changes.

## Low-Data and Fallback Behavior

Expected state handling:

- Missing authorization: show setup-needed or permission-needed guidance.
- HealthKit unavailable: show unavailable messaging and keep mock or safe fallback behavior.
- Empty HealthKit results: show calm low-data copy.
- Partial data: compute only from available optional values and lower confidence.
- Sparse history: avoid confident scoring and show a cautious estimate if possible.
- Cannot score: fall back to mock data in Phase 8.3, with low-data or unavailable state design deferred to later QA.
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
