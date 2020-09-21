//
//  API.swift
//  GameComparison
//
//  Created by Personal on 7/28/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

class API {
    private var gameLibrary: Library
    
    init(_ library: Library) {
        self.gameLibrary = library
    }
    
    func getGameLibrary(username: String) -> Void {
        var savedLibrary = CoreDataService.shared.fetchGameLibrary()
        savedLibrary.sort(by: {$1.name > $0.name })
        self.gameLibrary.library = savedLibrary
//        #if DEBUG
//        self.gameLibrary.library = gameLibraryPreviewData
//        #endif
        let username = username.trimmingCharacters(in: .whitespaces)
        let url = "\(Consts.URLs.APIBaseURL)/GetCollection/\(username)?code=\(Consts.URLs.APIFunctionKey)"
        
        NetworkService.shared.get(url, completion: { result in
            
            switch (result) {
            case .success(let rawData):
                do {
                    guard let json = try JSONSerialization.jsonObject(with: rawData, options:[]) as? [[String: Any]] else { return }
                    
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
                        game.imageFilePath = "\(game.id)"
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
                        
                        ImageHelper.shared.retrieveImage(url: game.imageUrl, key: game.imageFilePath, completion: {_ in })
                        return game
                    })
                    
                    for remote in remoteLibrary {
                        let alreadySaved = savedLibrary.contains(where: {
                            return $0.id == remote.id
                        })
                        if (alreadySaved == false) {
                            DispatchQueue.main.async {
                                self.gameLibrary.library.append(remote)
                                CoreDataService.shared.saveContext()
                            }
                        }
                    }
                    
                    for saved in self.gameLibrary.library {
                        let deleted = !remoteLibrary.contains(where: { $0.id == saved.id})
                        if(deleted) {
                            print("Game \(saved.name) has been deleted")
                            DispatchQueue.main.async {
                                self.gameLibrary.library.removeAll(where: { $0.id == saved.id})
                            }
                            CoreDataService.shared.context.delete(saved)
                            ImageHelper.shared.deleteImage(forKey: "\(saved.id)")
                        }
                    }
                } catch {
                    print(error)
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    static func getGameStatistics(game: Game, completion: @escaping (GameStatistics?) -> Void) {
        NetworkService.shared.get("\(Consts.URLs.APIBaseURL)/GetGameStatistics/\(game.id)?code=\(Consts.URLs.APIFunctionKey)", completion: { result in
            
            switch result {
            case .success(let data):
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options:[]) as? [String: Any] else { return }
                    
                    let stats = GameStatistics(context: CoreDataService.shared.context)
                    stats.complexity = (json["complexity"] as? Double)!
                    stats.desc = (json["description"] as? String)!
                    stats.maxPlayers = (json["maxPlayers"] as? Int32)!
                    stats.minPlayers = (json["minPlayers"] as? Int32)!
                    stats.playerAge = (json["playerAge"] as? Int32)!
                    stats.playingTime = (json["playingTime"] as? Int32)!
                    stats.rating = (json["rating"] as? Double)!
                    stats.recommendedPlayers = (json["recommendedPlayers"] as? Int32)!
                    stats.suggestedPlayerAge = (json["suggestedPlayerAge"] as? Int32)!
                    completion(stats)
                    
                }catch {
                    print("Error while unpacking get statistics result. Error: \(error)")
                    completion(nil)
                }
                break;
            case .failure(let error):
                print(error)
                completion(nil)
                break;
            }
        })
    }
    
    static func searchByUPC(_ upc: String, completion: @escaping ([SearchResult]?) -> Void) {
        let url = "\(Consts.URLs.APIBaseURL)/SearchByUPC/\(upc)?code=\(Consts.URLs.APIFunctionKey)"
        NetworkService.shared.get(url, completion: { result in
            switch (result) {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let results = try decoder.decode([SearchResult].self, from: data)
                    completion(results)
                } catch{
                    print("Error unpacking search by upc results. Error: \(error)")
                    completion(nil)
                }
                break;
            case .failure(let error):
                print("Error searching by UPC. Error: \(error)")
                completion(nil)
                break;
            }
        })
    }
    
    static func searchByTitle(title: String, completion: @escaping ([SearchResult]?) -> Void){
        if let parameters = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = "\(Consts.URLs.APIBaseURL)/SearchByTitle/?code=\(Consts.URLs.APIFunctionKey)&title=\(parameters)"
            NetworkService.shared.get(url, completion: { result in
                switch (result) {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let results = try decoder.decode([SearchResult].self, from: data)
                        completion(results)
                    }
                    catch{
                        print("Error unpacking search by title results. Error: \(error)")
                        completion(nil)
                    }
                    break;
                case .failure(let error):
                    print("Failed searching by title")
                    print(error)
                    completion(nil)
                    break;
                }
            })
        }
    }
    
    static func searchById(gameId: Int, completion: @escaping (GameComparisonObject?) -> Void){
        let url = "\(Consts.URLs.APIBaseURL)/GetGameDetails/\(gameId)?code=\(Consts.URLs.APIFunctionKey)"
        NetworkService.shared.get(url, completion: { result in
            switch (result) {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(GameComparisonObject.self, from: data)
                    completion(result)
                }catch{
                    print("Error unpacking get game details. Error: \(error)")
                }
                break;
            case .failure(let error):
                print("Error getting game details. Error: \(error)")
                completion(nil)
                break;
            }
        })
    }
    
    static func addBarcode(gameId: Int32, barcode: String, completion: @escaping (Bool) -> Void) -> Void {
        let url = "\(Consts.URLs.APIBaseURL)/AddBarcode/\(gameId)/\(barcode)/?code=\(Consts.URLs.APIFunctionKey)"
        NetworkService.shared.post(url, completion: { result in
            switch (result) {
            case .success(_):
                completion(true)
                break;
            case .failure(let error):
                print("Error updating game with barcode with error: \(error)")
                completion(false)
                break;
            }
        })
    }
}
