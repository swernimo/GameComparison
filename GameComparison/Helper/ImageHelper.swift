//Original Source: https://programmingwithswift.com/save-images-locally-with-swift-5/
//Modified by: Sean Wernimont 2020

import Foundation
import SwiftUI

class ImageHelper {
    static let shared = ImageHelper()
    
    func retrieveImage(url: String?, key: String, completion: @escaping (Data?) -> Void) {
        if let filePath = self.filePath(forKey: key), let fileData = FileManager.default.contents(atPath: filePath.path) {
            if(fileData.isEmpty) {
                downloadImage(forURL: url, completion: { data in
                    if let data = data {
                        self.saveImageToDisk(forKey: key, withData: data)
                        completion(data)
                    } else {
                        completion(nil)
                    }
                })
            } else {
                completion(fileData)
            }
        } else {
            downloadImage(forURL: url, completion: { data in
                if let data = data {
                    self.saveImageToDisk(forKey: key, withData: data)
                    completion(data)
                } else {
                    completion(nil)
                }
            })
        }
    }
    
    private func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
       
        return documentURL.appendingPathComponent(key)
    }
    
    private func saveImageToDisk(forKey key: String, withData data:Data) -> Void {
        guard let url = filePath(forKey: key) else {
            AnalysticsService.shared.logMessage("Error could not find file url for key \(key)")
            return
        }
        
        do {
            try data.write(to: url)
        }catch{
            AnalysticsService.shared.logException(exception: CustomError.runtimeError("Error trying to save image to disk at location \(url)", error))
        }
    }
    
    private func downloadImage(forURL url: String?, completion: @escaping (Data?) -> Void ){
        if (url == nil) {
            AnalysticsService.shared.logMessage("Error download image URL cannot be nil")
            completion(nil)
        } else {
            NetworkService.shared.downloadImage(url!, completion: { result in
                switch result {
                case .success(let data):
                    completion(data)
                    break
                case .failure(let error):
                    AnalysticsService.shared.logException(exception: CustomError.runtimeError("Failed network request when downloading image from \(String(describing: url))", error))
                    completion(nil)
                    break
                }
            })
        }
    }
    
    func deleteImage(forKey key: String) -> Void {
        if let filePath = self.filePath(forKey: key) {
            do{
                try FileManager.default.removeItem(at: filePath)
            }catch{
                AnalysticsService.shared.logException(exception: CustomError.runtimeError("Error deleting image from disk", error))
            }
        }
    }
    
    func getImage(data: Data?) -> Image {
        guard let data = data else {
            return Image(systemName: "xmark.square")
        }
        let uiImage = UIImage(data: data)!
        return Image(uiImage: uiImage)
    }
}
