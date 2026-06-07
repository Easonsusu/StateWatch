# Open-Source Maintenance Backlog

This fallback backlog was created because GitHub CLI issue creation was unavailable in the local environment. `gh auth status` failed with `command not found: gh`.

Before creating these issues manually or through an authenticated GitHub tool, check the open issue list and skip any duplicate or substantially similar issue.

## 1. Prepare v0.1.0 release checklist

Labels: `release`, `documentation`

Create a release checklist for the first public StateWatch MVP. Include README review, changelog review, privacy review, test plan, CI status, manual QA, screenshots using mock data, and known limitations.

## 2. Add real-device HealthKit QA report

Labels: `qa`, `healthkit`, `privacy`

Document manual QA results from a real iPhone / Apple Watch environment. Verify permission flow, missing data behavior, read-only HealthKit access, local-only data handling, and no HealthKit write prompt.

## 3. Feature-flag HealthKit-backed production dashboard

Labels: `enhancement`, `healthkit`, `safety`

Plan and implement a feature flag for switching the production dashboard from mock StateAssessment data to local HealthKit-derived StateAssessment output after debug preview validation.

## 4. Add local persistence for snapshots and baselines

Labels: `enhancement`, `privacy`, `architecture`

Design local-only persistence for DailyHealthSnapshot history and HealthBaseline values. The implementation must avoid server sync, advertising, profiling, or HealthKit data upload.

## 5. Finalize privacy policy for MVP

Labels: `privacy`, `documentation`

Review and finalize the MVP privacy policy. It should clearly explain local-only HealthKit processing, no advertising use, no data mining, no profiling, no server upload, and user control over Apple Health permissions.

## 6. Add onboarding disclaimer and HealthKit permission flow polish

Labels: `ux`, `healthkit`, `safety`

Improve first-launch onboarding so users see non-medical wellness wording before any HealthKit permission request. The copy must avoid diagnosis, disease detection, clinical stress detection, or medical advice.

## 7. Add issue and pull request templates

Labels: `maintenance`, `documentation`

Add GitHub issue templates and a pull request template. Include sections for summary, testing, HealthKit privacy impact, medical-safety wording review, screenshots if UI changed, and release note impact.

## 8. Add dependency and security review checklist

Labels: `security`, `maintenance`

Create a lightweight security review checklist for future dependencies and privacy-sensitive changes. Include HealthKit data boundaries, networking checks, local storage checks, and medical wording risks.

## 9. Expand scoring test fixtures

Labels: `test`, `scoring`

Add more scoring fixtures for low activity, high activity, sleep consistency, sparse data, missing HRV, missing sleep, and mixed-signal days. Confirm missing data lowers confidence rather than creating negative wellness conclusions.

## 10. Plan watchOS data sync and complication strategy

Labels: `watchos`, `architecture`, `privacy`

Plan how watchOS views and future complications should receive local state. Evaluate whether WatchConnectivity, App Groups, or WidgetKit are appropriate while preserving local-only privacy boundaries.
