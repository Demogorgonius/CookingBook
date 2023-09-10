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

    private let addingView: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor.red
        element.layer.cornerRadius = 24
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let addButton: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(named: "plus"), for: .normal)
        element.backgroundColor = .clear
        element.layer.cornerRadius = 24
        element.translatesAutoresizingMaskIntoConstraints = false
        return  element
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
extension CustomTabBarController {
// MARK: - flow funcs
    private func setUpView() {
        customDesignedView.isUserInteractionEnabled = false
        tabBar.layer.zPosition = 1
        view.addSubview(customDesignedView)
        view.addSubview(addingView)
        addingView.addSubview(addButton)
        setConstraints()
        delegate = self
        createCTabBar()
    }
    
    private func createCTabBar() {
        let emptyViewController = UIViewController()
        emptyViewController.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 2)
        
        viewControllers = [
            makeViewControllers(vc: StartScreenController(), image: UIImage(named: "home"), selectedImage: UIImage(named: "home.selected")),
            makeViewControllers(vc: FavoritesViewController(), image: UIImage(named: "bookmark"), selectedImage: UIImage(named: "bookmark.selected")),
            emptyViewController,
            makeViewControllers(vc: NotificationViewController(), image: UIImage(named: "bell"), selectedImage: UIImage(named: "bell.selected")),
            makeViewControllers(vc: ProfileViewController(), image: UIImage(named: "person"), selectedImage: UIImage(named: "person.selected"))
        ]
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
            customDesignedView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            addingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addingView.topAnchor.constraint(equalTo: customDesignedView.topAnchor, constant: -25),
            addingView.heightAnchor.constraint(equalToConstant: 48),
            addingView.widthAnchor.constraint(equalToConstant: 48),
            
            addButton.heightAnchor.constraint(equalToConstant: 48),
            addButton.widthAnchor.constraint(equalToConstant: 48),
            addButton.centerXAnchor.constraint(equalTo: addingView.centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: addingView.centerYAnchor)
        ])
    }
}
