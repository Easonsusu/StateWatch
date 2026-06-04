import SwiftUI

struct HealthPermissionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Health Access")
                .font(.headline)
            Text("StateWatch requests only the Health data needed for readiness insights.")
            Text("Data stays on your device in MVP.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    HealthPermissionView()
        .padding()
}
