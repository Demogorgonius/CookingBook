//
//  OnboardingViewController.swift
//  CookingBook
//
//  Created by Caroline Tikhomirova on 31.08.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private var currentPageNumber = 0
    
    //MARK: - UI Elements
    
    private let backgroundImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 25
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white0
        label.font = UIFont.semiBold40()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.isUserInteractionEnabled = true
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .semiBold16()
        button.layer.cornerRadius = 23
        button.backgroundColor = UIColor.primary50
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.white0, for: .normal)
        button.titleLabel?.font = .regular10()
        button.addTarget(self, action: #selector(skipTapped), for: .valueChanged)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        addSubViews()
        setupConstraints()
        configureInfoPageControl()
        updateUI(pageNumber: currentPageNumber)
        
    }
    
    // MARK: - Buttons Methods
    
    @objc func skipTapped(_ sender:AnyObject) {
        skipButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.skipButton.alpha = 1
            UserDefaults.standard.setValue(true, forKey: "isOnboarding")
            let newVC = CustomTabBarController()
            newVC.modalPresentationStyle = .fullScreen
            newVC.modalTransitionStyle = .crossDissolve
            self.present(newVC, animated: true)
        }
    }
    
    @objc private func continueButtonTapped() {
        continueButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            self.continueButton.alpha = 1
            if self.currentPageNumber <= 3 {
                self.currentPageNumber += 1
            }
            self.updateUI(pageNumber: self.currentPageNumber)
        }
    }
    
    // MARK: - Configure UI
    
    private func addSubViews() {
        view.addSubview(backgroundImage)
        view.addSubview(continueButton)
        view.addSubview(pageControl)
        view.addSubview(textLabel)
        view.addSubview(skipButton)
        
        backgroundImage.addGradient([.clear, .neutral100.withAlphaComponent(0.6)], locations: [0, 0.75], frame: view.bounds)
        
        view.addGestureRecognizer(createSwipe(direction: .left))
        view.addGestureRecognizer(createSwipe(direction: .right))
        
    }
    
    private func updateUI(pageNumber number: Int) {
        if number < OnboardingDataManager.dataArray.count {
            let data = OnboardingDataManager.dataArray[number]
            UIView.transition(
                with: self.pageControl,
                duration: 0.5,
                options: .transitionCrossDissolve,
                animations: {
                    self.pageControl.currentPage = number
                },
                completion: nil)
            UIView.transition(
                with: self.textLabel,
                duration: 0.5,
                options: .transitionCrossDissolve,
                animations: {
                    self.textLabel.attributedText = data.text
                },
                completion: nil)
            UIView.transition(
                with: self.continueButton,
                duration: 0.5,
                options: .transitionCrossDissolve,
                animations: {
                    self.continueButton.setTitle(data.buttonText, for: .normal)
                },
                completion: nil)
            UIView.transition(
                with: self.backgroundImage,
                duration: 0.5,
                options: .transitionCrossDissolve,
                animations: {
                    self.backgroundImage.image = data.backImage
                },
                completion: nil)
            if number == OnboardingDataManager.dataArray.count - 1 {
                skipButton.isHidden = true
            }
        } else {
            UserDefaults.standard.setValue(true, forKey: "isOnboarding")
            let newVC = CustomTabBarController()
            newVC.modalPresentationStyle = .fullScreen
            newVC.modalTransitionStyle = .crossDissolve
            present(newVC, animated: true)
        }
        
    }
    
    private func createSwipe(direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
            
            let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
            swipeGestureRecognizer.direction = direction
            return swipeGestureRecognizer
        }
        
        @objc func didSwipe(_ sender: UISwipeGestureRecognizer) {
            switch sender.direction {
            case .left:
                continueButton.alpha = 0.5
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.continueButton.alpha = 1
                    if self.currentPageNumber <= 3 {
                        self.currentPageNumber += 1
                    }
                    self.updateUI(pageNumber: self.currentPageNumber)
                }
            case .right:
                continueButton.alpha = 0.5
                if currentPageNumber == 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        self.continueButton.alpha = 1
                    }
                    break
                } else  {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        self.continueButton.alpha = 1
                        if self.currentPageNumber <= 3 {
                            self.currentPageNumber -= 1
                        }
                        self.updateUI(pageNumber: self.currentPageNumber)
                    }
                }
            default:
                break
            }
        }
        
    private func configureInfoPageControl() {
        pageControl.numberOfPages = OnboardingDataManager.dataArray.count
        pageControl.currentPage = 0
        pageControl.preferredIndicatorImage = UIImage(named: "unselectedPage")
        pageControl.pageIndicatorTintColor = .neutral20
        pageControl.currentPageIndicatorTintColor = .rating100
        if #available(iOS 16.0, *) {
            pageControl.preferredCurrentPageIndicatorImage = UIImage(named: "selectedPage")
        }
        pageControl.addTarget(self, action: #selector(pageTapped(_:)), for: .touchUpInside)
        
    }
    
    @objc func pageTapped(_ sender: UIPageControl) {
            print("sender page: \(sender.currentPage)\n current page: \(pageControl.currentPage)")
        continueButtonTapped()
        }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -55),
            continueButton.heightAnchor.constraint(equalToConstant: 44),
            continueButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 193),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            pageControl.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -12),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -12),
            
            skipButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 12),
            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
        ])
    }
    
}

//extension OnboardingViewController: PaperOnboardingDelegate {
//
//    func onboardingWillTransitonToIndex(_ index: Int) {
//        skipButton.isHidden = index == 2 ? false : true
//    }

//class CustomImagePageControl: UIPageControl {
//    
//    let activeImage:UIImage = UIImage(named: "selectedPage")!
//    let inactiveImage:UIImage = UIImage(named: "unselectedPage")!
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        self.pageIndicatorTintColor = UIColor.clear
//        self.currentPageIndicatorTintColor = UIColor.clear
//        self.clipsToBounds = false
//    }
//    
//    func updateDots() {
//        var i = 0
//        for view in self.subviews {
//            if let imageView = self.imageForSubview(view) {
//                if i == self.currentPage {
//                    imageView.image = self.activeImage
//                } else {
//                    imageView.image = self.inactiveImage
//                }
//                i = i + 1
//            } else {
//                var dotImage = self.inactiveImage
//                if i == self.currentPage {
//                    dotImage = self.activeImage
//                }
//                view.clipsToBounds = false
//                view.addSubview(UIImageView(image:dotImage))
//                i = i + 1
//            }
//        }
//    }
//    
//    fileprivate func imageForSubview(_ view:UIView) -> UIImageView? {
//        var dot:UIImageView?
//        
//        if let dotImageView = view as? UIImageView {
//            dot = dotImageView
//        } else {
//            for foundView in view.subviews {
//                if let imageView = foundView as? UIImageView {
//                    dot = imageView
//                    break
//                }
//            }
//        }
//        
//        return dot
//    }
//}
