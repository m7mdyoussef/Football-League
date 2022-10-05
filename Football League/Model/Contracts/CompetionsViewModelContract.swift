
import Foundation
import RxSwift
import RxRelay

protocol CompetionsViewModelContract : BaseViewModelContract {
    var items: BehaviorRelay<[Competition]> {get}
    func fetchdata()
}
