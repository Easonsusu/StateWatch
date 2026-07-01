# Phase 9.15 MVP Check-in Boundary Decision

## Purpose

Phase 9.15 makes a formal MVP boundary decision for State Check-in before any
broader iPhone, WidgetKit, App Group, WatchConnectivity, or scoring integration
work begins.

The decision keeps State Check-in narrow, optional, subjective, local-only, and
non-medical for the first MVP release.

## Scope

This phase is design and documentation only.

It decides:

- Whether iPhone read-only check-in display belongs in MVP.
- Whether WidgetKit check-in summary belongs in MVP.
- Whether App Group should carry check-in data in MVP.
- Whether WatchConnectivity should be introduced in MVP.
- Whether check-ins should connect to State Score in MVP.
- What must be deferred until after MVP.
- What gates are required before any future cross-surface check-in feature.

This phase does not implement product behavior.

## Decision Summary

For MVP, State Check-in remains Watch-only and local-only.

The Watch app may keep the current narrow check-in entry, latest-three recent
history, and Watch-local single-record deletion foundation. No iPhone,
WidgetKit, App Group, WatchConnectivity, or State Score rollout is included in
the MVP boundary.

## MVP Decision

MVP includes only:

- Watch Check-in entry.
- Watch-local storage.
- Watch-only latest-three recent history.
- Watch-local single-record deletion.
- Subjective labels: `Energized`, `Stable`, `Tired`, and `Low`.
- Calm copy that treats check-ins as optional personal context.

MVP does not include cross-device check-in visibility, shared check-in state, or
score effects.

## Non-MVP Deferred Items

The following are deferred until after MVP:

- iPhone read-only check-in history.
- iPhone check-in entry.
- iPhone check-in deletion or management.
- WidgetKit check-in display.
- WidgetKit check-in summary.
- App Group raw check-in history.
- App Group check-in propagation.
- WatchConnectivity sync.
- State Score integration.
- Check-in-derived trends, streaks, counts, summaries, causes,
  interpretations, or pattern analysis.
- Notes.
- Export.
- Reminders, notifications, scheduling, or background delivery.
- Cloud sync or iCloud sync.
- Account systems.
- AI analysis or AI cloud analysis.
- Analytics.
- Remote config.

## iPhone Read-only Display Decision

Do not add iPhone read-only check-in history for MVP.

Rationale:

- iPhone display would require cross-device data movement.
- Cross-device data movement needs an explicit transport and consistency model.
- Possible transport choices such as WatchConnectivity, App Group summaries, or
  another local sync path need separate design and QA.
- The current Watch-only implementation is enough for MVP validation.
- Adding iPhone visibility now would increase privacy, deletion, and App Store
  review complexity without being necessary for the first release.

A future iPhone display must be designed as a separate phase.

## WidgetKit Check-in Summary Decision

Do not add WidgetKit check-in display, summary, timeline data, or direct
check-in reads for MVP.

Rationale:

- Complications are glanceable surfaces with little room for nuance.
- Check-ins are subjective and could be misunderstood if reduced to a tiny
  badge or state.
- WidgetKit should not read raw check-in records.
- Any future WidgetKit check-in idea must first define a compact,
  privacy-reviewed summary and fallback behavior.

For MVP, WidgetKit remains focused on the existing readiness summary behavior
and does not expose check-in history or selections.

## App Group Check-in Data Decision

Do not store raw check-in history, deletion state, display preference, notes, or
check-in-derived summaries in App Group storage for MVP.

Rationale:

- App Group storage is shared across targets and should stay compact and
  summary-oriented.
- Raw check-in history is more sensitive than the existing mock readiness
  summary.
- Deletion and consistency behavior would become more complex if check-ins were
  copied across containers.
- The current Watch-local JSON file keeps ownership and deletion clear.

Any future App Group check-in data must use a reviewed compact summary only,
never raw history, and must define deletion and stale-data behavior first.

## WatchConnectivity Decision

Do not add WatchConnectivity for MVP.

Rationale:

- WatchConnectivity introduces delivery timing, retry, conflict, and consistency
  questions.
- A cross-device check-in feature needs explicit user expectations around what
  appears where and when.
- Deletion across devices requires a dedicated model to avoid stale or
  surprising state.
- MVP can validate the Watch-only local check-in flow without sync.

Any future WatchConnectivity feature must be scoped in its own design and QA
phase before implementation.

## State Score Relationship Decision

