//
//  data.swift
//  GameComparison
//
//  Created by Personal on 7/30/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import Foundation

let searchResultsPreviewData: [SearchResult] = load("searchResultsPreviewData.json")
let gameComparisonPreviewData: GameComparisonObject = load("gamecomparison.json")
let gameLibraryPreviewData: [Game] = loadCollection()

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func loadCollection() -> [Game] {
    let data: Data
    let filename = "collection.json"
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
           else {
               fatalError("Couldn't find \(filename) in main bundle.")
       }
    do {
        data = try Data(contentsOf: file)

        guard let json = try JSONSerialization.jsonObject(with: data, options:[]) as? [[String: Any]] else { return [] }
        
        let remoteLibrary: [Game] = json.compactMap({
            guard
                let objectType = $0["objectType"] as? String,
                let id = $0["id"] as? Int32,
                let name = $0["name"] as? String,
                let year = $0["yearPublished"] as? Int32,
                let imageUrl = $0["imageUrl"] as? String,
                let owned = $0["owned"] as? Bool,
                let numberPlays = $0["numberPlays"] as? Int32,
                let statsJSON = $0["statistics"] as? [String: Any],
                let complexity = statsJSON["complexity"] as? Double,
                let description = statsJSON["description"] as? String,
                let maxPlayers = statsJSON["maxPlayers"] as? Int32,
                let minPlayers = statsJSON["minPlayers"] as? Int32,
                let playerAge = statsJSON["playerAge"] as? Int32,
                let playingTime = statsJSON["playingTime"] as? Int32,
                let rating = statsJSON["rating"] as? Double,
                let recommendPlayers = statsJSON["recommendedPlayers"] as? Int32,
                let suggestedPlayerAge = statsJSON["suggestedPlayerAge"] as? Int32
            else { return nil }
            
            let game = Game(context: CoreDataService.shared.context)
            game.type = objectType
            game.id = id
            game.name = name
            game.owned = owned
            game.numberPlays = numberPlays
            game.yearPublished = year
            game.imageUrl = imageUrl
            game.imageFilePath = "\(game.name).\(game.id)"
            game.statistics = GameStatistics(context: CoreDataService.shared.context)
            game.statistics!.game = game
            game.statistics!.complexity = complexity
            game.statistics!.desc = description
            game.statistics!.maxPlayers = maxPlayers
            game.statistics!.minPlayers = minPlayers
            game.statistics!.playerAge = playerAge
            game.statistics!.playingTime = playingTime
            game.statistics!.rating = rating
            game.statistics!.recommendedPlayers = recommendPlayers
            game.statistics!.suggestedPlayerAge = suggestedPlayerAge
            return game
        })
        
        return remoteLibrary
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
}
