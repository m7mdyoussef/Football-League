

import Foundation

protocol CompetionsApiContract {
    func getAllCompetions(completion: @escaping (Result<CompetionModelElement?, NSError>) -> Void)
}
