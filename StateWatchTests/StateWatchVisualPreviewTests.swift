import XCTest
@testable import StateWatchApp

#if DEBUG
final class StateWatchVisualPreviewTests: XCTestCase {
    func testLowDataCopyIsCalmAndNonMedical() {
        let content = StateWatchVisualPreviewState.lowData.content

        XCTAssertEqual(content.summary, "Recent data is limited, so this estimate is cautious.")
        XCTAssertEqual(content.confidence, .low)
        XCTAssertNoForbiddenMedicalWording(in: content.searchableText)
    }

    func testUnavailableCopyKeepsDemoFallback() {
        let content = StateWatchVisualPreviewState.unavailable.content

        XCTAssertTrue(content.summary.contains("StateWatch can keep showing demo data"))
        XCTAssertEqual(content.confidence, .unavailable)
        XCTAssertTrue(content.metrics.allSatisfy { $0.value == "--" })
        XCTAssertNoForbiddenMedicalWording(in: content.searchableText)
    }

    func testNormalPreviewUsesMockVisualDataOnly() {
        let content = StateWatchVisualPreviewState.normal.content

        XCTAssertEqual(content.score, 76)
        XCTAssertEqual(content.label, "Mixed")
        XCTAssertEqual(content.trendCaption, "Mock data")
        XCTAssertEqual(content.trendValues, [62, 67, 64, 72, 70, 76, 74])
        XCTAssertEqual(content.metrics.count, 4)
    }

    func testAllPreviewStatesUseCalmNonMedicalCopy() {
        for state in StateWatchVisualPreviewState.allCases {
            XCTAssertNoForbiddenMedicalWording(
                in: state.content.searchableText,
                "Unexpected forbidden wording in \(state.title)"
            )
        }
    }

    func testVisualPreviewStatesAreStaticMockContent() {
        let normal = StateWatchVisualPreviewState.normal.content
        let lowData = StateWatchVisualPreviewState.lowData.content
        let unavailable = StateWatchVisualPreviewState.unavailable.content

        XCTAssertEqual(normal.trendCaption, "Mock data")
        XCTAssertEqual(lowData.trendCaption, "Limited")
        XCTAssertEqual(unavailable.trendCaption, "No data")
        XCTAssertEqual(Set(StateWatchVisualPreviewState.allCases.map(\.title)), ["Normal", "Low Data", "Unavailable"])
    }

    private func XCTAssertNoForbiddenMedicalWording(
        in text: String,
        _ message: String = "Unexpected medical-style wording",
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        for forbiddenTerm in [
            "diagnos",
            "disease",
            "illness",
            "clinical stress",
            "detect",
            "treatment",
            "prevention",
            "health risk",
            "warning"
        ] {
            XCTAssertFalse(
                text.localizedCaseInsensitiveContains(forbiddenTerm),
                "\(message): \(forbiddenTerm)",
                file: file,
                line: line
            )
        }
    }
}

private extension StateWatchVisualPreviewContent {
    var searchableText: String {
        (
            [label, updatedText, kicker, summary, suggestion, trendCaption]
                + reasons
                + metrics.flatMap { [$0.title, $0.value, $0.subtitle] }
        ).joined(separator: " ")
    }
}
#endif
