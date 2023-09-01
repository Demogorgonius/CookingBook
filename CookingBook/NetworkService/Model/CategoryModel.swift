//
//  CategoryModel.swift
//  CookingBook
//
//  Created by sidzhe on 31.08.2023.
//

import Foundation

//MARK: - CategoryModel

struct CategoryModel: Hashable {
    let category: String
    var isSelected: Bool = false
}

