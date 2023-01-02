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
        case tapLoginButton(ViewModelProtocol)
        case tapPhotoCell
    }
    
    var coordinator: LoginCoordinator?
    
    
    
    func viewInputDidChange(viewInput: ViewInput) {
        switch viewInput {
        case .tapLoginButton:
            coordinator?.pushProfileViewController(viewModel: self, pushTo: .ProfileVC(self))
            print(coordinator ?? "nil")
            
        case .tapPhotoCell:
            coordinator?.pushProfileViewController(viewModel: self, pushTo: .PhotoVC)
            print(coordinator ?? "nil")
        }
    }
}
