
import Foundation
import RxSwift

protocol BaseViewModelContract{
    var errorObservable:Observable<(NSError)>{get}
    var loadingObservable: Observable<Bool> {get}
    var networkConnectionFailedObservable: Observable<Bool> {get}

}
