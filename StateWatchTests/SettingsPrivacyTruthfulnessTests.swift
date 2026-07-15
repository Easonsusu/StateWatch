import XCTest
@testable import StateWatchApp

final class SettingsPrivacyTruthfulnessTests: XCTestCase {
    func testCurrentStorageDisclosuresCoverMVPBoundaries() {
        let text = SettingsPrivacyContent.searchableText.lowercased()

        assertContainsAll(
            [
                "dashboard demo values",
                "generated locally",
                "not stored as a personal history",
                "onboarding completion",
                "local preference",
                "watch check-ins",
                "apple watch",
                "read-only",
                "processed on device",
                "compact demo readiness summary",
                "app group",
                "raw apple health samples",
                "not stored in shared app group state or uploaded",
                "healthkit-derived dashboard output",
                "not published to watch, widgetkit, or the app group"
            ],
            in: text
        )
    }

    func testProductionCopyDoesNotOfferMisleadingResetOrDeletionActions() {
        let text = SettingsPrivacyContent.searchableText.lowercased()
        let prohibitedClaims = [
            "reset local mock data",
            "delete all data",
            "erase apple health data",
            "clear healthkit",
            "reset health permissions",
            "delete watch check-ins from iphone",
            "clear everything"
        ]

        for claim in prohibitedClaims {
            XCTAssertFalse(text.contains(claim), "Unexpected reset or deletion claim: \(claim)")
        }
    }

    func testProductionCopyAvoidsUnsafeMedicalAndUnsupportedPrivacyClaims() {
        let text = SettingsPrivacyContent.searchableText.lowercased()
        let prohibitedClaims = [
            "diagnoses",
            "disease detected",
            "clinical stress",
            "treatment",
            "emergency",
            "abnormal state",
            "health risk",
            "hipaa compliant",
            "gdpr compliant",
            "anonymous",
            "zero data retention",
            "encrypted everywhere"
        ]

        XCTAssertTrue(text.contains("does not diagnose"))
        for claim in prohibitedClaims {
            XCTAssertFalse(text.contains(claim), "Unexpected medical or privacy claim: \(claim)")
        }
    }

    func testProductionSettingsSourcesDoNotContainOldResetOrTodoCopy() throws {
        let settingsSource = try source(
            at: "StateWatchApp/Features/Settings/SettingsView.swift"
        )
        let privacySource = try source(
            at: "StateWatchApp/Features/Settings/PrivacyView.swift"
        )

        XCTAssertFalse(settingsSource.contains("Reset Local Mock Data"))
        XCTAssertFalse(settingsSource.contains("TODO: Clear local persistence after it exists."))
        XCTAssertFalse(privacySource.contains("Section(\"TODO\")"))
        XCTAssertFalse(privacySource.contains("Finalize privacy policy after"))

        let combinedSource = settingsSource + privacySource
        for mutationAPI in [
            "UserDefaults",
            "SharedReadinessStore",
            "removePersistentDomain",
            "removeObject("
        ] {
            XCTAssertFalse(combinedSource.contains(mutationAPI))
        }
    }

    func testContentModelHasNoStorageOrHealthKitMutationDependencies() throws {
        let source = try source(
            at: "StateWatchApp/Features/Settings/SettingsPrivacyContent.swift"
        )
        let prohibitedSource = [
            "import SwiftUI",
            "import HealthKit",
            "UserDefaults",
            "SharedReadinessStore",
            "func reset",
            "func delete",
            "removePersistentDomain",
            "removeObject(",
            ".set("
        ]

        for item in prohibitedSource {
            XCTAssertFalse(source.contains(item), "Unexpected content-model dependency: \(item)")
        }
    }

    private func assertContainsAll(
        _ concepts: [String],
        in text: String,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        for concept in concepts {
            XCTAssertTrue(
                text.contains(concept.lowercased()),
                "Missing disclosure concept: \(concept)",
                file: file,
                line: line
            )
        }
    }

    private func source(at relativePath: String) throws -> String {
        let root = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        return try String(
            contentsOf: root.appendingPathComponent(relativePath),
            encoding: .utf8
        )
    }
}
