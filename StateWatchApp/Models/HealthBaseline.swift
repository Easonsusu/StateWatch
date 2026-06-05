import Foundation

enum ScoreConfidence: String, CaseIterable, Codable, Identifiable, Equatable {
    case high
    case medium
    case low
    case unavailable

    var id: String { rawValue }

    static func forSampleCount(_ count: Int) -> ScoreConfidence {
        switch count {
        case 7...: return .high
        case 3..<7: return .medium
        case 1..<3: return .low
        default: return .unavailable
        }
    }

    static func combined(_ values: [ScoreConfidence]) -> ScoreConfidence {
        let available = values.filter { $0 != .unavailable }
        guard !available.isEmpty else { return .unavailable }
        if available.contains(.low) { return .low }
        if available.allSatisfy({ $0 == .high }) { return .high }
        return .medium
    }
}

enum BaselineWindow: Int, CaseIterable, Codable, Identifiable, Equatable, Hashable {
    case sevenDays = 7
    case fourteenDays = 14
    case thirtyDays = 30

    var id: Int { rawValue }
    var dayCount: Int { rawValue }
}

struct MetricBaseline: Codable, Equatable {
    static let minimumValidSampleCount = 3
    static let unavailable = MetricBaseline(average: nil, validSampleCount: 0, confidence: .unavailable)

    let average: Double?
    let validSampleCount: Int
    let confidence: ScoreConfidence

    static func available(average: Double, validSampleCount: Int) -> MetricBaseline {
        let exposedAverage = validSampleCount >= minimumValidSampleCount ? average : nil
        return MetricBaseline(
            average: exposedAverage,
            validSampleCount: validSampleCount,
            confidence: ScoreConfidence.forSampleCount(validSampleCount)
        )
    }

    static func calculated(from values: [Double]) -> MetricBaseline {
        let validSampleCount = values.count
        let confidence = ScoreConfidence.forSampleCount(validSampleCount)
        guard validSampleCount >= minimumValidSampleCount else {
            return MetricBaseline(average: nil, validSampleCount: validSampleCount, confidence: confidence)
        }

        let average = values.reduce(0, +) / Double(validSampleCount)
        return MetricBaseline(average: average, validSampleCount: validSampleCount, confidence: confidence)
    }
}

struct HealthBaseline: Codable, Equatable {
    let window: BaselineWindow
    let restingHeartRate: MetricBaseline
    let averageHeartRate: MetricBaseline
    let heartRateVariability: MetricBaseline
    let sleepDuration: MetricBaseline
    let activeEnergy: MetricBaseline
    let exerciseMinutes: MetricBaseline
    let stepCount: MetricBaseline
    let sampleCount: Int

    var restingHeartRateAverage: Double? { restingHeartRate.average }
    var averageHeartRateAverage: Double? { averageHeartRate.average }
    var heartRateVariabilityAverage: Double? { heartRateVariability.average }
    var sleepDurationAverage: Double? { sleepDuration.average }
    var activeEnergyAverage: Double? { activeEnergy.average }
    var exerciseMinutesAverage: Double? { exerciseMinutes.average }
    var stepCountAverage: Double? { stepCount.average }

    var overallConfidence: ScoreConfidence {
        ScoreConfidence.combined([
            restingHeartRate.confidence,
            averageHeartRate.confidence,
            heartRateVariability.confidence,
            sleepDuration.confidence,
            activeEnergy.confidence,
            exerciseMinutes.confidence,
            stepCount.confidence
        ])
    }

    var hasEnoughHistory: Bool {
        sampleCount >= MetricBaseline.minimumValidSampleCount && [.high, .medium].contains(overallConfidence)
    }

    var isEmpty: Bool {
        sampleCount == 0
            && restingHeartRateAverage == nil
            && averageHeartRateAverage == nil
            && heartRateVariabilityAverage == nil
            && sleepDurationAverage == nil
            && activeEnergyAverage == nil
            && exerciseMinutesAverage == nil
            && stepCountAverage == nil
    }

    init(
        window: BaselineWindow = .sevenDays,
        restingHeartRate: MetricBaseline,
        averageHeartRate: MetricBaseline,
        heartRateVariability: MetricBaseline,
        sleepDuration: MetricBaseline,
        activeEnergy: MetricBaseline,
        exerciseMinutes: MetricBaseline,
        stepCount: MetricBaseline,
        sampleCount: Int
    ) {
        self.window = window
        self.restingHeartRate = restingHeartRate
        self.averageHeartRate = averageHeartRate
        self.heartRateVariability = heartRateVariability
        self.sleepDuration = sleepDuration
        self.activeEnergy = activeEnergy
        self.exerciseMinutes = exerciseMinutes
        self.stepCount = stepCount
        self.sampleCount = sampleCount
    }

    init(
        restingHeartRateAverage: Double?,
        averageHeartRateAverage: Double? = nil,
        heartRateVariabilityAverage: Double?,
        sleepDurationAverage: Double?,
        activeEnergyAverage: Double?,
        exerciseMinutesAverage: Double? = nil,
        stepCountAverage: Double? = nil,
        sampleCount: Int,
        window: BaselineWindow = .sevenDays
    ) {
        self.init(
            window: window,
            restingHeartRate: Self.metric(from: restingHeartRateAverage, sampleCount: sampleCount),
            averageHeartRate: Self.metric(from: averageHeartRateAverage, sampleCount: sampleCount),
            heartRateVariability: Self.metric(from: heartRateVariabilityAverage, sampleCount: sampleCount),
            sleepDuration: Self.metric(from: sleepDurationAverage, sampleCount: sampleCount),
            activeEnergy: Self.metric(from: activeEnergyAverage, sampleCount: sampleCount),
            exerciseMinutes: Self.metric(from: exerciseMinutesAverage, sampleCount: sampleCount),
            stepCount: Self.metric(from: stepCountAverage, sampleCount: sampleCount),
            sampleCount: sampleCount
        )
    }

    func confidence(for metric: HealthMetricType) -> ScoreConfidence {
        metricBaseline(for: metric).confidence
    }

    func validSampleCount(for metric: HealthMetricType) -> Int {
        metricBaseline(for: metric).validSampleCount
    }

    func metricBaseline(for metric: HealthMetricType) -> MetricBaseline {
        switch metric {
        case .restingHeartRate: return restingHeartRate
        case .averageHeartRate: return averageHeartRate
        case .heartRateVariability: return heartRateVariability
        case .sleepDuration: return sleepDuration
        case .activeEnergy: return activeEnergy
        case .exerciseMinutes: return exerciseMinutes
        case .steps: return stepCount
        case .standHours, .mindfulMinutes: return .unavailable
        }
    }

    private static func metric(from average: Double?, sampleCount: Int) -> MetricBaseline {
        guard let average else { return .unavailable }
        return .available(average: average, validSampleCount: sampleCount)
    }
}

extension HealthBaseline {
    static let mock = MockSampleData.baseline

    static let empty = HealthBaseline(
        window: .sevenDays,
        restingHeartRate: .unavailable,
        averageHeartRate: .unavailable,
        heartRateVariability: .unavailable,
        sleepDuration: .unavailable,
        activeEnergy: .unavailable,
        exerciseMinutes: .unavailable,
        stepCount: .unavailable,
        sampleCount: 0
    )
}
