//
//  TestUserService.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 23.10.2022.
//

import UIKit

class TestUserService: UserService {
    
    let testUser = User(login: "test", name: "Иван Иванов", status: "Hello world!", avatar: UIImage(named: "ava-vk-animal-91")!)
    
    func input(login: String) throws -> User {
        
        guard testUser.login == login else { throw LoginViewController.LoginErrors.noLogin }
        return testUser
    }
}
