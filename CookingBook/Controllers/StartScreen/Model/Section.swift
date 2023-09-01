//
//  Section.swift
//  CookingBook
//
//  Created by sidzhe on 28.08.2023.
//

import Foundation

enum Section: Int, Hashable, CustomStringConvertible {
    case trending, popular, popularFood, recent
//    , creators
    
    var description: String {
        switch self {
            
        case .trending:
            return "Trending"
        case .popular:
            return "Popular"
        case .popularFood:
            return "popularFood"
        case .recent:
            return "Recent"
//        case .creators:
//            return "Creators"
        }
    }
}
