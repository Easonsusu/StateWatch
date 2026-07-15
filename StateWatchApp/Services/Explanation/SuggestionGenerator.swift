import Foundation

struct SuggestionGenerator {
    func suggestions(for overallScore: Int, snapshot: DailyHealthSnapshot) -> [String] {
        var suggestions: [String] = []

        if overallScore < 60 {
            suggestions.append(String(localized: "Consider a lighter day if that matches how you feel."))
        } else {
            suggestions.append(String(localized: "Keep an eye on your trends and adjust plans based on how you feel."))
        }

        if snapshot.sleepDurationHours ?? 0 < 7 {
            suggestions.append(String(localized: "A consistent bedtime tonight may support recovery."))
        }

        if snapshot.checkIn == nil {
            suggestions.append(String(localized: "A quick check-in can add context to today's signals."))
        }

        return suggestions
    }

    // TODO: Keep suggestions optional, non-medical, and easy to dismiss.
}
