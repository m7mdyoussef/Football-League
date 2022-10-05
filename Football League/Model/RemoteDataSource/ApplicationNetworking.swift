
import Foundation
import Alamofire

enum ApplicationNetworking{
    case getCompetitions
    case getAllTeams(withCode:String)
}

extension ApplicationNetworking : TargetType{
    var baseURL: String {
        switch self{
        default:
            return Constants.baseURL
        }
    }
    
    var path: String {
        switch self{
        case .getCompetitions:
            return Constants.urlCompetions
        case .getAllTeams(withCode: let code):
            return Constants.urlGetAllTeams + code + Constants.urlGetTeams
        }
    }
    
    var method: HTTPMethod {
        switch self{
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self{
        case .getCompetitions:
            return .requestPlain
        case .getAllTeams:
            return .requestPlain
        }
    }
    var headers: [String : String]? {
        switch self{
        default:
            return ["Accept": "application/json","Content-Type": "application/json","X-Auth-Token": "851f6e19e4c34a94a6b98e2f007cf9d3"]
        }
    }
}
