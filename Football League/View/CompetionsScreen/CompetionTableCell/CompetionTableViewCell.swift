//
//  CompetionTableViewCell.swift
//  Football League
//
//  Created by Joe on 02/10/2022.
//

import UIKit

class CompetionTableViewCell: UITableViewCell, CompetionCellModelContract {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leageNameLabel: UILabel!
    @IBOutlet weak var numberOfteamsLabel: UILabel!
    @IBOutlet weak var numberOfGamesLabel: UILabel!
    
    static let identifier = "CompetionTableViewCell"
        
    func configureCellModel(CompetitionModel:Competition?){
        guard let CompetitionModel = CompetitionModel else { return }
        var leagueName = CompetitionModel.name ?? ""
        if let leagueShortName = CompetitionModel.code {
            leagueName += " (" + (leagueShortName) + ")"
        }
        leageNameLabel.text = leagueName
        if let numberOfTeams = CompetitionModel.teamsData?.count {
            numberOfteamsLabel.text = String(numberOfTeams)
            numberOfGamesLabel.text = String(getNumberOfGames(numberOfTeams: numberOfTeams))
        }
    }
    
    func getNumberOfGames(numberOfTeams:Int) -> Int{
        return (((numberOfTeams - 1) * 2) * numberOfTeams)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        containerView.addShadow(cornerRadius: 10.0, offset: CGSize(width: 2.0, height: 2.0), color: UIColor.black, radius: 3.0, opacity: 0.8)
    }
}
