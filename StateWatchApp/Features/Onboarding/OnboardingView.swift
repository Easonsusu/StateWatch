import SwiftUI

struct OnboardingView: View {
    let onFinish: () -> Void

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                Text("StateWatch")
                    .font(.largeTitle.bold())
                Text("Daily wellness reflections using local Apple Health signals and optional check-ins.")
                    .font(.body)
                DisclaimerView()
                NavigationLink("Review Health Access") {
                    HealthPermissionView(onContinue: onFinish)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Welcome")
        }
    }
}

#Preview {
    OnboardingView(onFinish: {})
}
