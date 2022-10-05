
import UIKit
import RxCocoa
import RxSwift
import SDWebImage

class CompetitionDetailsViewController: BaseViewController {
    
    @IBOutlet private weak var detailsView: UIView!
    @IBOutlet private weak var competitionLogo: UIImageView!
    @IBOutlet private weak var competionName: UILabel!
    @IBOutlet private weak var competitionType: UILabel!
    @IBOutlet private weak var numberOfteamsLbl: UILabel!
    @IBOutlet private weak var teamsTableView: UITableView!
    
    private var competition:Competition
    private var disposeBag:DisposeBag
    private var items: BehaviorRelay<[Team]>
    init?(coder: NSCoder, competition: Competition) {
        self.competition = competition
        disposeBag = DisposeBag()
        items = BehaviorRelay<[Team]>(value: [])
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a user.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        items.accept(competition.teamsData?.teams ?? [])
        setupUI()
        setupNavigationController()
        registerCellNibFile()
        assignLabels()
        
        listenOnObservables()
    }
    
    private func setupUI(){
        teamsTableView.estimatedRowHeight = 120
        teamsTableView.rowHeight = UITableView.automaticDimension
        detailsView.addShadow(cornerRadius: 10.0, offset: CGSize(width: 2.0, height: 2.0), color: UIColor.black, radius: 3.0, opacity: 0.8)
    }
    
    private func setupNavigationController(){
        self.title = Constants.CompetitionDetailsScreenHeader
    }
    
    private func registerCellNibFile(){
        let competitionsNibCell = UINib(nibName: TeamDetailsCell.identifier, bundle: nil)
        teamsTableView.register(competitionsNibCell, forCellReuseIdentifier: TeamDetailsCell.identifier)
    }
    
    private func assignLabels(){
        competitionLogo.downloadImage(url: competition.emblem ?? "")
        competionName.text = (competition.code ?? "") + " " + (competition.name ?? "")
        competitionType.text = competition.type ?? ""
        if let numberOfTeams = competition.teamsData?.count {
            numberOfteamsLbl.text = "\(numberOfTeams) " + (Constants.teams)
        }
    }
    
    private func listenOnObservables(){
        items.bind(to: teamsTableView.rx.items){ (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: TeamDetailsCell.identifier, for: IndexPath(index: row)) as! TeamDetailsCell
            cell.configureCellModel(CompetitionTeamModel: element)
            return cell
        }.disposed(by: disposeBag)
        
        teamsTableView.rx.modelSelected(Team.self).subscribe(onNext: {[weak self] (teamItem) in
            guard let self = self else {return}
            guard let vc = self.storyboard?.instantiateViewController(identifier: Constants.ClubDetailsVC, creator: { coder in
                return ClubDetailsViewController(coder: coder, team: teamItem)
            }) else {
                fatalError("Failed to load EditUserViewController from storyboard.")
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
    }
    
}

extension CompetitionDetailsViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
