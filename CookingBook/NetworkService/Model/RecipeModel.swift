//
//  RecipeModel.swift
//  CookingBook
//
//  Created by sidzhe on 28.08.2023.
//

import Foundation

//MARK: - RecipeModel

struct RecipeModel: Decodable, Hashable {
    let results: [Results]
    let offset, number, totalResults: Int?
}

