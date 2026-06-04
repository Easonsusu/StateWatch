import SwiftUI

struct WatchSuggestionView: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.footnote)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    WatchSuggestionView(text: "Consider a moderate activity day.")
}
