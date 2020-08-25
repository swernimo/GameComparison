//
//  Game+CoreDataProperties.swift
//  GameComparison
//
//  Created by Personal on 8/22/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var id: Int32
    @NSManaged public var imageFilePath: String
    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String
    @NSManaged public var numberPlays: Int32
    @NSManaged public var owned: Bool
    @NSManaged public var type: String
    @NSManaged public var yearPublished: Int32
    @NSManaged public var statistics: GameStatistics?

}
