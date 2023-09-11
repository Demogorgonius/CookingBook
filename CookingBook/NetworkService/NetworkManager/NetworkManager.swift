//
//  NetworkManager.swift
//  CookingBook
//
//  Created by sidzhe on 28.08.2023.
//

import UIKit

//MARK: - NetworkManagerProtocol

protocol NetworkManagerProtocol {
    func fetch<T: Decodable>(completion: @escaping (Result<T, RequestError>) -> Void)
    func searchRecipe<T: Decodable>(type: String, completion: @escaping (Result<T, RequestError>) -> Void)
    func loadRandomRecipe<T: Decodable>(completion: @escaping (Result<T, RequestError>) -> Void)
    func loadWithId<T: Decodable>(id: String, completion: @escaping (Result<T, RequestError>) -> Void)
}

//MARK: - NetworkManager

class NetworkManager: NetworkManagerProtocol {
    
    private var service = RecipeService()
    
    private var imageCache = NSCache<NSString, UIImage>()
    
    func fetch<T: Decodable>(completion: @escaping (Result<T, RequestError>) -> Void) {
        Task(priority: .background) {
            let result: Result<T, RequestError> = await service.getRecipe()
            completion(result)
        }
    }
    
    func searchRecipe<T: Decodable>(type: String, completion: @escaping (Result<T, RequestError>) -> Void) {
        
        Task(priority: .background) {
            let result: Result<T, RequestError> = await service.searchRecipe(type: type)
            completion(result)
        }
    }
    
    func loadRandomRecipe<T: Decodable>(completion: @escaping (Result<T, RequestError>) -> Void) {
        
        Task(priority: .background) {
            let result: Result<T, RequestError> = await service.searchRandom()
            completion(result)
        }
    }
    
    func loadWithId<T: Decodable>(id: String, completion: @escaping (Result<T, RequestError>) -> Void) {
        
        Task(priority: .background) {
            let result: Result<T, RequestError> = await service.searchId(id: id)
            completion(result)
        }
    }
    
    //MARK: - LoadImage
    
    func loadImage(from urlString: String?, completion: @escaping (UIImage) -> Void) {
        
        guard let imageString = urlString, let url = URL(string: imageString) else { return }
        
        if let image = imageCache.object(forKey: imageString as NSString) {
            completion(image)
        } else {
            let session = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            let task = URLSession.shared.dataTask(with: session) { data, response, error in
                if let error = error {
                    print(error)
                }
                guard let data = data else { return }
                let image = UIImage(data: data) ?? UIImage()
                self.imageCache.setObject(image, forKey: imageString as NSString)
                completion(image)
            }
            task.resume()
        }
    }
}
