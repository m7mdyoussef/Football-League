
import Foundation

// MARK: - ResponseModel
struct CompetionModelElement: Codable {
    let count: Int?
    let competitions: [Competition]?
}

// MARK: - Competition
struct Competition: Codable {
    let id: Int?
    let area: Area?
    let name: String?
    let code: String?
    let emblemURL: String?
    let plan: Plan?
    let currentSeason: CurrentSeason?
    let numberOfAvailableSeasons: Int?
    let lastUpdated: String?
    var teamsData: CompetitionTeamsModel?
    enum CodingKeys: String, CodingKey {
        case id, area, name, code, teamsData
        case emblemURL = "emblemUrl"
        case plan, currentSeason, numberOfAvailableSeasons, lastUpdated
    }
}

// MARK: - Area
struct Area: Codable {
    let id: Int?
    let name, countryCode: String?
    let ensignURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name, countryCode
        case ensignURL = "ensignUrl"
    }
}

// MARK: - CurrentSeason
struct CurrentSeason: Codable {
    let id: Int?
    let startDate, endDate: String?
    let currentMatchday: Int?
    let winner: Winner?
}

// MARK: - Winner
struct Winner: Codable {
    let id: Int?
    let name: String?
    let shortName, tla: String?
    let crestURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name, shortName, tla
        case crestURL = "crestUrl"
    }
}

enum Plan: String, Codable {
    case tierFour = "TIER_FOUR"
    case tierOne = "TIER_ONE"
    case tierThree = "TIER_THREE"
    case tierTwo = "TIER_TWO"
}

