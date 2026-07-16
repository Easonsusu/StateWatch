import Foundation
import XCTest
@testable import StateWatchApp

final class WatchTraditionalChineseLocalizationTests: XCTestCase {
    func testWatchAndComplicationCatalogsUseEnglishSourceAndCompleteTraditionalChineseTranslations() throws {
        for specification in catalogSpecifications {
            let catalog = try catalogJSON(at: specification.path)
            XCTAssertEqual(catalog["sourceLanguage"] as? String, "en", specification.path)

            let strings = try XCTUnwrap(catalog["strings"] as? [String: Any])
            XCTAssertFalse(strings.isEmpty, specification.path)

            for key in specification.requiredKeys {
                _ = try translation(for: key, in: strings)
            }

            for key in strings.keys.sorted() {
                let value = try translation(for: key, in: strings)
                let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
                XCTAssertFalse(trimmed.isEmpty, "Empty zh-Hant translation for \(key)")
                XCTAssertFalse(trimmed.localizedCaseInsensitiveContains("TODO"), key)
                XCTAssertFalse(trimmed.localizedCaseInsensitiveContains("TBD"), key)
                XCTAssertFalse(removingPlaceholders(from: trimmed).trimmingCharacters(in: .punctuationCharacters.union(.whitespacesAndNewlines)).isEmpty, "Placeholder-only translation for \(key)")
            }
        }
    }

    func testFormattedTranslationsPreserveSourcePlaceholders() throws {
        for specification in catalogSpecifications {
            let strings = try XCTUnwrap(try catalogJSON(at: specification.path)["strings"] as? [String: Any])

            for key in strings.keys.sorted() {
                XCTAssertEqual(
                    placeholders(in: try translation(for: key, in: strings)),
                    placeholders(in: key),
                    "Placeholder mismatch for \(key) in \(specification.path)"
                )
            }
        }
    }

    func testTraditionalChineseCopyIncludesRequiredWatchAndComplicationConcepts() throws {
        let watchText = try combinedTranslations(at: watchCatalogPath)
        for concept in [
            "模擬資料",
            "狀態估計",
            "可信度",
            "資料不足",
            "無法使用",
            "狀態記錄",
            "選用",
            "本機",
            "只會從這支 Apple Watch 移除",
            "有活力",
            "穩定",
            "疲累",
            "低狀態"
        ] {
            XCTAssertTrue(watchText.contains(concept), "Missing Watch concept: \(concept)")
        }

        let complicationText = try combinedTranslations(at: complicationCatalogPath)
        for concept in ["模擬", "狀態", "綜合", "穩定", "較低", "適合放慢步調"] {
            XCTAssertTrue(complicationText.contains(concept), "Missing complication concept: \(concept)")
        }
    }

    func testTraditionalChineseCopyDoesNotContainForbiddenClaimsOrSimplifiedChineseTerms() throws {
        let text = try [watchCatalogPath, complicationCatalogPath]
            .map { try combinedTranslations(at: $0) }
            .joined(separator: "\n")

        for claim in [
            "疾病偵測",
            "偵測到疾病",
            "醫療診斷",
            "治療建議",
            "異常狀態",
            "健康風險",
            "緊急警示",
            "即時監控",
            "持續監控",
            "完全匿名",
            "零資料留存",
            "符合 HIPAA",
            "符合 GDPR",
            "全面加密"
        ] {
            XCTAssertFalse(text.contains(claim), "Unexpected claim: \(claim)")
        }

        for term in [
            "设置", "隐私", "数据", "权限", "设备", "上传", "诊断", "继续",
            "用户", "删除", "选择", "状态", "记录", "疲劳"
        ] {
            XCTAssertFalse(text.contains(term), "Unexpected Simplified Chinese term: \(term)")
        }
    }

    func testSharedTranslationsMatchApprovedIPhoneCatalogTerminology() throws {
        let iphoneStrings = try strings(at: iphoneCatalogPath)

        for path in [watchCatalogPath, complicationCatalogPath] {
            let strings = try strings(at: path)
            for key in Set(strings.keys).intersection(iphoneStrings.keys).sorted() {
                if path == watchCatalogPath, key == "Low" {
                    continue
                }

                XCTAssertEqual(
                    try translation(for: key, in: strings),
                    try translation(for: key, in: iphoneStrings),
                    "Inconsistent approved translation for \(key) in \(path)"
                )
            }
        }

        let watchStrings = try strings(at: watchCatalogPath)
        XCTAssertEqual(try translation(for: "Low", in: watchStrings), "低狀態")
        XCTAssertEqual(
            try translation(for: "Low readiness", in: watchStrings),
            try translation(for: "Low", in: iphoneStrings)
        )
    }

