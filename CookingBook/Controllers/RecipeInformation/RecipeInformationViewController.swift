//
//  RecipeInformationViewController.swift
//  CookingBook
//
//  Created by Elizaveta Eremyonok on 06.09.2023.
//

import UIKit

final class RecipeInformationViewController: UIViewController {
    enum Section: Int, CaseIterable {
        case title
        case summary
        case ingredients
    }
    
    //MARK: - Private properties
    private let presenter: DetailPresenterProtocol
    private let detailView: DetailViewProtocol
    private lazy var dataSource = makeDataSource()
    
    // MARK: - init(_:)
    init(
        presenter: DetailPresenterProtocol,
        detailView: DetailViewProtocol
    ) {
        self.presenter = presenter
        self.detailView = detailView
        super.init(nibName: nil, bundle: nil)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - deinit
    deinit {
    }
    
    //  MARK: - Life Cycle
    override func loadView() {
        self.view = detailView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.supplementaryViewProvider = makeHeaderRegistration().headerProvider
        detailView.collectionView.dataSource = dataSource
        
        presenter.viewDidLoad()
        recipeDidLoad(Recipe.sample)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter.viewDidDisappear()
    }
    
}

extension RecipeInformationViewController: DetailPresenterDelegate {
    func recipeDidLoad(_ recipe: Recipe) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(
            [Item.title(recipe)],
            toSection: .title
        )
        snapshot.appendItems(
            [Item.summary(recipe.summary)],
            toSection: .summary
        )

        snapshot.appendItems(
            recipe.extendedIngredients?.map(Item.ingredient) ?? .init(),
            toSection: .ingredients
        )
     
        dataSource.apply(snapshot)
    }
}

private extension RecipeInformationViewController {
    
    enum Item: Hashable {
        case title(Recipe)
        case summary(String?)
        case ingredient(Ingredient)
    }
    
    //MARK: - Typealias
    typealias Header = TitleSupplementaryView
    typealias CellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, Item>
    typealias HeaderRegistration = UICollectionView.SupplementaryRegistration<Header>
    
    //MARK: - Private methods
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        UICollectionViewDiffableDataSource(
            collectionView: detailView.collectionView,
            cellProvider: makeCellRegistration().cellProvider
        )
    }
    
//    func makeTitleRegistration() -> UICollectionView.CellRegistration {
//
//    }
//
//    func makeSummaryRegistration() -> UICollectionView.CellRegistration {
//
//    }
    
    func makeCellRegistration() -> CellRegistration {
        CellRegistration { cell, indexPath, item in
            cell.backgroundColor = .systemPink
        }
    }
    
    func makeHeaderRegistration() -> HeaderRegistration {
        .init(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
            let tutorialCollection = ["How to cook", "Instructions", "Ingredients"]
            
            switch Section(rawValue: indexPath.section) {
            case .title:
                supplementaryView.textLabel.text = tutorialCollection[indexPath.section]
                
            case .summary:
                supplementaryView.textLabel.text = tutorialCollection[indexPath.section]
                
            case .ingredients:
                supplementaryView.textLabel.text = tutorialCollection[indexPath.section]
                supplementaryView.numberLabel.text = "\(tutorialCollection.count) items"
                
            case nil:
                break
            }
        }
    }
    
}

private extension UICollectionView.CellRegistration {
    var cellProvider: (UICollectionView, IndexPath, Item) -> Cell {
        return { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(
                using: self,
                for: indexPath,
                item: item
            )
        }
    }
}

private extension UICollectionView.SupplementaryRegistration<TitleSupplementaryView> {
    var headerProvider: (UICollectionView, String, IndexPath) -> TitleSupplementaryView {
        return { collectionView, kind, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(
                using: self,
                for: indexPath
            )
        }
    }
}
    
