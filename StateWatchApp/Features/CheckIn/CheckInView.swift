import SwiftUI

struct CheckInView: View {
    @State private var mood: UserCheckIn.Mood = .neutral
    @State private var fatigue: UserCheckIn.Intensity = .medium
    @State private var perceivedStress: UserCheckIn.Intensity = .medium
    @State private var note = ""

    var body: some View {
        Form {
            Picker("Mood", selection: $mood) {
                ForEach(UserCheckIn.Mood.allCases, id: \.self) { Text($0.rawValue).tag($0) }
            }
            Picker("Fatigue", selection: $fatigue) {
                ForEach(UserCheckIn.Intensity.allCases, id: \.self) { Text($0.rawValue).tag($0) }
            }
            Picker("Perceived stress", selection: $perceivedStress) {
                ForEach(UserCheckIn.Intensity.allCases, id: \.self) { Text($0.rawValue).tag($0) }
            }
            TextField("Optional note", text: $note, axis: .vertical)
            Button("Save Check-In") {
                // TODO: Save locally after persistence is added.
            }
        }
        .navigationTitle("Check-In")
    }
}

#Preview {
    NavigationStack { CheckInView() }
}
