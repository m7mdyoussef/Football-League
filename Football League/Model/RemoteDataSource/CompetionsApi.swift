
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

}
