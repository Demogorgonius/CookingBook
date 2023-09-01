//
//  CategoryCell.swift
//  CookingBook
//
//  Created by sidzhe on 31.08.2023.
//

import UIKit
import SnapKit

final class CategoryCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "CategoryCell32131"
    
    //MARK: - UI Elements
    
    lazy var cellView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "BTC/USDT"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        addShadowLayer()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    
    private func setupViews() {
        
        addSubview(cellView)
        addSubview(categoryLabel)
        
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func addShadowLayer() {
        
        let shadowLayer = CALayer()
        shadowLayer.backgroundColor = UIColor.white.cgColor
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOpacity = 0.1
        shadowLayer.shadowRadius = 3
        shadowLayer.shadowColor = UIColor.systemBlue.cgColor
        shadowLayer.shadowOffset = CGSize(width: 3, height: 3)
        shadowLayer.cornerRadius = 10
        
        shadowLayer.frame = contentView.bounds.insetBy(dx: 0, dy: 0)
        
        layer.insertSublayer(shadowLayer, at: 0)
    }
    
    //MARK: - Configure
    
    func configure(with model: CategoryModel) {
        
        categoryLabel.text = model.category
        categoryLabel.textColor = model.isSelected ? .white : .systemPink
        cellView.backgroundColor = model.isSelected ? .systemPink : .white
    }
}
