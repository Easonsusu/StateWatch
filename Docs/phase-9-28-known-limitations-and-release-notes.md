# Phase 9.28 Known Limitations And Release Notes

## Purpose

This is known-limitations and release-notes guidance, not a TestFlight upload, App Store submission, or release-ready claim.

Phase 9.28 translates the current StateWatch / Watch Check-in MVP limitations
into clear internal release-note guidance, tester-facing caveats, App Review
Notes boundaries, and prohibited claim rules.

## Scope

In scope:

- Document known limitations for the current Watch Check-in MVP state.
- Define release-note wording that is safe for limited internal planning.
- Define wording that must not appear in release notes, App Review Notes, or
  user-facing copy.
- Carry forward unresolved hardware and HealthKit QA limitations from previous
  phases.
- Add a matching Phase 9.28 checklist to `TEST_PLAN.md`.

Out of scope:

- TestFlight upload.
- App Store Connect release work.
- App Store metadata, screenshots, bundle identifiers, signing, or
  provisioning changes.
- Swift implementation changes.
- Xcode project changes.
- Entitlement changes.
- CI workflow changes.
- Product behavior changes.
- iPhone Check-in UI, history, deletion, management, or scaffold cleanup.
- WidgetKit Check-in display, summary, or direct Check-in reads.
- App Group raw Check-in history, Check-in propagation, or display preference
  propagation.
- WatchConnectivity.
- State Score integration.
- HealthKit write access or write authorization.
- Networking, cloud sync, iCloud sync, analytics, AI cloud analysis, account
  systems, login, upload paths, or remote config.
- Latest-five history, clear-all UI, long-term history, notes, export,
  reminders, notifications, scheduling, trends, streaks, counts, causes,
  interpretations, pattern summaries, or insights.
- Phase 9.29 work.

## Current Baseline

- Phase 9.27 was merged through PR #74.
- Baseline commit at the start of this phase:
  `1198b827d4d793834cb1e86bc6d6b12ff42f8f9e`.
- Watch Check-in remains Watch-only and local-only.
- The approved states remain `Energized`, `Stable`, `Tired`, and `Low`.
- Traditional Chinese reference labels remain `有活力`, `穩定`, `疲累`, and
  `低狀態`.
- Display modes remain `Icon + Text`, `Icon Only`, and `Text Only`.
- Default display remains `Icon + Text`.
- Recent history remains latest-three.
- Single-record local deletion remains the only deletion behavior in the Watch
  MVP.
- Phase 9.22 remains deferred/blocked, not completed.
- Real-device Watch VoiceOver QA remains unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 validation was non-real-device validation only and does not replace real Apple Watch QA or real-device HealthKit QA.
- Internal TestFlight planning may continue only with explicit limitations.
- Broad external release-readiness, App Store approval, and App Store
  submission readiness are not claimed.

## Relationship To Phase 9.23 Through Phase 9.27

Phase 9.23 records release blockers and deferred blockers, including unresolved
real-device Watch VoiceOver QA, physical Apple Watch tap ergonomics, and real
Watch spoken cadence / focus order.

Phase 9.24 allows Watch Check-in MVP to proceed only to internal TestFlight
planning with explicit limitations. It blocks broad release-ready claims until
real-device Watch QA is completed or the limitations are explicit.

Phase 9.25 defines an internal TestFlight QA planning checklist. It is not a
TestFlight execution report and does not claim real-device QA was performed.

Phase 9.26 audits App Store, privacy, HealthKit, and medical-safety boundaries.
It does not submit to App Store Review and does not claim App Store approval or
external submission readiness.

Phase 9.27 records non-real-device validation only. It reports simulator
build/test results while preserving the unresolved real Apple Watch and
real-device HealthKit limitations.

## Explicit Limitations Carried Forward

- Phase 9.22 remains deferred/blocked, not completed.
- Real-device Watch Check-in VoiceOver QA remains unresolved.
- Physical Apple Watch small-screen tap ergonomics remain unresolved.
- Real Watch VoiceOver spoken cadence and focus order remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Broad Watch Check-in release-ready claims remain blocked.
- External App Store submission readiness is not claimed.
- Internal TestFlight planning may continue only with explicit limitations.
- Non-real-device validation does not replace real-device Watch QA or
  real-device HealthKit QA.

