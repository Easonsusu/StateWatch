import SwiftUI

struct ReasonCardView: View {
    let reasons: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Why this score")
                .font(.headline)
            ForEach(reasons, id: \.self) { reason in
                Text("• \(reason)")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ReasonCardView(reasons: StateAssessment.mock.reasons)
        .padding()
}
