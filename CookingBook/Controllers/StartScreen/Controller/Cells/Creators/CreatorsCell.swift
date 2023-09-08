//
//  CreatorsCell.swift
//  CookingBook
//
//  Created by sidzhe on 01.09.2023.
//

import UIKit
import SnapKit

final class CreatorsCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private var networkManager = NetworkManager()
    
    //MARK: - UI Elements
    
    private lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var avatarLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSize(size: 12)
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
            make.size.equalTo(120)
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        avatarLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.bottom).inset(-8)
            make.centerX.equalTo(avatarImage.snp.centerX)
        }
    }
    
    //MARK: - Configure
    
    func configure(with model: Results) {
        
        avatarLabel.text = model.sourceName
        avatarImage.clipsToBounds = true
        avatarImage.layer.cornerRadius = 60
        
        if avatarImage.image == nil {
            networkManager.loadImage(from: model.image) { [weak self] image in
                                
                DispatchQueue.main.async { self?.avatarImage.image = image }
            }
        }
    }
}
