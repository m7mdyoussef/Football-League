//
//  TeamDetailsCell.swift
//  Football League
//
//  Created by Joe on 04/10/2022.
//

import UIKit

class TeamDetailsCell: UITableViewCell {
    
    @IBOutlet private weak var teamImageView: UIImageView!
    @IBOutlet private weak var teamnamelbl: UILabel!

    static let identifier = "TeamDetailsCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    var CompetitionTeam:Team!{
        didSet{
            guard let CompetitionTeamModel = CompetitionTeam else { return }
            configureCellModel(CompetitionTeamModel: CompetitionTeamModel)
        }
    }
    
    func configureCellModel(CompetitionTeamModel:Team){
        
        teamImageView.sd_setImage(with: URL(string: CompetitionTeamModel.crest ?? ""), placeholderImage: UIImage(named:"placeholder"))
        
        var teamName = CompetitionTeamModel.name ?? ""
        if let leagueShortName = CompetitionTeamModel.shortName {
            teamName += " (" + (leagueShortName) + ")"
        }
        teamnamelbl.text = teamName
    }
    
}
