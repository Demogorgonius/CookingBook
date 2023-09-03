//
//  MainModel.swift
//  CookingBook
//
//  Created by sidzhe on 03.09.2023.
//

import UIKit

class MainModel {
    
    static let shared = MainModel()
    
    var recipeData = [Results]()
    var categoryFood = [Results]()
    var categoryModel = [
        CategoryModel(category: "Salad", isSelected: true), CategoryModel(category: "Breakfast"),
        CategoryModel(category: "Dessert"), CategoryModel(category: "Appetizer"),
        CategoryModel(category: "Soup"), CategoryModel(category: "Snack"),
        CategoryModel(category: "Drink")
    ]
    
    private init() {}
    
    
}


