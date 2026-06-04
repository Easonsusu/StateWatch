import SwiftUI

struct DisclaimerView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Wellness only")
                .font(.headline)
            Text("StateWatch is not a medical device and does not provide diagnosis, treatment, or disease detection. If you have medical concerns, consult a qualified healthcare professional.")
                .font(.callout)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    DisclaimerView()
        .padding()
}
