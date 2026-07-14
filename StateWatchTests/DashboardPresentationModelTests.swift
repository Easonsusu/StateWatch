import XCTest
@testable import StateWatchApp

final class DashboardPresentationModelTests: XCTestCase {
    func testMockPresentationClearlyUsesDemoData() {
        let model = DashboardPresentationModel(
            result: DashboardAssessmentResult(
                assessment: .mock,
                source: .mock,
                notice: "This source should not show a fallback notice."
            )
        )

        XCTAssertEqual(model.sourceBadgeText, "Demo wellness estimate")
        XCTAssertTrue(model.updatedText.contains("Demo data"))
        XCTAssertNil(model.noticeText)
        XCTAssertTrue(model.showsTrendChart)
        XCTAssertEqual(model.trendValues, DashboardPresentationModel.demoTrendValues)
        XCTAssertEqual(model.trendCaption, "Demo data")
        XCTAssertTrue(model.searchableText.contains("Demo wellness estimate"))
    }

    func testHealthKitDerivedPresentationDoesNotShowDemoTrendOrCopy() {
        let model = DashboardPresentationModel(
            result: DashboardAssessmentResult(
                assessment: .mock,
                source: .healthKitDerived,
                notice: "This source should not show a fallback notice."
            )
        )
        let presentationText = [model.searchableText, model.accessibilitySummary, model.trendAccessibilitySummary]
            .joined(separator: " ")

        XCTAssertEqual(model.sourceBadgeText, "On-device wellness estimate")
        XCTAssertFalse(model.updatedText.contains("Demo"))
        XCTAssertNil(model.noticeText)
        XCTAssertFalse(model.showsTrendChart)
        XCTAssertEqual(model.trendValues, [])
        XCTAssertEqual(model.trendUnavailableTitle, "Trend unavailable")
        XCTAssertEqual(model.trendUnavailableMessage, "A validated on-device trend is not available yet.")

        for forbiddenDemoTerm in ["Mock wellness estimate", "Demo wellness estimate", "Demo data", "Mock data"] {
            XCTAssertFalse(presentationText.localizedCaseInsensitiveContains(forbiddenDemoTerm))
        }
    }

    func testLowDataFallbackKeepsSafeAssessmentAndDisclosesDemoData() {
        let model = DashboardPresentationModel(
            result: DashboardAssessmentResult(
                assessment: .mock,
                source: .lowDataFallback,
                notice: DashboardPresentationModel.lowDataFallbackNotice
            )
        )

        XCTAssertEqual(model.score, 76)
        XCTAssertEqual(model.stateLabel, "Mixed")
        XCTAssertEqual(model.sourceBadgeText, "Demo wellness estimate")
        XCTAssertEqual(model.noticeText, "Recent Apple Health data is limited. Showing demo data.")
        XCTAssertEqual(model.noticeAccessibilityLabel, "Dashboard information. Recent Apple Health data is limited. Showing demo data.")
        XCTAssertTrue(model.showsTrendChart)
        XCTAssertEqual(model.trendCaption, "Demo data")
    }

    func testUnavailableFallbackKeepsSafeAssessmentAndDisclosesDemoData() {
        let model = DashboardPresentationModel(
            result: DashboardAssessmentResult(
                assessment: .mock,
                source: .fallback,
                notice: DashboardPresentationModel.unavailableFallbackNotice
            )
        )

        XCTAssertEqual(model.score, 76)
        XCTAssertEqual(model.stateLabel, "Mixed")
        XCTAssertEqual(model.sourceBadgeText, "Demo wellness estimate")
        XCTAssertEqual(model.noticeText, "Apple Health data is unavailable. Showing demo data.")
        XCTAssertTrue(model.showsTrendChart)
        XCTAssertEqual(model.trendValues, DashboardPresentationModel.demoTrendValues)
    }

    func testAccessibilityAndSearchableTextReflectCurrentPresentation() {
        let model = DashboardPresentationModel(
            result: DashboardAssessmentResult(
                assessment: .mock,
                source: .lowDataFallback,
                notice: DashboardPresentationModel.lowDataFallbackNotice
            )
        )
        let presentationText = [model.accessibilitySummary, model.searchableText, model.noticeAccessibilityLabel ?? ""]
            .joined(separator: " ")

        for expectedTerm in ["Demo wellness estimate", "76", "Mixed", "Medium", "Recent Apple Health data is limited", "Demo data"] {
            XCTAssertTrue(presentationText.localizedCaseInsensitiveContains(expectedTerm))
        }

        for forbiddenTerm in ["diagnos", "disease", "clinical stress", "treatment", "warning", "emergency", "abnormal state", "health risk"] {
            XCTAssertFalse(presentationText.localizedCaseInsensitiveContains(forbiddenTerm))
        }
    }
}
