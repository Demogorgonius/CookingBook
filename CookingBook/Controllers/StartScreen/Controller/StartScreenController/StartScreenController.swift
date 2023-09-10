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
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    //MARK: - UI Elements
    
    lazy var headerlabel: UILabel = {
        let label = UILabel()
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
        textField.delegate = self
        return textField
    }()
    
    private lazy var sharedControl: UIActivityViewController = {
        let view = UIActivityViewController(activityItems: [], applicationActivities: nil)
        return view
    }()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        configureCollectionView()
        createDataSourse()
        MainModel.shared.loadFromUserDef()
        applySnapshot()
        
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
    
    private func loadCategory(type: String) {
        
        MainModel.shared.keyCategory = type
        
        networkManager.searchRecipe(type: type) { [weak self] (result: Result<CategoryRecipe, RequestError>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                MainModel.shared.categoryFood = data.results
                DispatchQueue.main.async { self.applySnapshot() }
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
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalWidth(0.7))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16)
                
                ///header
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                                elementKind: UICollectionView.elementKindSectionHeader,
                                                                                alignment: .top)
                sectionHeader.pinToVisibleBounds = false
                sectionHeader.zIndex = 2
                section.boundarySupplementaryItems = [sectionHeader]
                
            } else if sectionKind == .popular {
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalWidth(0.1))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 16
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
                
                ///header
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                                elementKind: UICollectionView.elementKindSectionHeader,
                                                                                alignment: .top)
                sectionHeader.pinToVisibleBounds = false
                sectionHeader.zIndex = 2
                section.boundarySupplementaryItems = [sectionHeader]
                
            } else if sectionKind == .popularFood {
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.36), heightDimension: .fractionalWidth(0.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 16
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
                
            } else if sectionKind == .recent {
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(124), heightDimension: .fractionalWidth(0.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 20
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16)
                
                ///header
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                                elementKind: UICollectionView.elementKindSectionHeader,
                                                                                alignment: .top)
                sectionHeader.pinToVisibleBounds = false
                sectionHeader.zIndex = 2
                section.boundarySupplementaryItems = [sectionHeader]
                
            } else if sectionKind == .creators {
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(124), heightDimension: .fractionalWidth(0.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 16
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)
                
                ///header
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                                elementKind: UICollectionView.elementKindSectionHeader,
                                                                                alignment: .top)
                sectionHeader.pinToVisibleBounds = false
                sectionHeader.zIndex = 2
                section.boundarySupplementaryItems = [sectionHeader]
                
            } else {
                fatalError("Unknown section!")
            }
            
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    //MARK: - Registration
    
    private func registrTrending() -> UICollectionView.CellRegistration<TrendingCell, Item> {
        
        return UICollectionView.CellRegistration<TrendingCell, Item> { [weak self] (cell, indexPath, recipe) in
            guard let self = self else { return }
            let model = MainModel.shared.recipeData[indexPath.row]
            cell.favoriteButton.tag = indexPath.row
            cell.tappedButton = { self.present(self.sharedControl, animated: true) }
            cell.configure(with: model, state: MainModel.shared.createState()[indexPath.row])
        }
    }
    
    private func registrPopularCell() -> UICollectionView.CellRegistration<CategoryCell, CategoryModel> {
        
        return UICollectionView.CellRegistration<CategoryCell, CategoryModel> { (cell, indexPath, label) in
            cell.configure(with: MainModel.shared.categoryModel[indexPath.row])
        }
    }
    
    private func registrPopularFood() -> UICollectionView.CellRegistration<PopularCell, Results> {
        
        return UICollectionView.CellRegistration<PopularCell, Results> { (cell, indexPath, recipe) in
            let model = MainModel.shared.categoryFood[indexPath.row]
            let state = MainModel.shared.createPopulatState()[MainModel.shared.keyCategory]![indexPath.row]
            cell.configure(with: model, state: state)
            cell.favoriteButton.tag = indexPath.row
        }
    }
    
    private func registrRecent() -> UICollectionView.CellRegistration<RecentCell, Item> {
        
        return UICollectionView.CellRegistration<RecentCell, Item> { (cell, indexPath, recipe) in
            cell.configure(with: MainModel.shared.recipeData[indexPath.row])
        }
    }
    
    private func registrCreators() -> UICollectionView.CellRegistration<CreatorsCell, Item> {
        
        return UICollectionView.CellRegistration<CreatorsCell, Item> { (cell, indexPath, recipe) in
            cell.configure(with: MainModel.shared.recipeData[indexPath.row])
        }
    }
    
    private func registrHeader() -> UICollectionView.SupplementaryRegistration<TrendingHeader> {
        return UICollectionView.SupplementaryRegistration<TrendingHeader>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            header.trendLabel.text = "Trending now 🔥"
            header.completionHandler = { [weak self] in
                let vc = SeeAllController(trending: MainModel.shared.recipeData, recent: nil, creators: nil)
                self?.present(vc, animated: true)
                
            }
        }
    }
    
    private func registrPopularHeaher() ->  UICollectionView.SupplementaryRegistration<PopularHeader> {
        return UICollectionView.SupplementaryRegistration<PopularHeader>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            header.trendLabel.text = "Popular category"
        }
    }
    
    private func registrRecentHeader() -> UICollectionView.SupplementaryRegistration<RecentHeader> {
        return UICollectionView.SupplementaryRegistration<RecentHeader>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            header.recentLabel.text = "Recent recipe"
            header.completionHandler = { [weak self] in
                let vc = SeeAllController(trending: nil, recent: MainModel.shared.recipeData, creators: nil)
                self?.present(vc, animated: true)
            }
        }
    }
    
    private func registrCreatorsHeader() -> UICollectionView.SupplementaryRegistration<HeaderCreators> {
        return UICollectionView.SupplementaryRegistration<HeaderCreators>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            header.creatorsLabel.text = "Popular creators"
            header.completionHandler = { [weak self] in
                let vc = SeeAllController(trending: nil, recent: nil, creators: MainModel.shared.recipeData)
                self?.present(vc, animated: true)
            }
        }
    }
    
    //MARK: - DataSource
    
    private func createDataSourse() {
        
        let trendingCell = registrTrending()
        let popularCell = registrPopularCell()
        let trendHeader = registrHeader()
        let popularHeader = registrPopularHeaher()
        let popularFood = registrPopularFood()
        let recentHeader = registrRecentHeader()
        let recentCell = registrRecent()
        let creatorsHeader = registrCreatorsHeader()
        let creatorsCell = registrCreators()
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            (collectionView, indexPath, recipe) -> UICollectionViewCell? in
            
            guard let sectionKind = Section(rawValue: indexPath.section) else { return nil }
            
            switch sectionKind {
            case .trending:
                return collectionView.dequeueConfiguredReusableCell(using: trendingCell, for: indexPath, item: recipe)
            case .popular:
                return collectionView.dequeueConfiguredReusableCell(using: popularCell, for: indexPath, item: recipe.category)
            case .popularFood:
                return collectionView.dequeueConfiguredReusableCell(using: popularFood, for: indexPath, item: recipe.categoryFood)
            case .recent:
                return collectionView.dequeueConfiguredReusableCell(using: recentCell, for: indexPath, item: recipe)
            case .creators:
                return collectionView.dequeueConfiguredReusableCell(using: creatorsCell, for: indexPath, item: recipe)
            }
        }
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                if let sectionKind = Section(rawValue: indexPath.section) {
                    switch sectionKind {
                    case .trending:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: trendHeader, for: indexPath)
                    case .popular:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: popularHeader, for: indexPath)
                    case .popularFood:
                        return nil
                    case .recent:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: recentHeader, for: indexPath)
                    case .creators:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: creatorsHeader, for: indexPath)
                    }
                }
            }
            return nil
        }
    }
    
    //MARK: - SnapShot
    
    private func applySnapshot() {
        
        MainModel.shared.loadFromUserDef()
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.trending, .popular, .popularFood, .recent, .creators])
        
        let item = MainModel.shared.recipeData.map { Item(recipes: $0) }
        let item2 = MainModel.shared.categoryModel.map { Item(category: $0) }
        let item3 = MainModel.shared.categoryFood.map { Item(categoryFood: $0) }
        let item4 = MainModel.shared.recipeData.map { Item(recipes: $0) }
        let item5 = MainModel.shared.recipeData.map { Item(recipes: $0) }
        
        snapshot.appendItems(item, toSection: .trending)
        snapshot.appendItems(item2, toSection: .popular)
        snapshot.appendItems(item3, toSection: .popularFood)
        snapshot.appendItems(item4, toSection: .recent)
        snapshot.appendItems(item5, toSection: .creators)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}


//MARK: - UICollectionViewDelegate

extension StartScreenController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let sectionKind = Section(rawValue: indexPath.section) else { return }
        switch sectionKind {
            
        case .trending:
            print("trending: \(indexPath.row)")
        case .popular:
            
            let popular = MainModel.shared.categoryModel[indexPath.row].category
            
            loadCategory(type: popular)
            
            for i in 0..<MainModel.shared.categoryModel.count {
                MainModel.shared.categoryModel[i].isSelectedCategory = false
            }
            
            MainModel.shared.categoryModel[indexPath.row].isSelectedCategory = true
                        
        case .popularFood:
            print("popularFood: \(indexPath.row)")
        case .recent:
            print("recent: \(indexPath.row)")
        case .creators:
            print("creators: \(indexPath.row)")
        }
    }
}

//MARK: - Extension

extension StartScreenController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text else { return false }
        
        let vc = SearchBarController(search: text)
        present(vc, animated: true)
        return true
    }
}
