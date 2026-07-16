import Foundation

enum WatchLocalization {
    static func text(_ key: String) -> String {
        Bundle.main.localizedString(forKey: key, value: key, table: nil)
    }

    static func stateLabel(_ value: String) -> String {
        guard value == "Low" else {
            return text(value)
        }

        return Bundle.main.localizedString(forKey: "Low readiness", value: value, table: nil)
    }

    static func formatted(_ key: String, _ arguments: CVarArg...) -> String {
        String(
            format: text(key),
            locale: Locale.current,
            arguments: arguments
        )
    }
}
