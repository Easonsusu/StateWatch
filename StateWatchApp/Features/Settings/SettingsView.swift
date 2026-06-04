import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Privacy") {
                    NavigationLink("Privacy", destination: PrivacyView())
                    NavigationLink("Data Permissions", destination: DataPermissionView())
                }

                Section("Data") {
                    Text("HealthKit data stays local in the MVP.")
                    Button("Reset Local Mock Data") {
                        // TODO: Clear local persistence after it exists.
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
