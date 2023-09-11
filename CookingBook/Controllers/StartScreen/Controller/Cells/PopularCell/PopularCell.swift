//
//  PopularCell.swift
//  CookingBook
//
//  Created by sidzhe on 31.08.2023.
//

import UIKit
import SnapKit

final class PopularCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private let networkManager = NetworkManager()
    
    //MARK: - UI Elements
    
    private lazy var backgroungView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.boldSize(size: 14)
        return label
    }()
        
    private lazy var minutesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSize(size: 12)
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapFavoriteButton), for: .touchUpInside)
        button.setBackgroundImage(UIImage(systemName: "bookmark.circle.fill"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    //MARK: - Inits
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        logoImage.image = nil
        
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
        
        contentView.addSubview(backgroungView)
        contentView.addSubview(logoImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(minutesLabel)
        
        backgroungView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(contentView.snp.top).inset(contentView.bounds.height * 0.1)
        }
        
        logoImage.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(backgroungView.snp.centerY)
            make.top.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).inset(-10)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().inset(10)
        }
        
        minutesLabel.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview().inset(10)
        }
    }
    
    //MARK: - Target
    
    @objc private func tapFavoriteButton(_ sender: UIButton) {
        
        sender.tintColor = sender.tintColor == .systemGray ? .systemPink : .systemGray
        MainModel.shared.checkId(sender.tag)
    }
    
    //MARK: - Configure
    
    func configure(with model: Results) {
        
        favoriteButton.tintColor = MainModel.shared.setState(model: model) ? .primary50 : .systemGray
        nameLabel.text = model.title
        minutesLabel.text = "\(model.readyInMinutes?.description ?? "5")  Mins"
        
        if logoImage.image == nil {
            
            networkManager.loadImage(from: model.image) { [weak self] image in
                DispatchQueue.main.async {
                    self?.logoImage.image = image
                    self?.logoImage.clipsToBounds = true
                    let minSize = min(self?.logoImage.frame.size.width ?? 100.0, self?.logoImage.frame.size.height ?? 100.0)
                    self?.logoImage.layer.cornerRadius = minSize / 2
                }
            }
        }
    }
}
