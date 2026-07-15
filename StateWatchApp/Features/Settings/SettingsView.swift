import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Privacy") {
                    NavigationLink("Privacy", destination: PrivacyView())
                }

                Section("Apple Health") {
                    NavigationLink("Health Permissions", destination: DataPermissionView())
                    Text("StateWatch requests read-only Apple Health access for local wellness summaries.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                #if DEBUG
                Section("Developer Preview") {
                    NavigationLink("HealthKit Scoring Preview", destination: HealthKitScoringPreviewView())
                    NavigationLink("Visual Dashboard Preview", destination: StateWatchVisualPreviewView())
                }
                #endif

                Section("Local Data") {
                    Label(
                        SettingsPrivacyContent.dashboardDemoDisclosure,
                        systemImage: "square.stack.3d.up"
                    )
                    Label(
                        SettingsPrivacyContent.onboardingDisclosure,
                        systemImage: "iphone"
                    )
                    Label(
                        SettingsPrivacyContent.watchCheckInDisclosure,
                        systemImage: "applewatch"
                    )
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
