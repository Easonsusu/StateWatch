import Foundation

struct SettingsPrivacyContent {
    static let dashboardDemoDisclosure =
        String(localized: "Dashboard demo values are generated locally and are not stored as a personal history.")

    static let onboardingDisclosure =
        String(localized: "Onboarding completion is stored as one local preference on this iPhone.")

    static let watchCheckInDisclosure =
        String(localized: "Watch Check-ins stay on Apple Watch and can be deleted individually there.")

    static let localFirstDisclosure =
        String(localized: "StateWatch does not upload Apple Health data to any server in the MVP.")

    static let dataUseDisclosure =
        String(localized: "Apple Health data is not used for advertising, marketing, data mining, or profiling.")

    static let healthKitProcessingDisclosure =
        String(localized: "Optional Apple Health access is read-only, and available data is processed on device.")

    static let sharedSummaryDisclosure =
        String(localized: "A compact demo readiness summary may be stored in the local App Group for mock complication previews.")

    static let healthKitIsolationDisclosure =
        String(localized: "Raw Apple Health samples are not stored in shared App Group state or uploaded.")

    static let healthKitSurfaceIsolationDisclosure =
        String(localized: "HealthKit-derived Dashboard output is not published to Watch, WidgetKit, or the App Group.")

    static let wellnessOnlyDisclosure =
        String(localized: "StateWatch is not a medical device. It does not diagnose, treat, cure, or prevent any disease, and it does not provide medical advice.")

    static var searchableText: String {
        [
            dashboardDemoDisclosure,
            onboardingDisclosure,
            watchCheckInDisclosure,
            localFirstDisclosure,
            dataUseDisclosure,
            healthKitProcessingDisclosure,
            sharedSummaryDisclosure,
            healthKitIsolationDisclosure,
            healthKitSurfaceIsolationDisclosure,
            wellnessOnlyDisclosure
        ].joined(separator: "\n")
    }
}
