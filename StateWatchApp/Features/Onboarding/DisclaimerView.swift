import SwiftUI

struct DisclaimerView: View {
    var body: some View {
        Text("StateWatch is not a medical diagnosis app.")
            .font(.footnote)
            .foregroundStyle(.secondary)
    }
}

#Preview {
    DisclaimerView()
        .padding()
}
