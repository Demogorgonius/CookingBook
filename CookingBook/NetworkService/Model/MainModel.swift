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
    var recentData = [Results]()
    var categoryFood = [Results]()
    var searchBar = [Results]()
    var categoryModel = [
        CategoryModel(category: "Salad", isSelectedCategory: true), CategoryModel(category: "Breakfast"),
        CategoryModel(category: "Dessert"), CategoryModel(category: "Appetizer"),
        CategoryModel(category: "Soup"), CategoryModel(category: "Snack"),
        CategoryModel(category: "Drink")
    ]
    
    var saveId = Set<Int>()
    
    var userDefaults = UserDefaults.standard

    var keyCategory = "Salad"
    
    //MARK: - Private init
    
    private init() {}
    
    //MARK: - Methods
    
    func checkId(_ id: Int) {
        
        if saveId.contains(id) {
            saveId.remove(id)
        } else {
            saveId.insert(id)
        }
    }
    
    func setState(model: Results) -> Bool {
        
        guard let id = model.id else { return false }
        if saveId.contains(id) {
            return true
        }
        return false
    }

    func saveUserDef() {
        
        let saveObject = saveId.map { $0 }
        userDefaults.set(saveObject, forKey: "saveUD")
    }
    
    func loadFromUserDef() {
        
        guard let object = userDefaults.object(forKey: "saveUD") as? [Int] else { return }
        object.forEach { saveId.insert($0) }
    }
}
