
import Foundation
import Alamofire

enum ApplicationNetworking{
    case getCompetitions
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
        }
    }
    var headers: [String : String]? {
        switch self{
        default:
            return ["Accept": "application/json","Content-Type": "application/json"]
        }
    }
}
