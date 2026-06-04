import SwiftUI

struct TodaySuggestionView: View {
    let suggestion: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today's suggestion")
                .font(.headline)
            Text(suggestion)
            Text("Wellness guidance only, not medical advice.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    TodaySuggestionView(suggestion: StateAssessment.mock.suggestion)
        .padding()
}
