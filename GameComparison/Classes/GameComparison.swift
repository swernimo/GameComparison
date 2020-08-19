//
//  GameComparison.swift
//  GameComparison
//
//  Created by Personal on 8/16/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import Foundation

class GameComparison: Codable {
    public var id: Int
    public var name: String
    public var objectType: String
    public var yearPublished: Int
    public var imageUrl: String
    public var minPlayers: Int
    public var maxPlayers: Int
    public var playerAge: Int
    public var playingTime: Int
    public var rating: Double
    public var recommendedPlayers: Int
    public var suggestedPlayerAge: Int
    public var description: String
    public var complexity: Double
}
