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
    static let currentDevice = UIDevice.current
    
    func get(_ urlPath: String, queryString: [QueryStringParameters]? = nil, completion: @escaping (Result<Data, Error>) -> Void ) {
        var urlString = Consts.URLs.APIBaseURL + urlPath
        if queryString != nil && queryString!.isEmpty == false{
            urlString += "?"
            queryString!.forEach({ param in
                if let value = param.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    urlString += "\(param.key)=\(value)&"
                }
            })
            urlString.removeLast()
            urlString += "&code=\(Consts.URLs.APIFunctionKey)"
        } else {
            urlString += "?code=\(Consts.URLs.APIFunctionKey)"
        }
        
        makeRequest(urlString, method: "GET", completion: completion)
    }
    
    func post(_ urlPath: String, body: [String: Any] = [:], completion: @escaping (Result<Data, Error>) -> Void ) {
        let urlString = Consts.URLs.APIBaseURL + urlPath + "?code=\(Consts.URLs.APIFunctionKey)"
        makeRequest(urlString, method: "POST", body: body, completion: completion)
    }
    
    private func makeRequest(_ url: String, method: String, body: [String: Any] = [:], completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = method
        let header = "UUID:\(NetworkService.currentDevice.identifierForVendor!)|AppVersion:\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String)|Platform:iOS|DeviceVersion:\(NetworkService.currentDevice.systemVersion)|DeviceModel:\(NetworkService.currentDevice.model)"
        let utf8 = header.data(using: .utf8)
        let base64 = utf8!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        request.addValue("\(base64)", forHTTPHeaderField: "DeviceInfo")
        if (!body.isEmpty){
            do {
                let json = try JSONSerialization.data(withJSONObject: body, options: .withoutEscapingSlashes)
                request.httpBody = json
            } catch {
                AnalysticsService.shared.logException(exception: CustomError.runtimeError("Error trying to serialize POST body to JSON", error))
            }
            
        }
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            let urlResponse = response as? HTTPURLResponse
            if (urlResponse != nil) {
                let statusCode = urlResponse!.statusCode
                if statusCode != 200 {
                    completion(.failure(NSError(domain: "Network Service request did not return 200", code: statusCode, userInfo: ["URL": String(describing: "urlResponse?.url")])))
                } else {
                    if let d = data {
                        completion(.success(d))
                    }
                }
            } else {
                if let d = data {
                    completion(.success(d))
                } else if let error = error {
                    completion(.failure(error as NSError))
                }
            }
        })
        
        task.resume()
    }
    
    func downloadImage(_ urlPath: String, completion: @escaping (Result<Data, Error>) -> Void ) {
        makeRequest(urlPath, method: "GET", completion: completion)
    }
}
