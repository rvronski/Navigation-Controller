//
//  SceneDelegate.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 14.07.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
   
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
       
        let secondNavController = UINavigationController(rootViewController: FeedViewController())
        let factory = MyLoginFactory()
        let loginInspector = factory.makeLoginInspector()
        let loginVC = LoginViewController()
        let navController = UINavigationController(rootViewController: loginVC )
        loginVC.loginDelegate = loginInspector
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            navController, secondNavController
        ]
        tabBarController.viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = $0 == 0 ? "Профиль" : "Лента"
            $1.tabBarItem.image = $0 == 0
            ? UIImage(systemName: "person")
            : UIImage(systemName: "chart.bar.doc.horizontal")
        }
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
    }
    
//    func createLoginInspector() -> LoginInspector {
//        let factory = MyLoginFactory()
//        let loginInspector = factory.makeLoginInspector()
//        let loginVC = LoginViewController()
//        loginVC.loginDelegate = loginInspector
//        return loginInspector
    
    

    func sceneDidDisconnect(_ scene: UIScene) {
        
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
       
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        let PhotosVC = PhotosViewController()
        PhotosVC.facade.removeSubscription(for: PhotosVC)
        PhotosVC.facade.rechargeImageLibrary()
        print("🍅 отписка")
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
       
        
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
       
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}

