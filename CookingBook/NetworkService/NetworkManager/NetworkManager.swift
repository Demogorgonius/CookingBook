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
    
    //MARK: - LoadImage
    
    func loadImage(from urlString: String?, completion: @escaping (UIImage) -> Void) {
        
        DispatchQueue.global().async {
            
            guard let urlString = urlString,
                  let url = URL(string: urlString) else { return }
            
            if let cachedImege = self.imageCache.object(forKey: urlString as NSString) {
                completion(cachedImege)
            } else {
                let data = try? Data(contentsOf: url)
                guard let data = data else { return }
                let image = UIImage(data: data) ?? UIImage()
                self.imageCache.setObject(image, forKey: urlString as NSString)
                completion(image)
            }
        }
    }
}

