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
    public private(set) var avgPlayerAge: Double = 0
    public private (set) var avgPlayTime: Double = 0
    public private(set) var avgMinPlayerCount: Double = 0
    public private(set) var avgMaxPlayerCount: Double = 0
    
    init(from: [Game]) {
        self.library = from
        self.libraryCount = Double(self.library.count)
        self.avgRating = self.setAverageRating()
        self.avgComplexity = self.setAverageComplexity()
        self.avgPlayerCount = self.setAveragePlayerCount()
        self.avgPlayerAge = self.setPlayerAge()
        self.avgPlayTime = self.setAvgeragePlayTime()
        self.avgMinPlayerCount = self.setAverageMinPlayerCount()
        self.avgMaxPlayerCount = self.setAverageMaxPlayerCount()
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
    
    private func setPlayerAge() -> Double {
        let ageSum = self.library.reduce(0, { a, b in
            a + b.statistics!.suggestedPlayerAge
        })
        
        return Double(ageSum) / libraryCount
    }
    
    func getPlayerAgeDifference(_ comparedTo: GameComparisonObject) -> Double {
        var difference = self.avgPlayerAge - Double(comparedTo.suggestedPlayerAge)
        if (difference < 0) {
            difference *= -1
        }
        return difference
    }
    
    private func setAvgeragePlayTime() -> Double {
        let timeSum = self.library.reduce(0, { a, b in
            a + b.statistics!.playingTime
        })
        
        return Double(timeSum) / libraryCount
    }
    
    func getPlayTimeDifference(_ comparedTo: GameComparisonObject) -> Double {
        var difference = self.avgPlayTime - Double(comparedTo.playingTime)
        if (difference < 0) {
            difference *= -1
        }
        return difference
    }
    
    private func setAverageMinPlayerCount() -> Double {
        let minPlayerSum = self.library.reduce(0, { a, b in
            a + b.statistics!.minPlayers
        })
        
        return Double(minPlayerSum) / libraryCount
    }
    
    func getAvgMinPlayerCount(_ comparedTo: GameComparisonObject) -> Double {
        var difference = self.avgMinPlayerCount - Double(comparedTo.minPlayers)
        if (difference < 0) {
            difference *= -1
        }
        return difference
    }
    
    private func setAverageMaxPlayerCount() -> Double {
        let maxPlayerSum = self.library.reduce(0, { a, b in
            a + b.statistics!.maxPlayers
        })
        
        return Double(maxPlayerSum) / libraryCount
    }
    
    func getAvgMaxPlayerCount(_ comparedTo: GameComparisonObject) -> Double {
        var difference = self.avgMaxPlayerCount - Double(comparedTo.maxPlayers)
        if (difference < 0) {
            difference *= -1
        }
        return difference
    }
}
