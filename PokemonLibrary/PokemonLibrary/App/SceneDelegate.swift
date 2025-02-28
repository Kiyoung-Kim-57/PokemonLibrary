//
//  SceneDelegate.swift
//  PokemonLibrary
//
//  Created by 김기영 on 1/27/25.
//

import UIKit
import PLPresentation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let startViewController = HomeViewController()
        let tempViewController = UIViewController()
        let mainTabBarController = MainTabBarController(viewControllers: [
            startViewController,
            tempViewController
        ])
        
        mainTabBarController.setTabBarItem(at: 0) { item in
            item.image = UIImage(systemName: "person.circle")
            item.selectedImage = UIImage(systemName: "person.circle.fill")
            item.title = "Home"
        }
        
        mainTabBarController.setTabBarItem(at: 1) { item in
            item.image = UIImage(systemName: "plus")
            item.selectedImage = UIImage(systemName: "plus.fill")
            item.title = "Add"
        }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = mainTabBarController
        
        window?.makeKeyAndVisible()
    }
}

