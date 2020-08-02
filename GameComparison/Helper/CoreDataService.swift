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
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "GameComparison")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchGameLibrary() -> [Game]
     {
         print("Fetching Data..")
         let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
         request.returnsObjectsAsFaults = false
         do {
             let result = try context.fetch(request)
            guard let library = result as? [Game] else { return [] }
            return library
         } catch {
             print("Fetching data Failed")
         }
        return []
     }
}