    func testStableRawStorageSharedAndWidgetValuesRemainUnchanged() {
        XCTAssertEqual(StateCheckInOption.allCases.map(\.rawValue), ["energized", "stable", "tired", "low"])
        XCTAssertEqual(StateCheckInDisplayMode.allCases.map(\.rawValue), ["iconAndText", "iconOnly", "textOnly"])
        XCTAssertEqual(LocalStateCheckInStore.storageFileName, "statewatch-watch-checkins-v1.json")
        XCTAssertEqual(LocalStateCheckInDisplayPreferenceStore.storageKey, "statewatch.watchCheckIn.displayMode.v1")
        XCTAssertEqual(SharedReadinessStore.appGroupIdentifier, "group.com.easonsusu.StateWatch")
        XCTAssertEqual(SharedReadinessStore.storageKey, "statewatch.shared.readiness.summary.v1")
        XCTAssertEqual(SharedReadinessSummary.currentSchemaVersion, 1)
        XCTAssertEqual(MockDashboardSharedStatePublisher.source, "iphone-mock-dashboard")
        XCTAssertEqual(WatchDashboardDisplayModel(assessment: .mock).source, "static-watch-mock")
    }

    func testCatalogsAndLocalizationCodeHaveOnlyTheirIntendedTargetMembership() throws {
        let project = try projectFile()

        let iphoneCatalog = try buildFileID(for: "Localizable.xcstrings in Resources", in: project)
        let watchCatalog = try buildFileID(for: "Watch Localization Catalog in Resources", in: project)
        let complicationCatalog = try buildFileID(for: "Complication Localization Catalog in Resources", in: project)
        let watchHelper = try buildFileID(for: "WatchLocalization.swift in Sources", in: project)
        let localizationTests = try buildFileID(for: "WatchTraditionalChineseLocalizationTests.swift in Sources", in: project)

        let iphoneResources = projectBlock(id: "166A09B4A5A2A8BE7565A775", in: project)
        let watchResources = projectBlock(id: "DDD6FE7A96F211931B4C861E", in: project)
        let testResources = projectBlock(id: "2BD6B9B82414E6AB1198F133", in: project)
        let complicationResources = projectBlock(id: "F64200000000000000000003", in: project)

        XCTAssertTrue(iphoneResources.contains(iphoneCatalog))
        XCTAssertFalse(watchResources.contains(iphoneCatalog))
        XCTAssertFalse(testResources.contains(iphoneCatalog))
        XCTAssertFalse(complicationResources.contains(iphoneCatalog))

        XCTAssertTrue(watchResources.contains(watchCatalog))
        XCTAssertFalse(iphoneResources.contains(watchCatalog))
        XCTAssertFalse(testResources.contains(watchCatalog))
        XCTAssertFalse(complicationResources.contains(watchCatalog))

        XCTAssertTrue(complicationResources.contains(complicationCatalog))
        XCTAssertFalse(iphoneResources.contains(complicationCatalog))
        XCTAssertFalse(watchResources.contains(complicationCatalog))
        XCTAssertFalse(testResources.contains(complicationCatalog))

        let iphoneSources = projectBlock(id: "3EB653855794ACB8194696BC", in: project)
        let watchSources = projectBlock(id: "8CA58B3836539C87BAF378EB", in: project)
        let testSources = projectBlock(id: "B6F43314D0693B2B792DAE17", in: project)
        let complicationSources = projectBlock(id: "F64200000000000000000001", in: project)

        XCTAssertTrue(watchSources.contains(watchHelper))
        XCTAssertFalse(iphoneSources.contains(watchHelper))
        XCTAssertFalse(testSources.contains(watchHelper))
        XCTAssertFalse(complicationSources.contains(watchHelper))

        XCTAssertTrue(testSources.contains(localizationTests))
        XCTAssertFalse(iphoneSources.contains(localizationTests))
        XCTAssertFalse(watchSources.contains(localizationTests))
        XCTAssertFalse(complicationSources.contains(localizationTests))

        XCTAssertTrue(project.contains("path = StateWatchApp/Resources/Localizable.xcstrings;"))
        XCTAssertTrue(project.contains("path = StateWatchWatchApp/Resources/Localizable.xcstrings;"))
        XCTAssertTrue(project.contains("path = StateWatchComplications/Localizable.xcstrings;"))
        XCTAssertTrue(project.contains("developmentRegion = en;"))
        XCTAssertTrue(project.contains("\n\t\t\t\t\"zh-Hant\",\n"))
    }

    func testActiveComplicationTargetKeepsLegacyPlaceholderFilesInactive() throws {
        let project = try projectFile()
        let complicationSources = projectBlock(id: "F64200000000000000000001", in: project)

        XCTAssertTrue(complicationSources.contains("ComplicationStateSummary.swift in Sources"))
        XCTAssertTrue(complicationSources.contains("StateWatchComplicationProvider.swift in Sources"))
        XCTAssertTrue(complicationSources.contains("StateWatchComplicationView.swift in Sources"))
        XCTAssertTrue(complicationSources.contains("StateWatchComplicationsBundle.swift in Sources"))
        XCTAssertFalse(complicationSources.contains("StateWatchComplicationBundle.swift in Sources"))
        XCTAssertFalse(complicationSources.contains("StateWatchWidgetView.swift in Sources"))

        let complicationView = try sourceFile("StateWatchComplications/StateWatchComplicationView.swift")
        XCTAssertTrue(complicationView.contains("private let kind = \"StateWatchComplication\""))
    }

