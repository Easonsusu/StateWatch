import SwiftUI

struct WatchCheckInView: View {
    private let store: any StateCheckInStoring
    private let displayPreferenceStore: any StateCheckInDisplayPreferenceStoring

    @State private var selectedOption: StateCheckInOption?
    @State private var showsConfirmation = false
    @State private var confirmationState = CheckInConfirmationState.saved
    @State private var displayMode = StateCheckInDisplayMode.defaultMode

    init(
        store: any StateCheckInStoring = LocalStateCheckInStore(),
        displayPreferenceStore: any StateCheckInDisplayPreferenceStoring = LocalStateCheckInDisplayPreferenceStore()
    ) {
        self.store = store
        self.displayPreferenceStore = displayPreferenceStore
    }

    var body: some View {
        WatchPage {
            if showsConfirmation, let selectedOption {
                confirmationView(for: selectedOption)
            } else {
                selectionView
            }
        }
        .accessibilityLabel(accessibilitySummary)
    }

    private var selectionView: some View {
        VStack(alignment: .leading, spacing: 9) {
            VStack(alignment: .leading, spacing: 3) {
                Text(StateCheckInOption.screenTitle)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(WatchStyle.textPrimary)

                Text(StateCheckInOption.screenSubtitle)
                    .font(.system(size: 11, weight: .medium, design: .rounded))
                    .foregroundStyle(WatchStyle.textMuted)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
            }

            displayModeSelector

            VStack(spacing: 6) {
                ForEach(StateCheckInOption.allCases) { option in
                    Button {
                        save(option)
                    } label: {
                        optionRow(option)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(option.accessibilityLabel)
                }
            }
        }
    }

    private var displayModeSelector: some View {
        HStack(spacing: 4) {
            ForEach(StateCheckInDisplayMode.allCases) { mode in
                Button {
                    updateDisplayMode(mode)
                } label: {
                    Text(mode.compactLabel)
                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        .foregroundStyle(displayMode == mode ? WatchStyle.backgroundPrimary : WatchStyle.textSecondary)
                        .background(displayMode == mode ? WatchStyle.accentCyan : WatchStyle.panel)
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Check-in display style, \(mode.label)")
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Check-in display style")
        .onAppear {
            displayMode = displayPreferenceStore.load()
        }
    }

    private func optionRow(_ option: StateCheckInOption) -> some View {
        HStack(spacing: 8) {
            if displayMode.showsIcon {
                Image(systemName: option.symbolName)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(optionColor(for: option))
                    .frame(width: 18, height: 18)
            }

            if displayMode.showsText {
                Text(option.label)
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundStyle(WatchStyle.textPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.78)
            }

            Spacer(minLength: 4)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(WatchStyle.panel)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(optionColor(for: option).opacity(0.28), lineWidth: 1)
        )
    }

    private func confirmationView(for option: StateCheckInOption) -> some View {
        VStack(spacing: 9) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(WatchStyle.accentCyan)

            VStack(spacing: 3) {
                Text(confirmationState.title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(WatchStyle.textPrimary)

                Text(confirmationState.message)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(WatchStyle.textSecondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.82)

                Text(option.label)
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(optionColor(for: option))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(WatchStyle.panel)
                    .clipShape(Capsule())
            }

            Text(confirmationState.detail)
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .foregroundStyle(WatchStyle.textMuted)
                .lineLimit(2)
                .multilineTextAlignment(.center)

            Button(StateCheckInOption.doneButtonTitle) {
                showsConfirmation = false
                selectedOption = nil
            }
            .font(.system(size: 12, weight: .semibold, design: .rounded))
            .buttonStyle(.borderedProminent)
            .tint(WatchStyle.accentBlue)
        }
        .frame(maxWidth: .infinity)
    }

    private var accessibilitySummary: String {
        if showsConfirmation, let selectedOption {
            return "\(confirmationState.message). \(selectedOption.accessibilityLabel)."
        }

        return "\(StateCheckInOption.screenTitle). \(StateCheckInOption.screenSubtitle)"
    }

    private func updateDisplayMode(_ mode: StateCheckInDisplayMode) {
        displayMode = mode
        displayPreferenceStore.save(mode)
    }

    private func save(_ option: StateCheckInOption) {
        selectedOption = option

        do {
            try store.save(StateCheckInRecord(option: option))
            confirmationState = .saved
        } catch {
            confirmationState = .unavailable
        }

        showsConfirmation = true
    }

    private func optionColor(for option: StateCheckInOption) -> Color {
        switch option {
        case .energized:
            return WatchStyle.recoveryGreen
        case .stable:
            return WatchStyle.accentCyan
        case .tired:
            return WatchStyle.cautionAmber
        case .low:
            return WatchStyle.textMuted
        }
    }
}

private enum CheckInConfirmationState {
    case saved
    case unavailable

    var title: String {
        switch self {
        case .saved:
            return StateCheckInOption.confirmationTitle
        case .unavailable:
            return "Unavailable"
        }
    }

    var message: String {
        switch self {
        case .saved:
            return StateCheckInOption.confirmationMessage
        case .unavailable:
            return "Check-in unavailable"
        }
    }

    var detail: String {
        switch self {
        case .saved:
            return StateCheckInOption.confirmationDetail
        case .unavailable:
            return "Try again later."
        }
    }
}

#Preview("Watch Check-in") {
    WatchCheckInView()
}
