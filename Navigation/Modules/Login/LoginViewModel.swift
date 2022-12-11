//
//  LoginViewModel.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 15.11.2022.
//

import UIKit

protocol LoginViewModelProtocol: ViewModelProtocol {
    func viewInputDidChange(viewInput: LoginViewModel.ViewInput)
}

class LoginViewModel: LoginViewModelProtocol {
    enum ViewInput {
        case tapLoginButton(User,ViewModelProtocol)
        case tapPhotoCell
    }
    
    var coordinator: LoginCoordinator?
    
    
    
    func viewInputDidChange(viewInput: ViewInput) {
        switch viewInput {
        case let .tapLoginButton(user, self):
            coordinator?.pushProfileViewController(viewModel: self, user: user, pushTo: .ProfileVC(user, self))
            print(coordinator ?? "nil")
            
        case .tapPhotoCell:
            coordinator?.pushProfileViewController(viewModel: self, user: nil, pushTo: .PhotoVC)
            print(coordinator ?? "nil")
        }
    }
}
