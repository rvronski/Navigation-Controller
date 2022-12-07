//
//  CurrentUserService.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 21.10.2022.
//

import UIKit

class CurrentUserService: UserService {
    
    var user = User(login: "rvronski", name: "Роман Вронский", status: " ", avatar: UIImage(named: "IMG_1824")!)
    
    func input(login: String) throws -> User {
        
        guard user.login == login else { throw LoginViewController.LoginErrors.noLogin }
        return user
    }
    
}
