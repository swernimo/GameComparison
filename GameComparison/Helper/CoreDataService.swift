//
//  CoreDataService.swift
//  GameComparison
//
//  Created by Personal on 7/31/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import Foundation
import CoreData

class CoreDataService {
    private init() {}
    
    static let shared = CoreDataService()
    var context: NSManagedObjectContext { return persistentContainer.viewContext }

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "GameComparison")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        context.mergePolicy = NSOverwriteMergePolicy
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                AnalysticsService.shared.logException(exception: error, errorMsg: "Error saving context")
            }
        }
    }
    
    func fetchGameLibrary() -> [Game]
     {
         let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
         request.returnsObjectsAsFaults = false
         do {
             let result = try context.fetch(request)
            guard let library = result as? [Game] else { return [] }
            return library
         } catch {
            AnalysticsService.shared.logException(exception: error, errorMsg: "Fetching data Failed")
         }
        return []
     }
    
    func deleteAllData() {
        deleteGameLibrary()
    }
    
    private func deleteGameLibrary() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        } catch let error {
            AnalysticsService.shared.logException(exception: error, errorMsg: "Error deleting all data")
        }
        
    }
}
