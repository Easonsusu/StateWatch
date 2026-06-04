# AGENTS.md

Guidance for future agents and contributors working on StateWatch.

## Product guardrails

- StateWatch is a wellness app, not a medical diagnosis app.
- Do not claim to detect, diagnose, predict, treat, or prevent illness or disease.
- Use cautious language such as "may suggest", "wellness signal", "recovery trend", and "consider resting".
- HealthKit data must stay local for the MVP.
- Do not upload HealthKit data to servers.
- Do not use HealthKit data for advertising, marketing, data mining, or profiling.
- Use mock data for previews, tests, screenshots, and development demos.

## Engineering guardrails

- Keep Swift files modular and easy to review.
- Prefer small models and services with one clear responsibility.
- Avoid adding a real Xcode project until the next setup task.
- Leave explicit TODO comments where HealthKit, persistence, watch sync, widgets, or production scoring should be implemented later.
- Keep scoring rules explainable and conservative.
- Any future AI feature must operate on local or user-approved exported summaries unless the privacy policy and consent model are updated first.
