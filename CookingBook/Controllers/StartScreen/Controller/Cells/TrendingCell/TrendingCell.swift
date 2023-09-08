//
//  TrendingCell.swift
//  CookingBook
//
//  Created by sidzhe on 28.08.2023.
//

import UIKit
import SnapKit

final class TrendingCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var tappedButton: (() -> Void)?
    
    private var networkManager = NetworkManager()
    
    //MARK: - UI Elements
    
    private lazy var ratingView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var ratingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "heart.fill")
        image.tintColor = .systemPink
        return image
    }()
    
    private lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        return image
    }()
    
    private lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var avatarLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapFavoriteButton), for: .touchUpInside)
        button.setBackgroundImage(UIImage(systemName: "bookmark.circle.fill"), for: .normal)
        button.tintColor = .systemGray3
        return button
    }()
    
    private lazy var additionalButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemPink
        button.addTarget(self, action: #selector(tapAdditionalButton), for: .touchUpInside)
        return button
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
        
        contentView.addSubview(mainImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(avatarImage)
        contentView.addSubview(avatarLabel)
        contentView.addSubview(additionalButton)
        contentView.addSubview(favoriteButton)
        
        mainImage.addSubview(ratingView)
        
        ratingView.addSubview(ratingImage)
        ratingView.addSubview(ratingLabel)
        
        mainImage.snp.makeConstraints { make in
            make.width.equalTo(280)
            make.height.equalTo(180)
            make.top.equalToSuperview()
        }
        
        ratingView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(16)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        ratingImage.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(6)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.centerY.equalToSuperview()
            make.left.equalTo(ratingImage.snp.right).inset(-4)
            make.right.equalToSuperview().inset(6)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.centerY.equalTo(ratingLabel.snp.centerY)
            make.right.equalToSuperview().inset(42)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(mainImage.snp.horizontalEdges)
            make.top.equalTo(mainImage.snp.bottom).inset(-16)
        }
        
        avatarImage.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.left.equalTo(mainImage.snp.left)
            make.top.equalTo(nameLabel.snp.bottom).inset(-8)
        }
        
        avatarLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImage.snp.right).inset(-8)
            make.right.equalTo(mainImage.snp.right)
            make.centerY.equalTo(avatarImage.snp.centerY)
        }
        
        additionalButton.snp.makeConstraints { make in
            make.size.equalTo(18)
            make.right.equalTo(mainImage.snp.right)
            make.centerY.equalTo(avatarImage.snp.centerY)
        }
    }
    
    //MARK: - Target
    
    @objc private func tapFavoriteButton(_ sender: UIButton) {
        
        sender.tintColor = sender.tintColor == .systemGray3 ? .systemPink : .systemGray3
        MainModel.shared.checkTrendingIndex(tag: sender.tag)
    }
    
    @objc private func tapAdditionalButton() {
        tappedButton?()
    }
    
    //MARK: - checkLikes
    
    private func checkLikes(with like: String) -> String {
        
        switch like.count {
        case 1...3:
            return like
        case 4:
            return String(like[like.startIndex..<like.index(like.startIndex, offsetBy: 1)] + " K")
        case 5:
            return String(like[like.startIndex..<like.index(like.startIndex, offsetBy: 2)] + " K")
        default:
            return String(like[like.startIndex..<like.index(like.startIndex, offsetBy: 3)] + " K")
        }
    }
    
    //MARK: - Configure
    
    func configure(with model: Results, state: Bool) {
        
        let likes = model.aggregateLikes ?? 0
        let rating = checkLikes(with: likes.description)
        ratingLabel.text = rating
        nameLabel.text = model.title
        avatarLabel.text = model.sourceName
        mainImage.layer.cornerRadius = 20
        mainImage.clipsToBounds = true
        favoriteButton.tintColor = state ? .systemPink : .systemGray3
        
        if mainImage.image == nil {
            networkManager.loadImage(from: model.image) { [weak self] image in
                DispatchQueue.main.async {
                    self?.mainImage.image = image
                }
            }
        }
    }
}
