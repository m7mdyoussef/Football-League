//
//  CompetitionRepository.swift
//  Football League
//
//  Created by Joe on 03/10/2022.
//

import Foundation
import RxSwift
import RxRelay

class CompetitionRepository: CompetitionRepositoryContract{
    
    private var errorsubject = PublishSubject<String>()
    private var loadingsubject = PublishSubject<Bool>()
    private var dataSubject = PublishSubject<[Competition]>()
    private var competitionsAPI:CompetionsApiContract!
    private var disposeBag:DisposeBag
    
    
    var dataObservable: Observable<[Competition]>
    var errorObservable: Observable<(String)>
    var loadingObservable: Observable<Bool>
    var items: BehaviorRelay<Competitions>
    
    init() {
        errorObservable = errorsubject.asObservable()
        loadingObservable = loadingsubject.asObservable()
        dataObservable = dataSubject.asObservable()
        items = BehaviorRelay<Competitions>(value: [])
        
        
        competitionsAPI = CompetionsAPI.sharedInstance
        disposeBag = DisposeBag()
//        fetchData()
    }
    
     func fetchData() {
        self.loadingsubject.onNext(true)
        
        competitionsAPI.getAllCompetions { [weak self] (result) in
            guard let self = self else{
                print("PVM* getComFailed")
                return
            }
            
            switch result{
            case .success(let competitionModel):
                print("2")
                self.handleData(data: competitionModel?.competitions)
            case .failure(let error):
                print("get from caching")
                self.loadingsubject.onNext(false)
                self.errorsubject.onNext(error.localizedDescription)
            }
            
        }
    }
    
    private func handleData(data: [Competition]?) {
        guard let data = data else {return}
       var compContentArr = data
        
        let group = DispatchGroup()
        
        for comp in 0..<data.count {
            guard let code = data[comp].code else {return}
            group.enter()
            competitionsAPI.getCompetionTeams(code: code) { [weak self] (result) in
                guard let self = self else{
                    print("PVM* getTeamsFailed")
                    return
                }
                
                switch result{
                case .success(let competitionTeamsModel):
                    print("3")
                    compContentArr[comp].teamsData = competitionTeamsModel
                case .failure(let error):
                    self.loadingsubject.onNext(false)
                    self.errorsubject.onNext(error.localizedDescription)
                }
                group.leave()
            }

            
            group.notify(queue: .main) {
                if comp == (data.count - 1) {
                    //cach and return to dataSubject
                    self.loadingsubject.onNext(false)
                    self.dataSubject.onNext(compContentArr)
                }
             }
        }
//        data?.forEach{ comp in
//            guard let code = comp.code else {return}
//            group.enter()
//            competitionsAPI.getCompetionTeams(code: code) { [weak self] (result) in
//                guard let self = self else{
//                    print("PVM* getTeamsFailed")
//                    return
//                }
//
//                switch result{
//                case .success(let competitionTeamsModel):
//                    print("3")
//                    byCode[code] = competitionTeamsModel?.count
//                case .failure(let error):
//                    self.errorsubject.onNext(error.localizedDescription)
//                }
//                group.leave()
//            }
//
//
//            group.notify(queue: .main) {
//
////                compContentArr.append(CompetitionContentModel(leagueName: comp.name, leagueShortName: comp.code, numberOfTeams: byCode[code], numberOfTGames: ((byCode[code]! - 1) * byCode[code]!) ))
//                print("ditcccc:: \(byCode[code])")
//                //data.map { byCode[$0]! }
//
//                if
//             }
//        }

        
        
    }
    
}
