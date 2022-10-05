//
//  ClubDetailsCell.swift
//  Football League
//
//  Created by Joe on 04/10/2022.
//

import UIKit

class ClubDetailsCell: UITableViewCell {
    @IBOutlet weak var playerNameLbl: UILabel!
    
    @IBOutlet weak var playerPostionLbl: UILabel!
    
    @IBOutlet weak var playerNationalityLbl: UILabel!
    
    static let identifier = "ClubDetailsCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }  
    
    var teamSquad:Squad!{
        didSet{
            guard let teamSquad = teamSquad else { return }
            configureCellModel(teamSquad:teamSquad)
        }
    }
    
    func configureCellModel(teamSquad:Squad){
        playerNameLbl.text = teamSquad.name ?? ""
        playerPostionLbl.text = teamSquad.position ?? ""
        playerNationalityLbl.text = teamSquad.nationality ?? ""
    }
}
