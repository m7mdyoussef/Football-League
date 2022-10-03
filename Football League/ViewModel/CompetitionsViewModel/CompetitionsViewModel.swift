
import Foundation
import RxSwift
import RxRelay

class CompetitionsViewModel : CompetionsViewModelContract{
    
    var items: BehaviorRelay<[Competition]>
    
    var errorObservable: Observable<(String)>
    var loadingObservable: Observable<Bool>
    
    private var errorsubject = PublishSubject<String>()
    private var loadingsubject = PublishSubject<Bool>()
    
    init() {
        errorObservable = errorsubject.asObservable()
        loadingObservable = loadingsubject.asObservable()
        items = BehaviorRelay<[Competition]>(value: [])
    }
}

