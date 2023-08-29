//
//  OnboardingViewController.swift
//  CookingBook
//
//  Created by Caroline Tikhomirova on 29.08.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - UI Elements
    
    let backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "onboardingScreenImage")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
    
        return image
    }()
    
    let gradientEffectImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "gradientEffect")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
    
        return image
    }()
    
    private lazy var aboutRecipesTextStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 0
        stack.alignment = .top
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let starLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "\u{2605}  "
        label.font = .semiBold14()
        label.textAlignment = .center
        label.textColor = .neutral100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountRecipesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "100k+ "
        label.textAlignment = .center
        label.font = .semiBold16()
        label.textColor = .white0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let recipesTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Premium recipes"
        label.textAlignment = .center
        label.font = .regular16()
        label.textColor = .white0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainTextStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 15
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let bestRecipeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Best \n Recipe"
        label.textAlignment = .center
        label.font = .semiBold56()
        label.textColor = .white0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Find best recipes for cooking"
        label.textAlignment = .center
        label.font = .regular16()
        label.textColor = .white0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get started", for: .normal)
        button.titleLabel?.font = .semiBold16()
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor.primary50
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setupConstraints()
        
    }
    
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(gradientEffectImageView)
        
        view.addSubview(aboutRecipesTextStack)
        aboutRecipesTextStack.addArrangedSubview(starLabel)
        aboutRecipesTextStack.addArrangedSubview(amountRecipesLabel)
        aboutRecipesTextStack.addArrangedSubview(recipesTextLabel)
        
        view.addSubview(mainTextStack)
        mainTextStack.addArrangedSubview(bestRecipeLabel)
        mainTextStack.addArrangedSubview(secondLabel)
        
        view.addSubview(startButton)
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            gradientEffectImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientEffectImageView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            gradientEffectImageView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            
            aboutRecipesTextStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            aboutRecipesTextStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            aboutRecipesTextStack.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            
            mainTextStack.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -32),
            mainTextStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -82),
            startButton.heightAnchor.constraint(equalToConstant: 56),
            startButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 156),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            
            
            
        ])
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
