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
//    static func getCollection(username: String, completion: @escaping ([CollectionItem]) -> Void) {
//        NetworkService.shared.request("https://gamecomparison.azurewebsites.net/api/GetCollection/\(username)?code=rXtVglq/1uPAmep6lFGGo4ix93bgqmH45eUDxDcc0DboxYZjFXYQTg==", completion: { (result) in
//            
//            switch result {
//            case .success(let data):
//                 let collection = try! JSONDecoder().decode([CollectionItem].self, from: data)
//                    completion(collection)
//                break
//            case .failure(_) :
//                break
//            }
//        })
//    }
    
    static func getGameLibrary(username: String, completion: @escaping ([Game]) -> Void) {
        
        NetworkService.shared.request("https://gamecomparison.azurewebsites.net/api/GetCollection/\(username)?code=rXtVglq/1uPAmep6lFGGo4ix93bgqmH45eUDxDcc0DboxYZjFXYQTg==", completion: {result in
            
            switch (result) {
            case .success(let rawData):
                do {
                    guard let json = try JSONSerialization.jsonObject(with: rawData, options:[]) as? [[String: Any]] else { return }
                    
                    let library: [Game] = json.compactMap({
                        guard
                            let subType = $0["subType"] as? String,
                            let objectType = $0["objectType"] as? String,
                            let id = $0["id"] as? Int32,
                            let name = $0["name"] as? String,
                            let year = $0["yearPublished"] as? Int32,
                            let imageUrl = $0["imageUrl"] as? String,
                            let owned = $0["owned"] as? Bool,
                            let numberPlayes = $0["numberPlays"] as? Int32
                        else { return nil }
                        
                        let game = Game(context: CoreDataService.shared.context)
                        game.subtype = subType
                        game.type = objectType
                        game.id = id
                        game.name = name
                        game.owned = owned
                        game.numberPlays = numberPlayes
                        game.yearPublished = year
                        
                        downloadImage(url: imageUrl, completion: {
                            result in
                            game.image = result
                            CoreDataService.shared.saveContext()
                        })
                        return game
                    })
                    
                    completion(library)
                } catch {
                    print(error)
                }
                break
            case .failure(_): break
            }
        })
        
//        let shared = URLSession.shared
//        let url = URL(string: "https://gamecomparison.azurewebsites.net/api/GetCollection/\(username)?code=rXtVglq/1uPAmep6lFGGo4ix93bgqmH45eUDxDcc0DboxYZjFXYQTg==")!
//        let task = shared.dataTask(with: url, completionHandler: {
//            data, response, error in
//            do {
//                guard let json = try JSONSerialization.jsonObject(with: data!, options:[]) as? [[String: Any]] else { return }
//
//                let library: [Game] = json.compactMap({
//                    guard
//                        let subType = $0["subType"] as? String,
//                        let objectType = $0["objectType"] as? String,
//                        let id = $0["id"] as? Int32,
//                        let name = $0["name"] as? String,
//                        let year = $0["yearPublished"] as? Int32,
//                        let imageUrl = $0["imageUrl"] as? String,
//                        let owned = $0["owned"] as? Bool,
//                        let numberPlayes = $0["numberPlays"] as? Int32
//                    else { return nil }
//
//                    let game = Game(context: CoreDataService.shared.context)
//                    game.subtype = subType
//                    game.type = objectType
//                    game.id = id
//                    game.name = name
//                    game.owned = owned
//                    game.numberPlays = numberPlayes
//                    game.yearPublished = year
//
//                    downloadImage(url: imageUrl, completion: {
//                        result in
//                        game.image = result
//                        CoreDataService.shared.saveContext()
//                    })
//                    return game
//                })
//
//                completion(library)
//            } catch {
//                print(error)
//            }
//        })
//        task.resume()
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
