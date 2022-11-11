//
//  AppFactory.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 12.11.2022.
//

import UIKit

class AppFactory {
    
    func makeModule(ofType moduleType: Module.ModuleType) -> Module {
        switch moduleType {
        case .login:
            let view = UINavigationController(rootViewController: ProfileViewController(user: CurrentUserService().user))
            return Module(moduleType: moduleType, view: view)
        case .feed:
            let view = UINavigationController(rootViewController: FeedViewController())
            return Module(moduleType: moduleType, view: view)
        }
    }
}
