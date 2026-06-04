import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Welcome to StateWatch")
                .font(.title2)
            Text("Daily wellness readiness insights from your Health data.")
                .multilineTextAlignment(.center)
            DisclaimerView()
            HealthPermissionView()
        }
        .padding()
    }
}

#Preview {
    OnboardingView()
}
