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
    
    func getGameLibrary(username: String){
        var savedLibrary = CoreDataService.shared.fetchGameLibrary()
        savedLibrary.sort(by: {$1.name > $0.name })
        self.gameLibrary.library = savedLibrary
        
        NetworkService.shared.request("https://gamecomparison.azurewebsites.net/api/GetCollection/\(username)?code=rXtVglq/1uPAmep6lFGGo4ix93bgqmH45eUDxDcc0DboxYZjFXYQTg==", completion: {result in
            
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

                        return game
                    })
                    
                    for remote in remoteLibrary {
                        let alreadySaved = savedLibrary.contains(where: {
                            return $0.id == remote.id
                        })
                        
                        if (alreadySaved == false) {
                            API.downloadImage(url: remote.imageUrl, completion: { result in
                                let newGame = Game(context: CoreDataService.shared.context)
                                newGame.desc = remote.desc
                                newGame.id = remote.id
                                newGame.image = result
                                newGame.imageUrl = remote.imageUrl
                                newGame.name = remote.name
                                newGame.numberPlays = remote.numberPlays
                                newGame.owned = remote.owned
                                newGame.subtype = remote.subtype
                                newGame.type = remote.type
                                newGame.yearPublished = remote.yearPublished
                                
                                DispatchQueue.main.async{
                                    self.gameLibrary.library.append(newGame)
                                    CoreDataService.shared.saveContext()
                                    print(remote)
                                }
                            })
                        }
                    }
                    
//                    for saved in remoteLibrary {
//                        let deleted = remoteLibrary.contains(where: { $0.id == saved.id})
//                        
//                        if(deleted == false) {
//                            self.gameLibrary.library.removeAll(where: { $0.id == saved.id})
//                            print(saved)
//                        }
//                    }
                } catch {
                    print(error)
                }
                break
            case .failure(_): break
            }
        })
    }
    
    static func downloadImage(url: String, completion: @escaping (Data?) -> Void) {
        NetworkService.shared.request(url, completion: { (result) in
            
            switch result {
            case .success(let data):
                completion(data)
                break
            case .failure(_): break
            }
        })
    }
}
