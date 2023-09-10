//
//  SceneDelegate.swift
//  CookingBook
//
//  Created by Sergey on 27.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let networkManager = NetworkManager()
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        networkManager.fetch { (result: Result<RecipeModel, RequestError>) in
            switch result {
            case .success(let response):
                MainModel.shared.recipeData = response.results
            case .failure(let error):
                print(error.customMessage)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        networkManager.searchRecipe(type: "Salad") {(result: Result<RecipeModel, RequestError>) in
            switch result {
            case .success(let data):
                MainModel.shared.categoryFood = data.results
            case .failure(let error):
                print(error.customMessage)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            guard let windowScene = scene as? UIWindowScene else { return }
            let window = UIWindow(windowScene: windowScene)
            window.makeKeyAndVisible()
            window.rootViewController = WelcomeViewController()
            self.window = window
        }
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        MainModel.shared.saveUserDef()
    }
}

