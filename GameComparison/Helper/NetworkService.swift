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
    
    func get(_ urlPath: String, queryString: [QueryStringParameters]? = nil, completion: @escaping (Result<Data, NSError>) -> Void ) {
        var urlString = Consts.URLs.APIBaseURL + "/" + urlPath
        if queryString != nil && queryString!.isEmpty == false{
            urlString += "?"
            queryString!.forEach({ param in
                if let value = param.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    urlString += "&\(param.key)=\(value)"
                }
            })
            urlString += "&code=\(Consts.URLs.APIFunctionKey)"
        } else {
            urlString += "?code=\(Consts.URLs.APIFunctionKey)"
        }
        
        makeRequest(urlString, method: "GET", completion: completion)
    }
    
    func post(_ urlPath: String, completion: @escaping (Result<Data, NSError>) -> Void ) {
        makeRequest(urlPath, method: "POST", completion: completion)
    }
    
    private func makeRequest(_ url: String, method: String, completion: @escaping (Result<Data, NSError>) -> Void) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("\(String(describing: UIDevice.current.identifierForVendor))", forHTTPHeaderField: "DeviceInfo")
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            if let d = data {
                completion(.success(d))
            } else if let error = error {
                completion(.failure(error as NSError))
            }
        })
        
        task.resume()
        
    }
    
    func downloadImage(_ urlPath: String, completion: @escaping (Result<Data, NSError>) -> Void ) {
        makeRequest(urlPath, method: "GET", completion: completion)
    }
}
