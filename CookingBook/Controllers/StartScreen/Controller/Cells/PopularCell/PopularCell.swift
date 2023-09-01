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
    
    static let identifier = "PopularCell"
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
        image.image = UIImage(named: "video")
        image.layer.cornerRadius = 45
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Chiken with chesee"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Time"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var minutesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapFavoriteButton), for: .touchUpInside)
        button.setBackgroundImage(UIImage(systemName: "bookmark.circle.fill"), for: .normal)
        button.tintColor = .systemPink
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
        contentView.addSubview(timeLabel)
        
        backgroungView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(contentView.snp.top).inset(contentView.bounds.height * 0.2)
        }
        
        logoImage.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(backgroungView.snp.top).inset(contentView.bounds.height * 0.3)
            make.top.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).inset(-12)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().inset(10)
        }
        
        minutesLabel.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview().inset(10)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(minutesLabel.snp.top).inset(-4)
            make.left.equalToSuperview().inset(10)
        }
        
    }
    
    //MARK: - Target
    
    @objc private func tapFavoriteButton() {
        
    }
    
    //MARK: - Configure
    
    func configure(with model: Results) {
        
        nameLabel.text = model.title
        minutesLabel.text = "\(model.readyInMinutes?.description ?? "5") Mins"
        
        networkManager.loadImage(from: model.image) { [weak self] image in
            DispatchQueue.main.async { self?.logoImage.image = image }
        }
    }
}
