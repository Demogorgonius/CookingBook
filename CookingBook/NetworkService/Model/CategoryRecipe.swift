//
//  CategoryRecipe.swift
//  CookingBook
//
//  Created by sidzhe on 31.08.2023.
//

import Foundation

// MARK: - CategoryRecipe

struct CategoryRecipe: Decodable, Hashable {
    let results: [Results]?
}

// MARK: - Result

struct Results: Decodable, Hashable {
    let id: Int?
    let title: String?
    let image: String?
}
