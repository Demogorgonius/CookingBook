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
    
    private var recipeData = [Recipes]()
    private var networkManager = NetworkManager()
    private var collectionView: UICollectionView!
    private var dataSourse: UICollectionViewDiffableDataSource<Section, Item>?
    private var categoryFood = [Results]()
    private var categoryModel = [
        CategoryModel(category: "Salad"), CategoryModel(category: "Breakfast"),
        CategoryModel(category: "Dessert"), CategoryModel(category: "Appetizer"),
        CategoryModel(category: "Soup"), CategoryModel(category: "Snack"),
        CategoryModel(category: "Drink")
    ]
    
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
        searchIcon.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        contentView.addSubview(searchIcon)
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.leftView = contentView
        textField.leftViewMode = .always
        return textField
    }()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRecipe()
        loadCategory(type: "salad")
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
        
        networkManager.fetch { [weak self] (result: Result<RecipeModel, RequestError>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.recipeData.append(contentsOf: response.recipes)
                self.applySnapshot()
            case .failure(let error):
                print(error.customMessage)
            }
        }
    }
    
    private func loadCategory(type: String) {
        
        networkManager.searchRecipe(type: type) { [weak self] (result: Result<CategoryRecipe, RequestError>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let food = data.results else { return }
                self.categoryFood.append(contentsOf: food)
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
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).inset(-16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Layout
    
    private func createLayout() -> UICollectionViewLayout {
        
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            
            if sectionKind == .trending {
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 10, trailing: 8)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .fractionalWidth(0.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 5
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 90, trailing: 16)
                
                ///header
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                                elementKind: UICollectionView.elementKindSectionHeader,
                                                                                alignment: .top)
                sectionHeader.pinToVisibleBounds = true
                sectionHeader.zIndex = 2
                section.boundarySupplementaryItems = [sectionHeader]
                
            } else if sectionKind == .popular {
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalWidth(0.2))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
                
                ///header
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                                elementKind: UICollectionView.elementKindSectionHeader,
                                                                                alignment: .top)
                sectionHeader.pinToVisibleBounds = true
                sectionHeader.zIndex = 2
                section.boundarySupplementaryItems = [sectionHeader]
                
            } else if sectionKind == .popularFood {
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 10, trailing: 8)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.38), heightDimension: .fractionalWidth(0.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 5
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: -40, leading: 16, bottom: 10, trailing: 16)
                
            } else {
                fatalError("Unknown section!")
            }
            
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    //MARK: - Registration
    
    private func registrTrending() -> UICollectionView.CellRegistration<TrendingCell, Item> {
        return UICollectionView.CellRegistration<TrendingCell, Item> { (cell, indexPath, recipe) in
            cell.configure(with: self.recipeData[indexPath.row])
        }
    }
    
    private func registrPopularCell() -> UICollectionView.CellRegistration<UICollectionViewCell, CategoryModel> {
        return UICollectionView.CellRegistration<UICollectionViewCell, CategoryModel> { (cell, indexPath, label) in
            var content = UIListContentConfiguration.cell()
            content.text = label.category
            content.textProperties.font = .boldSystemFont(ofSize: 12)
            content.textProperties.alignment = .center
            content.directionalLayoutMargins = .zero
            cell.contentConfiguration = content
            
            var background = UIBackgroundConfiguration.listPlainCell()
            background.cornerRadius = 8
            background.strokeWidth = 1.0 / cell.traitCollection.displayScale
            background.backgroundColor = .white
            cell.backgroundConfiguration = background
            
            let selectedView = UIView()
            selectedView.backgroundColor = .systemPink
            selectedView.layer.cornerRadius = 8
            selectedView.clipsToBounds = true
            cell.selectedBackgroundView = selectedView
            
        }
    }
    
    private func registrPopularFood() -> UICollectionView.CellRegistration<PopularCell, Results> {
        return UICollectionView.CellRegistration<PopularCell, Results> { (cell, indexPath, recipe) in
            cell.configure(with: self.categoryFood[indexPath.row])
        }
    }
    
    private func registrHeader() -> UICollectionView.SupplementaryRegistration<TrendingHeader> {
        return UICollectionView.SupplementaryRegistration<TrendingHeader>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            header.trendLabel.text = "Trending now 🔥"
        }
    }
    
    private func registrPopularHeaher() ->  UICollectionView.SupplementaryRegistration<PopularHeader> {
        return UICollectionView.SupplementaryRegistration<PopularHeader>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            header.trendLabel.text = "Popular category"
        }
    }
    
    //MARK: - DataSource
    
    private func createDataSourse() {
        let trendingCell = registrTrending()
        let popularCell = registrPopularCell()
        let trendHeader = registrHeader()
        let popularHeader = registrPopularHeaher()
        let popularFood = registrPopularFood()
        
        dataSourse = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            (collectionView, indexPath, recipe) -> UICollectionViewCell? in
            
            guard let sectionKind = Section(rawValue: indexPath.section) else { return nil }
            
            switch sectionKind {
            case .trending:
                return collectionView.dequeueConfiguredReusableCell(using: trendingCell, for: indexPath, item: recipe)
            case .popular:
                return collectionView.dequeueConfiguredReusableCell(using: popularCell, for: indexPath, item: recipe.category)
            case .popularFood:
                return collectionView.dequeueConfiguredReusableCell(using: popularFood, for: indexPath, item: recipe.categoryFood)
            }
        }
        
        dataSourse?.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                if let sectionKind = Section(rawValue: indexPath.section) {
                    switch sectionKind {
                    case .trending:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: trendHeader, for: indexPath)
                    case .popular:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: popularHeader, for: indexPath)
                    case .popularFood:
                        return nil
                    }
                }
            }
            return nil
        }
    }
    
    //MARK: - SnapShot
    
    private func applySnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.trending, .popular, .popularFood])
        let item = recipeData.map { Item(recipes: $0) }
        let item2 = categoryModel.map { Item(category: $0) }
        let item3 = categoryFood.map { Item(categoryFood: $0) }
        snapshot.appendItems(item, toSection: .trending)
        snapshot.appendItems(item2, toSection: .popular)
        snapshot.appendItems(item3, toSection: .popularFood)
        dataSourse?.apply(snapshot, animatingDifferences: true)
    }
}


//MARK: - UICollectionViewDelegate

extension StartScreenController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let popular = categoryModel[indexPath.row].category
        
        guard let sectionKind = Section(rawValue: indexPath.section) else { return }
        
        switch sectionKind {
            
        case .trending:
            print("trending: \(indexPath.row)")
        case .popular:
            loadCategory(type: popular)
        case .popularFood:
            print("popularFood: \(indexPath.row)")
        }
    }
}
