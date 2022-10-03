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

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
