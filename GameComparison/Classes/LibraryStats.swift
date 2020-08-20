//
//  LibraryStats.swift
//  GameComparison
//
//  Created by Personal on 8/18/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import Foundation

class LibraryStats{
    private var library: [Game]
    public private(set) var avgRating: Double = 0
    public private(set) var avgComplexity: Double = 0
    private var libraryCount: Double
    public private(set) var avgPlayerCount: Double = 0
    
    init(from: [Game]) {
        self.library = from
        self.libraryCount = Double(self.library.count)
        self.avgRating = self.setAverageRating()
        self.avgComplexity = self.setAverageComplexity()
        self.avgPlayerCount = self.setAveragePlayerCount()
    }
    
    private func setAverageRating() -> Double {
        let ratingSum = self.library.reduce(0, { a, b in
            a + b.statistics!.rating
        })
        return ratingSum / self.libraryCount
    }
    
    func getRatingDifference(_ comparedTo: GameComparisonObject) -> Double {
        var difference = self.avgRating - comparedTo.rating
        if (difference < 0) {
            difference *= -1
        }
        return difference
    }
    
    private func setAverageComplexity() -> Double {
        let complexitySum = self.library.reduce(0, {a, b in
            a + b.statistics!.complexity
        })
        return complexitySum / self.libraryCount
    }
    
    func getComplexityDifference(_ comparedTo: GameComparisonObject) -> Double {
        var difference = self.avgComplexity - comparedTo.complexity
        if (difference < 0) {
            difference *= -1
        }
        return difference
        
    }
    
    private func setAveragePlayerCount() -> Double {
        let sumPlayerCount = self.library.reduce(0, { a, b in
            a + b.statistics!.recommendedPlayers
        })
        
        return Double(sumPlayerCount) / self.libraryCount
    }
    
    func getPlayerCountDifference(_ comparedTo: GameComparisonObject) -> Double {
        var difference = self.avgPlayerCount - Double(comparedTo.recommendedPlayers)
        if (difference < 0) {
            difference *= -1
        }
        return difference
        
    }
}
