//
//  Game+CoreDataProperties.swift
//  GameComparison
//
//  Created by Personal on 7/31/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: Int32
    @NSManaged public var image: Data?
    @NSManaged public var name: String
    @NSManaged public var numberPlays: Int32
    @NSManaged public var owned: Bool
    @NSManaged public var subtype: String
    @NSManaged public var type: String
    @NSManaged public var yearPublished: Int32
    @NSManaged public var statistics: GameStatistics?

}
