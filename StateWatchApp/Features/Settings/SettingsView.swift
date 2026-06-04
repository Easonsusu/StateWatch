import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Privacy", destination: PrivacyView())
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
