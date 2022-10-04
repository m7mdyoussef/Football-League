
import Foundation

class CompetionModelElement:NSObject, Codable, NSSecureCoding {
    
    static var supportsSecureCoding: Bool {
          return true
       }
    var count: Int?
    var competitions: [Competition]?
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.count = decoder.decodeInteger(forKey: "count") as Int
        self.competitions = decoder.decodeObject(forKey: "competitions") as? [Competition]
    }
    convenience init(count:Int?, competitions:[Competition]?) {
        self.init()
        self.count = count
        self.competitions = competitions
    }
    func encode(with coder: NSCoder) {
        if let count = count { coder.encode(count, forKey: "count") }
        if let competitions = competitions { coder.encode(competitions, forKey: "competitions") }

    }
}

// MARK: - Competition
class Competition:NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool {
          return true
       }
    
    var name: String?
    var code: String?
    var type: String?
    var emblem: String?
    var teamsData: CompetitionTeamsModel?

    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.name = decoder.decodeObject(forKey: "name") as? String
        self.code = decoder.decodeObject(forKey: "code") as? String
        self.type = decoder.decodeObject(forKey: "type") as? String
        self.emblem = decoder.decodeObject(forKey: "emblem") as? String
        self.teamsData = decoder.decodeObject(forKey: "teamsData") as? CompetitionTeamsModel
    }
    convenience init(name: String?,code: String?,type: String?,emblem: String?, teamsData: CompetitionTeamsModel?) {
        self.init()
        self.name = name
        self.code = code
        self.type = type
        self.emblem = emblem
        self.teamsData = teamsData
    }
    func encode(with coder: NSCoder) {
        if let name = name { coder.encode(name, forKey: "name") }
        if let code = code { coder.encode(code, forKey: "code") }
        if let type = type { coder.encode(type, forKey: "type") }
        if let emblem = emblem { coder.encode(emblem, forKey: "emblem") }
        if let teamsData = teamsData { coder.encode(teamsData, forKey: "teamsData") }

    }
    
}
