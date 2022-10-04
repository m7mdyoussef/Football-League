
import Foundation

struct CompetitionContentModel {
    let leagueName: String?
    let leagueShortName: String?
    let numberOfTeams: Int?
    let numberOfTGames: Int?
    
    init(leagueName: String?,leagueShortName: String?,numberOfTeams: Int?,numberOfTGames: Int?) {
        self.leagueName = leagueName
        self.leagueShortName = leagueShortName
        self.numberOfTeams = numberOfTeams
        self.numberOfTGames = numberOfTGames
    }

}

typealias Competitions = [CompetitionContentModel]
