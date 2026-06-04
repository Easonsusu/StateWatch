import SwiftUI

struct PrivacyView: View {
    var body: some View {
        List {
            Section("Local-first MVP") {
                Text("StateWatch does not upload HealthKit data to any server in the MVP.")
                Text("HealthKit data must not be used for advertising, marketing, data mining, or profiling.")
            }
            Section("Wellness only") {
                Text("StateWatch is not a medical device and does not provide medical diagnosis, treatment, or disease detection.")
            }
            Section("TODO") {
                Text("Finalize privacy policy after HealthKit permissions and local storage are implemented.")
            }
        }
        .navigationTitle("Privacy")
    }
}

#Preview {
    NavigationStack { PrivacyView() }
}
