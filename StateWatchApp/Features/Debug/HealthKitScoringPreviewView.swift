import SwiftUI
#if canImport(HealthKit)
import HealthKit
#endif

#if DEBUG
enum HealthKitScoringPreviewState: Equatable {
    case idle
    case loading
    case loaded(HealthKitScoringPreviewReport)
    case emptyData
    case unavailable(String)
    case failed(String)
}

struct HealthKitScoringPreviewReport: Equatable {
    let snapshots: [DailyHealthSnapshot]
    let latestSnapshot: DailyHealthSnapshot
    let baseline: HealthBaseline
    let assessment: StateAssessment?
    let missingDataNotice: String?
    let sparseDataNotice: String?

    var snapshotCount: Int { snapshots.count }
    var latestAvailableMetricsCount: Int { latestSnapshot.availableMetrics.count }

    static func make(from snapshots: [DailyHealthSnapshot]) -> HealthKitScoringPreviewReport? {
        let sortedSnapshots = snapshots.sorted { $0.date < $1.date }
        guard let latestSnapshot = sortedSnapshots.last,
              sortedSnapshots.contains(where: { !$0.availableMetrics.isEmpty })
        else {
            return nil
        }

        let priorSnapshots = Array(sortedSnapshots.dropLast())
        let baseline = BaselineCalculator().calculate(from: priorSnapshots, window: .thirtyDays)
        let assessment = OverallStateEngine().assess(history: sortedSnapshots, window: .thirtyDays)
        let missingDataNotice = Self.missingDataNotice(for: latestSnapshot)
        let sparseDataNotice = Self.sparseDataNotice(baseline: baseline, assessment: assessment)

        return HealthKitScoringPreviewReport(
            snapshots: sortedSnapshots,
            latestSnapshot: latestSnapshot,
            baseline: baseline,
            assessment: assessment,
            missingDataNotice: missingDataNotice,
            sparseDataNotice: sparseDataNotice
        )
    }

    private static func missingDataNotice(for snapshot: DailyHealthSnapshot) -> String? {
        guard snapshot.availableMetrics.count < 6 else { return nil }
        return "Some recent Apple Health fields are unavailable, so this preview may have lower confidence."
    }

    private static func sparseDataNotice(
        baseline: HealthBaseline,
        assessment: StateAssessment?
    ) -> String? {
        guard !baseline.hasEnoughHistory || assessment?.confidence == .low || assessment?.confidence == .unavailable else {
            return nil
        }

        return "There is not enough recent data to produce a confident preview yet."
    }
}

final class HealthKitScoringPreviewViewModel: ObservableObject {
    typealias SnapshotLoader = (Int) async throws -> [DailyHealthSnapshot]

    static let lookbackDays = 30

    @Published private(set) var state: HealthKitScoringPreviewState = .idle

    private let snapshotLoader: SnapshotLoader
    private let healthDataAvailability: () -> Bool

    init(
        snapshotLoader: @escaping SnapshotLoader = HealthKitScoringPreviewViewModel.defaultSnapshotLoader,
        healthDataAvailability: @escaping () -> Bool = HealthKitScoringPreviewViewModel.defaultHealthDataAvailability
    ) {
        self.snapshotLoader = snapshotLoader
        self.healthDataAvailability = healthDataAvailability
    }

    @MainActor
    func loadPreview() async {
        guard healthDataAvailability() else {
            state = .unavailable("Apple Health data is not available on this device. The main dashboard can continue using mock data.")
            return
        }

        state = .loading

        do {
            let snapshots = try await snapshotLoader(Self.lookbackDays)
            guard let report = HealthKitScoringPreviewReport.make(from: snapshots) else {
                state = .emptyData
                return
            }

            state = .loaded(report)
        } catch {
            state = .failed("HealthKit preview could not be loaded. The main dashboard can continue using mock data.")
        }
    }

