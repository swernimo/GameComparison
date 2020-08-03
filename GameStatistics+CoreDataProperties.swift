//
//  GameStatistics+CoreDataProperties.swift
//  GameComparison
//
//  Created by Personal on 8/1/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//
//

import Foundation
import CoreData


extension GameStatistics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameStatistics> {
        return NSFetchRequest<GameStatistics>(entityName: "GameStatistics")
    }

    @NSManaged public var average: NSDecimalNumber?
    @NSManaged public var bayesaverage: NSDecimalNumber?
    @NSManaged public var complexity: NSDecimalNumber?
    @NSManaged public var standardDeviation: NSDecimalNumber?
    @NSManaged public var game: Game?

}
