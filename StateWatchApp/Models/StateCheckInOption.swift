import Foundation

enum StateCheckInOption: String, CaseIterable, Identifiable, Equatable {
    case energized
    case stable
    case tired
    case low

    var id: String { rawValue }

    var label: String {
        switch self {
        case .energized:
            return "Energized"
        case .stable:
            return "Stable"
        case .tired:
            return "Tired"
        case .low:
            return "Low"
        }
    }

    var traditionalChineseReferenceLabel: String {
        switch self {
        case .energized:
            return "有活力"
        case .stable:
            return "穩定"
        case .tired:
            return "疲累"
        case .low:
            return "低狀態"
        }
    }

    var symbolName: String {
        switch self {
        case .energized:
            return "sparkles"
        case .stable:
            return "circle"
        case .tired:
            return "moon"
        case .low:
            return "circle.dashed"
        }
    }

    var accessibilityLabel: String {
        "\(label), self-reported state"
    }

    static let screenTitle = "Check in"
    static let screenSubtitle = "How do you feel right now?"
    static let confirmationTitle = "Saved"
    static let confirmationMessage = "Check-in saved"
    static let confirmationDetail = "You can update it later."
    static let doneButtonTitle = "Done"
    static let noCheckInTitle = "No check-in yet"
    static let optionalCheckInMessage = "Check-ins are optional."

    static var searchableCopy: String {
        (
            [
                screenTitle,
                screenSubtitle,
                confirmationTitle,
                confirmationMessage,
                confirmationDetail,
                doneButtonTitle,
                noCheckInTitle,
                optionalCheckInMessage
            ]
            + allCases.flatMap {
                [
                    $0.label,
                    $0.traditionalChineseReferenceLabel,
                    $0.symbolName,
                    $0.accessibilityLabel
                ]
            }
        ).joined(separator: " ")
    }
}