    private static func defaultSnapshotLoader(days: Int) async throws -> [DailyHealthSnapshot] {
        await HealthKitDataFetcher().fetchRecentSnapshots(days: days)
    }

    private static func defaultHealthDataAvailability() -> Bool {
        #if canImport(HealthKit)
        return HKHealthStore.isHealthDataAvailable()
        #else
        return false
        #endif
    }
}

struct HealthKitScoringPreviewView: View {
    @StateObject private var viewModel: HealthKitScoringPreviewViewModel

    @MainActor
    init(viewModel: HealthKitScoringPreviewViewModel = HealthKitScoringPreviewViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        List {
            Section("Preview") {
                Button {
                    Task { await viewModel.loadPreview() }
                } label: {
                    Label("Load HealthKit Preview", systemImage: "waveform.path.ecg")
                }
                .disabled(viewModel.state == .loading)

                Text("Local-only developer preview. The production dashboard continues to use mock data.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            content
        }
        .navigationTitle("HealthKit Preview")
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            Section("Status") {
                Text("Ready to load a local preview.")
                    .foregroundStyle(.secondary)
            }
        case .loading:
            Section("Status") {
                HStack {
                    ProgressView()
                    Text("Loading local Apple Health samples...")
                }
            }
        case .loaded(let report):
            loadedContent(report)
        case .emptyData:
            Section("Status") {
                Text("No recent Apple Health samples were available. The main dashboard can continue using mock data.")
                    .foregroundStyle(.secondary)
            }
        case .unavailable(let message), .failed(let message):
            Section("Status") {
                Text(message)
                    .foregroundStyle(.secondary)
            }
        }
    }

    @ViewBuilder
    private func loadedContent(_ report: HealthKitScoringPreviewReport) -> some View {
        Section("Snapshot History") {
            LabeledContent("Snapshots fetched", value: "\(report.snapshotCount)")
            LabeledContent("Latest snapshot", value: formattedDate(report.latestSnapshot.date))
            LabeledContent("Available metrics", value: "\(report.latestAvailableMetricsCount)")
        }

        Section("Baseline") {
            LabeledContent("Window", value: "\(report.baseline.window.dayCount) days")
            LabeledContent("Confidence", value: report.baseline.overallConfidence.rawValue.capitalized)
        }

        if let assessment = report.assessment {
            Section("Assessment") {
                LabeledContent("Overall score", value: "\(assessment.overallScore)")
                LabeledContent("Overall confidence", value: assessment.confidence.rawValue.capitalized)
            }

            Section("Components") {
                ForEach(assessment.components) { component in
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text(component.title)
                                .font(.subheadline.weight(.semibold))
                            Spacer()
                            Text("\(component.score)")
                                .font(.subheadline.monospacedDigit())
                        }
                        Text("Confidence: \(component.confidence.rawValue.capitalized)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }

            Section("Reasons") {
                ForEach(assessment.reasons, id: \.self) { reason in
                    Text(reason)
                }
            }

            Section("Suggestions") {
                ForEach(assessment.suggestions, id: \.self) { suggestion in
                    Text(suggestion)
                }
            }
        } else {
            Section("Assessment") {
                Text("There is not enough recent data to produce a confident preview yet.")
                    .foregroundStyle(.secondary)
            }
        }

        if let sparseDataNotice = report.sparseDataNotice {
            Section("Confidence Notice") {
                Text(sparseDataNotice)
                    .foregroundStyle(.secondary)
            }
        }

        if let missingDataNotice = report.missingDataNotice {
            Section("Missing Data") {
                Text(missingDataNotice)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        date.formatted(date: .abbreviated, time: .omitted)
    }
}

#Preview {
    NavigationStack {
        HealthKitScoringPreviewView(
            viewModel: HealthKitScoringPreviewViewModel(
                snapshotLoader: { _ in MockSampleData.weeklySnapshots },
                healthDataAvailability: { true }
            )
        )
    }
}
#endif
