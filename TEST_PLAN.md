# Test Plan

## Current scope

StateWatch now includes a runnable iOS app target, watchOS app target, and XCTest target. The current test focus is the mock dashboard, read-only HealthKit permission flow, local-only HealthKit data fetch foundation, rule-based baseline/scoring engine, and debug-only HealthKit scoring preview.

## Foundation checks

- Confirm required root docs exist.
- Confirm required `Docs/` files exist.
- Confirm iOS and watchOS placeholder files exist.
- Confirm all previews and tests use mock data.
- Confirm no file claims medical diagnosis or disease detection.
- Confirm HealthKit data upload is not introduced.

## Automated Scoring Tests

- Baseline calculation handles empty, sparse, and normal mock histories.
- Baseline calculation ignores nil metric values.
- Baseline calculation requires enough valid samples before exposing a metric average.
- Baseline calculation supports 7-day, 14-day, and 30-day windows.
- Sparse baseline history produces low or unavailable confidence.
- Recovery scoring responds conservatively to HRV below baseline.
- Recovery scoring responds conservatively to resting heart rate above baseline.
- Sleep scoring reflects duration below baseline and recent sleep trend.
- Missing sleep data returns a cautious placeholder and unavailable confidence.
- Overall state combines recovery, sleep, stress/fatigue context, and activity load with the MVP weights.
- Scores are clamped between 0 and 100.
- Low-data history produces lower-confidence StateAssessment output.
- Suggestion generation avoids medical advice and uses cautious language.
- HealthKit aggregation keeps missing data optional and never treats missing samples as a negative signal.

## Future Automated Tests

- Add fixture histories for low activity, high activity, strong sleep consistency, and mixed signal days.
- Add UI snapshot or preview checks once the dashboard consumes scored mock histories.

## Automated Debug Preview Tests

- Preview reports are not created from empty HealthKit history.
- All-nil snapshot histories show the empty-data state.
- Unavailable HealthKit environments show an unavailable state without loading samples.
- Preview reports include snapshot count, latest date, available metric count, baseline confidence, and assessment output.
- Sparse history shows lower-confidence preview guidance.
- Partial latest snapshots show a missing-data notice.

## GitHub Actions CI

- Pull requests and pushes to `main` run `.github/workflows/ios-watchos-ci.yml`.
- CI checks diff whitespace, builds the `StateWatch` iOS scheme, runs the `StateWatch` XCTest suite, and builds the `StateWatchWatchApp` watchOS scheme.
- CI disables code signing and compiler index storage for build/test verification.
- Local/manual testing is still required for HealthKit permission UI behavior and any real Apple Health data scenarios.

## Design and UI QA

- Verify dark mode readability across dashboard, settings, Watch, and debug preview surfaces.
- Verify score ring legibility at iPhone and Apple Watch sizes.
- Verify component cards have clear hierarchy for title, value, confidence, and summary text.
- Verify low-data states are calm, non-alarming, and do not treat missing data as a negative wellness signal.
- Verify the Watch app is glanceable within a few seconds.
- Verify complication layouts do not overflow in accessory circular, rectangular, inline, or corner families.
- Verify text remains readable on small Apple Watch screens.
- Verify no medical, diagnosis, disease detection, clinical stress detection, or alarming wording appears in UI.
- Verify Figma design specs are reviewed before SwiftUI implementation begins.

## Figma Phase 5.7 Review

- Verify the Figma file `StateWatch UI Design System` contains `[Phase 5.7]` frames on `01 Design Tokens`, `02 iPhone Dashboard`, `03 Watch App`, `04 Watch Complications`, `05 Components`, and `06 Handoff Notes`.
- Verify all Phase 5.7 layers are editable and not flattened screenshots.
- Verify the token board includes final color, score-state, confidence-state, typography, spacing, radius, and effect specs.
- Verify iPhone dashboard frames cover normal, low data, loading, HealthKit unavailable, permission-needed, and debug-preview entry states.
- Verify Watch frames are glanceable within a few seconds and avoid tiny paragraphs.
- Verify complication variants do not overflow in normal, low confidence, stale data, or unavailable states.
- Verify low-data and unavailable wording is calm and non-alarming.
- Verify no medical, diagnosis, disease detection, clinical stress detection, warning, or health-risk wording appears in mockups.
- Verify Phase 5.8 SwiftUI work starts from Figma tokens and components rather than generic UI invention.

## SwiftUI Design System Foundation

