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
        CategoryModel(category: "Salad", isSelectedCategory: true), CategoryModel(category: "Breakfast"),
        CategoryModel(category: "Dessert"), CategoryModel(category: "Appetizer"),
        CategoryModel(category: "Soup"), CategoryModel(category: "Snack"),
        CategoryModel(category: "Drink")
    ]
    
    var indexTrending = Set<Int>()
    var stateTrending: [Bool]?
    
    var indexPopular: [String : [Int]] = ["Salad" : [], "Breakfast" : [], "Dessert" : [], "Appetizer" : [], "Soup" : [], "Snack" : [], "Drink" : []]
    var statePopular: [String : [Bool]]?
    var keyCategory = "Salad"
    
    //MARK: - Private init
    
    private init() {}
    
    //MARK: - Methods
    
    func createState() -> [Bool] {
        checkTrendingState()
        return stateTrending!
    }
    
    func createPopulatState() -> [String : [Bool]] {
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
        
        if indexPopular[keyCategory] != nil, indexPopular[keyCategory]!.contains(tag) {
            for (index, value) in indexPopular[keyCategory]!.enumerated() {
                if value == tag {
                    indexPopular[keyCategory]?.remove(at: index)
                }
            }
        } else {
            indexPopular[keyCategory]?.append(tag)
        }
    }
    
    private func checkPopularState() {
        
        let keys = categoryModel.map { $0.category }
        let values = Array(repeating: false, count: categoryFood.count)
        var item = [String : [Bool]]()
        keys.forEach { item[$0] = values }
        
        indexPopular[keyCategory]?.forEach { index in
            item[keyCategory]![index] = !item[keyCategory]![index]
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