## Files Reviewed

The following requested references were present and reviewed or source-checked
at the guidance level:

- `Docs/phase-9-27-non-real-device-release-candidate-validation.md`
- `Docs/phase-9-26-app-store-privacy-medical-safety-final-audit.md`
- `Docs/phase-9-25-internal-testflight-qa-checklist.md`
- `Docs/phase-9-24-checkin-mvp-release-readiness-audit.md`
- `Docs/phase-9-23-release-blocker-register.md`
- `Docs/phase-9-21-watch-checkin-voiceover-qa-results.md`
- `Docs/phase-9-20-watch-checkin-real-device-voiceover-qa-plan.md`
- `Docs/phase-9-19-watch-checkin-final-ux-polish-qa.md`
- `Docs/phase-9-18-watch-checkin-final-ux-polish.md`
- `Docs/phase-9-17-watch-checkin-final-ux-polish-design.md`
- `Docs/phase-9-16-mvp-checkin-boundary-qa.md`
- `Docs/phase-9-15-mvp-checkin-boundary-decision.md`
- `Docs/phase-9-14-watch-checkin-recent-history-deletion-qa.md`
- `Docs/phase-9-13-watch-checkin-recent-history-deletion-foundation.md`
- `Docs/phase-9-10-watch-checkin-display-preference-qa.md`
- `Docs/phase-9-9-watch-checkin-display-preference.md`
- `Docs/phase-9-8-watch-checkin-local-storage-foundation-qa.md`
- `Docs/phase-9-7-watch-checkin-local-storage-foundation.md`
- `Docs/phase-8-9-real-device-healthkit-qa-plan.md`
- `Docs/phase-8-8-internal-test-mode-feature-flag-qa.md`
- `Docs/phase-8-7-production-wording-safety-qa.md`
- `Docs/phase-8-6-production-wording-audit.md`
- `TEST_PLAN.md`
- `PRD.md`
- `PRIVACY_POLICY_DRAFT.md`
- `APP_STORE_CHECKLIST.md`
- `Docs/medical-safety-wording.md`
- `Docs/ui-copy-guidelines.md`
- `README.md`
- `StateWatchApp/Models/StateCheckInOption.swift`
- `StateWatchWatchApp/Features/WatchCheckInView.swift`
- `StateWatchWatchApp/Features/WatchDashboardView.swift`
- `StateWatchWatchApp/Services/CheckIn/StateCheckInRecord.swift`
- `StateWatchWatchApp/Services/CheckIn/LocalStateCheckInStore.swift`
- `StateWatchWatchApp/Services/CheckIn/StateCheckInDisplayPreference.swift`
- `StateWatchTests/StateWatchThemeTests.swift`
- `StateWatchTests/StateCheckInStorageTests.swift`
- `StateWatch.xcodeproj/project.pbxproj`

No requested reference was found missing.

## Search Terms Used

Pre-change searches covered:

- Known limitation, limitations, release notes, release note, release
  candidate, release-ready, App Store, App Review, approval, TestFlight,
  TestFlight upload, real-device, real device, VoiceOver, HealthKit QA, and
  Phase 9.22 through Phase 9.28.
- Watch Check-in, State Check-in, check-in, latest-three, latest five,
  clear-all, Icon + Text, Icon Only, Text Only, Energized, Stable, Tired, Low,
  有活力, 穩定, 疲累, 低狀態, self-reported, local Watch, local-only,
  Watch-only, single-record, and delete.
