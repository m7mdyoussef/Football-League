
import Foundation
import RxSwift
import RxRelay

class CompetitionsViewModel : CompetionsViewModelContract{
    
    var items: BehaviorRelay<[Competition]>
    
    var errorObservable: Observable<(String)>
    var loadingObservable: Observable<Bool>
    
    private var errorsubject = PublishSubject<String>()
    private var loadingsubject = PublishSubject<Bool>()
    
    private var disposeBag:DisposeBag
    private var repo:CompetitionRepositoryContract
    
    init() {
        errorObservable = errorsubject.asObservable()
        loadingObservable = loadingsubject.asObservable()
        items = BehaviorRelay<[Competition]>(value: [])
        
        disposeBag = DisposeBag()
        repo = CompetitionRepository()
        bind()
    }
    
    private func bind() {
        
        repo.dataObservable.subscribe(onNext: {[weak self] (ComArray) in
            guard let self = self else {return}
            self.items.accept(ComArray)
        }).disposed(by: disposeBag)
        
        repo.errorObservable.subscribe(onNext: {[weak self] (message) in
            guard let self = self else {return}
            self.errorsubject.onNext(message)
        }).disposed(by: disposeBag)
        
        repo.loadingObservable.subscribe(onNext: {[weak self] (bool) in
            guard let self = self else {return}
            self.loadingsubject.onNext(bool)
        }).disposed(by: disposeBag)
        
    }
    
    func fetchdata(){
        repo.fetchData()
    }
}

