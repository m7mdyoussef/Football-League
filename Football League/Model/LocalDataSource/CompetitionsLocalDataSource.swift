//
//  GGGGGg.swift
//  Football League
//
//  Created by Joe on 04/10/2022.
//


import UIKit
import CoreData

class CompetitionsLocalDataSource{
    static let sharedInstance = CompetitionsLocalDataSource()
    
    private let appDelegate:AppDelegate
    private let managedContext:NSManagedObjectContext
    private let entity:NSEntityDescription?
    private init(){
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.newBackgroundContext()
        entity = NSEntityDescription.entity(forEntityName: Constants.competitionEntity,in: managedContext)
        
    }
    
    func save(competitionArray: [Competition],completion: @escaping (Result<Bool,NSError>) -> Void){
        guard let entity = entity else{
            completion(.failure(NSError(domain: Constants.databaseDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: Constants.genericError])))
            return
        }
        
        for competition in competitionArray{
            
            let competitions = NSManagedObject(entity: entity, insertInto: managedContext)
            let data = try? NSKeyedArchiver.archivedData(withRootObject: competition, requiringSecureCoding: false)
            
            competitions.setValue(data, forKey: Constants.competitionData)
            
        }
        managedContext.perform {[weak self] in
            guard let self = self else {return}
            do {
                try self.managedContext.save()
                completion(.success(true))
                
            } catch let error as NSError {
                completion(.failure(error))
                return
            }
        }
    }
    
    func fetchAllCompetitions(completion: @escaping ([Competition]?) -> Void){
        var Competitions = [Competition]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.competitionEntity)
        
        managedContext.perform {[weak self] in
            guard let self = self else {return}
            
            do {
                let storedCompetitions = try self.managedContext.fetch(fetchRequest)
                
                for storedCompetition in storedCompetitions{
                    let compID = storedCompetition.value(forKey: Constants.competitionData) as! Data
                    let retrieved = try! NSKeyedUnarchiver.unarchivedObject(ofClasses: [Competition.self,CompetitionTeamsModel.self,Team.self,Coach.self,Squad.self,NSArray.self,NSString.self,NSNumber.self], from: compID)
                    Competitions.append(retrieved as! Competition)
                }
                
                DispatchQueue.main.async {
                    if(Competitions.isEmpty){
                        completion(nil)
                    }else{
                        completion(Competitions)
                    }
                }
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func deleteAllData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.competitionEntity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                managedContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data error :", error)
        }
    }
}
