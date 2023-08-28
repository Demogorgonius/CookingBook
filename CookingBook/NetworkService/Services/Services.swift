//
//  Services.swift
//  CookingBook
//
//  Created by sidzhe on 28.08.2023.
//

import Foundation

//MARK: - RecipeService

struct RecipeService: RecipeClient, Serviceable {
    func getRecipe<T: Decodable>() async -> Result<T, RequestError> {
        return await sendRequest(endpoint: RecipeEndpoint.getRandomRecipe, responseModel: T.self)
    }
}
