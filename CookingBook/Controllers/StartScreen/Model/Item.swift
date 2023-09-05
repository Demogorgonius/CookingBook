//
//  Item.swift
//  CookingBook
//
//  Created by sidzhe on 31.08.2023.
//

import Foundation

//MARK: - Item

struct Item: Hashable {
    var category: CategoryModel?
    var recipes: Results?
    var categoryFood: Results?
    let identifier = UUID()
}
