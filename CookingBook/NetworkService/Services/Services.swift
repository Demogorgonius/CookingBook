//
//  Services.swift
//  CookingBook
//
//  Created by sidzhe on 28.08.2023.
//

import Foundation

//MARK: - RecipeService

struct RecipeService: RecipeClient, Serviceable {
    
    func searchRandom<T: Decodable>() async -> Result<T, RequestError> {
        return await sendRecentRequest(endpoint: RecipeEndpoint.getRecipe, responseModel: T.self)
    }
    
    func getRecipe<T: Decodable>() async -> Result<T, RequestError> {
        return await sendRequest(endpoint: RecipeEndpoint.getRandomRecipe, responseModel: T.self)
    }
    
    func searchRecipe<T: Decodable>(type: String) async -> Result<T, RequestError> {
        return await sendSearchRequest(endpoint: RecipeEndpoint.getCategoryRecipe, responseModel: T.self, type: type)
    }
    
    func searchId<T: Decodable>(id: String) async -> Result<T, RequestError> {
        return await sendIdRequest(id: id, endpoint: RecipeEndpoint.getWithId, responseModel: T.self)
    }
}
