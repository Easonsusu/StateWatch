import SwiftUI

struct PrivacyView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Privacy")
                .font(.title2)
            Text("Health data is processed locally in the MVP.")
            Text("No HealthKit data is uploaded, sold, or used for advertising.")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    PrivacyView()
}
