
import Foundation
import RxSwift
import RxRelay

class CompetitionsViewModel : CompetionsViewModelContract{
    
    var items: BehaviorRelay<[Competition]>
    
    var errorObservable: Observable<(NSError)>
    var loadingObservable: Observable<Bool>
    var networkConnectionFailedObservable: Observable<Bool>

    private var errorsubject = PublishSubject<NSError>()
    private var loadingsubject = PublishSubject<Bool>()
    private var networkConnectionFailedSubject = PublishSubject<Bool>()
    
    private var disposeBag:DisposeBag
    private var repo:CompetitionRepositoryContract
    
    init() {
        errorObservable = errorsubject.asObservable()
        loadingObservable = loadingsubject.asObservable()
        networkConnectionFailedObservable = networkConnectionFailedSubject.asObservable()
        items = BehaviorRelay<[Competition]>(value: [])
        
        disposeBag = DisposeBag()
        repo = CompetitionRepository()
        bind()
    }
    
    private func bind() {
        repo.networkConnectionFailedObservable.subscribe(onNext: {[weak self] (bool) in
            guard let self = self else {return}
            self.networkConnectionFailedSubject.onNext(bool)
        }).disposed(by: disposeBag)
        
        repo.dataObservable.subscribe(onNext: {[weak self] (ComArray) in
            guard let self = self else {return}
            self.items.accept(ComArray)
        }).disposed(by: disposeBag)
        
        repo.errorObservable.subscribe(onNext: {[weak self] (error) in
            guard let self = self else {return}
            self.errorsubject.onNext(error)
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

