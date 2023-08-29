//
//  Endpoints.swift
//  CookingBook
//
//  Created by sidzhe on 28.08.2023.
//

import Foundation

//MARK: - Recipe endpoints

enum RecipeEndpoint {
    case getRandomRecipe
}

//MARK: - Extension RecipeEndpoint

extension RecipeEndpoint: Endpoint {
    var header: [String : String]? {
        switch self {
            
        case .getRandomRecipe:
            return nil
        }
    }
    
    var path: String {
        switch self {
            
        case .getRandomRecipe:
            return "/recipes/random"
        }
    }
    
    var method: RequestMethod {
        switch self {
            
        case .getRandomRecipe:
            return .get
        }
    }
    
    var body: [String : String]? {
        switch self {
            
        case .getRandomRecipe:
            return nil
        }
    }
    
    var item: [URLQueryItem]? {
        switch self {
            
        case .getRandomRecipe:
            return [URLQueryItem(name: "number", value: "15"),
//                    URLQueryItem(name: "apiKey", value: "5f4e2fd189314d2a829f2dcd7b06f5c1")
                    URLQueryItem(name: "apiKey", value: "d560af6bb33a4ad289d3cc2c562ab5a5")
            ]
            
        }
    }
}
