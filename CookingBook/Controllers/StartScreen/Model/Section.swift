//
//  Section.swift
//  CookingBook
//
//  Created by sidzhe on 28.08.2023.
//

import Foundation

struct Section: Hashable {
    let avatarImage: String
    let avatarName: String
    let foodName: String
    let rating: String
    let foodImage: String
    var isFavorite: Bool = false
    
    init(avatarImage: String, avatarName: String, foodName: String, rating: String, foodImage: String, isFavorite: Bool) {
        self.avatarImage = avatarImage
        self.avatarName = avatarName
        self.foodName = foodName
        self.rating = rating
        self.foodImage = foodImage
        self.isFavorite = isFavorite
    }
}
