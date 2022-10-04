
import Foundation

// MARK: - ResponseModel
struct CompetitionTeamsModel: Codable {
    let count: Int?
    let competition: CompetitionDetail?
    let season: Season?
    let teams: [Team]?
}

// MARK: - Competition
struct CompetitionDetail: Codable {
    let id: Int?
    let name: String?
    let code: String?
    let type: String?
    let emblem: String?
}

// MARK: - Season
struct Season: Codable {
    let id: Int?
    let startDate, endDate: String?
    let currentMatchday: Int?
}

// MARK: - Team
struct Team: Codable {
    let area: CompetitionArea?
    let id: Int?
    let name, shortName, tla: String?
    let crest: String?
    let address: String?
    let website: String?
    let founded: Int?
    let clubColors, venue: String?
    let runningCompetitions: [Competition]?
    let coach: Coach?
    let squad: [Squad]?
    let staff: [Coach]?
    let lastUpdated: String?
}

// MARK: - Area
struct CompetitionArea: Codable {
    let id: Int?
    let name: String?
    let code: String?
    let flag: String?
}

// MARK: - Coach
struct Coach: Codable {
    let id: Int?
    let firstName, lastName, name, dateOfBirth: String?
    let nationality: String?
}

// MARK: - Squad
struct Squad: Codable {
    let id: Int?
    let name: String?
    let position: String?
    let dateOfBirth, nationality: String?
}