Do not connect check-ins to State Score for MVP.

Check-ins remain optional subjective reflection. They do not affect:

- Overall State Score.
- Recovery score.
- Sleep score.
- Fatigue context score.
- Activity load score.
- Confidence.
- Reasons.
- Suggestions.
- HealthKit-derived assessment output.
- iPhone Dashboard state.
- Watch score state.
- WidgetKit complications.
- App Group readiness summary.

Rationale:

- State Score should remain based on available on-device wellness signals and
  rule-based readiness logic.
- Subjective check-ins can be valuable context, but using them in scoring would
  need a separate scoring design and safety QA.
- Missing check-ins must remain neutral.
- `Low` check-ins must remain subjective, non-medical, non-warning, and
  non-score-lowering.

## Clear-all / Notes / Export / Reminders Decision

Do not add clear-all UI, notes, export, reminders, notifications, scheduling,
or background delivery for MVP.

Rationale:

- Clear-all UI needs a separate destructive-action copy and privacy review.
- Notes and export increase privacy scope and review complexity.
- Reminders and notifications can create pressure to complete check-ins, which
  is not needed for the MVP.
- Trend, count, streak, cause, interpretation, or pattern summaries could imply
  more certainty than the MVP should claim.

## Privacy Rationale

The MVP privacy boundary is easiest to explain and review when check-ins stay
on the Watch surface where they are entered.

This decision preserves:

- Local-only check-in storage.
- No developer-accessible check-in database.
- No cloud check-in database.
- No account requirement.
- No raw check-in history in App Group.
- No check-in sync through WatchConnectivity.
- No networking or upload path.
- No analytics, remote config, or AI cloud profiling.
- No HealthKit write access.

## App Store Safety Rationale

State Check-in must remain a subjective wellness reflection feature, not a
medical, mental-health, diagnostic, treatment, emergency, or warning feature.

The MVP boundary avoids:

- Symptom-history framing.
- Medical-record framing.
- Clinical stress claims.
- Anxiety or depression detection claims.
- Disease or illness detection claims.
- Causal claims such as "you feel low because..."
- Score-causality claims such as "your score dropped because..."

Allowed framing stays close to:

- `Check-ins are optional.`
- `This is your self-reported state.`
- `Check-ins can add context later.`

## Product Simplicity Rationale

The Watch is the most direct surface for quick check-in entry. Keeping the MVP
there avoids building extra management surfaces before the user value is proven.

The first MVP should validate:

- Whether users understand the four subjective labels.
- Whether Watch entry is fast enough.
- Whether latest-three recent history is useful.
- Whether local single-record deletion is enough for correction.

Cross-surface features can be considered after those basics are validated.

## User Experience Rationale

Keeping check-ins Watch-only reduces the chance that users read the feature as a
long-term record, health archive, or diagnostic log.

The MVP experience should feel lightweight:

- Enter a subjective state.
- See the latest few local entries.
- Delete one local entry if needed.
- Leave scores and readiness explanations independent.

## Future Gating Requirements

Before any future iPhone, WidgetKit, App Group, WatchConnectivity, or scoring
check-in feature, require:

- Dedicated design phase.
- Dedicated privacy review.
- Dedicated deletion model.
- Dedicated data consistency model.
- Dedicated QA phase.
- Explicit App Store privacy copy update if needed.
- No raw history in WidgetKit.
- No raw history in App Group.
- No State Score impact unless a separate scoring design and safety QA approves
  it.
- Clear stale, missing, corrupted, and unavailable-data fallback behavior.
- Cautious copy review for non-medical, non-causal, low-anxiety wording.

## Files Reviewed

- `Docs/phase-9-0-state-checkin-architecture.md`
- `Docs/phase-9-1-state-checkin-architecture-qa.md`
- `Docs/phase-9-5-state-checkin-local-storage-design.md`
- `Docs/phase-9-6-state-checkin-local-storage-design-qa.md`
- `Docs/phase-9-7-watch-checkin-local-storage-foundation.md`
- `Docs/phase-9-8-watch-checkin-local-storage-foundation-qa.md`
- `Docs/phase-9-11-watch-checkin-history-management-design.md`
- `Docs/phase-9-12-watch-checkin-history-management-design-qa.md`
- `Docs/phase-9-13-watch-checkin-recent-history-deletion-foundation.md`
- `Docs/phase-9-14-watch-checkin-recent-history-deletion-qa.md`
- `TEST_PLAN.md`
- `PRD.md`
- `PRIVACY_POLICY_DRAFT.md`
- `APP_STORE_CHECKLIST.md`
- `Docs/medical-safety-wording.md`
- `Docs/ui-copy-guidelines.md`
- `StateWatchApp/Models/StateCheckInOption.swift`
- `StateWatchWatchApp/Features/WatchCheckInView.swift`
- `StateWatchWatchApp/Services/CheckIn/StateCheckInRecord.swift`
- `StateWatchWatchApp/Services/CheckIn/LocalStateCheckInStore.swift`
- `StateWatchWatchApp/Services/CheckIn/StateCheckInDisplayPreference.swift`
- `StateWatchComplications`
- `StateWatchShared`
- `StateWatch.xcodeproj/project.pbxproj`

