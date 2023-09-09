//
//  Ingridient.swift
//  CookingBook
//
//  Created by Elizaveta Eremyonok on 09.09.2023.
//

import Foundation

/// Модель ингредиента
struct Ingredient: Decodable, Hashable {
    /// Название ингредиента
    let name: String
    
    /// Имя картинки ингредиента
    let image: String
    
    /// Количество
    let amount: Amount
}

extension Ingredient {
    static let sample: [Ingredient] = [
        .init(name: "Fish", image: "Fish", amount: .init(unit: "gr", value: 200)),
        .init(name: "Sugar", image: "Sugar", amount: .init(unit: "gr", value: 200)),
        .init(name: "Ginger", image: "Ginger", amount: .init(unit: "gr", value: 200)),
        .init(name: "Salt", image: "Salt", amount: .init(unit: "gr", value: 200))
    ]
}
