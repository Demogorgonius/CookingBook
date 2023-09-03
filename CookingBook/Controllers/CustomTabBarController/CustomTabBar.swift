//
//  CustomTapBar.swift
//  CookingBook
//
//  Created by Sergey on 28.08.2023.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCTabBar()
        
    }
    
    private func createCTabBar() {
        
        viewControllers = [
//            makeViewControllers(vc: StartScreenController(), title: "Home", icon: UIImage(systemName: "house.fill")),
            makeViewControllers(vc: FavoritesViewController(), title: "Favorites", icon: UIImage(systemName: "bookmark.fill")),
            makeViewControllers(vc: NotificationViewController(), title: "Notifications", icon: UIImage(systemName: "bell.fill")),
            makeViewControllers(vc: ProfileViewController(), title: "Profile", icon: UIImage(systemName: "person.crop.circle"))
        ]
        tabBar.tintColor = .darkGray
        tabBar.unselectedItemTintColor = .lightGray
    }
    
    private func makeViewControllers(vc: UIViewController, title: String, icon: UIImage?) -> UIViewController {
        
        vc.tabBarItem.title = title
        vc.tabBarItem.image = icon
        return vc
        
    }
    
}
