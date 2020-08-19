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
    
    init(from: [Game]) {
        self.library = from
        self.libraryCount = Double(self.library.count)
        self.avgRating = self.setAverageRating()
        self.avgComplexity = self.setAverageComplexity()
    }
    
    private func setAverageRating() -> Double {
        let ratingSum = self.library.reduce(0, { a, b in
            a + b.statistics!.rating
        })
        return ratingSum / self.libraryCount
    }
    
    func getRatingDifference(_ comparedTo: GameComparison) -> Double {
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
    
    func getComplexityDifference(_ comparedTo: GameComparison) -> Double {
        var difference = self.avgComplexity - comparedTo.rating
        if (difference < 0) {
            difference *= -1
        }
        return difference
        
    }
}
