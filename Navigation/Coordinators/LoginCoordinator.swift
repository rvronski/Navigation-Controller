//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 12.11.2022.
//

import UIKit

class LoginCoordinator: ModuleCoordinatable {
    
    enum PushVC {
        case ProfileVC(User, ViewModelProtocol)
        case PhotoVC
        
    }
    
    let moduleType: Module.ModuleType

    private let factory: AppFactory

    private(set) var coordinators: [Coordinatable] = []
    private(set) var module: Module?
    private var navigationController: UINavigationController

    init(moduleType: Module.ModuleType, factory: AppFactory, navigationController: UINavigationController) {
        self.moduleType = moduleType
        self.factory = factory
        self.navigationController = navigationController
    }
   
    func start() -> UIViewController {
        let module = factory.makeModule(ofType: .login)
        let viewController = module.view
        viewController.tabBarItem = moduleType.tabBarItem
        (module.viewModel as? LoginViewModel)?.coordinator = self
        self.module = module
        return viewController
    }

    func pushProfileViewController(viewModel: ViewModelProtocol, user: User?, pushTo: PushVC) {
        switch pushTo{
        case let .ProfileVC(user, viewModel):
            let viewControllerToPush = ProfileViewController(viewModel: viewModel as! LoginViewModelProtocol, user: user)
            
            (module!.view as? UINavigationController)?.pushViewController(viewControllerToPush, animated: true)
            print("🍑")
        case .PhotoVC:
            let vc = PhotosViewController()
//            viewModel.coordinator  = self
            (module!.view as? UINavigationController)?.pushViewController(vc, animated: true)
        }
    }
    
}
