import Foundation

struct ExplanationGenerator {
    func makeReasons(from assessment: StateAssessment) -> [String] {
        // TODO: Generate factor-based plain-language reasons.
        return assessment.reasons
    }
}
