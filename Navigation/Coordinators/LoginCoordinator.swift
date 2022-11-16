//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 12.11.2022.
//

import UIKit

class LoginCoordinator: ModuleCoordinatable {
    
    let moduleType: Module.ModuleType

    private let factory: AppFactory

    private(set) var coordinators: [Coordinatable] = []
    private(set) var module: Module?

    init(moduleType: Module.ModuleType, factory: AppFactory) {
        self.moduleType = moduleType
        self.factory = factory
    }
    
    func start() -> UIViewController {
        let module = factory.makeModule(ofType: .login)
        let viewController = module.view
        viewController.tabBarItem = moduleType.tabBarItem
        (module.viewModel as? LoginViewModel)?.coordinator = self
        self.module = module
        return viewController
    }

    func pushProfileViewController(user: User) {
        let viewControllerToPush = ProfileViewController(user: user)
        (module?.view as? UINavigationController)?.pushViewController(viewControllerToPush, animated: true)
        print("🍑")
    }
    
    
    
}
