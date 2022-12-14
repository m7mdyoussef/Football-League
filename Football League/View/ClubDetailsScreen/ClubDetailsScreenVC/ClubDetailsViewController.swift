
import UIKit
import RxCocoa
import RxSwift
import SDWebImage

class ClubDetailsViewController: BaseViewController {
    
    @IBOutlet private weak var clubImageLogo: UIImageView!
    @IBOutlet private weak var clubNameLbl: UILabel!
    @IBOutlet private weak var clubAdressLbl: UILabel!
    @IBOutlet private weak var clubColorsLbl: UILabel!
    @IBOutlet private weak var clubVenueLbl: UILabel!
    @IBOutlet private weak var clubCoachLbl: UILabel!
    @IBOutlet private weak var runningCopetitionLbl: UILabel!
    @IBOutlet private weak var teamSquadTableView: UITableView!
    
    private var team:Team
    private var disposeBag:DisposeBag
    private var items: BehaviorRelay<[Squad]>
    init?(coder: NSCoder, team: Team) {
        self.team = team
        disposeBag = DisposeBag()
        items = BehaviorRelay<[Squad]>(value: [])
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a user.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items.accept(team.squad ?? [])
        setUpUI()
        setupNavigationController()
        registerCellNibFile()
        assignLabels()
        listenOnObservables()
    }
    
    private func setUpUI(){
        teamSquadTableView.estimatedRowHeight = 80
        teamSquadTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupNavigationController(){
        self.title = Constants.clubDetailsScreenHeader
    }
    
    private func registerCellNibFile(){
        let competitionsNibCell = UINib(nibName: ClubDetailsCell.identifier, bundle: nil)
        teamSquadTableView.register(competitionsNibCell, forCellReuseIdentifier: ClubDetailsCell.identifier)
    }
    
    private func assignLabels(){
        clubImageLogo.downloadImage(url: team.crest ?? "")
        var teamName = team.name ?? ""
        if let teamShortName = team.shortName {
            teamName += " (" + teamShortName + ")"
        }
        clubNameLbl.text = teamName
        clubAdressLbl.text = team.address ?? ""
        clubColorsLbl.text = team.clubColors ?? ""
        clubVenueLbl.text = team.venue ?? ""
        clubCoachLbl.text = team.coach?.name ?? ""
        
        var teamRunningCompetitions = ""
        team.runningCompetitions?.forEach({ competition in
            teamRunningCompetitions.append((competition.code ?? "") + (competition.name ?? "") + "\n")
        })
        
        runningCopetitionLbl.text = teamRunningCompetitions
    }
    
    private func listenOnObservables(){
        items.bind(to: teamSquadTableView.rx.items){ (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: ClubDetailsCell.identifier, for: IndexPath(index: row)) as! ClubDetailsCell
            cell.configureCellModel(teamSquad: element)
            return cell
        }.disposed(by: disposeBag)
    }
    
}

extension ClubDetailsViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
