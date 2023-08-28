//
//  NetworkManager.swift
//  CookingBook
//
//  Created by sidzhe on 28.08.2023.
//

//MARK: - NetworkManagerProtocol

protocol NetworkManagerProtocol {
    func fetch<T: Decodable>(completion: @escaping (Result<T, RequestError>) -> Void)
}

//MARK: - NetworkManager

class NetworkManager: NetworkManagerProtocol {
    
    private var service = RecipeService()
    
    func fetch<T: Decodable>(completion: @escaping (Result<T, RequestError>) -> Void) {
        Task(priority: .background) {
            let result: Result<T, RequestError> = await service.getRecipe()
            completion(result)
        }
    }
}
