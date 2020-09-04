//Original Source: https://programmingwithswift.com/save-images-locally-with-swift-5/
//Modified by: Sean Wernimont 2020

import Foundation

class ImageHelper {
    static let shared = ImageHelper()
    
    func retrieveImage(url: String?, key: String, completion: @escaping (Data?) -> Void) {
        if let filePath = self.filePath(forKey: key), let fileData = FileManager.default.contents(atPath: filePath.path) {
                completion(fileData)
        } else {
            downloadImage(forURL: url, completion: { data in
                if let data = data {
                    self.saveImageToDisk(forKey: key, withData: data)
                    completion(data)
                } else {
                    print("Error downloading image at \(String(describing: url))")
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
            print("Error could not find file url for key \(key)")
            return
        }
        
        do {
            try data.write(to: url)
        }catch{
            print("Error trying to save image to disk at location: \(url) with error: \(error)")
        }
    }
    
    private func downloadImage(forURL url: String?, completion: @escaping (Data?) -> Void ){
        if (url == nil) {
            print("Error download image cannot be nil")
            completion(nil)
        } else {
            NetworkService.shared.get(url!, completion: { result in
                switch result {
                case .success(let data):
                    completion(data)
                    break
                case .failure(let error):
                    print("Error. Failed network request when downloading image from \(url!) with error \(error)")
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
                print("Error trying to delete image from disk with error \(error)")
            }
        }
    }
}
