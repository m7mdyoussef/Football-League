
import Foundation
import Alamofire


class CompetionsAPI : BaseAPI<ApplicationNetworking>, CompetionsApiContract{

    
    static let sharedInstance = CompetionsAPI()
    
    private override init() {}

    func getAllCompetions(completion: @escaping (Result<CompetionModelElement?, NSError>) -> Void) {
        self.fetchData(target: .getCompetitions, responseClass: CompetionModelElement.self) { (result) in
            completion(result)
        }
    }
    
    func getCompetionTeams(code:String, completion: @escaping (Result<CompetitionTeamsModel?, NSError>) -> Void) {
        self.fetchData(target: .getAllTeams(withCode: code), responseClass: CompetitionTeamsModel.self) { (result) in
            completion(result)
        }
    }
    

}
