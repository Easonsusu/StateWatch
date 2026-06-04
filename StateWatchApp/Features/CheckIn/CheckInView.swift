import SwiftUI

struct CheckInView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Daily Check-In")
                .font(.title2)
            Text("Capture your self-reported energy and stress to add context.")
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    CheckInView()
}
