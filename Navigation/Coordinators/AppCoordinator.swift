//
//  AppCoordinator.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 12.11.2022.
//

import UIKit

final class AppCoordinator: Coordinatable {
    private(set) var coordinators: [Coordinatable] = []
    
    private let factory: AppFactory
    
    init(factory: AppFactory) {
        self.factory = factory
    }

    func start() -> UIViewController {
       
    }


}
