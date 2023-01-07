//
//  AppCoordinator.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 12.11.2022.
//

import UIKit

final class AppCoordinator: Coordinatable {
    private(set) var coordinators: [Coordinatable] = []
    
    private let factory: AppFactory
    
    init(factory: AppFactory) {
        self.factory = factory
    }

    func start() -> UIViewController {
        let loginViewCoordinator = LoginCoordinator(moduleType: .login, factory: factory, navigationController: UINavigationController())
        let feedViewCoordinator = FeedCoordinator(factory: factory, moduleType: .feed)
        let musicCoordinator = MusicCoordinator(factory: factory, moduleType: .music)
        let infoCoordinator = MusicCoordinator(factory: factory, moduleType: .info)
        let likeCoordinator = LikeCoordinator(factory: factory, moduleType: .like)
        let tabBarController = AppTabBarController(viewControllers:
                                                    [loginViewCoordinator.start(),
                                                     feedViewCoordinator.start(),
                                                     musicCoordinator.start(),
                                                     infoCoordinator.start(),
                                                     likeCoordinator.start()])
        addCoordinator(coordinator: loginViewCoordinator)
        addCoordinator(coordinator: feedViewCoordinator)
        addCoordinator(coordinator: musicCoordinator)
        addCoordinator(coordinator: infoCoordinator)
        addCoordinator(coordinator: likeCoordinator)
    
        
        return tabBarController
        
    }

    func addCoordinator(coordinator: Coordinatable) {
        guard coordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        coordinators.append(coordinator)
    }

    func removeCoordinator(coordinator: Coordinatable) {
        coordinators = coordinators.filter { $0 === coordinator }
    }
    
}
