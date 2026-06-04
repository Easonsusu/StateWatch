import SwiftUI

struct TodaySuggestionView: View {
    let suggestions: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Today")
                .font(.headline)
            ForEach(suggestions, id: \.self) { suggestion in
                Label(suggestion, systemImage: "leaf")
                    .font(.callout)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    TodaySuggestionView(suggestions: StateAssessment.mock.suggestions)
}