- iPhone Check-in, WidgetKit Check-in, check-in display, check-in summary,
  App Group raw, App Group Check-in, WatchConnectivity, WCSession, State Score
  integration, HealthKit write, HKHealthStore.save, requestAuthorization(toShare,
  and toShare.
- URLSession, cloud, iCloud, analytics, remote config, AI cloud, account,
  login, sign in, upload path, developer database, sync, and network.
- Diagnosis, clinical, medical advice, treatment, therapy, emergency, warning,
  abnormal, health risk, anxiety, depression, disease, detected, caused by,
  because you, symptom history, medical record, score dropped, low because, bad
  health, doctor, physician, care provider, regulatory, FDA, and clearance.

Matches were reviewed as existing source, tests, guardrails, forbidden-copy
examples, release blocker language, safety disclaimers, limitation language, or
Phase documentation. No product behavior change was added in this phase.

## Limitation Labels

- Must disclose
- Internal-only limitation
- Deferred pending hardware
- Future release blocker
- Non-blocking follow-up
- Prohibited claim

## Known Limitations Summary Table

| ID | Limitation | Label | Current status | Safe wording | Prohibited wording | Required follow-up |
| --- | --- | --- | --- | --- | --- | --- |
| LIM-001 | Real-device Watch VoiceOver QA | Deferred pending hardware | Unresolved. Phase 9.21 and Phase 9.27 did not test a real Apple Watch. | "Real-device Watch VoiceOver remains pending." | "VoiceOver verified on real Apple Watch." | Execute Phase 9.20 / Phase 9.22 cases on a real paired Apple Watch. |
| LIM-002 | Physical Apple Watch tap ergonomics | Deferred pending hardware | Unresolved because physical hardware was unavailable. | "Physical tap ergonomics remain pending." | "Fully validated on Apple Watch." | Test on real Apple Watch hardware, ideally including the smallest practical screen. |
| LIM-003 | Real Watch VoiceOver spoken cadence and focus order | Deferred pending hardware | Source review cannot validate actual spoken cadence, pronunciation, focus order, or rotor behavior. | "VoiceOver spoken cadence and focus order still require real-device QA." | "Spoken output and focus order passed on hardware." | Listen to VoiceOver output on real Watch hardware and record results. |
| LIM-004 | Real-device HealthKit QA | Future release blocker | Planned through Phase 8.9 documentation, not executed. | "Real-device HealthKit QA remains pending." | "HealthKit QA complete on real devices." | Execute real-device HealthKit QA before production HealthKit rollout claims. |
| LIM-005 | Phase 9.27 simulator validation | Must disclose | iOS simulator build/test, Watch simulator build, and complications simulator build passed in the recorded environment. | "Simulator build/test validation passed for the recorded environment; this is non-real-device validation only." | "Release ready." | Keep non-real-device limitation visible in release materials. |
| LIM-006 | Internal TestFlight planning status | Internal-only limitation | Planning may continue only with explicit limitations. | "Internal build prepared for limited QA with known hardware-dependent limitations." | "Ready for external release." | Keep tester notes and internal release notes limitation-aware. |
| LIM-007 | Broad release-ready claim | Prohibited claim | Blocked until hardware-dependent limits are cleared or explicitly limited. | "Limited internal QA candidate with known limitations." | "Release ready." | Complete unresolved QA or keep broad claims out of release materials. |
| LIM-008 | App Store approval / external submission readiness | Prohibited claim | Not claimed. No App Store submission was performed. | "App Store submission readiness is not claimed." | "App Store ready." | Complete final submission-specific review before external submission. |
| LIM-009 | Watch Check-in MVP scope | Must disclose | Watch-only, local-only, latest-three recent history, single-record deletion only. | "Watch Check-in is available as a Watch-only, local-only MVP." | "Check-ins sync everywhere." | Keep scope explicit in internal and user-facing notes. |
| LIM-010 | iPhone Check-in | Must disclose | Not supported in current MVP; old scaffold is not a user-facing feature. | "iPhone Check-in is not included in this MVP." | "Manage Check-ins on iPhone." | Design separately before claiming iPhone support. |
| LIM-011 | WidgetKit Check-in | Must disclose | WidgetKit does not display Check-in data or directly read Check-ins. | "WidgetKit Check-in display is not included." | "Check-ins appear in complications." | Design and review separately before adding WidgetKit Check-in display. |
| LIM-012 | App Group Check-in history / propagation | Must disclose | No raw Check-in history or display preference propagation through App Group. | "Check-in history is not propagated through App Group." | "Check-ins sync through App Group." | Complete privacy-reviewed design before any propagation. |
| LIM-013 | WatchConnectivity | Must disclose | No WatchConnectivity or WCSession sync. | "WatchConnectivity sync is deferred." | "Syncs Check-ins to iPhone." | Design separately if cross-device sync is needed. |
| LIM-014 | State Score integration | Must disclose | Check-ins do not affect State Score, readiness, confidence, reasons, or suggestions. | "Check-ins are subjective and separate from State Score." | "Check-ins change your score." | Define and test a future integration before making any score claim. |
| LIM-015 | HealthKit write access | Must disclose | HealthKit remains read-only. | "HealthKit access remains read-only." | "Writes health data." | Keep write access out unless explicitly approved in a future phase. |
| LIM-016 | Cloud / network / AI / analytics / account | Must disclose | No account, cloud sync, AI cloud analysis, analytics, remote config, or upload path. | "StateWatch remains local-first for this MVP." | "Syncs to cloud" or "AI cloud analysis." | Keep local-first boundaries unless separately reviewed. |
| LIM-017 | Medical-safety framing | Must disclose | Non-medical wellness/readiness only. | "StateWatch does not diagnose, treat, cure, or prevent disease and does not provide medical advice." | "Detects health problems." | Review future copy against medical-safety guidance. |
| LIM-018 | `Low` Check-in | Must disclose | Subjective, non-medical, non-warning, and non-score-lowering. | "`Low` is a subjective self-report." | "Low means bad health." | Keep copy calm and optional. |
| LIM-019 | Missing Check-ins and missing HealthKit data | Must disclose | Missing data remains neutral, low-confidence, unavailable, or fallback where applicable. | "Not enough recent data is available." | "Missing data means a negative state." | Keep missing-data states neutral. |
| LIM-020 | Old iPhone `CheckInView` scaffold | Non-blocking follow-up | Existing scaffold is not part of current Watch MVP release notes. | "Not a user-facing release-note item." | "iPhone Check-in is available." | Revisit in a separate iPhone Check-in phase. |
| LIM-021 | `StateWatchThemeTests.swift` size | Non-blocking follow-up | Internal test refactor follow-up only. | "Internal test refactor follow-up." | "User-facing limitation." | Split in a later test refactor phase if needed. |

## Internal TestFlight Release-note Guidance

Internal release notes may say:

- "Internal build prepared for limited QA with known hardware-dependent limitations."
- "Simulator build/test validation passed for the recorded environment."
- "Watch Check-in is available as a Watch-only, local-only MVP."
- "Real-device Watch VoiceOver and physical ergonomics remain pending."
- "Real-device HealthKit QA remains pending."

Internal release notes must preserve limitations and must not convert simulator
or source-review validation into real-device pass claims.

## User-facing Release-note Guidance

Safe user-facing wording examples:

- "Adds a simple Watch-only daily state check-in."
- "Check-ins are stored locally on Apple Watch."
- "Recent check-ins show the latest three local entries."
- "Check-ins are subjective and do not provide medical advice."

User-facing release notes should stay short, calm, non-medical, and scoped to
features that actually exist in the current build.

## App Review Notes Limitation Guidance

Future App Review Notes should disclose any active limitation that affects
review:

- Watch Check-in is Watch-only and local-only.
- Check-ins are subjective and do not affect State Score.
- HealthKit access remains read-only.
- No HealthKit write, networking, cloud sync, analytics, account, AI cloud
  analysis, or upload path is included.
- Real-device Watch VoiceOver and physical tap ergonomics must not be claimed
  complete unless actually completed.
- Real-device HealthKit QA must not be claimed complete unless actually
  completed.

This phase does not edit App Store metadata or submit anything to App Review.

## Privacy / HealthKit Wording Guidance

Safe wording:

- "HealthKit access remains read-only."
- "HealthKit-derived production rollout remains guarded by feature flags and
  separate QA."
- "Health data stays local in the MVP."
- "No raw HealthKit upload or developer-accessible health database is
  introduced."

Avoid wording that implies upload, developer access, cloud analysis, ad
profiling, HealthKit write access, or real-device HealthKit QA completion.

## Medical-safety Wording Guidance

StateWatch wording must remain wellness/readiness-oriented. It must not imply
diagnosis, treatment, therapy, emergency response, abnormal-state detection,
clinical stress detection, disease detection, medical advice, or clinical
decision support.

Safe wording:

- "daily state"
- "readiness"
- "subjective check-in"
- "based on available on-device data"
- "not a medical device"
- "does not provide medical advice"

Avoid causal health claims. For example, prefer "On days with lower sleep, you
more often reported feeling tired" over "You feel tired because you slept
less."

## Watch Check-in MVP Limitation Language

Recommended limitation language:

- "Watch Check-in is currently a Watch-only, local-only MVP."
- "The MVP supports the four states `Energized`, `Stable`, `Tired`, and `Low`."
- "Recent history shows the latest three local entries."
- "Single-record local deletion is supported."
- "Check-ins do not affect State Score, readiness, confidence, reasons,
  suggestions, WidgetKit, App Group shared state, iPhone Dashboard state, or
  Watch score state."
- "`Low` is a subjective self-report, not a medical warning or score penalty."

## Prohibited Release-note Claims

Release notes must not claim broad release readiness, App Store approval, App Store submission readiness, real-device Watch VoiceOver pass, physical Apple Watch ergonomics pass, or real-device HealthKit QA completion.

Prohibited examples:

- "Release ready."
- "App Store ready."
- "Fully validated on Apple Watch."
- "VoiceOver verified on real Apple Watch."
- "HealthKit QA complete on real devices."
- "Detects health problems."
- "Warns you about abnormal state."
- "Diagnoses stress, anxiety, depression, or illness."
- "Low means bad health."
- "Check-ins change your score."
- "Syncs Check-ins to iPhone, widgets, or cloud."

## Acceptable Release-note Claims

Acceptable examples:

- "Adds a simple Watch-only daily state check-in."
- "Check-ins are stored locally on Apple Watch."
- "Recent check-ins show the latest three local entries."
- "Check-ins are subjective and do not provide medical advice."
- "Simulator build/test validation passed for the recorded environment."
- "Real-device Watch VoiceOver and physical ergonomics remain pending."
- "Real-device HealthKit QA remains pending."

## Claims That Require Future Hardware Validation

These claims require future real hardware validation before they can be made:

- Real-device Watch VoiceOver pass.
- Real Watch spoken cadence, pronunciation, focus order, and rotor behavior
  pass.
- Physical Apple Watch tap ergonomics pass.
- Smallest-screen physical Watch usability pass.
- Real-device HealthKit permission and sample-flow QA pass.
- Broad release-ready claim for Watch Check-in.

## Work That May Continue

- Internal TestFlight distribution readiness checklist planning.
- Internal release-note drafting with explicit limitations.
- App Review Notes drafting with limitation language.
- Documentation-only QA planning.
- Separate future issue planning for real-device Watch QA and real-device
  HealthKit QA.
- Separate future design planning for iPhone Check-in, WidgetKit Check-in, App
  Group propagation, WatchConnectivity, or State Score integration.

## Work That Must Wait

- Broad release-ready claims.
- App Store approval or external submission readiness claims.
- TestFlight upload unless explicitly requested in a separate phase.
- App Store Connect release work.
- Real-device Watch VoiceOver pass claims.
- Physical Watch ergonomics pass claims.
- Real-device HealthKit QA completion claims.
- Production Check-in propagation to iPhone, WidgetKit, App Group, or
  WatchConnectivity.
- Check-in integration into State Score.

## Non-blocking Follow-ups

- Split `StateWatchThemeTests.swift` in a later test refactor phase.
- Revisit the old iPhone `CheckInView` scaffold in a separate iPhone Check-in
  design or cleanup phase.
- Continue refining release-note and App Review language as future QA results
  arrive.

## Risks / Limitations

- This phase is documentation-only and does not execute TestFlight or real
  hardware QA.
- It does not clear Phase 9.22.
- It does not prove real-device Watch accessibility, tap ergonomics, or
  HealthKit behavior.
- It does not update App Store Connect or App Store metadata.
- Future implementation phases must re-check these limitations before making
  release claims.

## Recommended Next Phase

Phase 9.29: Internal TestFlight Distribution Readiness Checklist.

Phase 9.29 should:

- Use this Phase 9.28 known limitations and release-note guidance as input.
- Prepare a checklist for whether an internal TestFlight distribution may be
  prepared with explicit limitations.
- Keep real-device Watch VoiceOver QA and real-device HealthKit QA unresolved
  unless actually run.
- Avoid uploading to TestFlight unless explicitly requested in a separate
  phase.
- Avoid broad release-ready language unless limitations are explicit.
- Remain documentation-only unless a separate implementation issue is
  explicitly opened.

## Changes Made

- Added this Phase 9.28 known limitations and release-notes guidance document.
- Added a matching Phase 9.28 checklist to `TEST_PLAN.md`.
- No Swift files, Xcode project files, entitlement files, CI workflows, App
  Store metadata, TestFlight uploads, or product behavior were changed.

## Final Phase 9.28 Checklist

- Phase 9.28 known limitations and release-notes document exists.
- The document is guidance only, not TestFlight upload or App Store submission.
- Phase 9.23 through Phase 9.27 were used as input.
- Explicit limitations are carried forward.
- Phase 9.22 remains deferred/blocked, not completed.
- Real-device Watch Check-in VoiceOver QA remains unresolved.
- Physical Apple Watch tap ergonomics remain unresolved.
- Real Watch VoiceOver spoken cadence and focus order remain unresolved.
- Real-device HealthKit QA remains planned, not executed.
- Phase 9.27 validation is described as non-real-device validation only.
- Non-real-device validation is not treated as real-device QA.
- Known limitations summary table is documented.
- Internal TestFlight release-note guidance is documented.
- User-facing release-note guidance is documented.
- App Review Notes limitation guidance is documented.
- Privacy / HealthKit wording guidance is documented.
- Medical-safety wording guidance is documented.
- Watch Check-in MVP limitation language is documented.
- Safe example wording is documented.
- Prohibited wording is documented.
- Claims requiring future hardware validation are documented.
- Work that may continue is documented.
- Work that must wait is documented.
- Non-blocking follow-ups are documented.
- No broad release-ready claim is made.
- No App Store approval or external submission-readiness claim is made.
- No TestFlight upload was performed.
- No App Store Connect release work was performed.
- No real-device QA result was fabricated.
- HealthKit remains read-only.
- No HealthKit write access or write authorization was added.
- No raw HealthKit upload or developer-accessible health database is
  introduced.
- No diagnosis, treatment, therapy, emergency, abnormal-state, warning,
  disease-detection, clinical-stress, or medical-advice claim is made.
- `Low` remains subjective, non-medical, non-warning, and non-score-lowering.
- Missing Check-ins and missing HealthKit data remain neutral.
- Check-ins do not affect State Score.
- No Swift files changed.
- No Xcode project files changed.
- No entitlements changed.
- No CI workflows changed.
- No product behavior changed.
- Watch Check-in remains Watch-only.
- Watch Check-in remains local-only.
- Four states remain `Energized`, `Stable`, `Tired`, and `Low`.
- Traditional Chinese reference labels remain `有活力`, `穩定`, `疲累`, and
  `低狀態`.
- Display modes remain `Icon + Text`, `Icon Only`, and `Text Only`.
- Default display remains `Icon + Text`.
- Latest-three recent history remains unchanged.
- No latest-five history added.
- No clear-all UI added.
- No long-term history added.
- No notes, export, reminders, notifications, trends, streaks, counts, causes,
  interpretations, pattern summaries, or insights added.
- No iPhone Check-in UI, history, deletion, or management added.
- Old iPhone `CheckInView` scaffold was not addressed.
- No WidgetKit Check-in display, summary, or direct read added.
- No App Group raw Check-in history, Check-in propagation, or display
  preference propagation added.
- No WatchConnectivity added.
- No State Score integration added.
- No networking, cloud sync, iCloud sync, analytics, AI, account system, login,
  upload path, or remote config added.
- Recommended next phase is Phase 9.29: Internal TestFlight Distribution
  Readiness Checklist.
- Local validation commands are expected for this docs-only phase.
- GitHub Actions should be reviewed after PR creation without manually
  rerunning Actions as a debugging loop.
- No Phase 9.29 work started.
