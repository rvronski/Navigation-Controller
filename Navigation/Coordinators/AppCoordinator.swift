//
//  AppCoordinator.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 12.11.2022.
//

import UIKit

final class AppCoordinator: Coordinatable {
    
    enum PushVC {
        case registration(ViewModelProtocol)
        case tabBar
    }
                        
    private(set) var coordinators: [Coordinatable] = []
    
    private let factory: AppFactory
    private(set) var module: Module?
    var navigationController: UINavigationController
    init(factory: AppFactory, navigationController: UINavigationController) {
        self.factory = factory
        self.navigationController = navigationController
    }
    func start() -> UIViewController {
        let module = factory.makeModule(ofType: .login)
        let viewController = module.view
        (module.viewModel as! LoginViewModel).coordinator = self
        self.module = module
        return viewController
    }
    
    func goTo(viewModel: ViewModelProtocol, pushTo: PushVC) {
        switch pushTo {
            
        case let .registration(viewModel):
            let viewControllerToPush = RegisterViewController(viewModel: viewModel as! LoginViewModelProtocol)
            (module!.view as? UINavigationController)?.pushViewController(viewControllerToPush, animated: true)
        case .tabBar:
            let profileCoordinator = ProfileCoordinator(moduleType: .profile, factory: factory, navigationController: UINavigationController())
            let feedViewCoordinator = FeedCoordinator(factory: factory, moduleType: .feed)
            let musicCoordinator = MusicCoordinator(factory: factory, moduleType: .music)
            let infoCoordinator = MusicCoordinator(factory: factory, moduleType: .info)
            let likeCoordinator = LikeCoordinator(factory: factory, moduleType: .like)
            let tabBarController = AppTabBarController(viewControllers:
                                                        [profileCoordinator.start(),
                                                         feedViewCoordinator.start(),
                                                         musicCoordinator.start(),
                                                         infoCoordinator.start(),
                                                         likeCoordinator.start()])
            addCoordinator(coordinator: profileCoordinator)
            addCoordinator(coordinator: feedViewCoordinator)
            addCoordinator(coordinator: musicCoordinator)
            addCoordinator(coordinator: infoCoordinator)
            addCoordinator(coordinator: likeCoordinator)
        
            (module!.view as? UINavigationController)?.pushViewController(tabBarController, animated: true)
        }
    }
    
//    func start() -> UIViewController {
//        let loginViewCoordinator = LoginCoordinator(moduleType: .login, factory: factory, navigationController: UINavigationController())
//        let feedViewCoordinator = FeedCoordinator(factory: factory, moduleType: .feed)
//        let musicCoordinator = MusicCoordinator(factory: factory, moduleType: .music)
//        let infoCoordinator = MusicCoordinator(factory: factory, moduleType: .info)
//        let likeCoordinator = LikeCoordinator(factory: factory, moduleType: .like)
//        let tabBarController = AppTabBarController(viewControllers:
//                                                    [loginViewCoordinator.start(),
//                                                     feedViewCoordinator.start(),
//                                                     musicCoordinator.start(),
//                                                     infoCoordinator.start(),
//                                                     likeCoordinator.start()])
//        addCoordinator(coordinator: loginViewCoordinator)
//        addCoordinator(coordinator: feedViewCoordinator)
//        addCoordinator(coordinator: musicCoordinator)
//        addCoordinator(coordinator: infoCoordinator)
//        addCoordinator(coordinator: likeCoordinator)
//    
//        
//        return tabBarController
//        
//    }

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
