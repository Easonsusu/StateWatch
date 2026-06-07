# Security and Privacy Policy

StateWatch is an early-stage, local-first SwiftUI iOS + watchOS wellness app. Protecting user privacy is a core project requirement, especially for Apple Health / HealthKit data.

## Reporting Security or Privacy Issues

Please do not include personal health data, screenshots containing health data, device identifiers, access tokens, or other sensitive details in public GitHub issues.

If GitHub private vulnerability reporting is enabled for this repository, use that channel. If it is not available, open a minimal public issue stating that you have a security or privacy concern and ask the maintainers to provide a private contact path. Include only non-sensitive context in the public issue.

Helpful non-sensitive report details include:

- A short description of the issue.
- The affected area of the app or documentation.
- Steps to reproduce using mock data when possible.
- Expected behavior and actual behavior.
- Whether the issue could expose, upload, persist, or misuse HealthKit data.

## Scope

Security and privacy reports may include, but are not limited to:

- HealthKit data handling.
- Local storage of wellness or HealthKit-derived data.
- HealthKit permission handling and denied, unavailable, empty, or partial data states.
- Accidental networking or upload paths.
- Dependency risk.
- Build, CI, or project configuration that could expose sensitive data.
- Accidental medical claims, diagnosis wording, disease detection wording, clinical stress detection wording, or medical advice wording.

## HealthKit Data Rules

HealthKit data should not be uploaded, sold, shared with advertisers, used for profiling, used for marketing, or used for data mining.

For the MVP:

- HealthKit data must remain local.
- The app should request read access only.
- HealthKit write access should not be added unless explicitly discussed and approved for a future phase.
- Contributors should use mock data for tests, previews, screenshots, and public examples.
- Missing or unavailable HealthKit data should be handled calmly and should not be treated as a negative health signal.

## Medical-Safety Scope

StateWatch is a wellness app, not a medical device. Reports about wording are welcome when the app, documentation, tests, or examples imply diagnosis, disease detection, illness detection, clinical stress detection, treatment, or medical advice.

Preferred wording should be cautious and wellness-oriented, such as "recent signals," "wellness estimate," "fatigue context," "low data," or "consider a lighter day if that matches how you feel."

## Project Status

StateWatch is early-stage software. Privacy and safety expectations may become more formal as the project matures, but the local-first HealthKit privacy rule applies now.
