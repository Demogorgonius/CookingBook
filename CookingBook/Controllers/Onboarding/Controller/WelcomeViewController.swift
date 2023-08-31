//
//  OnboardingViewController.swift
//  CookingBook
//
//  Created by Caroline Tikhomirova on 29.08.2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // MARK: - UI Elements
    
    let backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "onboardingScreenImage")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
    
        return image
    }()
    
    private lazy var topTextStack: UIStackView = {
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
    
    private let amountOfRecipesLabel: UILabel = {
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
        stack.spacing = -10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let bestTextLineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Best"
        label.textAlignment = .center
        label.font = .semiBold56()
        label.textColor = .white0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let recipeTextLineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Recipe"
        label.textAlignment = .center
        label.font = .semiBold56()
        label.textColor = .white0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondTextLineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "\nFind best recipes for cooking"
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
        
        view.addSubview(topTextStack)
        topTextStack.addArrangedSubview(starLabel)
        topTextStack.addArrangedSubview(amountOfRecipesLabel)
        topTextStack.addArrangedSubview(recipesTextLabel)
        
        view.addSubview(mainTextStack)
        mainTextStack.addArrangedSubview(bestTextLineLabel)
        mainTextStack.addArrangedSubview(recipeTextLineLabel)
        mainTextStack.addArrangedSubview(secondTextLineLabel)
        
        view.addSubview(startButton)
        
        backgroundImageView.addGradient([.clear, .neutral100], locations: [0.3, 1], frame: view.bounds)
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            topTextStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            topTextStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topTextStack.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            
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
