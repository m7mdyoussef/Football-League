
import UIKit
import RxCocoa
import RxSwift


class CompetionsViewController: BaseViewController {
    
    @IBOutlet weak var networkConnectionFailView: UIView!
    @IBOutlet weak var retryButton: UIButton!
    
    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var errorReasonLbl: UILabel!
    @IBOutlet private weak var competionsTableView: UITableView!
    
    private var disposeBag:DisposeBag!
    private var competionsViewModel:CompetionsViewModelContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        competionsTableView.estimatedRowHeight = 140
        competionsTableView.rowHeight = UITableView.automaticDimension
        
        setupNavigationController()
        registerCellNibFile()
        instantiateRXItems()
        
        listenOnObservables()
        competionsViewModel.fetchdata()
    }
    
    private func setupNavigationController(){
        self.title = Constants.CompetitionsScreenHeader
    }
    
    private func registerCellNibFile(){
        let competitionsNibCell = UINib(nibName: CompetionTableViewCell.identifier, bundle: nil)
        competionsTableView.register(competitionsNibCell, forCellReuseIdentifier: CompetionTableViewCell.identifier)
    }
    
    private func instantiateRXItems(){
        disposeBag = DisposeBag()
        competionsViewModel = CompetitionsViewModel()
    }
    
    private func showFailViewWith(error:NSError){
       
        self.networkConnectionFailView.isHidden = false
        self.competionsTableView.isHidden = true
        if error.code == 0 {
            errorImageView.image = UIImage(named: Constants.NetworkErrorImg)
            errorReasonLbl.text = Constants.noInternetConnectionTitle
        }else{
            errorImageView.image = UIImage(named: Constants.serverErrorImg)
            errorReasonLbl.text = Constants.internalServerErrorTitle
        }
    }
    
    private func hideFailView(){
        self.networkConnectionFailView.isHidden = true
        self.competionsTableView.isHidden = false
    }
    
    private func listenOnObservables(){
        competionsViewModel.items.bind(to: competionsTableView.rx.items){ (tableView, row, element) in
         
            self.hideFailView()
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CompetionTableViewCell.identifier, for: IndexPath(index: row)) as! CompetionTableViewCell
            cell.configureCellModel(CompetitionModel: element)
            return cell
        }.disposed(by: disposeBag)
        
        
        competionsViewModel.errorObservable.subscribe(onNext: {[weak self] (error) in
            guard let self = self else{
                return
            }
            self.showAlert(title: Constants.alertErrorTitle, body: error.localizedDescription, actions: [UIAlertAction(title: Constants.alertOk, style: UIAlertAction.Style.default, handler: nil)])
            self.showFailViewWith(error:error)
        }).disposed(by: disposeBag)
        
        competionsViewModel.loadingObservable.subscribe(onNext: {[weak self] (boolValue) in
            guard let self = self else{
                return
            }
            switch boolValue{
            case true:
                self.showLoading()
            case false:
                self.hideLoading()
            }
        }).disposed(by: disposeBag)
        
        competionsTableView.rx.modelSelected(Competition.self).subscribe(onNext: {[weak self] (competitionItem) in
            guard let self = self else {return}
            guard let vc = self.storyboard?.instantiateViewController(identifier: Constants.CompetitionDetailsVC, creator: { coder in
                return CompetitionDetailsViewController(coder: coder, competition: competitionItem)
            }) else {
                fatalError("Failed to load EditUserViewController from storyboard.")
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
    }
    
    @IBAction func didTapRetryButton(_ sender: UIButton) {
        competionsViewModel.fetchdata()
    }
    
}

extension CompetionsViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
