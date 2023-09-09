//
//  SearchBarController.swift
//  CookingBook
//
//  Created by sidzhe on 09.09.2023.
//

import UIKit
import SnapKit

class SeeAllController: UIViewController {
    
    //MARK: - Properties
    
    var identifier = "cellId"
    var trending: [Results]?
    var recent: [Results]?
    
    //MARK: - UI Elements
    
    private lazy var headerlabel: UILabel = {
        let label = UILabel()
        label.text = "Trending now"
        label.textAlignment = .center
        label.font = UIFont.boldSize(size: 20)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width - 32, height: view.frame.height / 4)
        layout.minimumLineSpacing = 24
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(SeeAllCell.self, forCellWithReuseIdentifier: identifier)
        view.dataSource = self
        return view
    }()
    
    //MARK: - Inits
    
    init(trending: [Results]?, recent: [Results]?) {
        self.trending = trending
        self.recent = recent
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    //MARK: - Methods
    
    private func setupViews() {
        
        view.addSubview(headerlabel)
        view.addSubview(collectionView)
        
        headerlabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(collectionView.snp.top)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerlabel.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}


//MARK: - Extension UICollectionViewDataSource

extension SeeAllController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trending?.count ?? recent?.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = trending ?? recent ?? [Results]()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? SeeAllCell
        cell?.configure(with: model[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}
