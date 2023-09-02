//
//  CategoryRecipe.swift
//  CookingBook
//
//  Created by sidzhe on 31.08.2023.
//

import Foundation

// MARK: - CategoryRecipe

struct CategoryRecipe: Decodable, Hashable {
    let results: [Results]
    let offset, number, totalResults: Int?
}

// MARK: - Result

struct Results: Decodable, Hashable {
    let vegetarian, vegan, glutenFree, dairyFree: Bool?
    let veryHealthy, cheap, veryPopular, sustainable: Bool?
    let lowFodmap: Bool?
    let weightWatcherSmartPoints: Int?
    let preparationMinutes, cookingMinutes, aggregateLikes, healthScore: Int?
    let creditsText, sourceName: String?
    let pricePerServing: Double?
    let id: Int?
    let title: String?
    let readyInMinutes, servings: Int?
    let sourceURL: String?
    let image: String?
    let summary: String?
    let cuisines, dishTypes, diets, occasions: [String]?
    let analyzedInstructions: [AnalyzedInstruction]?
    let spoonacularSourceURL: String?
    let license: String?
}

// MARK: - AnalyzedInstruction
struct AnalyzedInstruction: Decodable, Hashable {
    let name: String?
    let steps: [Step]?
}

// MARK: - Step
struct Step: Decodable, Hashable {
    let number: Int?
    let step: String?
    let ingredients, equipment: [Ent]?
}

// MARK: - Ent
struct Ent: Decodable, Hashable {
    let id: Int?
    let name, localizedName, image: String?
}