    private struct CatalogSpecification {
        let path: String
        let requiredKeys: [String]
    }

    private struct Placeholder: Equatable {
        let position: Int?
        let type: String
    }

    private var catalogSpecifications: [CatalogSpecification] {
        [
            CatalogSpecification(path: watchCatalogPath, requiredKeys: requiredWatchKeys),
            CatalogSpecification(path: complicationCatalogPath, requiredKeys: requiredComplicationKeys)
        ]
    }

    private let requiredWatchKeys = [
        "Signals", "Estimate", "Confidence: %@", "Updated: %@", "Mock data only",
        "Suggestion", "If it matches how you feel", "Demo", "Recovery", "Sleep",
        "Fatigue Context", "Activity Load", "High", "Medium", "Low data", "Unavailable",
        "Mixed", "Steady", "Low", "Needs Rest",
        "Consider a lighter day if that matches how you feel.",
        "Mock wellness score %d, %@, confidence %@, %@",
        "Mock signal summary. Recovery %d. Sleep %d. Fatigue Context %d. Activity Load %d.",
        "Confidence %@. Updated %@. Mock data only.", "Check in",
        "How do you feel right now?", "Energized", "Stable", "Tired", "Icon + Text",
        "Icon Only", "Text Only", "Both", "Icon", "Text", "Check-in display style",
        "Check-in display style, %@", "Selected", "Not selected", "%@, self-reported state",
        "Saved", "Check-in saved", "You can update it later.", "Done", "No check-in yet",
        "Check-ins are optional.", "Recent check-ins", "Delete check-in",
        "Remove this local check-in?", "This removes it from this Watch.", "Delete", "Keep",
        "Delete unavailable", "Try again later.", "Delete %@ check-in", "Today %@", "Yesterday"
    ]

    private let requiredComplicationKeys = [
        "Shows a mock readiness summary.", "State %d - %@", "StateWatch %d %@", "Demo",
        "Demo data", "Mixed", "Steady", "Low", "Needs Rest", "High", "Medium",
        "Low data", "Unavailable", "Consider a lighter day if that matches how you feel.",
        "Stale", "Current demo"
    ]

    private var watchCatalogPath: String { "StateWatchWatchApp/Resources/Localizable.xcstrings" }
    private var complicationCatalogPath: String { "StateWatchComplications/Localizable.xcstrings" }
    private var iphoneCatalogPath: String { "StateWatchApp/Resources/Localizable.xcstrings" }

    private func catalogJSON(at path: String) throws -> [String: Any] {
        let data = try Data(contentsOf: repositoryRoot.appendingPathComponent(path))
        return try XCTUnwrap(JSONSerialization.jsonObject(with: data) as? [String: Any])
    }

    private func strings(at path: String) throws -> [String: Any] {
        try XCTUnwrap(try catalogJSON(at: path)["strings"] as? [String: Any])
    }

    private func translation(for key: String, in strings: [String: Any]) throws -> String {
        let entry = try XCTUnwrap(strings[key] as? [String: Any], "Missing key: \(key)")
        let localizations = try XCTUnwrap(entry["localizations"] as? [String: Any])
        let traditionalChinese = try XCTUnwrap(localizations["zh-Hant"] as? [String: Any])
        let stringUnit = try XCTUnwrap(traditionalChinese["stringUnit"] as? [String: Any])
        XCTAssertEqual(stringUnit["state"] as? String, "translated", key)
        return try XCTUnwrap(stringUnit["value"] as? String)
    }

    private func combinedTranslations(at path: String) throws -> String {
        let strings = try strings(at: path)
        return try strings.keys.sorted().map { try translation(for: $0, in: strings) }.joined(separator: "\n")
    }

    private func placeholders(in text: String) -> [Placeholder] {
        let expression = try! NSRegularExpression(pattern: "%(?:(\\d+)\\$)?([@d])")
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        return expression.matches(in: text, range: range).map { match in
            let position = Range(match.range(at: 1), in: text).flatMap { Int(text[$0]) }
            let typeRange = Range(match.range(at: 2), in: text)!
            return Placeholder(position: position, type: String(text[typeRange]))
        }
    }

    private func removingPlaceholders(from text: String) -> String {
        let expression = try! NSRegularExpression(pattern: "%(?:(\\d+)\\$)?[@d]")
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        return expression.stringByReplacingMatches(in: text, range: range, withTemplate: "")
    }

    private func projectFile() throws -> String {
        try sourceFile("StateWatch.xcodeproj/project.pbxproj")
    }

    private func sourceFile(_ path: String) throws -> String {
        try String(contentsOf: repositoryRoot.appendingPathComponent(path), encoding: .utf8)
    }

    private func buildFileID(for comment: String, in project: String) throws -> String {
        let escapedComment = NSRegularExpression.escapedPattern(for: comment)
        let expression = try NSRegularExpression(pattern: "([A-F0-9]{24}) /\\* \(escapedComment) \\*/ = \\{isa = PBXBuildFile;")
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
