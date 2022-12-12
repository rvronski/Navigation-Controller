//
//  InfoCoordinator.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 12.12.2022.
//

import UIKit


class InfoCoordinator: ModuleCoordinatable {
    var module: Module?
    private let factory: AppFactory
   private(set) var moduleType: Module.ModuleType
    
   private(set) var coordinators: [Coordinatable] = []
    init(factory:AppFactory, moduleType: Module.ModuleType){
        self.factory = factory
        self.moduleType = moduleType
    }
    
    func start() -> UIViewController {
        let module = factory.makeModule(ofType: moduleType)
        let viewController = module.view
        viewController.tabBarItem = moduleType.tabBarItem
        return viewController
    }
}


