import SwiftUI

struct ScoreRingView: View {
    let score: Int

    var body: some View {
        VStack(spacing: 8) {
            Text("Readiness")
                .font(.headline)
            Text("\(score)")
                .font(.system(size: 48, weight: .bold))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ScoreRingView(score: 76)
        .padding()
}
