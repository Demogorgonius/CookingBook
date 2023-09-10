//
//  DetailPresenter.swift
//  CookingBook
//
//  Created by Elizaveta Eremyonok on 09.09.2023.
//

import Foundation
import OSLog

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewDidDisappear()
}

protocol DetailPresenterDelegate: AnyObject {
    func recipeDidLoad(_ recipe: Recipe)
}

final class DetailPresenter: DetailPresenterProtocol {
    //MARK: - Private properties
    private let apiClient: ApiClientProtocol
    
    //MARK: - Public properties
    weak var delegate: DetailPresenterDelegate?
    
    //MARK: - init(_:)
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
        
    }
    
    deinit {
    }
    
    //MARK: - Public methods
    func viewDidLoad() {
    }
    
    func viewDidDisappear() {
    }
    
}
    
