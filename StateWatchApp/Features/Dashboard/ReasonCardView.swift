import SwiftUI

struct ReasonCardView: View {
    let reason: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "info.circle")
                .foregroundStyle(.blue)
            Text(reason)
                .font(.body)
            Spacer(minLength: 0)
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    ReasonCardView(reason: StateAssessment.mock.reasons[0])
}
