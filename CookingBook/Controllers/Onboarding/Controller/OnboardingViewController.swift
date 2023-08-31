//
//  OnboardingViewController.swift
//  CookingBook
//
//  Created by Caroline Tikhomirova on 31.08.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    //MARK: - UI Elements
    private let backgroundImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .semiBold16()
        button.layer.cornerRadius = 50
        button.backgroundColor = UIColor.primary50
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let textLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white0
        label.font = UIFont.semiBold40()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var skipButton : UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.white0, for: .normal)
        button.titleLabel?.font = .regular10()
        button.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

   
    
    //MARK: - Init
    
    init(onboardingData: OnboardingData) {
        super.init(nibName: nil, bundle: nil)
        edgesForExtendedLayout = []
        
        backgroundImage.image = onboardingData.backImage
        textLabel.text = onboardingData.text
        continueButton.setTitle(onboardingData.buttonText, for: .normal)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func skipTapped(_ sender:AnyObject) {
        skipButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.skipButton.alpha = 1
            let newVC = WelcomeViewController()
            newVC.modalPresentationStyle = .fullScreen
            self.present(newVC, animated: true)
        }
    }
    
    private func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(textLabel)
        view.addSubview(continueButton)
        view.addSubview(skipButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            textLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 72),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: 72),
            
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -46),
            continueButton.heightAnchor.constraint(equalToConstant: 44),
            //continueButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 156),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            skipButton.bottomAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 12),
            skipButton.heightAnchor.constraint(equalToConstant: 56),
            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
