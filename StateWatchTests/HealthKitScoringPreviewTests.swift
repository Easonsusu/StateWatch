import XCTest
@testable import StateWatchApp

@MainActor
final class HealthKitScoringPreviewTests: XCTestCase {
    func testUnavailableStateWhenHealthDataIsNotAvailable() async {
        let viewModel = HealthKitScoringPreviewViewModel(
            snapshotLoader: { _ in XCTFail("Snapshot loader should not run when HealthKit is unavailable"); return [] },
            healthDataAvailability: { false }
        )

        await viewModel.loadPreview()

        guard case .unavailable(let message) = viewModel.state else {
            return XCTFail("Expected unavailable state, got \(viewModel.state)")
        }
        XCTAssertTrue(message.localizedCaseInsensitiveContains("not available"))
    }

    func testFailedStateWhenSnapshotLoaderThrows() async {
        let viewModel = HealthKitScoringPreviewViewModel(
            snapshotLoader: { _ in throw PreviewLoaderError.failed },
            healthDataAvailability: { true }
        )

        await viewModel.loadPreview()

        guard case .failed(let message) = viewModel.state else {
            return XCTFail("Expected failed state, got \(viewModel.state)")
        }
        XCTAssertTrue(message.localizedCaseInsensitiveContains("could not be loaded"))
    }

    func testEmptyDataStateWhenSnapshotsContainNoMetrics() async {
        let snapshots = (1...3).map { DailyHealthSnapshot(date: date(day: $0)) }
        let viewModel = HealthKitScoringPreviewViewModel(
            snapshotLoader: { _ in snapshots },
            healthDataAvailability: { true }
        )

        await viewModel.loadPreview()

        XCTAssertEqual(viewModel.state, .emptyData)
    }

    func testDashboardDefaultsToMockAssessment() {
        let dashboard = DashboardView()

        XCTAssertEqual(dashboard.assessment, .mock)
    }

    func testPreviewReportCanBeCreatedFromMockSnapshots() throws {
        let report = try XCTUnwrap(HealthKitScoringPreviewReport.make(from: MockSampleData.weeklySnapshots))

        XCTAssertEqual(report.snapshotCount, MockSampleData.weeklySnapshots.count)
        XCTAssertEqual(report.latestSnapshot, MockSampleData.weeklySnapshots.sorted { $0.date < $1.date }.last)
        XCTAssertGreaterThan(report.latestAvailableMetricsCount, 0)
        XCTAssertNotNil(report.assessment)
    }

    func testPreviewReportBuildsBaselineAssessmentAndMissingDataNotice() throws {
        let history = (1...8).map { day in
            DailyHealthSnapshot(
                date: date(day: day),
                restingHeartRate: day == 8 ? 64 : 58,
                heartRateVariability: day == 8 ? 50 : 62,
                sleepDurationHours: day == 8 ? 6.2 : 7.4,
                activeEnergyKcal: day == 8 ? nil : 520,
                exerciseMinutes: 32,
                stepCount: day == 8 ? nil : 8_000
            )
        }

        let report = try XCTUnwrap(HealthKitScoringPreviewReport.make(from: history))

        XCTAssertEqual(report.snapshotCount, 8)
        XCTAssertEqual(report.latestSnapshot.date, date(day: 8))
        XCTAssertEqual(report.latestAvailableMetricsCount, 4)
        XCTAssertEqual(report.baseline.window, .thirtyDays)
        XCTAssertEqual(report.baseline.overallConfidence, .high)
        XCTAssertNotNil(report.assessment)
        XCTAssertNotNil(report.missingDataNotice)
    }

    func testSparseHistoryShowsNotEnoughConfidentPreviewNotice() throws {
        let history = [
            DailyHealthSnapshot(
                date: date(day: 1),
                restingHeartRate: 60,
                heartRateVariability: 55,
                sleepDurationHours: 6.8
            )
        ]

        let report = try XCTUnwrap(HealthKitScoringPreviewReport.make(from: history))

        XCTAssertEqual(report.baseline.overallConfidence, .unavailable)
        XCTAssertEqual(report.assessment?.confidence, .low)
        XCTAssertEqual(report.sparseDataNotice, "There is not enough recent data to produce a confident preview yet.")
    }

    private func date(day: Int) -> Date {
        let components = DateComponents(timeZone: TimeZone(secondsFromGMT: 0), year: 2026, month: 1, day: day)
        return Calendar(identifier: .gregorian).date(from: components) ?? Date(timeIntervalSince1970: 0)
    }

    private enum PreviewLoaderError: Error {
        case failed
    }
}
