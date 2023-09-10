//
//  TrendingHeader.swift
//  CookingBook
//
//  Created by sidzhe on 30.08.2023.
//

import UIKit
import SnapKit
import UIKit.UIFont

final class TrendingHeader: UICollectionReusableView {
        
    //MARK: - Properties
    
    var completionHandler: (() -> Void)?
    
    //MARK: - UI Elements
    
    var trendLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSize(size: 20)
        return label
    }()
    
    private lazy var seeAllLabel: UILabel = {
        let label = UILabel()
        label.text = "See all "
        label.font = UIFont.boldSize(size: 14)
        label.textColor = UIColor.primary50
        return label
    }()
    
    private lazy var seeAllImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.right")
        image.tintColor = .black
        return image
    }()
    
    private lazy var trendButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(tapTrendButton), for: .touchUpInside)
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
    
    //MARK: - Methods
    
    private func setupViews() {
        
        addSubview(trendLabel)
        addSubview(seeAllLabel)
        addSubview(seeAllImage)
        addSubview(trendButton)

        trendLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        seeAllImage.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(18)
        }
        
        seeAllLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(seeAllImage.snp.left)
        }
        
        trendButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(seeAllLabel.snp.left)
            make.right.equalTo(seeAllImage.snp.right)
            make.height.equalTo(12)
        }
    }
    
    @objc private func tapTrendButton() {
        completionHandler?()
    }
}
