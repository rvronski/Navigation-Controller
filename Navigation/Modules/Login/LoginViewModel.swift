//
//  LoginViewModel.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 15.11.2022.
//

import UIKit

protocol LoginViewModelProtocol: ViewModelProtocol {
    func didTapLoginButton(viewInput: LoginViewModel.ViewInput)
}

class LoginViewModel: LoginViewModelProtocol {
    enum ViewInput {
        case tapLoginButton(User)
    }
    
    var coordinator: LoginCoordinator?
    
    
    
    func didTapLoginButton(viewInput: ViewInput) {
        switch viewInput {
        case let .tapLoginButton(user):
            coordinator?.pushProfileViewController(user: user)
            print("🍎")
            
        }
    }
}
