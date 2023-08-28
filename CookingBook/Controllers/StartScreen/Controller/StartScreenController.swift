//
//  StartScreenController.swift
//  CookingBook
//
//  Created by Sergey on 28.08.2023.
//

import UIKit
import SnapKit

final class StartScreenController: UIViewController {
    
    //MARK: - Properties
    
    private var networkManager = NetworkManager()
    
    private var collectionView: UICollectionView!
    private var dataSourse: UICollectionViewDiffableDataSource<String, String>!

    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

      loadTableView()
       
    }
    
    //MARK: - Properties
        
    private func loadTableView() {
        
        networkManager.fetch { [weak self] (result: Result<RecipeModel, RequestError>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                print(self.networkManager)
                print(response)
            case .failure(let error):
                print(error.customMessage)
            }
        }
    }
}


//MARK: - Extension StartScreenController

extension StartScreenController {
    
    private func configureCollectionView() {
        collectionView
    }
    
}
