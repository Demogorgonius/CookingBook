//
//  TrendingCell.swift
//  CookingBook
//
//  Created by sidzhe on 28.08.2023.
//

import UIKit
import SnapKit

class TrendingCell: UICollectionViewCell, ConfigCellProtocol {
    
    //MARK: - Properties
    
    static let identifier: String = "TrendingCell"
    
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
        view.contentMode = .center
        view.distribution = .fillProportionally
        view.spacing = 4
        return view
    }()
    
    private lazy var ratingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "hand.thumbsup.fill")
        image.tintColor = .systemPink
        return image
    }()
    
    private lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "video")
        return image
    }()
    
    private lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "video")
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
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
        button.tintColor = .systemPink
        return button
    }()
    
    //MARK: - Inits
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//        mainImage.image = nil
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    
    private func setupViews() {
        
        contentView.addSubview(mainImage)

        mainImage.addSubview(ratingViewStackView)
        mainImage.addSubview(favoriteButton)
        ratingViewStackView.addArrangedSubview(ratingImage)
        ratingViewStackView.addArrangedSubview(ratingLabel)
        
        mainImage.snp.makeConstraints { make in
            make.width.equalTo(280)
            make.height.equalTo(180)
            make.center.equalToSuperview()
        }
        
        ratingViewStackView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(6)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(6)
            make.size.equalTo(32)
        }
        
      
        
      
    }
    
    //MARK: - Target
    
    @objc private func tapFavoriteButton() {
        
    }
    
    //MARK: - Configure
    
    func configure(with model: Recipes) {
        ratingLabel.text = String(model.aggregateLikes ?? 0)
    }
}
