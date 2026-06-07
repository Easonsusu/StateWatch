import SwiftUI

enum StateWatchColors {
    static let backgroundPrimary = Color(stateWatchHex: 0x080B12)
    static let backgroundSecondary = Color(stateWatchHex: 0x0E1320)
    static let panel = Color(stateWatchHex: 0x141B2A)
    static let panelElevated = Color(stateWatchHex: 0x182033)
    static let border = Color(stateWatchHex: 0x28344A)
    static let textPrimary = Color(stateWatchHex: 0xF4F8FF)
    static let textSecondary = Color(stateWatchHex: 0xAAB7CC)
    static let textMuted = Color(stateWatchHex: 0x65738C)
    static let accentCyan = Color(stateWatchHex: 0x35E7FF)
    static let accentBlue = Color(stateWatchHex: 0x4D7CFF)
    static let accentViolet = Color(stateWatchHex: 0x8E6CFF)
    static let recoveryGreen = Color(stateWatchHex: 0x5CF2B1)
    static let cautionAmber = Color(stateWatchHex: 0xFFCA63)
    static let softRed = Color(stateWatchHex: 0xFF6B6B)
}

extension Color {
    init(stateWatchHex hex: UInt, opacity: Double = 1) {
        let red = Double((hex >> 16) & 0xFF) / 255
        let green = Double((hex >> 8) & 0xFF) / 255
        let blue = Double(hex & 0xFF) / 255
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
