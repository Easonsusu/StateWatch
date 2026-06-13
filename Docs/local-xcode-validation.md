# Local Xcode Validation

StateWatch uses local Xcode simulator validation as the primary development loop. GitHub Actions remains available for final pull request confidence, pushes to `main`, and manually triggered checks, but it should not be used as the normal debugging loop.

## Why Local First

- macOS GitHub Actions minutes are limited and should be reserved for final verification.
- Simulator build failures are faster to inspect locally in Xcode or with `xcodebuild`.
- HealthKit permission behavior, Watch app behavior, and complication presentation still need manual local or real-device review.

## Required Local Setup

- Full Xcode installed at `/Applications/Xcode.app`.
- Xcode selected with `xcode-select`.
- At least one available iPhone simulator.
- At least one available Apple Watch simulator.
- A local repository checkout. A Google Drive-synced checkout is acceptable, but do not commit machine-specific paths.

Check the toolchain:

```sh
xcode-select -p
xcodebuild -version
xcrun simctl list devices available
xcodebuild -project StateWatch.xcodeproj -list
```

## Recommended Simulator Destinations

Use concrete simulator destinations for local testing so failures are reproducible. Pick names from `xcrun simctl list devices available`.

Examples:

- iPhone: `platform=iOS Simulator,name=iPhone 17 Pro`
- Apple Watch: `platform=watchOS Simulator,name=Apple Watch Series 11 (46mm)`

If those names are not installed on another machine, replace them with an available iPhone or Apple Watch simulator name.

## Local Validation Commands

Run these from the repository root before asking GitHub Actions to spend macOS minutes.

### Diff Hygiene

```sh
git diff --check origin/main...HEAD
```

### iOS Build

```sh
xcodebuild \
  -project StateWatch.xcodeproj \
  -scheme StateWatch \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  CODE_SIGNING_ALLOWED=NO \
  COMPILER_INDEX_STORE_ENABLE=NO \
  build
```

### iOS Tests

```sh
xcodebuild \
  -project StateWatch.xcodeproj \
  -scheme StateWatch \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  CODE_SIGNING_ALLOWED=NO \
  COMPILER_INDEX_STORE_ENABLE=NO \
  test
```

### watchOS App Build

```sh
xcodebuild \
  -project StateWatch.xcodeproj \
  -scheme StateWatchWatchApp \
  -destination 'platform=watchOS Simulator,name=Apple Watch Series 11 (46mm)' \
  CODE_SIGNING_ALLOWED=NO \
  COMPILER_INDEX_STORE_ENABLE=NO \
  build
```

### WidgetKit Complication Build

```sh
xcodebuild \
  -project StateWatch.xcodeproj \
  -scheme StateWatchComplications \
  -destination 'platform=watchOS Simulator,name=Apple Watch Series 11 (46mm)' \
  CODE_SIGNING_ALLOWED=NO \
  COMPILER_INDEX_STORE_ENABLE=NO \
  build
```

## GitHub Actions Cost Control

The GitHub Actions workflow keeps a lightweight Ubuntu validation job for all pull requests, including drafts. That job checks whitespace and expected project directories only; it does not run `xcodebuild`.

The full macOS `xcodebuild` job runs when:

- a pull request is marked ready for review,
- code is pushed to `main`, or
- the workflow is manually triggered with `workflow_dispatch`.

Draft pull requests intentionally skip the full macOS job. Convert a draft pull request to ready for review or manually dispatch the workflow when final CI confidence is needed.

## Manual QA Still Required

Local simulator validation does not replace:

- real-device HealthKit permission testing,
- Apple Health data availability checks,
- complication gallery review,
- Watch app glanceability checks,
- visual review against Figma design specs,
- privacy and medical-safety wording review.

HealthKit data must remain local-only, and production iPhone, Watch, and complication surfaces must remain mock-backed until a future gated rollout explicitly changes that behavior.
