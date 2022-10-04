
import UIKit
import RxCocoa
import RxSwift


class CompetionsViewController: BaseViewController {
    
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
    
    private func listenOnObservables(){
        competionsViewModel.items.bind(to: competionsTableView.rx.items){ (tableView, row, element) in
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

    }
}

extension CompetionsViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
