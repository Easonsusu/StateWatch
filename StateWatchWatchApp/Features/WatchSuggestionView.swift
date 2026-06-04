import SwiftUI

struct WatchSuggestionView: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.footnote)
            .multilineTextAlignment(.center)
            .foregroundStyle(.secondary)
    }
}

#Preview {
    WatchSuggestionView(text: "Consider a lighter activity day if that matches how you feel.")
}
