
import UIKit
import RxCocoa
import RxSwift

class CompetitionDetailsViewController: BaseViewController {
    
    @IBOutlet private weak var competitionLogo: UIImageView!
    @IBOutlet private weak var competionName: UILabel!
    @IBOutlet private weak var competitionType: UILabel!
    @IBOutlet private weak var numberOfteamsLbl: UILabel!
    @IBOutlet private weak var teamsTableView: UITableView!
}
