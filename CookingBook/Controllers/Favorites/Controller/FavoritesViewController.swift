//
//  FavoritesViewController.swift
//  CookingBook
//
//  Created by Sergey on 28.08.2023.
//

import UIKit
import SnapKit

final class FavoritesViewController: UIViewController {
    
    //MARK: - Properties
    
    private let identifier = "favoritesCell"
    private let networkManager = NetworkManager()
    weak var delegate: FavoriteDelegate?
    
    //MARK: - UI Elements
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height / 3)
        layout.minimumLineSpacing = 24
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(FavoritesCell.self, forCellWithReuseIdentifier: identifier)
        view.dataSource = self
        return view
    }()
    
    //MARK: - Init
    
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
}

//MARK: - Extension UICollectionViewDataSource

extension FavoritesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainModel.shared.favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? FavoritesCell
        cell?.favoriteButton.tag = MainModel.shared.favorites[indexPath.row].id ?? 0
        cell?.configure(with: MainModel.shared.favorites[indexPath.row])
        cell?.deleteItem = { [weak self] in
            guard let self = self else { return }
            if let indexPathToDelete = collectionView.indexPath(for: cell!) {
                MainModel.shared.favorites.remove(at: indexPathToDelete.row)
                collectionView.deleteItems(at: [indexPathToDelete])
                delegate?.update()
            }
        }
        
        return cell ?? UICollectionViewCell()
    }
}


//MARK: - Extension StartScreenProtocol

extension FavoritesViewController: StartScreenProtocol {
    
    func updateFavorites() {
        
        MainModel.shared.saveId.forEach {
            networkManager.loadWithId(id: $0.description) { [weak self] (result: Result<Results, RequestError>) in
                switch result {
                case .success(let data):
                    if !MainModel.shared.favorites.contains(data) {
                        MainModel.shared.favorites.append(data)
                        DispatchQueue.main.async { self?.collectionView.reloadData() }
                    }
                case .failure(let error):
                    print(error.customMessage)
                }
            }
        }
    }
}

//MARK: - Extension FavoriteDelegate

protocol FavoriteDelegate: AnyObject {
    func update()
}
