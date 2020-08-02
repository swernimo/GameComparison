//
//  NetworkingService.swift
//  GameComparison
//
//  Created by Personal on 7/31/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import Foundation
import UIKit

class NetworkService {
    
    private init() {}
    static let shared = NetworkService()
    
    func request(_ urlPath: String, completion: @escaping (Result<Data, NSError>) -> Void ) {
        let url = URL(string: urlPath)!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {
            data, _, err in
            
            if let d = data {
                completion(.success(d))
            } else if let error = err {
                completion(.failure(error as NSError))
            }
        })
        task.resume()
    }
}
