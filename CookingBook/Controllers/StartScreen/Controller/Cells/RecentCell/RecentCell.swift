//
//  RecentCell.swift
//  CookingBook
//
//  Created by sidzhe on 01.09.2023.
//

import UIKit
import SnapKit

final class RecentCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private var networkManager = NetworkManager()
    
    //MARK: - UI Elements
    
    private lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var avatarLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "How to sharwama at home"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    //MARK: - Inits
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        mainImage.image = nil
        
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
        
        addSubview(mainImage)
        addSubview(nameLabel)
        addSubview(avatarLabel)
        
        mainImage.snp.makeConstraints { make in
            make.size.equalTo(124)
            make.top.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(mainImage.snp.bottom).inset(-8)
        }
        
        avatarLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).inset(-8)
        }
    }
    
    //MARK: - Target
    
    @objc private func tapFavoriteButton() {
        
    }
    
    //MARK: - Configure
    
    func configure(with model: Results) {
        
        nameLabel.text = model.title
        avatarLabel.text = model.sourceName
        
        networkManager.loadImage(from: model.image) { [weak self] image in
            DispatchQueue.main.async { self?.mainImage.image = image }
        }
    }
}
