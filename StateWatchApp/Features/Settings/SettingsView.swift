import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            NavigationLink("Privacy") {
                PrivacyView()
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
