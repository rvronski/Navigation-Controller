//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 12.11.2022.
//

import UIKit

class LoginCoordinator: ModuleCoordinatable {
    
    private let factory: AppFactory
    
    private(set) var moduleType: Module.ModuleType
    
    init(factory: AppFactory, moduleType: Module.ModuleType) {
        self.factory = factory
        self.moduleType = moduleType
    }
    
    private(set)var coordinators: [Coordinatable] = []
    var module: Module?
    
    func start() -> UIViewController {
        let module = factory.makeModule(ofType: moduleType)
        let viewController = module.view
        viewController.tabBarItem = moduleType.tabBarItem
    }
    
    
    
    
}
