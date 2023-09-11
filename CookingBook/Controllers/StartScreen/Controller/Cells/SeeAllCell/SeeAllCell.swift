//
//  SearchBarCell.swift
//  CookingBook
//
//  Created by sidzhe on 09.09.2023.
//

import UIKit
import SnapKit

final class SeeAllCell: UICollectionViewCell {
    
    //MARK: - Properties
    
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
        image.tintColor = .primary50
        return image
    }()
    
    private lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSize(size: 14)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSize(size: 18)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSize(size: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        return view
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
        contentView.addSubview(timeLabel)
        
        mainImage.addSubview(ratingView)
        mainImage.addSubview(indicator)
        
        ratingView.addSubview(ratingImage)
        ratingView.addSubview(ratingLabel)
        
        mainImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        
        nameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(mainImage.snp.horizontalEdges).inset(16)
            make.bottom.equalToSuperview().inset(42)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
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
    
    func configure(with model: Results) {
        
        indicator.startAnimating()
        
        let likes = model.aggregateLikes ?? 0
        let rating = checkLikes(with: likes.description)
        ratingLabel.text = rating
        nameLabel.text = model.title
        mainImage.layer.cornerRadius = 10
        mainImage.clipsToBounds = true
        
        let ingridients = model.analyzedInstructions?.first?.steps?.first?.ingredients?.count ?? 0
        let min = model.readyInMinutes ?? 0
        timeLabel.text = "\(ingridients) ingridients | \(min) min"
        
        if mainImage.image == nil {
            networkManager.loadImage(from: model.image) { [weak self] image in
                
                DispatchQueue.main.async {
                    self?.mainImage.image = image
                    self?.indicator.stopAnimating()
                }
            }
        }
    }
}
