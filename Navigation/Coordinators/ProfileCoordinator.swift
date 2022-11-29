//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 18.11.2022.
//

import UIKit

//class ProfileCoordinator: ModuleCoordinatable {
//    let moduleType: Module.ModuleType
//
//    private let factory: AppFactory
//
//    private(set) var coordinators: [Coordinatable] = []
//    private(set) var module: Module?
//   
//    init(moduleType: Module.ModuleType, factory: AppFactory) {
//        self.moduleType = moduleType
//        self.factory = factory
//    }
//    
//    func start() -> UIViewController {
//        let module = factory.makeModule(ofType: .profile)
//        let viewController = module.view
//        (module.viewModel as! ProfileViewModel).coordinator = self
//        return viewController
//    }
//    
//    func photoCellDidTap() {
//        let vc = PhotosViewController()
//        (module?.view as? UINavigationController)?.pushViewController(vc, animated: true)
//    }
//    
//}
