import SwiftUI

struct HealthPermissionView: View {
    let onContinue: () -> Void

    @StateObject private var healthKitManager: HealthKitManager

    @MainActor
    init(
        onContinue: @escaping () -> Void,
        healthKitManager: HealthKitManager? = nil
    ) {
        self.onContinue = onContinue
        _healthKitManager = StateObject(wrappedValue: healthKitManager ?? HealthKitManager())
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Apple Health Access")
                        .font(.title.bold())
                    Text("StateWatch uses optional, read-only Apple Health data for local wellness summaries. You can continue with mock data at any time.")
                        .foregroundStyle(.secondary)
                }

                HealthPermissionStatusPanel(manager: healthKitManager)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Requested Read Permissions")
                        .font(.headline)

                    ForEach(healthKitManager.permissionStatuses) { status in
                        HealthPermissionRow(status: status)
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Label("Health data stays on this device for the MVP.", systemImage: "lock")
                    Label("StateWatch does not upload HealthKit data.", systemImage: "icloud.slash")
                    Label("Insights are wellness support only, not medical diagnosis.", systemImage: "heart.text.square")
                }
                .font(.footnote)
                .foregroundStyle(.secondary)
            }
            .padding()
        }
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 10) {
                Button {
                    Task { await healthKitManager.requestAuthorization() }
                } label: {
                    Label("Request Read Access", systemImage: "heart.text.square")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)

                Button(action: onContinue) {
                    Text(
                        healthKitManager.shouldUseMockData
                            ? String(localized: "Continue with Mock Data")
                            : String(localized: "Continue")
                    )
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .background(.bar)
        }
        .navigationTitle("Privacy First")
    }
}

private struct HealthPermissionStatusPanel: View {
    @ObservedObject var manager: HealthKitManager

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(manager.statusTitle)
                .font(.headline)
            Text(manager.statusMessage)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 8))
    }
}

private struct HealthPermissionRow: View {
    let status: HealthKitPermissionStatus

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .firstTextBaseline) {
                Text(status.permission.displayName)
                    .font(.subheadline.weight(.semibold))
                Spacer()
                Text(status.access.displayName)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
            }
            Text(status.permission.wellnessReason)
                .font(.footnote)
                .foregroundStyle(.secondary)
            Text(status.permission.exampleUse)
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding(12)
        .background(Color(.tertiarySystemBackground), in: RoundedRectangle(cornerRadius: 8))
    }
}

#Preview("Not Requested") {
    NavigationStack {
        HealthPermissionView(onContinue: {})
    }
}

#Preview("Denied") {
    NavigationStack {
        HealthPermissionView(
            onContinue: {},
            healthKitManager: .previewDenied
        )
    }
}
