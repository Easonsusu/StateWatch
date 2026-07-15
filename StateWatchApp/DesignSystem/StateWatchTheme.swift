import SwiftUI

enum StateWatchTheme {
    enum ScoreColorCategory: Equatable {
        case high
        case medium
        case caution
        case low
        case unavailable
    }

    static func clampedScore(_ score: Int) -> Int {
        min(100, max(0, score))
    }

    static func scoreColorCategory(for score: Int?) -> ScoreColorCategory {
        guard let score else { return .unavailable }

        switch clampedScore(score) {
        case 80...100: return .high
        case 60..<80: return .medium
        case 40..<60: return .caution
        default: return .low
        }
    }

    static func scoreColor(for score: Int?) -> Color {
        switch scoreColorCategory(for: score) {
        case .high: return StateWatchColors.recoveryGreen
        case .medium: return StateWatchColors.accentCyan
        case .caution: return StateWatchColors.cautionAmber
        case .low: return StateWatchColors.softRed
        case .unavailable: return StateWatchColors.textMuted
        }
    }

    static func confidenceColor(for confidence: ScoreConfidence) -> Color {
        switch confidence {
        case .high: return StateWatchColors.recoveryGreen
        case .medium: return StateWatchColors.accentCyan
        case .low: return StateWatchColors.cautionAmber
        case .unavailable: return StateWatchColors.textMuted
        }
    }

    static func confidenceLabel(for confidence: ScoreConfidence) -> String {
        switch confidence {
        case .high: return String(localized: "High")
        case .medium: return String(localized: "Medium")
        case .low: return String(localized: "Low data")
        case .unavailable: return String(localized: "Unavailable")
        }
    }

    static func stateLabelColor(for level: StateLevel) -> Color {
        switch level {
        case .steady: return StateWatchColors.recoveryGreen
        case .mixed: return StateWatchColors.accentCyan
        case .low: return StateWatchColors.cautionAmber
        case .needsRest: return StateWatchColors.softRed
        }
    }
}
