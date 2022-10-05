//
//  CompetionTableViewCell.swift
//  Football League
//
//  Created by Joe on 02/10/2022.
//

import UIKit

class CompetionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leageNameLabel: UILabel!
    @IBOutlet weak var numberOfteamsLabel: UILabel!
    @IBOutlet weak var numberOfGamesLabel: UILabel!
    
    static let identifier = "CompetionTableViewCell"
    
    var CompetitionModel:Competition!{
        didSet{
            guard let CompetitionModel = CompetitionModel else { return }
            configureCellModel(CompetitionModel: CompetitionModel)
        }
    }
    
    func configureCellModel(CompetitionModel:Competition){
        
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
    }
}
