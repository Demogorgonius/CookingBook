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
    private var dataSourse: UICollectionViewDiffableDataSource<Section, Item>!
    
    //MARK: - UI Elements
    
    private lazy var headerlabel: UILabel = {
        let label = UILabel()
        label.text = "Get amazing recipes for cooking"
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var searchBar: UITextField = {
        let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchIcon.tintColor = .darkGray
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Search recipes"
        textField.clearButtonMode = .always
        textField.leftView = searchIcon
        textField.leftViewMode = .always
        return textField
    }()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTableView()
        setupViews()
        configureCollectionView()
    }
    
    //MARK: - Properties
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(headerlabel)
        view.addSubview(searchBar)
        
        headerlabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(headerlabel.snp.bottom).inset(-16)
            make.height.equalTo(31)
        }
    }
    
    private func loadTableView() {
        
        networkManager.fetch { [weak self] (result: Result<RecipeModel, RequestError>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                print(self.networkManager)
                print(response.recipes.first!)
            case .failure(let error):
                print(error.customMessage)
            }
        }
    }
}


//MARK: - Extension StartScreenController

extension StartScreenController {
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).inset(-16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        return UICollectionViewLayout()
    }
}
