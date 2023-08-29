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
    
    private var recipeData = [RecipeModel]()
    private var networkManager = NetworkManager()
    private var collectionView: UICollectionView!
    private var dataSourse: UICollectionViewDiffableDataSource<Section, RecipeModel>?
    
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
        
        loadRecipe()
        setupViews()
        configureCollectionView()
        createDataSourse()
        
    }
    
    //MARK: - Setup UI
    
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
    
    //MARK: - NetworkLoad
    
    private func loadRecipe() {
        
        networkManager.fetch { [weak self] (result: Result<[RecipeModel], RequestError>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.recipeData.append(response)
                self.applySnapshot()
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
        
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            
            if sectionKind == .trending {
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .fractionalWidth(0.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 5
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)

            } else if sectionKind == .recent {
                let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
                section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
            } else {
                fatalError("Unknown section!")
            }
            
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    private func registrTrending() -> UICollectionView.CellRegistration<TrendingCell, RecipeModel> {
        
        return UICollectionView.CellRegistration<TrendingCell, RecipeModel> { (cell, indexPath, recipe) in
            
            cell.configure(with: self.recipeData[indexPath.row].recipes[indexPath.row])
        }
    }
    
    private func createDataSourse() {
        
        let trendingCell = registrTrending()
        
        dataSourse = UICollectionViewDiffableDataSource<Section, RecipeModel>(collectionView: collectionView) {
            (collectionView, indexPath, recipe) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: trendingCell, for: indexPath, item: recipe)
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, RecipeModel>()
        snapshot.appendSections([.trending])
        
        recipeData.forEach { print("+++++++++++++++++++++++++ \($0.recipes)") }
        
        snapshot.appendItems(recipeData, toSection: .trending)
        dataSourse?.apply(snapshot, animatingDifferences: true)
    }
}
