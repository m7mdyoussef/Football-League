
import UIKit
import RxCocoa
import RxSwift


class CompetionsViewController: BaseViewController {
    
    @IBOutlet weak var networkConnectionFailView: UIView!
    @IBOutlet weak var retryButton: UIButton!
    
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
        self.title = "Competitions"
    }
    
    private func registerCellNibFile(){
        let competitionsNibCell = UINib(nibName: CompetionTableViewCell.identifier, bundle: nil)
        competionsTableView.register(competitionsNibCell, forCellReuseIdentifier: CompetionTableViewCell.identifier)
    }
    
    private func instantiateRXItems(){
        disposeBag = DisposeBag()
        competionsViewModel = CompetitionsViewModel()
    }
    
    private func showNetworkConnectionFailView(){
        self.networkConnectionFailView.isHidden = false
        self.competionsTableView.isHidden = true
    }
    
    private func hideNetworkConnectionFailView(){
        self.networkConnectionFailView.isHidden = true
        self.competionsTableView.isHidden = false
    }
    
    private func listenOnObservables(){
        
        competionsViewModel.networkConnectionFailedObservable.subscribe(onNext: {[weak self] (boolValue) in
            guard let self = self else{
                print("PVC* error in doneObservable")
                return
            }
            switch boolValue{
            case true:
                self.showNetworkConnectionFailView()
            case false:
                self.hideNetworkConnectionFailView()
            }
        }).disposed(by: disposeBag)
        
        competionsViewModel.items.bind(to: competionsTableView.rx.items){ (tableView, row, element) in
         
            self.hideNetworkConnectionFailView()
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CompetionTableViewCell.identifier, for: IndexPath(index: row)) as! CompetionTableViewCell
            cell.CompetitionModel = element
            return cell
        }.disposed(by: disposeBag)
        
        
        competionsViewModel.errorObservable.subscribe(onNext: {[weak self] (message) in
            guard let self = self else{
                print("PVC* error in errorObservable")
                return
            }
            self.showAlert(title: "Error", body: message, actions: [UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)])
        }).disposed(by: disposeBag)
        
        competionsViewModel.loadingObservable.subscribe(onNext: {[weak self] (boolValue) in
            guard let self = self else{
                print("PVC* error in doneObservable")
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
