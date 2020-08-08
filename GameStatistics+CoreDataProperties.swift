//
//  GameStatistics+CoreDataProperties.swift
//  GameComparison
//
//  Created by Personal on 8/8/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//
//

import Foundation
import CoreData


extension GameStatistics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameStatistics> {
        return NSFetchRequest<GameStatistics>(entityName: "GameStatistics")
    }

    @NSManaged public var minPlayers: Int32
    @NSManaged public var maxPlayers: Int32
    @NSManaged public var playingTime: Int32
    @NSManaged public var playerAge: Int32
    @NSManaged public var recommendedPlayers: Int32
    @NSManaged public var complexity: Double
    @NSManaged public var rating: Double
    @NSManaged public var suggestedPlayerAge: Int32
    @NSManaged public var desc: String
    @NSManaged public var game: Game?

}
