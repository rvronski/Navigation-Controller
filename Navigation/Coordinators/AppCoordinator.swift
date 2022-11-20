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
        let loginViewCoordinator = LoginCoordinator(moduleType: .login, factory: factory)
        let feedViewCoordinator = FeedCoordinator(factory: factory, moduleType: .feed)
        let profileViewCoordinator = ProfileCoordinator(moduleType: .profile, factory: factory)
        let tabBarController = AppTabBarController(viewControllers:
                                                    [loginViewCoordinator.start(),
                                                     feedViewCoordinator.start(),profileViewCoordinator.start()                                                     ])
        addCoordinator(coordinator: loginViewCoordinator)
        addCoordinator(coordinator: feedViewCoordinator)
        addCoordinator(coordinator: profileViewCoordinator)
    
        
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
