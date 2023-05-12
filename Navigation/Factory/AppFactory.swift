//
//  AppFactory.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 12.11.2022.
//

import UIKit

class AppFactory {
    
    private let checkService: CheckerServiceProtocol
    
    init(checkService: CheckerServiceProtocol) {
        self.checkService = checkService
    }
    func makeModule(ofType moduleType: Module.ModuleType) -> Module {
        switch moduleType {
        case .login:
            let viewModel = LoginViewModel(checkService: checkService)
            let view = UINavigationController(rootViewController: LoginViewController(viewModel: viewModel))
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        case .feed:
            let viewModel = FeedViewModel()
            let view = UINavigationController(rootViewController: FeedViewController())
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
       
        case .music:
            let viewModel = MusicViewModel()
            let view = UINavigationController(rootViewController: MusicViewController())
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        case .info:
            let viewModel = InfoViewModel()
            let view = UINavigationController(rootViewController: InfoViewController())
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        case .like:
            let viewModel = LikeViewodel()
            let view = UINavigationController(rootViewController: LikeViewController())
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        case .profile:
            let viewModel = ProfileViewModel()
            let view = UINavigationController(rootViewController: ProfileViewController(viewModel: viewModel))
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        }
    }
}
