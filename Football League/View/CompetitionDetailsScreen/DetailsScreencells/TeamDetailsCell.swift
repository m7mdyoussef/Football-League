//
//  TeamDetailsCell.swift
//  Football League
//
//  Created by Joe on 04/10/2022.
//

import UIKit

class TeamDetailsCell: UITableViewCell, TeamDetailsCellModelContract {
    
    @IBOutlet private weak var teamImageView: UIImageView!
    @IBOutlet private weak var teamnamelbl: UILabel!

    static let identifier = "TeamDetailsCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
        
    func configureCellModel(CompetitionTeamModel:Team?){
        guard let CompetitionTeamModel = CompetitionTeamModel else { return }
        teamImageView.downloadImage(url: CompetitionTeamModel.crest ?? "")
        var teamName = CompetitionTeamModel.name ?? ""
        if let leagueShortName = CompetitionTeamModel.shortName {
            teamName += " (" + (leagueShortName) + ")"
        }
        teamnamelbl.text = teamName
    }
    
}
