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
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = StartViewController()
        window?.makeKeyAndVisible()
    }
}

