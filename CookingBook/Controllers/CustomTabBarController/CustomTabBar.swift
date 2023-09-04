//
//  CustomTapBar.swift
//  CookingBook
//
//  Created by Sergey on 28.08.2023.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
// MARK: - constant
    private let customDesignedView: CustomView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

// MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.backgroundColor = .clear
    }
}

// MARK: - extension
extension CustomTabBarController  {
// MARK: - flow funcs
    private func setUpView() {
        customDesignedView.isUserInteractionEnabled = false
        tabBar.layer.zPosition = 1
        view.addSubview(customDesignedView)
        setConstraints()
        delegate = self
        createCTabBar()
    }
    
    private func createCTabBar() {
        let emptyViewController = UIViewController()
        emptyViewController.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 2)
        
        viewControllers = [
            makeViewControllers(vc: StartScreenController(), image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill")?.withTintColor(UIColor.primary10,renderingMode: .alwaysOriginal)),
            makeViewControllers(vc: FavoritesViewController(), image: UIImage(systemName: "bookmark"), selectedImage: UIImage(systemName: "bookmark.fill")?.withTintColor(UIColor.primary10,renderingMode: .alwaysOriginal)),
            emptyViewController,
            makeViewControllers(vc: NotificationViewController(), image: UIImage(systemName: "bell"), selectedImage: UIImage(systemName: "bell.fill")?.withTintColor(UIColor.primary10,renderingMode: .alwaysOriginal)),
            makeViewControllers(vc: ProfileViewController(), image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill")?.withTintColor(UIColor.primary10,renderingMode: .alwaysOriginal))
        ]
        tabBar.unselectedItemTintColor = UIColor.neutral40
    }
    
    private func makeViewControllers(vc: UIViewController, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        vc.tabBarItem.image = image
        vc.tabBarItem.selectedImage = selectedImage
        return vc
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 2 {
                //false, чтобы предотвратить переход на черный экран.
                return false
            }
            return true
        }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            customDesignedView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            customDesignedView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            customDesignedView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
}
