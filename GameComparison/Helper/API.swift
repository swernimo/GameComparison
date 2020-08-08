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
        
        NetworkService.shared.request("https://gamecomparison.azurewebsites.net/api/GetCollection/\(username)?code=rXtVglq/1uPAmep6lFGGo4ix93bgqmH45eUDxDcc0DboxYZjFXYQTg==", completion: { result in
            
            switch (result) {
            case .success(let rawData):
                do {
                    guard let json = try JSONSerialization.jsonObject(with: rawData, options:[]) as? [[String: Any]] else { return }
                    
                    let remoteLibrary: [Game] = json.compactMap({
                        guard
                            let subType = $0["subType"] as? String,
                            let objectType = $0["objectType"] as? String,
                            let id = $0["id"] as? Int32,
                            let name = $0["name"] as? String,
                            let year = $0["yearPublished"] as? Int32,
                            let imageUrl = $0["imageUrl"] as? String,
                            let owned = $0["owned"] as? Bool,
                            let numberPlays = $0["numberPlays"] as? Int32
                        else { return nil }
                        
                        let game = Game(context: CoreDataService.shared.context)
                        game.subtype = subType
                        game.type = objectType
                        game.id = id
                        game.name = name
                        game.owned = owned
                        game.numberPlays = numberPlays
                        game.yearPublished = year
                        game.imageUrl = imageUrl
                        game.imageFilePath = "\(game.name).\(game.id)"
                        return game
                    })
                    
                    
                    for remote in remoteLibrary {
                        let alreadySaved = savedLibrary.contains(where: {
                            return $0.id == remote.id
                        })

                        if (alreadySaved == false) {
                            API.downloadImage(url: remote.imageUrl, completion: { data in
                                if (data != nil) {
                                    UserDefaults.standard.set(data, forKey: remote.imageFilePath)
                                    DispatchQueue.main.async {
                                        CoreDataService.shared.saveContext()
                                        self.gameLibrary.library.append(remote)
                                    }
                                }
                            })
                        }
                    }
                    //TODO: remove items from saved library that are no longer present in remote collection
//                    for saved in remoteLibrary {
//                        let deleted = remoteLibrary.contains(where: { $0.id == saved.id})
//                        
//                        if(deleted == false) {
//                            self.gameLibrary.library.removeAll(where: { $0.id == saved.id})
//                            print(saved)
                    //delete image from disk
//                        }
//                    }
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
    
    static func downloadImage(url: String?, completion: @escaping (Data?) -> Void) {
        if (url != nil) {
            NetworkService.shared.request(url, completion: { (result) in
                
                switch result {
                case .success(let data):
                    completion(data)
                    break
                case .failure(let error):
                    print("Error downloading image: \(error)")
                    completion(nil)
                    break
                }
            })
        } else {
            completion(nil)
        }
    }
    
    static func getGameStatistics(id: Int32, completion: @escaping (GameStatistics?) -> Void) {
        NetworkService.shared.request("https://gamecomparison.azurewebsites.net/api/GetGameStatistics/\(id)?code=rT/jCOHWPKD1H9EUfAsFjbR/XrVxPvqpqB9uRu17hw7RN7fptWVF3Q==", completion: {result in
            
            switch result {
            case .success(let data):
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options:[]) as? [String: Any] else { return }
                    
                    let stats = GameStatistics(context: CoreDataService.shared.context)
//                    let complexity = (json["complexity"] as? NSNumber)!
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
}
