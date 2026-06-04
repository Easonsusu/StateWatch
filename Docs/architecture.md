# Architecture

StateWatch uses a modular SwiftUI structure:
- App layer (entry + coordination)
- Models (domain data)
- Services (HealthKit access, scoring, explanations)
- Features (UI by user flow)

MVP uses local-only processing and mock-friendly interfaces.
