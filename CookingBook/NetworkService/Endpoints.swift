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
    case getCategoryRecipe
    case getRecipe
}

//MARK: - Extension RecipeEndpoint

extension RecipeEndpoint: Endpoint {
    var header: [String : String]? {
        switch self {
            
        case .getRandomRecipe:
            return nil
        case .getCategoryRecipe:
            return nil
        case .getRecipe:
            return nil
        }
    }
    
    var path: String {
        switch self {
            
        case .getRandomRecipe:
            return "/recipes/complexSearch"
        case .getCategoryRecipe:
            return "/recipes/complexSearch"
        case .getRecipe:
            return "/recipes"
        }
    }
    
    var method: RequestMethod {
        switch self {
            
        case .getRandomRecipe:
            return .get
        case .getCategoryRecipe:
            return .get
        case .getRecipe:
            return .get
        }
    }
    
    var body: [String : String]? {
        switch self {
            
        case .getRandomRecipe:
            return nil
        case .getCategoryRecipe:
            return nil
        case .getRecipe:
            return nil
        }
    }
    
    var item: [URLQueryItem]? {
        switch self {
            
        case .getRandomRecipe:
            return [URLQueryItem(name: "number", value: "5"),
//                                        URLQueryItem(name: "apiKey", value: "5f4e2fd189314d2a829f2dcd7b06f5c1"),
//                                        URLQueryItem(name: "apiKey", value: "d560af6bb33a4ad289d3cc2c562ab5a5"),
//                    URLQueryItem(name: "apiKey", value: "7a8cd7f64b124dd3841868f8dc77bfb8"),
//                    URLQueryItem(name: "apiKey", value: "76c720e3086144478cbcd27fb948b527"),
//                    URLQueryItem(name: "apiKey", value: "1242f412ecc44f2c9fbbe22061784465"),
                    URLQueryItem(name: "apiKey", value: "dde8d8c3cbd74e8594a9d0cf1687b507"),
                    URLQueryItem(name: "addRecipeInformation", value: "true"),
                    URLQueryItem(name: "sort", value: "popularity")
            ]
            
        case .getCategoryRecipe:
            return nil
        case .getRecipe:
            return [URLQueryItem(name: "apiKey", value: "dde8d8c3cbd74e8594a9d0cf1687b507")]
        }
    }
}
