//
//  TrendingCell.swift
//  CookingBook
//
//  Created by sidzhe on 28.08.2023.
//

import UIKit
import SnapKit

class TrendingCell: UICollectionViewCell {
    
    //MARK: - UI Elements
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        return view
    }()
    
    private lazy var ratingViewStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        return view
    }()
    
    private lazy var ratingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        return image
    }()
    
    private lazy var mainImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var avatarLabel: UILabel = {
        let label = UILabel()
        label.text = "name name"
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "4.5"
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "How to sharwama at home"
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapFavoriteButton), for: .touchUpInside)
        button.setBackgroundImage(UIImage(systemName: "star.circle.fill"), for: .normal)
        return button
    }()
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    
    private func setupViews() {
        
        mainImage.addSubview(ratingViewStackView)
        mainImage.addSubview(favoriteButton)
        
        ratingViewStackView.addArrangedSubview(ratingImage)
        ratingViewStackView.addArrangedSubview(ratingLabel)
        
        stackView.addArrangedSubview(mainImage)
        stackView.addArrangedSubview(mainImage)
        
        mainImage.snp.makeConstraints { make in
            make.width.equalTo(280)
            make.height.equalTo(180)
        }
        
        ratingViewStackView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(16)
            make.width.equalTo(58)
            make.height.equalTo(26)
        }

        favoriteButton.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.right.top.equalToSuperview().inset(16)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    //MARK: - Target
    
    @objc private func tapFavoriteButton() {
        
    }
}
