//
//  HeaderCell.swift
//  CookingBook
//
//  Created by sidzhe on 13.09.2023.
//

import UIKit

class HeaderCell: UITableViewCell {
    
    //MARK: - Properties
    
    private let networkManager = NetworkManager()
    
    //MARK: - UI Elements
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = "How to make Tasty Fish (point & Kill)"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSize(size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.text = "777 K"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var instructionHeader: UILabel = {
        let label = UILabel()
        label.text = "Instructions"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var ingredientsHeader: UILabel = {
        let label = UILabel()
        label.text = "Ingredients"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var itemsLabel: UILabel = {
        let label = UILabel()
        label.text = "5 items"
        label.font = UIFont.regular14()
        label.textColor = .systemGray
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var instructionList: UILabel = {
        let label = UILabel()
        label.text = "Instructions"
        label.font = UIFont.regular16()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "onboardingImagePage1")
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    private lazy var ratingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "heart.fill")
        image.tintColor = .primary50
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    
    //MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    
    private func setupViews() {
        
        stackView.addArrangedSubview(instructionHeader)
        stackView.addArrangedSubview(instructionList)
        
        contentView.addSubview(header)
        contentView.addSubview(mainImage)
        contentView.addSubview(ratingImage)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(stackView)
        contentView.addSubview(ingredientsHeader)
        contentView.addSubview(itemsLabel)
        
        header.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        mainImage.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).inset(-10)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
        
        ratingImage.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(mainImage.snp.bottom).inset(-16)
            make.size.equalTo(36)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).inset(-16)
            make.left.equalTo(ratingImage.snp.right).inset(-4)
            make.centerY.equalTo(ratingImage.snp.centerY)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(ratingImage.snp.bottom).inset(-16)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalTo(ingredientsHeader.snp.top).inset(-16)
        }
        
        ingredientsHeader.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(stackView.snp.bottom).inset(-16)
            make.bottom.equalToSuperview().inset(16)
        }
        
        itemsLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(stackView.snp.bottom).inset(-16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    //MARK: - Configure
    
    func configure(model: Results) {
        
        var ingridients = 0
        var steps = ""
        
        guard let items = model.analyzedInstructions?.first?.steps else { return }
        
        itemsLabel.text = items.count.description
        
        for item in items {
            
            ingridients += item.ingredients?.count ?? 0
            steps += "\(item.number?.description ?? "0"). \(item.step ?? "non") \n"
            
        }
        
        itemsLabel.text = ingridients.description
        header.text = model.title
        ratingLabel.text = model.aggregateLikes?.description
        instructionList.text = steps
        
        networkManager.loadImage(from: model.image) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.mainImage.image = image }
        }
    }
}

