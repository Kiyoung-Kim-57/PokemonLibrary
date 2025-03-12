import UIKit
import PLPresentation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let startViewController = HomeViewController(collectionViewLayout: UICollectionViewLayout())
        let mainTabBarController = MainTabBarController(viewControllers: [
            startViewController,
            UIViewController()
        ])
        
        mainTabBarController.setTabBarItem(at: 0) { item in
            item.image = UIImage(systemName: "house")
            item.selectedImage = UIImage(systemName: "house.fill")
            item.title = "Home"
        }
        
        mainTabBarController.setTabBarItem(at: 1) { item in
            item.image = UIImage(systemName: "person.circle")
            item.selectedImage = UIImage(systemName: "person.circle.fill")
            item.title = "Profile"
        }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = mainTabBarController
        
        window?.makeKeyAndVisible()
    }
}

