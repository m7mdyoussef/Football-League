//
//  ClubDetailsCell.swift
//  Football League
//
//  Created by Joe on 04/10/2022.
//

import UIKit

class ClubDetailsCell: UITableViewCell, ClubDetailsCellModelContract {
    @IBOutlet private weak var playerNameLbl: UILabel!
    @IBOutlet private weak var playerPostionLbl: UILabel!
    @IBOutlet private weak var playerNationalityLbl: UILabel!
    
    static let identifier = "ClubDetailsCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }  
        
    func configureCellModel(teamSquad:Squad?){
        guard let teamSquad = teamSquad else { return }
        playerNameLbl.text = teamSquad.name ?? ""
        playerPostionLbl.text = teamSquad.position ?? ""
        playerNationalityLbl.text = teamSquad.nationality ?? ""
    }
}
