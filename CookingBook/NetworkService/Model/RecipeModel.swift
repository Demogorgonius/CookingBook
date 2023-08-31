//
//  RecipeModel.swift
//  CookingBook
//
//  Created by sidzhe on 28.08.2023.
//

import Foundation

//MARK: - RecipeModel

struct RecipeModel: Decodable, Hashable {
    var recipes: [Recipes]
}

// MARK: - Recipe
struct Recipes: Decodable, Hashable {
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
}

// MARK: - ExtendedIngredient
struct ExtendedIngredient: Decodable, Hashable {
    let id: Int?
    let aisle: String?
    let image: String?
    let name: String?
    let amount: Double?
    let unit, unitShort, unitLong, originalString: String?
    let metaInformation: [String]?
}
