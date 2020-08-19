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
    
    init(from: [Game]) {
        self.library = from
    }
    
    func getAverageRating() -> Double {
        let ratingSum = self.library.reduce(0, { a, b in
            a + b.statistics!.rating
        })
        return ratingSum / Double(self.library.count)
    }
}
