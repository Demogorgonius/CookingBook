//
//  RecipeModel.swift
//  CookingBook
//
//  Created by sidzhe on 28.08.2023.
//

import Foundation

//MARK: - RecipeModel

struct RecipeModel: Decodable {
    var recipes: [Recipes]
}

// MARK: - Recipe
struct Recipes: Decodable {
    let vegetarian, vegan, glutenFree, dairyFree: Bool?
    let veryHealthy, cheap, veryPopular, sustainable: Bool?
    let weightWatcherSmartPoints: Int?
    let gaps: String?
    let lowFodmap, ketogenic, whole30: Bool?
    let servings, preparationMinutes, cookingMinutes: Int?
    let sourceURL: String?
    let spoonacularSourceURL: String?
    let aggregateLikes: Int?
    let creditText, sourceName: String?
    let extendedIngredients: [ExtendedIngredient]?
    let id: Int?
    let title: String?
    let readyInMinutes: Int?
    let image: String?
    let imageType, instructions: String?

//    enum CodingKeys: String, CodingKey {
//        case vegetarian, vegan, glutenFree, dairyFree, veryHealthy, cheap, veryPopular, sustainable, weightWatcherSmartPoints, gaps, lowFodmap, ketogenic, whole30, servings, preparationMinutes, cookingMinutes
//        case sourceURL = "sourceUrl"
//        case spoonacularSourceURL = "spoonacularSourceUrl"
//        case aggregateLikes, creditText, sourceName, extendedIngredients, id, title, readyInMinutes, image, imageType, instructions
//    }
}

// MARK: - ExtendedIngredient
struct ExtendedIngredient: Decodable {
    let id: Int?
    let aisle: String?
    let image: String?
    let name: String?
    let amount: Double?
    let unit, unitShort, unitLong, originalString: String?
    let metaInformation: [String]?
}
