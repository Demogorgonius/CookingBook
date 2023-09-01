//
//  CreatorsCell.swift
//  CookingBook
//
//  Created by sidzhe on 01.09.2023.
//

import UIKit
import SnapKit

final class CreatorsCell: UICollectionViewCell, ConfigCellProtocol {
    
    //MARK: - Properties
    
    static let identifier: String = "CreatorsCell"
    
    private var networkManager = NetworkManager()
    
    //MARK: - UI Elements
    
    private lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.layer.cornerRadius = 55
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var avatarLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Inits
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImage.image = nil
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    
    private func setupViews() {
        
        addSubview(avatarImage)
        addSubview(avatarLabel)
        
        avatarImage.snp.makeConstraints { make in
            make.size.equalTo(110)
            make.top.equalToSuperview()
        }
        
        avatarLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(avatarImage.snp.bottom).inset(-8)
        }
    }
    
    //MARK: - Target
    
    @objc private func tapFavoriteButton() {
        
    }
    
    //MARK: - Configure
    
    func configure(with model: Recipes) {
        
        avatarLabel.text = model.sourceName
        
        networkManager.loadImage(from: model.sourceURL) { [weak self] image in
            DispatchQueue.main.async { self?.avatarImage.image = image }
        }
    }
}
