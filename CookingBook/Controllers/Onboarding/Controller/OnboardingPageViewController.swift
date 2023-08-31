//
//  OnboardingPageViewController.swift
//  CookingBook
//
//  Created by Caroline Tikhomirova on 31.08.2023.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    var pagesArray = [OnboardingData]()
    let backImage1 = UIImage(named: "onboardingImagePage1")
    let backImage2 = UIImage(named: "onboardingImagePage2")
    let backImage3 = UIImage(named: "onboardingImagePage3")

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstPageData = OnboardingData(backImage: backImage1!, text: "Recipes from all over the World", buttonText: "Continue")
        let secondPageData = OnboardingData(backImage: backImage2!, text: "Recipes with each and every detail", buttonText: "Continue")
        let thirdPageData = OnboardingData(backImage: backImage3!, text: "Cook it now or save it for later", buttonText: "Start cooking")
        
        pagesArray.append(firstPageData)
        pagesArray.append(secondPageData)
        pagesArray.append(thirdPageData)
    }
    
   //MARK: - UIViewControllers
    
    lazy var arrayPageViewController: [OnboardingViewController] = {
        var onboardingVC = [OnboardingViewController]()
        for page in pagesArray {
            onboardingVC.append(OnboardingViewController(onboardingData: page))
        }
        return onboardingVC
    }()
    
    //MARK: - init UIPageViewController
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
        self.dataSource = self
        self.delegate = self
        setViewControllers(arrayPageViewController, direction: .forward, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension OnboardingPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard viewController == viewController as? OnboardingViewController else { return nil }
        if let index = arrayPageViewController.firstIndex(of: viewController as! OnboardingViewController) {
            if index > 0 {
                print(">0 index")
                return arrayPageViewController[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard viewController == viewController as? OnboardingViewController else { return nil }
        if let index = arrayPageViewController.firstIndex(of: viewController as! OnboardingViewController) {
            if index < pagesArray.count - 1 {
                return arrayPageViewController[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pagesArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
