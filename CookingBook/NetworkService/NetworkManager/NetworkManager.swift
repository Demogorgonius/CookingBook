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
    
    func loadImage(from model: [Recipes], completion: @escaping ([UIImage]?) -> Void) {
        
        let group = DispatchGroup()
        var imageData: [UIImage]? = []
        
        DispatchQueue.global().async(group: group) {
            
            model.forEach {
                guard let imageLink = $0.image else { return }
                
                if let cachedImege = self.imageCache.object(forKey: imageLink as NSString) {
                    imageData?.append(cachedImege)
                } else {
                    guard let url = URL(string: imageLink) else { return }
                    
                    let data = try? Data(contentsOf: url)
                    
                    guard let data = data else { return }
                    
                    let image = UIImage(data: data) ?? UIImage()
                    imageData?.append(image)
                    
                    self.imageCache.setObject(image, forKey: imageLink as NSString)
                }
            }
        }
        
        group.notify(queue: .main) { completion(imageData) }
    }
}
