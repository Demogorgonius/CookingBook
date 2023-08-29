//
//  ConfigurationCellProtocol.swift
//  CookingBook
//
//  Created by sidzhe on 28.08.2023.
//

import Foundation

protocol ConfigCellProtocol {
    static var identifier: String { get }
    func configure(with model: Recipes)
}
