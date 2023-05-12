//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 12.11.2022.
//

//import UIKit
//
//protocol LoginCoordinatable: AnyObject {
//    func pushProfileViewController(viewModel: ViewModelProtocol, pushTo: LoginCoordinator.PushVC)
//}
//
//class LoginCoordinator: LoginCoordinatable, ModuleCoordinatable {
//    
//    enum PushVC {
//        case ProfileVC(ViewModelProtocol)
//        case PhotoVC
//        case MapVC
//    }
//    
//    let moduleType: Module.ModuleType
//
//    private let factory: AppFactory
//
//    private(set) var coordinators: [Coordinatable] = []
//    private(set) var module: Module?
//    private var navigationController: UINavigationController
//
//    init(moduleType: Module.ModuleType, factory: AppFactory, navigationController: UINavigationController) {
//        self.moduleType = moduleType
//        self.factory = factory
//        self.navigationController = navigationController
//    }
//   
//    func start() -> UIViewController {
//        let module = factory.makeModule(ofType: .login)
//        let viewController = module.view
//        viewController.tabBarItem = moduleType.tabBarItem
//        (module.viewModel as? LoginViewModel)?.coordinator = self
//        self.module = module
//        return viewController
//    }
//
//    func pushProfileViewController(viewModel: ViewModelProtocol, pushTo: PushVC) {
//        switch pushTo{
//        case let .ProfileVC(viewModel):
//            let viewControllerToPush = ProfileViewController(viewModel: viewModel as! LoginViewModelProtocol)
//            
//            (module!.view as? UINavigationController)?.pushViewController(viewControllerToPush, animated: true)
//            print("🍑")
//        case .PhotoVC:
//            let vc = PhotosViewController()
////            viewModel.coordinator  = self
//            (module!.view as? UINavigationController)?.pushViewController(vc, animated: true)
//        case .MapVC:
//            let vc = MapViewController()
//            (module!.view as! UINavigationController).pushViewController(vc, animated: true)
//        }
//    }
//    
//}
