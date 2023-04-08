//
//  NavigationTests.swift
//  NavigationTests
//
//  Created by ROMAN VRONSKY on 07.04.2023.
//

import XCTest
import Foundation

@testable import Navigation

final class LoginViewModelTests: XCTestCase {

    let viewModel = LoginViewModel()
   
    let coordinator = FakeCoordinator()
    
    func testTapMapButton() {
        
        viewModel.coordinator = coordinator
        viewModel.coordinator?.pushProfileViewController(viewModel: viewModel, pushTo: .MapVC)
        
        XCTAssertEqual(coordinator.isPushMap, true)
        
    }
    
    func testLoginButton() {
        let profileVC = ProfileViewController(viewModel: self.viewModel)
        viewModel.coordinator = coordinator
        viewModel.coordinator?.pushProfileViewController(viewModel: viewModel, pushTo: .ProfileVC(viewModel))
        XCTAssertEqual(coordinator.isPushProfile, true)
       
    }
    
   
    func testTapPhoto() {
        viewModel.coordinator = coordinator
        viewModel.coordinator?.pushProfileViewController(viewModel: viewModel, pushTo: .PhotoVC)
        XCTAssertEqual(coordinator.isPushPhoto, true)
       
    }
}

class FakeCoordinator: LoginCoordinatable {
    
    var isPushMap = false
    var isPushPhoto = false
    var isPushProfile = false
    
    func pushProfileViewController(viewModel: Navigation.ViewModelProtocol, pushTo: Navigation.LoginCoordinator.PushVC) {
        switch pushTo {
        case .ProfileVC(_):
            isPushProfile = true
        case .MapVC:
            isPushMap = true
        case .PhotoVC:
            isPushPhoto = true
        }
    }
}
