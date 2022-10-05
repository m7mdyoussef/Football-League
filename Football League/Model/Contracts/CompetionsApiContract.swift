

import Foundation

protocol CompetionsApiContract {
    func getAllCompetions(completion: @escaping (Result<CompetionModelElement?, NSError>) -> Void)
    func getCompetionTeams(code:String, completion: @escaping (Result<CompetitionTeamsModel?, NSError>) -> Void)
}
