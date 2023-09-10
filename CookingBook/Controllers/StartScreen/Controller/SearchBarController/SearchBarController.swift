//
//  SearchBarController.swift
//  CookingBook
//
//  Created by sidzhe on 10.09.2023.
//

import UIKit
import SnapKit

final class SearchBarController: UIViewController {
    
    //MARK: - Properties
    
    private let identifier = "searchCell"
    private let networkManager = NetworkManager()
    
    //MARK: - UI Elements
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height / 3)
        layout.minimumLineSpacing = 24
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(SearchBarCell.self, forCellWithReuseIdentifier: identifier)
        view.dataSource = self
        return view
    }()
    
    //MARK: - Inits
    
    init(search: String) {
        super.init(nibName: nil, bundle: nil)
        load(recipe: search)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    //MARK: - Methods
    
    private func setupViews() {
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func load(recipe: String) {
        
        networkManager.searchRecipe(type: recipe) { [weak self] (result: Result<CategoryRecipe, RequestError>) in
            switch result {
                
            case .success(let data):
                MainModel.shared.searchBar = data.results
                DispatchQueue.main.async { self?.collectionView.reloadData() }
            case .failure(let error):
                print(error.customMessage)
            }
        }
    }
}

//MARK: - Extension UICollectionViewDataSource

extension SearchBarController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainModel.shared.searchBar.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? SearchBarCell
        cell?.configure(with: MainModel.shared.searchBar[indexPath.row], state: MainModel.shared.createState()[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}