- Verify design system components render in SwiftUI previews.
- Verify the score ring remains legible in dark mode across steady, mixed, cautious, and no-data examples.
- Verify glass cards do not overpower text or create heavy neon effects.
- Verify confidence badge wording is calm, especially `Low data`.
- Verify metric cards have a clear hierarchy for title, value, subtitle, and optional progress.
- Verify the mini trend chart handles empty data without crashing or implying a negative wellness state.
- Verify components do not introduce medical, diagnosis, disease detection, clinical stress detection, or alarming wording.
- Verify production `DashboardView` still behaves as before and remains mock-backed.
- Verify the Watch app still behaves as before and is not changed by the iOS design-system foundation.

## Debug Visual Preview Dashboard

- Run the `StateWatch` scheme on an iPhone simulator.
- Open Dashboard -> Settings.
- Under Developer Preview, open Visual Dashboard Preview.
- Confirm the preview uses the new technology-style design system components.
- Confirm Normal, Low Data, and Unavailable preview states are available.
- Confirm production `DashboardView` is unchanged and remains mock-backed.
- Confirm HealthKit Scoring Preview still opens from the same Developer Preview section.
- Confirm Visual Dashboard Preview does not request HealthKit permission.
- Confirm Visual Dashboard Preview does not fetch real HealthKit data.
- Confirm low-data and unavailable copy is calm and non-medical.
- Confirm dark mode readability, score ring legibility, and glass-card hierarchy.

## Phase 5.10 QA Audit

- Confirm GitHub Actions CI passes before merge.
- Confirm production `DashboardView` remains mock-backed.
- Confirm Settings -> Developer Preview -> HealthKit Scoring Preview opens.
- Confirm Settings -> Developer Preview -> Visual Dashboard Preview opens.
- Confirm Visual Dashboard Preview has Normal, Low Data, and Unavailable states.
- Confirm Visual Dashboard Preview does not request HealthKit permissions.
- Confirm Visual Dashboard Preview does not fetch real HealthKit data.
- Confirm Watch app still builds.
- Confirm no HealthKit write permission is requested.
- Confirm no networking or upload path exists.
- Confirm no medical or alarming UI wording exists.
- Confirm dark mode readability manually in Xcode previews or simulator when available.

## Manual QA for MVP

- First launch shows disclaimer before HealthKit permission request.
- HealthKit permission copy explains local-only use.
- Dashboard remains usable if permission is denied.
- Mock previews render without real HealthKit data.
- Settings privacy view clearly states data handling.
- Watch placeholders display mock score without needing HealthKit on watch.

## Manual HealthKit Data Fetch Checks

- Run the `StateWatch` scheme on an iPhone simulator or device that can access Apple Health data.
- Open Dashboard -> Settings -> Apple Health -> Health Permissions.
- Tap Request Read Access and grant read access for heart rate, resting heart rate, HRV, sleep, steps, active energy, and workouts.
- Confirm the app remains usable if some data categories are missing or denied.
- Confirm the mock dashboard still appears; Phase 3 does not replace dashboard scoring with fetched data.
- In Xcode or a temporary debug harness, instantiate `HealthKitDataFetcher` and call `fetchRecentSnapshots(days: 30)`.
- Confirm returned snapshots are local day-start dates using the current calendar/time zone.
- Confirm available HealthKit samples populate optional snapshot fields and unavailable metrics remain `nil`.
- Confirm no HealthKit write prompt appears.
- Confirm no network calls or upload paths are introduced.

## Manual Scoring Checks

- Run the `StateWatch` scheme on an iPhone simulator and confirm the dashboard still shows the mock wellness assessment.
- Run the `StateWatchWatchApp` scheme on an Apple Watch simulator and confirm the watch dashboard still shows mock assessment data.
- Confirm no production dashboard path has been switched to live HealthKit data.
- Run the XCTest target and confirm baseline/scoring tests pass.
- Review score explanations for cautious wellness wording.
- Confirm sparse or missing mock history produces lower confidence language instead of negative health conclusions.
- Confirm no score text claims to detect illness, disease, a medical condition, or clinical stress.

## Manual HealthKit Scoring Preview Checks

- Run the `StateWatch` scheme on an iPhone simulator or device.
- Open Dashboard -> Settings.
- Open Developer Preview -> HealthKit Scoring Preview.
- Tap Load HealthKit Preview.
- Confirm the screen handles unavailable Apple Health access without crashing.
- Confirm no recent Apple Health samples show: "No recent Apple Health samples were available. The main dashboard can continue using mock data."
- Confirm sparse data can show: "There is not enough recent data to produce a confident preview yet."
- Confirm loaded data shows snapshot count, latest snapshot date, available metrics count, baseline confidence, component scores, component confidence, reasons, and suggestions.
- Confirm the production dashboard remains mock-backed after returning from the preview.
- Confirm no HealthKit write prompt appears.
- Confirm no network calls or upload paths are introduced.
