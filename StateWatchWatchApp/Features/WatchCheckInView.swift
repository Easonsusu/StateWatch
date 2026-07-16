import SwiftUI

struct WatchCheckInView: View {
    private static let recentHistoryLimit = 3

    private let store: any StateCheckInStoring
    private let displayPreferenceStore: any StateCheckInDisplayPreferenceStoring

    @State private var selectedOption: StateCheckInOption?
    @State private var showsConfirmation = false
    @State private var confirmationState = CheckInConfirmationState.saved
    @State private var displayMode = StateCheckInDisplayMode.defaultMode
    @State private var recentCheckIns: [StateCheckInRecord] = []
    @State private var pendingDeleteRecord: StateCheckInRecord?
    @State private var deleteFailureMessage: String?

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
        ScrollView {
            VStack(alignment: .leading, spacing: 9) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(WatchLocalization.text(StateCheckInOption.screenTitle))
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundStyle(WatchStyle.textPrimary)

                    Text(WatchLocalization.text(StateCheckInOption.screenSubtitle))
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
                        .accessibilityLabel(Text(localizedOptionAccessibilityLabel(option)))
                        .accessibilityHint(Text(WatchLocalization.text(StateCheckInOption.saveAccessibilityHint)))
                    }
                }

                recentHistorySection
            }
        }
        .onAppear {
            reloadRecentCheckIns()
        }
    }

    private var displayModeSelector: some View {
        HStack(spacing: 4) {
            ForEach(StateCheckInDisplayMode.allCases) { mode in
                Button {
                    updateDisplayMode(mode)
                } label: {
                    Text(WatchLocalization.text(mode.compactLabel))
                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 4)
                        .foregroundStyle(displayMode == mode ? WatchStyle.backgroundPrimary : WatchStyle.textSecondary)
                        .background(displayMode == mode ? WatchStyle.accentCyan : WatchStyle.panel.opacity(0.56))
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(displayMode == mode ? WatchStyle.accentCyan.opacity(0.2) : WatchStyle.border.opacity(0.42), lineWidth: 1)
                        )
                }
                .buttonStyle(.plain)
                .accessibilityLabel(Text(WatchLocalization.formatted("Check-in display style, %@", WatchLocalization.text(mode.label))))
                .accessibilityValue(Text(WatchLocalization.text(displayMode == mode ? "Selected" : "Not selected")))
                .accessibilityHint(Text(WatchLocalization.text(StateCheckInOption.displayStyleAccessibilityHint)))
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(Text(WatchLocalization.text("Check-in display style")))
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
                Text(localizedOptionLabel(option))
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
                Text(WatchLocalization.text(confirmationState.title))
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(WatchStyle.textPrimary)

                Text(WatchLocalization.text(confirmationState.message))
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(WatchStyle.textSecondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.82)

                Text(localizedOptionLabel(option))
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(optionColor(for: option))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(WatchStyle.panel)
                    .clipShape(Capsule())
            }

            Text(WatchLocalization.text(confirmationState.detail))
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .foregroundStyle(WatchStyle.textMuted)
                .lineLimit(2)
                .multilineTextAlignment(.center)

            Button(WatchLocalization.text(StateCheckInOption.doneButtonTitle)) {
                showsConfirmation = false
                selectedOption = nil
            }
            .font(.system(size: 12, weight: .semibold, design: .rounded))
            .buttonStyle(.borderedProminent)
            .tint(WatchStyle.accentBlue)
        }
        .frame(maxWidth: .infinity)
    }

    private var recentHistorySection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(WatchLocalization.text(StateCheckInOption.recentCheckInsTitle))
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundStyle(WatchStyle.textSecondary)

            if recentCheckIns.isEmpty {
                emptyHistoryView
            } else {
                VStack(spacing: 5) {
                    ForEach(recentCheckIns) { record in
                        recentHistoryRow(record)
                    }
                }
            }

            if let pendingDeleteRecord {
                deleteConfirmationView(for: pendingDeleteRecord)
            }

            if let deleteFailureMessage {
                VStack(alignment: .leading, spacing: 2) {
                    Text(WatchLocalization.text(deleteFailureMessage))
                        .font(.system(size: 11, weight: .semibold, design: .rounded))
                        .foregroundStyle(WatchStyle.textSecondary)

                    Text(WatchLocalization.text(StateCheckInOption.tryAgainLaterMessage))
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                        .foregroundStyle(WatchStyle.textMuted)
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel(Text(WatchLocalization.text("Delete unavailable. Try again later.")))
            }
        }
        .padding(.top, 2)
    }

    private var emptyHistoryView: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(WatchLocalization.text(StateCheckInOption.noCheckInTitle))
                .font(.system(size: 11, weight: .semibold, design: .rounded))
                .foregroundStyle(WatchStyle.textPrimary)

            Text(WatchLocalization.text(StateCheckInOption.optionalCheckInMessage))
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundStyle(WatchStyle.textMuted)
                .lineLimit(2)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(WatchStyle.panel.opacity(0.72))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(WatchLocalization.text("No check-in yet. Check-ins are optional.")))
    }

    private func recentHistoryRow(_ record: StateCheckInRecord) -> some View {
        HStack(spacing: 7) {
            if displayMode.showsIcon {
                Image(systemName: record.option.symbolName)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(optionColor(for: record.option))
                    .frame(width: 15, height: 15)
            }

            VStack(alignment: .leading, spacing: 1) {
                Text(localizedOptionLabel(record.option))
                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                    .foregroundStyle(WatchStyle.textPrimary)
                    .lineLimit(1)

                Text(timestampText(for: record.createdAt))
                    .font(.system(size: 9, weight: .medium, design: .rounded))
                    .foregroundStyle(WatchStyle.textMuted)
                    .lineLimit(1)
                    .minimumScaleFactor(0.82)
            }

            Spacer(minLength: 2)

            Button {
                pendingDeleteRecord = record
                deleteFailureMessage = nil
            } label: {
                Image(systemName: "trash")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundStyle(WatchStyle.textMuted)
                    .frame(width: 22, height: 22)
                    .background(WatchStyle.panel)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel(Text(WatchLocalization.formatted("Delete %@ check-in", localizedOptionLabel(record.option))))
            .accessibilityHint(Text(WatchLocalization.text(StateCheckInOption.deleteCheckInAccessibilityHint)))
        }
        .padding(.horizontal, 9)
        .padding(.vertical, 7)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(WatchStyle.panel.opacity(0.82))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .accessibilityElement(children: .contain)
        .accessibilityLabel(Text(WatchLocalization.formatted("Recent check-in: %@, %@", localizedOptionAccessibilityLabel(record.option), timestampText(for: record.createdAt))))
        .accessibilityHint(Text(WatchLocalization.text(StateCheckInOption.recentCheckInAccessibilityHint)))
    }

    private func deleteConfirmationView(for record: StateCheckInRecord) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(WatchLocalization.text(StateCheckInOption.deleteCheckInPrompt))
                .font(.system(size: 11, weight: .semibold, design: .rounded))
                .foregroundStyle(WatchStyle.textPrimary)

            Text(WatchLocalization.text(StateCheckInOption.deleteCheckInDetail))
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundStyle(WatchStyle.textMuted)
                .lineLimit(2)

            HStack(spacing: 6) {
                Button(WatchLocalization.text(StateCheckInOption.deleteButtonTitle)) {
                    delete(record)
                }
                .font(.system(size: 10, weight: .semibold, design: .rounded))
                .buttonStyle(.borderedProminent)
                .tint(WatchStyle.accentBlue)
                .accessibilityLabel(Text(WatchLocalization.formatted("Delete check-in, %@", localizedOptionLabel(record.option))))
                .accessibilityHint(Text(WatchLocalization.text(StateCheckInOption.confirmDeleteAccessibilityHint)))

                Button(WatchLocalization.text(StateCheckInOption.keepButtonTitle)) {
                    pendingDeleteRecord = nil
                }
                .font(.system(size: 10, weight: .semibold, design: .rounded))
                .buttonStyle(.bordered)
                .tint(WatchStyle.textMuted)
                .accessibilityLabel(Text(WatchLocalization.text(StateCheckInOption.keepButtonTitle)))
                .accessibilityHint(Text(WatchLocalization.text(StateCheckInOption.keepCheckInAccessibilityHint)))
            }
        }
        .padding(9)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(WatchStyle.panel)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(WatchLocalization.text("Remove this local check-in? This removes it from this Watch.")))
    }

    private var accessibilitySummary: String {
        if showsConfirmation, let selectedOption {
            return WatchLocalization.formatted(confirmationState.accessibilityFormatKey, localizedOptionAccessibilityLabel(selectedOption))
        }

        return WatchLocalization.text("Check in. How do you feel right now?")
    }

    private func updateDisplayMode(_ mode: StateCheckInDisplayMode) {
        displayMode = mode
        displayPreferenceStore.save(mode)
    }

    private func localizedOptionLabel(_ option: StateCheckInOption) -> String {
        WatchLocalization.text(option.label)
    }

    private func localizedOptionAccessibilityLabel(_ option: StateCheckInOption) -> String {
        WatchLocalization.formatted("%@, self-reported state", localizedOptionLabel(option))
    }

    private func save(_ option: StateCheckInOption) {
        selectedOption = option

        do {
            try store.save(StateCheckInRecord(option: option))
            confirmationState = .saved
            reloadRecentCheckIns()
        } catch {
            confirmationState = .unavailable
        }

        showsConfirmation = true
    }

    private func delete(_ record: StateCheckInRecord) {
        do {
            try store.delete(id: record.id)
            pendingDeleteRecord = nil
            deleteFailureMessage = nil
            reloadRecentCheckIns()
        } catch {
            pendingDeleteRecord = nil
            deleteFailureMessage = StateCheckInOption.deleteUnavailableTitle
        }
    }

    private func reloadRecentCheckIns() {
        recentCheckIns = store.loadRecent(limit: Self.recentHistoryLimit)
    }

    private func timestampText(for date: Date) -> String {
        let calendar = Calendar.current

        if calendar.isDateInToday(date) {
            return WatchLocalization.formatted("Today %@", date.formatted(date: .omitted, time: .shortened))
        }

        if calendar.isDateInYesterday(date) {
            return WatchLocalization.text("Yesterday")
        }

        return date.formatted(date: .numeric, time: .omitted)
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

    var accessibilityFormatKey: String {
        switch self {
        case .saved:
            return "Check-in saved. %@."
        case .unavailable:
            return "Check-in unavailable. %@."
        }
    }
}

#Preview("Watch Check-in") {
    WatchCheckInView()
}
