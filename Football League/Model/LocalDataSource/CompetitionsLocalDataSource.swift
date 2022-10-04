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
        entity = NSEntityDescription.entity(forEntityName: "CompetitionEntity",in: managedContext)
        
    }
    
    func save(competitionArray: [Competition],completion: @escaping (Result<Bool,NSError>) -> Void){
        print("in competitionArraySaved")
        guard let entity = entity else{
            print("cant find entity")
            completion(.failure(NSError(domain: "databaseDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: Constants.genericError])))
            return
        }
        
        for competition in competitionArray{
            
            let competitions = NSManagedObject(entity: entity, insertInto: managedContext)
            let data = try? NSKeyedArchiver.archivedData(withRootObject: competition, requiringSecureCoding: false)
            
            competitions.setValue(data, forKey: "competitionData")
            
        }
        managedContext.perform {[weak self] in
            guard let self = self else {return}
            do {
                try self.managedContext.save()
                print("PLDS* saved successfully")
                completion(.success(true))
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                completion(.failure(error))
                return
            }
        }
    }
    
    func fetchAllCompetitions(completion: @escaping ([Competition]?) -> Void){
        print("dttt::", NSDate(), "\n")
        var Competitions = [Competition]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CompetitionEntity")
        
        managedContext.perform {[weak self] in
            guard let self = self else {return}
            
            do {
                print("dttt::2", NSDate(), "\n")
                let storedCompetitions = try self.managedContext.fetch(fetchRequest)
                
                for storedCompetition in storedCompetitions{
                    print("dttt::3", NSDate(), "\n")
                    let compID = storedCompetition.value(forKey: "competitionData") as! Data
                    let retrieved = try! NSKeyedUnarchiver.unarchivedObject(ofClasses: [Competition.self,CompetitionTeamsModel.self,Team.self,Coach.self,Squad.self,NSArray.self,NSString.self,NSNumber.self], from: compID)
                    Competitions.append(retrieved as! Competition)
                    print("dttt::4", NSDate(), "\n")
                }
                
                print("ULDS* fetched successfully")
                
                DispatchQueue.main.async {
                    if(Competitions.isEmpty){
                        completion(nil)
                    }else{
                        print("dttt::5", NSDate(), "\n")
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
        print("in delete")
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CompetitionEntity")
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
