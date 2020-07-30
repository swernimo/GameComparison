//
//  API.swift
//  GameComparison
//
//  Created by Personal on 7/28/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import Foundation
import SwiftUI

class API {
    static func getCollection(username: String, completion: @escaping ([CollectionItem]) -> Void) {
        let shared = URLSession.shared
        let url = URL(string: "https://gamecomparison.azurewebsites.net/api/GetCollection/\(username)?code=rXtVglq/1uPAmep6lFGGo4ix93bgqmH45eUDxDcc0DboxYZjFXYQTg==")!
        let task = shared.dataTask(with: url, completionHandler: {
            data, response, error in
            let collection = try! JSONDecoder().decode([CollectionItem].self, from: data!)
            completion(collection)
        })
        task.resume()
    }
    
    static func downloadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        let shared = URLSession.shared
        let url = URL(string: url)!
        let task = shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let imageData = data else { return }
            let image = UIImage(data: imageData)
            completion(image)
        })
        task.resume()
    }
}