## Search Terms Used

Broad Phase 9 boundary search:

```text
Phase 9|State Check-in|check-in|history|recent|delete|clear all|clearAll|iPhone|Dashboard|WidgetKit|Complication|App Group|WatchConnectivity|WCSession|State Score|score|confidence|HealthKit|UserDefaults|suiteName|SharedReadinessStore|ComplicationStateSummary|sync|cloud|iCloud|AI|analytics|account|login|remote config|export|notes|reminder|notification|trend|streak|count|pattern|summary|interpretation|cause
```

Focused check-in boundary search:

```text
iPhone check-in|read-only|read only|history display|Watch-only|Watch only|WidgetKit check-in|App Group raw|WatchConnectivity|State Score integration|check-ins do not affect|missing check-ins|Low check-ins|local-only|on-device
```

Focused forbidden implementation search:

```text
WCSession|WatchConnectivity|WidgetKit|TimelineProvider|App Group|group\.|UserDefaults\(suiteName|SharedReadinessStore|ComplicationStateSummary|URLSession|HKHealthStore\.save|requestAuthorization\(toShare|toShare|analytics|remote config|iCloud|cloud sync|AI cloud|account|login|sign in
```

Focused safety wording search:

```text
diagnos|clinical|medical advice|treatment|therapy|emergency|warning|abnormal|health risk|anxiety|depression|detected|caused by|because you|symptom|illness|disease|bad health|risk|medical record|symptom history|score dropped|low because
```

Search results were expected matches in existing Phase 9 docs, test guardrails,
read-only HealthKit references, mock WidgetKit/App Group shared-state code, and
medical-safety disclaimers. The review found no need for Swift, Xcode project,
entitlement, or CI workflow changes.

## Risks Considered

| Risk | MVP decision |
| --- | --- |
| iPhone read-only history expands privacy and sync scope. | Defer until a separate design and QA phase. |
| WidgetKit check-in display loses nuance. | Defer and forbid direct raw-history reads. |
| App Group stores raw user-entered history. | Do not store raw check-in history in App Group for MVP. |
| WatchConnectivity introduces stale or inconsistent state. | Defer until a separate consistency and deletion model exists. |
| Check-ins become score inputs too early. | Keep State Score independent for MVP. |
| Missing check-ins look like non-compliance. | Keep missing check-ins neutral and optional. |
| `Low` check-ins look like warnings. | Keep `Low` subjective, muted, non-medical, and non-score-lowering. |

## Changes Made

- Added this Phase 9.15 MVP boundary decision document.
- Added Phase 9.15 checklist coverage to `TEST_PLAN.md`.

No production Swift files, Xcode project files, entitlements, CI workflows, or
product behavior were changed.

## Final Phase 9.15 Checklist

- MVP Check-in remains Watch-only.
- MVP Check-in remains local-only.
- No iPhone read-only check-in history is added.
- No iPhone check-in entry is added.
- No iPhone check-in deletion is added.
- No WidgetKit check-in display, summary, timeline data, or direct read is
  added.
- No App Group raw check-in history or propagation is added.
- No WatchConnectivity is added.
- No State Score integration is added.
- No clear-all UI, notes, export, reminders, notifications, scheduling, trends,
  streaks, counts, causes, interpretations, or pattern summaries are added.
- No HealthKit write access is added.
- No networking, cloud sync, iCloud sync, analytics, AI, account system, login,
  upload path, or remote config is added.
- Missing check-ins remain neutral.
- `Low` check-ins remain subjective, non-medical, non-warning, and
  non-score-lowering.
- Future cross-surface check-in features require separate design, privacy,
  deletion, consistency, and QA phases.
- Phase 9.16 was not started.
