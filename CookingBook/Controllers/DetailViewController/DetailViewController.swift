//
//  DetailViewController.swift
//  CookingBook
//
//  Created by sidzhe on 11.09.2023.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    //MARK: - UI Elements
    
    private lazy var scrolView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = "How to make Tasty Fish (point & Kill)"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSize(size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.text = "777 K"
        return label
    }()
    
    private lazy var instructionHeader: UILabel = {
        let label = UILabel()
        label.text = "Instructions"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var instructionList: UILabel = {
        let label = UILabel()
        label.text = "Instructions"
        label.font = UIFont.regular16()
        label.textAlignment = .left
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
        view.distribution = .fillProportionally
        view.spacing = 10
        return view
    }()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        instructionList.text = """
Place eggs in a saucepan and cover with cold water. Bring water to a boil and immediately remove from heat. Cover and let eggs stand in hot water for 10 to 12 minutes. Remove from hot water, cool, peel, and chop.
Place chopped eggs in a bowl.
Add chopped tomatoes, corns, lettuce, and any other vegitable of your choice.
Stir in mayonnaise, green onion, and mustard. Season with paprika, salt, and pepper.
Stir and serve on your favorite bread or crackers.

"""
    }
    
    //MARK: - Methods
    
    private func setupViews() {
        
        view.backgroundColor = .white
        
        view.addSubview(header)
        view.addSubview(mainImage)
        view.addSubview(ratingImage)
        view.addSubview(ratingLabel)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(instructionHeader)
        stackView.addArrangedSubview(instructionList)
        
        header.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        mainImage.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).inset(-10)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(view.bounds.height / 4)
        }
        
        ratingImage.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(mainImage.snp.bottom).inset(-16)
            
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).inset(-16)
            make.left.equalTo(ratingImage.snp.right).inset(-4)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(ratingImage.snp.bottom).inset(-16)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
    }
}
