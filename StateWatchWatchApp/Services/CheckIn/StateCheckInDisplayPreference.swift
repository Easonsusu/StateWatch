import Foundation

enum StateCheckInDisplayMode: String, CaseIterable, Codable, Equatable, Identifiable {
    case iconAndText
    case iconOnly
    case textOnly

    static let defaultMode = StateCheckInDisplayMode.iconAndText

    var id: String {
        rawValue
    }

    var label: String {
        switch self {
        case .iconAndText:
            return "Icon + Text"
        case .iconOnly:
            return "Icon Only"
        case .textOnly:
            return "Text Only"
        }
    }

    var compactLabel: String {
        switch self {
        case .iconAndText:
            return "Both"
        case .iconOnly:
            return "Icon"
        case .textOnly:
            return "Text"
        }
    }

    var showsIcon: Bool {
        self != .textOnly
    }

    var showsText: Bool {
        self != .iconOnly
    }
}

protocol StateCheckInDisplayPreferenceStoring {
    func load() -> StateCheckInDisplayMode
    func save(_ mode: StateCheckInDisplayMode)
}

struct LocalStateCheckInDisplayPreferenceStore: StateCheckInDisplayPreferenceStoring {
    static let storageKey = "statewatch.watchCheckIn.displayMode.v1"

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    var storageKeyForTests: String {
        Self.storageKey
    }

    var userDefaultsForTests: UserDefaults {
        userDefaults
    }

    func load() -> StateCheckInDisplayMode {
        guard
            let rawValue = userDefaults.string(forKey: Self.storageKey),
            let mode = StateCheckInDisplayMode(rawValue: rawValue)
        else {
            return .defaultMode
        }

        return mode
    }

    func save(_ mode: StateCheckInDisplayMode) {
        userDefaults.set(mode.rawValue, forKey: Self.storageKey)
    }
}
