import Foundation

struct UserCheckIn: Codable {
    let date: Date
    let energyLevel: Int
    let stressLevel: Int
    let note: String?

    static let mock = UserCheckIn(date: Date(), energyLevel: 3, stressLevel: 2, note: "Felt okay after a full night of sleep.")
}
