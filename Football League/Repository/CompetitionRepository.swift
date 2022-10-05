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
    private var networkConnectionFailedSubject = PublishSubject<Bool>()
    private var dataSubject = PublishSubject<[Competition]>()
    private var competitionsAPI:CompetionsApiContract!
    private var disposeBag:DisposeBag
    
    
    var dataObservable: Observable<[Competition]>
    var errorObservable: Observable<(String)>
    var loadingObservable: Observable<Bool>
    var networkConnectionFailedObservable: Observable<Bool>
    var items: BehaviorRelay<[Competition]>
    
    private var localDataSource:CompetitionsLocalDataSource
    
    init() {
        errorObservable = errorsubject.asObservable()
        loadingObservable = loadingsubject.asObservable()
        networkConnectionFailedObservable = networkConnectionFailedSubject.asObservable()
        dataObservable = dataSubject.asObservable()
        items = BehaviorRelay<[Competition]>(value: [])
        
        
        competitionsAPI = CompetionsAPI.sharedInstance
        localDataSource = CompetitionsLocalDataSource.sharedInstance
        disposeBag = DisposeBag()
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
            case .failure(_):
                print("get from caching")
                self.localDataSource.fetchAllCompetitions { (competitionsArray) in
                    if let competitionsArray = competitionsArray {
                        self.items.accept(competitionsArray)
                        self.dataSubject.onNext(competitionsArray)
                       
                        self.loadingsubject.onNext(false)
                        return
                    }else{
                        self.loadingsubject.onNext(false)
                        self.networkConnectionFailedSubject.onNext(true)
                        //handle in case server error
                      //  self.errorsubject.onNext(error.localizedDescription)
                        
                    }
                }
            }
            
        }
    }
    
    private func handleData(data: [Competition]?) {
        
        guard let data = data else {return}
        let compContentArr = data
        
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
            
            
            group.notify(queue: .main) { [weak self] in
                guard let self = self else{return}
                if comp == (data.count - 1) {
                    self.localDataSource.deleteAllData()
                    //cach and return to dataSubject
                    self.loadingsubject.onNext(false)
                    
                    self.localDataSource.save(competitionArray: compContentArr) { [weak self] (result) in
                        guard let self = self else{return}
                        switch result{
                        case .success(let bol):
                            if(bol){
                                print("HD* in b=true")
                            }
                        case .failure(let error):
                            print("HD* in error")
                            self.errorsubject.onNext(error.localizedDescription)
                        }
                        self.items.accept(compContentArr)
                        self.dataSubject.onNext(compContentArr)
                    }
                }
            }
        }
    }
    
}
