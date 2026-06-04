# HealthKit Data Map

This map is a planning document. Full HealthKit implementation is intentionally left for a later task.

| Wellness area | Candidate HealthKit data | MVP use | Notes |
| --- | --- | --- | --- |
| Recovery | Resting heart rate, HRV | Compare with personal baseline | Explain as wellness signal, not medical status. |
| Sleep | Sleep analysis, time asleep | Duration and consistency | Avoid claims about sleep disorders. |
| Stress/fatigue | HRV trend, resting heart rate trend, mindfulness minutes, user check-in | Conservative fatigue context | Do not claim stress diagnosis. |
| Activity load | Active energy, exercise minutes, steps, stand hours | Load and recovery balance | Avoid performance or medical claims. |
| Subjective context | User check-in | User-provided complement to wearable data | Stored locally in MVP. |

## Permission principles

- Request only the minimum read permissions needed for the current feature.
- Explain each requested category before the system permission prompt.
- Continue gracefully if the user denies permission.
- Use mock data in previews and tests.

## TODO

- Finalize exact `HKQuantityTypeIdentifier` and `HKCategoryTypeIdentifier` values.
- Add Info.plist HealthKit usage descriptions in the future Xcode project.
- Add unit tests around denied, partial, and unavailable HealthKit access.
