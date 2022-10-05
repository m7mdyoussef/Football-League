
import Foundation
import RxSwift

protocol CompetitionRepositoryContract : BaseViewModelContract{
    var dataObservable:Observable<[Competition]> {get}
    func fetchData()
}
