//
//  DetailViewCell.swift
//  CookingBook
//
//  Created by sidzhe on 12.09.2023.
//

import UIKit
import SnapKit

final class DetailViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private let networnManager = NetworkManager()
    
    //MARK: - UI Elements
    
    private lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var ingridientLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSize(size: 14)
        return label
    }()
    
    //MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupViews() {
        
        contentView.addSubview(mainImage)
        contentView.addSubview(ingridientLabel)
        
        mainImage.snp.makeConstraints { make in
            make.size.equalTo(44)
            make.centerY.equalToSuperview()
            make.left.equalTo(16)
        }
        
        ingridientLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
    }
    
    //MARK: - Configure
    
    func configure(model: Ent) {
        
        ingridientLabel.text = model.name
        
        let path = model.image ?? ""
        let url = "https://spoonacular.com/cdn/ingredients_100x100/\(path)"
        mainImage.clipsToBounds = true
        mainImage.layer.cornerRadius = 10
        
        networnManager.loadImage(from: url) { [weak self] image in
            DispatchQueue.main.async { self?.mainImage.image = image }
        }
    }
}
