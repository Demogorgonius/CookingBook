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
    case getWithId
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
        case .getWithId:
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
            return "/recipes/complexSearch"
        case .getWithId:
            return "/recipes/479101/information"
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
        case .getWithId:
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
        case .getWithId:
            return nil
        }
    }
    
    var item: [URLQueryItem]? {
        switch self {
            
        case .getRandomRecipe:

            return [URLQueryItem(name: "number", value: "5"),
//                    URLQueryItem(name: "apiKey", value: "5f4e2fd189314d2a829f2dcd7b06f5c1"),
//                    URLQueryItem(name: "apiKey", value: "d560af6bb33a4ad289d3cc2c562ab5a5"),
                    URLQueryItem(name: "apiKey", value: "7a8cd7f64b124dd3841868f8dc77bfb8"),
//                    URLQueryItem(name: "apiKey", value: "76c720e3086144478cbcd27fb948b527"),
//                    URLQueryItem(name: "apiKey", value: "1242f412ecc44f2c9fbbe22061784465"),
//                    URLQueryItem(name: "apiKey", value: "d6080bac713e44768824eb6a664259ec"),
//                    URLQueryItem(name: "apiKey", value: "ecf8fe545f5c484aa9dba8388a900f3c"),
//                    URLQueryItem(name: "apiKey", value: "bb0b8e0819f74955b6d4aea39369379f"),
//                    URLQueryItem(name: "apiKey", value: "063d1857a795427880770e2f44a84d4d"),
//                    URLQueryItem(name: "apiKey", value: "73fd55a714424229b20abc76421fc3b1"),
                    URLQueryItem(name: "addRecipeInformation", value: "true"),
                    URLQueryItem(name: "sort", value: "popularity")
            ]
            
        case .getCategoryRecipe:
            return nil
        case .getRecipe:
            return [URLQueryItem(name: "apiKey", value: "7a8cd7f64b124dd3841868f8dc77bfb8"),
                    URLQueryItem(name: "number", value: "5"),
                    URLQueryItem(name: "addRecipeInformation", value: "true"),
                    URLQueryItem(name: "sort", value: "time"),
            ]
        case .getWithId:
            return [URLQueryItem(name: "apiKey", value: "7a8cd7f64b124dd3841868f8dc77bfb8")]
        }
    }
}
