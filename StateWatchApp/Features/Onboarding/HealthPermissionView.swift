import SwiftUI

struct HealthPermissionView: View {
    let onContinue: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Health Access")
                .font(.title.bold())
            Text("StateWatch will ask for read-only Apple Health access in a future MVP task. HealthKit data should stay local on your device.")
            Text("You can deny access and still explore the app with mock data.")
                .foregroundStyle(.secondary)
            Button("Continue with Mock Data", action: onContinue)
                .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Privacy First")
    }
}

#Preview {
    HealthPermissionView(onContinue: {})
}
