//
//  MainModel.swift
//  CookingBook
//
//  Created by sidzhe on 03.09.2023.
//

import UIKit

class MainModel {
    
    //MARK: - InitModel
    
    static let shared = MainModel()
    
    //MARK: - Properties
    
    var recipeData = [Results]()
    var categoryFood = [Results]()
    var categoryModel = [
        CategoryModel(category: "Salad", isSelected: true), CategoryModel(category: "Breakfast"),
        CategoryModel(category: "Dessert"), CategoryModel(category: "Appetizer"),
        CategoryModel(category: "Soup"), CategoryModel(category: "Snack"),
        CategoryModel(category: "Drink")
    ]
    
    var indexTrending = Set<Int>()
    var stateTrending: [Bool]?
    
    var indexPopular = Set<Int>()
    var statePopular: [Bool]?
    
    //MARK: - Private init
    
    private init() {}
    
    //MARK: - Methods
    
    func createState() -> [Bool] {
        checkTrendingState()
        return stateTrending!
    }
    
    func createPopulatState() -> [Bool] {
        checkPopularState()
        return statePopular!
    }
    
    func checkTrendingIndex(tag: Int) {
        
        if indexTrending.contains(tag) {
            indexTrending.remove(tag)
        } else {
            indexTrending.insert(tag)
        }
    }
    
    func checkPopularIndex(tag: Int) {
        
        if indexPopular.contains(tag) {
            indexPopular.remove(tag)
        } else {
            indexPopular.insert(tag)
        }
    }
    
    private func checkPopularState() {
        
        var item = Array(repeating: false, count: categoryFood.count)

        indexPopular.forEach {
            item[$0] = !item[$0]
        }
        
        statePopular = item
    }
    
    private func checkTrendingState() {
        
        var item = Array(repeating: false, count: recipeData.count)

        indexTrending.forEach {
            item[$0] = !item[$0]
        }
        
        stateTrending = item
    }
}


