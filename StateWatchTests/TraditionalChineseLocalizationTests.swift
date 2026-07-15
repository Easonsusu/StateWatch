import Foundation
import XCTest
@testable import StateWatchApp

final class TraditionalChineseLocalizationTests: XCTestCase {
    func testCatalogUsesEnglishSourceAndCompleteTraditionalChineseTranslations() throws {
        let catalog = try catalogJSON()
        XCTAssertEqual(catalog["sourceLanguage"] as? String, "en")

        let strings = try XCTUnwrap(catalog["strings"] as? [String: Any])
        XCTAssertFalse(strings.isEmpty)

        for key in requiredProductionKeys {
            let translation = try translation(for: key, in: strings)
            XCTAssertFalse(translation.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            XCTAssertFalse(translation.localizedCaseInsensitiveContains("TODO"))
            XCTAssertFalse(translation.localizedCaseInsensitiveContains("TBD"))
        }

        for key in strings.keys.sorted() {
            _ = try translation(for: key, in: strings)
        }
    }

    func testTraditionalChineseCopyPreservesPrivacyAndWellnessSafetyMeaning() throws {
        let text = try combinedTraditionalChineseTranslations()
        let requiredConcepts = [
            "不是醫療器材",
            "不會診斷",
            "不提供醫療建議",
            "選用",
            "僅供讀取",
            "在裝置上處理",
            "不會上傳",
            "原始 Apple「健康」樣本",
            "App Group",
            "不會發布到 Apple Watch、WidgetKit 或 App Group",
            "模擬資料",
            "資料不足",
            "無法使用"
        ]

        for concept in requiredConcepts {
            XCTAssertTrue(text.contains(concept), "Missing required safety concept: \(concept)")
        }
    }

    func testTraditionalChineseCopyDoesNotMakeForbiddenClaims() throws {
        let text = try combinedTraditionalChineseTranslations()
        let forbiddenClaims = [
            "疾病偵測",
            "偵測到疾病",
            "異常狀態",
            "健康風險",
            "緊急警示",
            "醫療診斷",
            "治療建議",
            "即時監控",
            "持續監控",
            "完全匿名",
            "零資料留存",
            "符合 HIPAA",
            "符合 GDPR",
            "全面加密"
        ]

        XCTAssertTrue(text.contains("不會診斷"))
        for claim in forbiddenClaims {
            XCTAssertFalse(text.contains(claim), "Unexpected unsupported claim: \(claim)")
        }
    }

    func testTraditionalChineseCopyDoesNotContainCommonSimplifiedChineseTerms() throws {
        let text = try combinedTraditionalChineseTranslations()
        for term in ["设置", "隐私", "数据", "健康权限", "设备", "上传", "诊断", "继续", "用户"] {
            XCTAssertFalse(text.contains(term), "Unexpected Simplified Chinese term: \(term)")
        }
    }

    func testStableStorageAndSemanticValuesRemainUnchanged() throws {
        XCTAssertEqual(UserDefaultsOnboardingCompletionStore.storageKey, "statewatch.onboarding.completed.v1")
        XCTAssertEqual(SharedReadinessStore.appGroupIdentifier, "group.com.easonsusu.StateWatch")
        XCTAssertEqual(SharedReadinessStore.storageKey, "statewatch.shared.readiness.summary.v1")
        XCTAssertEqual(MockDashboardSharedStatePublisher.source, "iphone-mock-dashboard")
        XCTAssertEqual(StateLevel.allCases.map(\.rawValue), ["Steady", "Mixed", "Low", "Needs Rest"])
        XCTAssertEqual(UserCheckIn.Mood.allCases.map(\.rawValue), ["Low", "Neutral", "Good"])
        XCTAssertEqual(UserCheckIn.Intensity.allCases.map(\.rawValue), ["Low", "Medium", "High"])
        XCTAssertEqual(
            HealthKitPermissionID.allCases.map(\.rawValue),
            [
                "heartRate",
                "restingHeartRate",
                "heartRateVariabilitySDNN",
                "sleepAnalysis",
                "stepCount",
                "activeEnergyBurned",
                "workouts"
            ]
        )

        let strings = try XCTUnwrap(try catalogJSON()["strings"] as? [String: Any])
        for stableValue in [
            "statewatch.onboarding.completed.v1",
            "statewatch.shared.readiness.summary.v1",
            "iphone-mock-dashboard",
            "static-watch-mock"
        ] {
            XCTAssertNil(strings[stableValue], "Stable identifier must not become a localization key")
        }
    }

    func testCatalogBelongsOnlyToIPhoneResourcesAndProjectKeepsEnglishDevelopmentLanguage() throws {
        let project = try projectFile()
        let resourceBuildID = try buildFileID(
            for: "Localizable.xcstrings in Resources",
            in: project
        )

        XCTAssertTrue(project.contains("path = StateWatchApp/Resources/Localizable.xcstrings;"))
        XCTAssertTrue(projectBlock(id: "166A09B4A5A2A8BE7565A775", in: project).contains(resourceBuildID))
        XCTAssertFalse(projectBlock(id: "DDD6FE7A96F211931B4C861E", in: project).contains(resourceBuildID))
        XCTAssertFalse(projectBlock(id: "2BD6B9B82414E6AB1198F133", in: project).contains(resourceBuildID))
        XCTAssertFalse(projectBlock(id: "F64200000000000000000003", in: project).contains(resourceBuildID))
        XCTAssertEqual(project.components(separatedBy: "Localizable.xcstrings in Resources").count - 1, 2)
        XCTAssertTrue(project.contains("developmentRegion = en;"))
        XCTAssertTrue(project.contains("\n\t\t\t\t\"zh-Hant\",\n"))
    }

    func testLocalizationTestsBelongOnlyToTestTarget() throws {
        let project = try projectFile()
        let testBuildID = try buildFileID(
            for: "TraditionalChineseLocalizationTests.swift in Sources",
            in: project
        )

        XCTAssertTrue(projectBlock(id: "B6F43314D0693B2B792DAE17", in: project).contains(testBuildID))
        XCTAssertFalse(projectBlock(id: "3EB653855794ACB8194696BC", in: project).contains(testBuildID))
        XCTAssertFalse(projectBlock(id: "8CA58B3836539C87BAF378EB", in: project).contains(testBuildID))
        XCTAssertFalse(projectBlock(id: "F64200000000000000000001", in: project).contains(testBuildID))
    }

    private let requiredProductionKeys = [
        "Welcome",
        "Wellness only",
        "StateWatch is not a medical device. It does not diagnose, treat, cure, or prevent any disease, and it does not provide medical advice. If you have medical concerns, consult a qualified healthcare professional.",
        "Apple Health Access",
        "Continue with Mock Data",
        "Today",
        "Demo wellness estimate",
        "Recent Apple Health data is limited. Showing demo data.",
        "Apple Health data is unavailable. Showing demo data.",
        "Low data",
        "Unavailable",
        "Recovery",
        "Sleep",
        "Fatigue Context",
        "Activity Load",
        "Today's suggestion",
        "7-day trend",
        "Trends",
        "Check-In",
        "Settings",
        "Privacy",
        "Health Permissions",
        "Optional Apple Health access is read-only, and available data is processed on device.",
        "StateWatch does not upload Apple Health data to any server in the MVP.",
        "Raw Apple Health samples are not stored in shared App Group state or uploaded.",
        "HealthKit-derived Dashboard output is not published to Watch, WidgetKit, or the App Group."
    ]

    private func catalogJSON() throws -> [String: Any] {
        let data = try Data(contentsOf: repositoryRoot.appendingPathComponent("StateWatchApp/Resources/Localizable.xcstrings"))
        return try XCTUnwrap(JSONSerialization.jsonObject(with: data) as? [String: Any])
    }

    private func translation(for key: String, in strings: [String: Any]) throws -> String {
        let entry = try XCTUnwrap(strings[key] as? [String: Any], "Missing localization key: \(key)")
        let localizations = try XCTUnwrap(entry["localizations"] as? [String: Any])
        let traditionalChinese = try XCTUnwrap(localizations["zh-Hant"] as? [String: Any])
        let stringUnit = try XCTUnwrap(traditionalChinese["stringUnit"] as? [String: Any])
        XCTAssertEqual(stringUnit["state"] as? String, "translated", "Translation is not complete: \(key)")
        return try XCTUnwrap(stringUnit["value"] as? String)
    }

    private func combinedTraditionalChineseTranslations() throws -> String {
        let strings = try XCTUnwrap(try catalogJSON()["strings"] as? [String: Any])
        return try strings.keys.sorted().map { try translation(for: $0, in: strings) }.joined(separator: "\n")
    }

    private func projectFile() throws -> String {
        try String(
            contentsOf: repositoryRoot.appendingPathComponent("StateWatch.xcodeproj/project.pbxproj"),
            encoding: .utf8
        )
    }

    private func buildFileID(for comment: String, in project: String) throws -> String {
        let escapedComment = NSRegularExpression.escapedPattern(for: comment)
        let expression = try NSRegularExpression(
            pattern: "([A-F0-9]{24}) /\\* \(escapedComment) \\*/ = \\{isa = PBXBuildFile;"
        )
        let range = NSRange(project.startIndex..<project.endIndex, in: project)
        let match = try XCTUnwrap(expression.firstMatch(in: project, range: range))
        let idRange = try XCTUnwrap(Range(match.range(at: 1), in: project))
        return String(project[idRange])
    }

    private func projectBlock(id: String, in project: String) -> String {
        guard let start = project.range(of: "\n\t\t\(id) /*")?.lowerBound else {
            return ""
        }
        let suffix = project[start...]
        guard let end = suffix.range(of: "\n\t\t};")?.upperBound else {
            return ""
        }
        return String(project[start..<end])
    }

    private var repositoryRoot: URL {
        URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
    }
}
