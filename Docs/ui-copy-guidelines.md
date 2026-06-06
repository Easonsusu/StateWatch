# UI Copy Guidelines

StateWatch copy should be calm, wellness-oriented, and cautious. The app should
help users reflect on recent signals without suggesting medical diagnosis,
disease detection, treatment, or clinical stress detection.

## Principles

- Use wellness-oriented language.
- Prefer optional suggestions over instructions.
- Be transparent when data is limited.
- Explain confidence without blaming the user.
- Keep copy short enough for iPhone, Watch, and complication layouts.
- Reinforce local-only HealthKit handling where relevant.

## Avoid

- Medical diagnosis language.
- Alarming wording.
- Claims that StateWatch detects illness, disease, medical conditions, or
  clinical stress.
- Certainty about why a metric changed.
- Treatment recommendations.
- Red-alert language for missing data.

## Preferred Phrases

- `Your recent signals look mixed.`
- `Consider a lighter day if that matches how you feel.`
- `Recent data is limited, so this estimate is cautious.`
- `This is a wellness estimate, not medical advice.`
- `A check-in can add context to today's signals.`
- `Apple Health data stays local in the MVP.`

## State Copy

Steady:

- `Your recent signals look steady.`
- `Today's estimate is based on available local data.`

Mixed:

- `Your recent signals look mixed.`
- `A lighter pace may be useful if that matches how you feel.`

Low:

- `Your recent signals look lower than usual.`
- `Consider a gentler day if that feels right.`

Limited data:

- `Recent data is limited, so this estimate is cautious.`
- `More local history can make the summary steadier.`

Unavailable:

- `Apple Health data is not available on this device.`
- `The dashboard can continue using mock data.`

## Suggestion Copy

Suggestions should be short and optional.

Good:

- `Consider a lighter activity day if that matches how you feel.`
- `A consistent bedtime tonight may support recovery.`
- `Check in to add context to today's estimate.`

Avoid:

- `You need rest immediately.`
- `You are stressed.`
- `Your body is abnormal.`
- `This detects illness risk.`

## Watch And Complication Copy

- Use one short phrase.
- Prefer `Limited data` over long explanations.
- Avoid punctuation-heavy text.
- Do not show medical disclaimers inside tiny complications unless required.

## Review Checklist

- Does the copy avoid diagnosis, disease, illness detection, and clinical stress
  claims?
- Does missing data lower confidence instead of lowering wellness state?
- Does the suggestion sound optional?
- Is the copy short enough for the target surface?
- Does privacy copy avoid implying upload or server processing?

## TODO

- Add a copy review pass before any SwiftUI redesign PR.
- Consider a lightweight disallowed-word test if UI copy grows.
