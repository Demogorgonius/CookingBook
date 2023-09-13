//
//  SearchBarController.swift
//  CookingBook
//
//  Created by sidzhe on 09.09.2023.
//

import UIKit
import SnapKit

final class SeeAllController: UIViewController {
    
    //MARK: - Properties
    
    var trending: [Results]?
    var recent: [Results]?
    var creators: [Results]?
    
    private let identifier = "cellId"
    
    //MARK: - UI Elements
    
    private lazy var headerlabel: UILabel = {
        let label = UILabel()
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
        view.delegate = self
        return view
    }()
    
    //MARK: - Inits
    
    init(trending: [Results]?, recent: [Results]?, creators: [Results]?) {
        self.trending = trending
        self.recent = recent
        self.creators = creators
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setHeader()
    }
    
    //MARK: - Methods
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(headerlabel)
        view.addSubview(collectionView)
        
        headerlabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(6)
            make.horizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerlabel.snp.bottom).inset(-12)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setHeader() {
        
        if trending != nil {
            headerlabel.text = "Trending now"
        } else if recent != nil {
            headerlabel.text = "Recent recipe"
        } else {
            headerlabel.text = "Popular creators"
        }
    }
}


//MARK: - Extension UICollectionViewDataSource

extension SeeAllController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trending?.count ?? recent?.count ?? creators?.count ?? 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = trending ?? recent ?? creators ?? [Results]()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? SeeAllCell
        cell?.configure(with: model[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}

//MARK: - Extension UICollectionViewDelegate

extension SeeAllController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = trending ?? recent ?? creators ?? [Results]()
        present(DetailViewController(model: model[indexPath.row]), animated: true)
    }
}
