
import Foundation

class CompetitionTeamsModel:NSObject, Codable, NSSecureCoding{
    static var supportsSecureCoding: Bool {
        return true
    }
    var count: Int?
    var teams: [Team]?
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.count = decoder.decodeInteger(forKey: "count") as Int
        self.teams = decoder.decodeObject(forKey: "teams") as? [Team]
    }
    convenience init(count:Int?, teams: [Team]?) {
        self.init()
        self.count = count
        self.teams = teams
    }
    func encode(with coder: NSCoder) {
        if let count = count { coder.encode(count, forKey: "count") }
        if let teams = teams { coder.encode(teams, forKey: "teams") }
    }
}

// MARK: - Team
class Team:NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    var name, shortName: String?
    var crest: String?
    var address: String?
    var clubColors, venue: String?
    var runningCompetitions: [Competition]?
    var coach: Coach?
    var squad: [Squad]?
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.name = decoder.decodeObject(forKey: "name") as? String
        self.shortName = decoder.decodeObject(forKey: "shortName") as? String
        self.crest = decoder.decodeObject(forKey: "crest") as? String
        self.address = decoder.decodeObject(forKey: "address") as? String
        self.clubColors = decoder.decodeObject(forKey: "clubColors") as? String
        self.venue = decoder.decodeObject(forKey: "venue") as? String
        
        self.runningCompetitions = decoder.decodeObject(forKey: "runningCompetitions") as? [Competition]
        self.coach = decoder.decodeObject(forKey: "coach") as? Coach
        self.squad = decoder.decodeObject(forKey: "squad") as? [Squad]
        
    }
    convenience init(name: String?, shortName: String?,crest: String?,address: String?,clubColors: String?, venue: String?,runningCompetitions: [Competition]?,coach: Coach?,squad: [Squad]?) {
        self.init()
        self.name = name
        self.shortName = shortName
        self.crest = crest
        self.address = address
        self.clubColors = clubColors
        self.venue = venue
        self.runningCompetitions = runningCompetitions
        self.coach = coach
        self.squad = squad
    }
    func encode(with coder: NSCoder) {
        if let name = name { coder.encode(name, forKey: "name") }
        if let shortName = shortName { coder.encode(shortName, forKey: "shortName") }
        if let crest = crest { coder.encode(crest, forKey: "crest") }
        if let address = address { coder.encode(address, forKey: "address") }
        if let clubColors = clubColors { coder.encode(clubColors, forKey: "clubColors") }
        if let venue = venue { coder.encode(venue, forKey: "venue") }
        if let runningCompetitions = runningCompetitions { coder.encode(runningCompetitions, forKey: "runningCompetitions") }
        if let coach = coach { coder.encode(coach, forKey: "coach") }
        if let squad = squad { coder.encode(squad, forKey: "squad") }
    }
}


// MARK: - Coach
class Coach:NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    var name: String?
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.name = decoder.decodeObject(forKey: "name") as? String
    }
    convenience init(name:String?) {
        self.init()
        self.name = name
    }
    func encode(with coder: NSCoder) {
        if let name = name { coder.encode(name, forKey: "name") }
    }
}

// MARK: - Squad
class Squad:NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    var name: String?
    var position: String?
    var nationality: String?
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.name = decoder.decodeObject(forKey: "name") as? String
        self.position = decoder.decodeObject(forKey: "position") as? String
        self.nationality = decoder.decodeObject(forKey: "nationality") as? String
        
    }
    convenience init(name:String?, position: String?, nationality: String?) {
        self.init()
        self.name = name
        self.position = position
        self.nationality = nationality
    }
    func encode(with coder: NSCoder) {
        if let name = name { coder.encode(name, forKey: "name") }
        if let position = position { coder.encode(position, forKey: "position") }
        if let nationality = nationality { coder.encode(nationality, forKey: "nationality") }
        
    }
}



