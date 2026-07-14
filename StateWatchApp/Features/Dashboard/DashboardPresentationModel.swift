import Foundation
import SwiftUI

struct DashboardPresentationModel {
    static let demoTrendValues: [Double] = [62, 67, 64, 72, 70, 76, 74]
    static let lowDataFallbackNotice = "Recent Apple Health data is limited. Showing demo data."
    static let unavailableFallbackNotice = "Apple Health data is unavailable. Showing demo data."

    let assessment: StateAssessment
    let source: DashboardAssessmentSource
    let score: Int
    let stateLabel: String
    let confidence: ScoreConfidence
    let sourceBadgeText: String
    let updatedText: String
    let noticeText: String?
    let noticeAccessibilityLabel: String?
    let summary: String
    let accentColor: Color
    let metrics: [DashboardMetricDisplay]
    let reasons: [String]
    let suggestion: String
    let showsTrendChart: Bool
    let trendValues: [Double]
    let trendCaption: String
    let trendUnavailableTitle: String?
    let trendUnavailableMessage: String?

    init(result: DashboardAssessmentResult) {
        assessment = result.assessment
        source = result.source
        score = StateWatchTheme.clampedScore(result.assessment.overallScore)
        stateLabel = result.assessment.level.rawValue
        confidence = result.assessment.confidence
        summary = Self.summary(for: result.assessment.level)
        accentColor = StateWatchTheme.stateLabelColor(for: result.assessment.level)
        metrics = result.assessment.components.map(DashboardMetricDisplay.init(component:))
        reasons = result.assessment.reasons
        suggestion = result.assessment.primarySuggestion

        switch result.source {
        case .mock:
            sourceBadgeText = "Demo wellness estimate"
            updatedText = "Demo data - Updated \(Self.formattedTime(for: result.assessment.date))"
            noticeText = nil
            showsTrendChart = true
            trendValues = Self.demoTrendValues
            trendCaption = "Demo data"
            trendUnavailableTitle = nil
            trendUnavailableMessage = nil

        case .healthKitDerived:
            sourceBadgeText = "On-device wellness estimate"
            updatedText = "On-device data - Updated \(Self.formattedTime(for: result.assessment.date))"
            noticeText = result.notice
            showsTrendChart = false
            trendValues = []
            trendCaption = "Unavailable"
            trendUnavailableTitle = "Trend unavailable"
            trendUnavailableMessage = "A validated on-device trend is not available yet."

        case .lowDataFallback:
            sourceBadgeText = "Demo wellness estimate"
            updatedText = "Demo data - Updated \(Self.formattedTime(for: result.assessment.date))"
            noticeText = result.notice ?? Self.lowDataFallbackNotice
            showsTrendChart = true
            trendValues = Self.demoTrendValues
            trendCaption = "Demo data"
            trendUnavailableTitle = nil
            trendUnavailableMessage = nil

        case .fallback:
            sourceBadgeText = "Demo wellness estimate"
            updatedText = "Demo data - Updated \(Self.formattedTime(for: result.assessment.date))"
            noticeText = result.notice ?? Self.unavailableFallbackNotice
            showsTrendChart = true
            trendValues = Self.demoTrendValues
            trendCaption = "Demo data"
            trendUnavailableTitle = nil
            trendUnavailableMessage = nil
        }

        noticeAccessibilityLabel = noticeText.map { "Dashboard information. \($0)" }
    }

    init(assessment: StateAssessment) {
        self.init(result: DashboardAssessmentResult(assessment: assessment, source: .mock, notice: nil))
    }

    var accessibilitySummary: String {
        "\(sourceBadgeText). Score \(score). \(stateLabel). Confidence \(StateWatchTheme.confidenceLabel(for: confidence))."
    }

    var trendAccessibilitySummary: String {
        if showsTrendChart {
            return "7-day trend. \(trendCaption)."
        }

        return ["7-day trend", trendUnavailableTitle, trendUnavailableMessage]
            .compactMap { $0 }
            .joined(separator: ". ")
    }

    var searchableText: String {
        (
            [
                sourceBadgeText,
                updatedText,
                "Score \(score)",
                stateLabel,
                "Confidence \(StateWatchTheme.confidenceLabel(for: confidence))",
                summary,
                suggestion,
                noticeText ?? "",
                trendCaption,
                trendUnavailableTitle ?? "",
                trendUnavailableMessage ?? ""
            ]
                + reasons
                + metrics.flatMap { [$0.title, $0.value, $0.subtitle] }
        ).joined(separator: " ")
    }

    private static func summary(for level: StateLevel) -> String {
        switch level {
        case .steady:
            return "Your recent signals look steady."
        case .mixed:
            return "Your recent signals look mixed."
        case .low:
            return "Recent signals are softer than your recent pattern."
        case .needsRest:
            return "Recent signals support a gentler plan if that matches how you feel."
        }
    }

    private static func formattedTime(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

typealias DashboardDisplayModel = DashboardPresentationModel

struct DashboardMetricDisplay: Identifiable {
    let id: String
    let title: String
    let value: String
    let subtitle: String
    let progress: Double
    let accentColor: Color

    init(component: ScoreComponent) {
        id = component.id
        title = Self.displayTitle(for: component)
        value = "\(StateWatchTheme.clampedScore(component.score))"
        subtitle = component.summary
        progress = Double(StateWatchTheme.clampedScore(component.score)) / 100
        accentColor = Self.accentColor(for: component)
    }

    private static func displayTitle(for component: ScoreComponent) -> String {
        component.id == "stressFatigue" ? "Fatigue Context" : component.title
    }

    private static func accentColor(for component: ScoreComponent) -> Color {
        switch component.id {
        case "recovery":
            return StateWatchColors.recoveryGreen
        case "sleep":
            return StateWatchColors.accentCyan
        case "stressFatigue":
            return StateWatchColors.cautionAmber
        case "activityLoad":
            return StateWatchColors.accentBlue
        default:
            return StateWatchTheme.scoreColor(for: component.score)
        }
    }
}
