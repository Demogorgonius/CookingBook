//
//  Servisable.swift
//  CookingBook
//
//  Created by sidzhe on 28.08.2023.
//

import Foundation

//MARK: - Protocol Servisable

protocol Serviceable {
    func getRecipe<T: Decodable>() async -> Result<T, RequestError>
    func searchRecipe<T: Decodable>(type: String) async -> Result<T, RequestError>
}
