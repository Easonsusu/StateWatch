import SwiftUI

struct PrivacyView: View {
    var body: some View {
        List {
            Section("Local-first MVP") {
                Text(SettingsPrivacyContent.localFirstDisclosure)
                Text(SettingsPrivacyContent.dataUseDisclosure)
            }

            Section("Stored Locally") {
                Text(SettingsPrivacyContent.onboardingDisclosure)
                Text(SettingsPrivacyContent.sharedSummaryDisclosure)
                Text(SettingsPrivacyContent.watchCheckInDisclosure)
            }

            Section("Apple Health Boundaries") {
                Text(SettingsPrivacyContent.healthKitProcessingDisclosure)
                Text(SettingsPrivacyContent.healthKitIsolationDisclosure)
                Text(SettingsPrivacyContent.healthKitSurfaceIsolationDisclosure)
            }

            Section("Wellness only") {
                Text(SettingsPrivacyContent.wellnessOnlyDisclosure)
            }
        }
        .navigationTitle("Privacy")
    }
}

#Preview {
    NavigationStack { PrivacyView() }
}
