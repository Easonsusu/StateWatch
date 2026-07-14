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
                assessment: healthKitAssessment,
                source: .healthKitDerived,
                notice: nil
            )
        )
        let presentationText = [model.searchableText, model.accessibilitySummary, model.trendAccessibilitySummary]
            .joined(separator: " ")

        XCTAssertEqual(model.score, 84)
        XCTAssertEqual(model.stateLabel, "Steady")
        XCTAssertEqual(model.confidence, .high)
        XCTAssertEqual(model.sourceBadgeText, "On-device wellness estimate")
        XCTAssertFalse(model.updatedText.contains("Demo"))
        XCTAssertNil(model.noticeText)
        XCTAssertNil(model.noticeAccessibilityLabel)
        XCTAssertFalse(model.showsTrendChart)
        XCTAssertEqual(model.trendValues, [])
        XCTAssertEqual(model.trendUnavailableTitle, "Trend unavailable")
        XCTAssertEqual(model.trendUnavailableMessage, "A validated on-device trend is not available yet.")

        for forbiddenDemoTerm in ["Mock wellness estimate", "Demo wellness estimate", "Demo data", "Mock data"] {
            XCTAssertFalse(presentationText.localizedCaseInsensitiveContains(forbiddenDemoTerm))
        }
    }

    func testHealthKitDerivedPresentationPreservesExplicitSafeNotice() {
        let notice = "Some on-device details are not available yet."
        let model = DashboardPresentationModel(
            result: DashboardAssessmentResult(
                assessment: healthKitAssessment,
                source: .healthKitDerived,
                notice: notice
            )
        )
        let presentationText = [model.searchableText, model.accessibilitySummary, model.trendAccessibilitySummary]
            .joined(separator: " ")

        XCTAssertEqual(model.noticeText, notice)
        XCTAssertTrue(model.noticeAccessibilityLabel?.contains(notice) == true)
        XCTAssertEqual(model.sourceBadgeText, "On-device wellness estimate")
        XCTAssertFalse(model.showsTrendChart)
        XCTAssertEqual(model.trendValues, [])

        for forbiddenTerm in ["mock", "demo", "diagnos", "disease", "clinical stress", "treatment", "warning", "emergency", "abnormal state", "health risk"] {
            XCTAssertFalse(presentationText.localizedCaseInsensitiveContains(forbiddenTerm))
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

    private var healthKitAssessment: StateAssessment {
        StateAssessment(
            date: Date(timeIntervalSince1970: 1_735_689_600),
            overallScore: 84,
            level: .steady,
            recovery: ScoreComponent(id: "recovery", title: "Recovery", score: 86, confidence: .high, summary: "Recovery context is steady."),
            sleep: ScoreComponent(id: "sleep", title: "Sleep", score: 82, confidence: .high, summary: "Sleep context is steady."),
            stressFatigue: ScoreComponent(id: "stressFatigue", title: "Fatigue Context", score: 79, confidence: .high, summary: "Fatigue context is steady."),
            activityLoad: ScoreComponent(id: "activityLoad", title: "Activity Load", score: 88, confidence: .high, summary: "Activity load is steady."),
            confidence: .high,
            reasons: ["Recent on-device signals are steady."],
            suggestions: ["Today may be a good day to keep things steady."]
        )
    }
}
