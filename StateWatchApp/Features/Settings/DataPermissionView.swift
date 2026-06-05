import SwiftUI

struct DataPermissionView: View {
    @StateObject private var healthKitManager: HealthKitManager

    @MainActor
    init(healthKitManager: HealthKitManager? = nil) {
        _healthKitManager = StateObject(wrappedValue: healthKitManager ?? HealthKitManager())
    }

    var body: some View {
        List {
            Section("Health Access") {
                VStack(alignment: .leading, spacing: 8) {
                    Text(healthKitManager.statusTitle)
                        .font(.headline)
                    Text(healthKitManager.statusMessage)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Button {
                    Task { await healthKitManager.requestAuthorization() }
                } label: {
                    Label("Request Read Access", systemImage: "heart.text.square")
                }
            }

            Section("Read Permissions") {
                ForEach(healthKitManager.permissionStatuses) { status in
                    DataPermissionRow(status: status)
                }
            }

            Section("Local Data Rules") {
                Label("Read-only HealthKit access", systemImage: "eye")
                Label("No HealthKit uploads in the MVP", systemImage: "icloud.slash")
                Label("No advertising, marketing, or data mining use", systemImage: "hand.raised")
                Label("Mock data remains available for previews and tests", systemImage: "square.stack.3d.up")
            }

            Section("Privacy Strings") {
                ForEach(HealthKitTypes.infoPlistPrivacyNotes, id: \.self) { note in
                    Text(note)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Data Permissions")
        .toolbar {
            Button("Refresh") {
                healthKitManager.refreshAuthorizationStatus()
            }
        }
    }
}

private struct DataPermissionRow: View {
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
        .padding(.vertical, 6)
    }
}

#Preview("Requested") {
    NavigationStack {
        DataPermissionView(healthKitManager: .previewReadAccessRequested)
    }
}

#Preview("Denied") {
    NavigationStack {
        DataPermissionView(healthKitManager: .previewDenied)
    }
}
