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
            let viewModel = LoginViewModel()
            let view = UINavigationController(rootViewController: LoginViewController(viewModel: viewModel))
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        case .feed:
            let viewModel = FeedViewModel()
            let view = UINavigationController(rootViewController: FeedViewController())
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
       
        }
    }
}