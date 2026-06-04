# App Store Checklist

## HealthKit and privacy

- Include HealthKit usage descriptions in the future Xcode project.
- Explain why each HealthKit type is requested.
- Confirm HealthKit data remains local for MVP.
- Confirm HealthKit data is not used for advertising, marketing, data mining, or profiling.
- Confirm screenshots and previews use mock data only.

## Medical safety

- StateWatch must be positioned as wellness reflection, not medical diagnosis.
- Avoid disease, illness, detection, diagnosis, treatment, and prevention claims.
- Include a clear disclaimer during onboarding.
- Include guidance to seek professional medical advice for medical concerns.

## App Review readiness

- Verify app works when HealthKit permission is denied.
- Provide reviewer notes describing mock/demo behavior if needed.
- Confirm watch app does not require network services.
- Confirm privacy policy matches actual data handling.
- Confirm no server endpoint receives HealthKit data in MVP.

## Accessibility and quality

- Support Dynamic Type where practical.
- Keep color contrast readable in dashboard score states.
- Avoid relying on color alone for wellness state.
- Test on small iPhone and Apple Watch screen sizes.
