//
//  Checker.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 25.10.2022.
//

import UIKit

protocol LoginViewControllerDelegate {
    func check(log: String, pass: String) -> Bool
}

public final class LoginModel {
    
    public static var shared: LoginModel = .init()
    
    private let login = "rvronski"
    private let password = "qwerty"
    
    func check(log: String, pass: String) -> Bool {
        login == log  && password == pass ? true : false
    }
}


struct LoginInspector: LoginViewControllerDelegate {
    
    func check(log: String, pass: String) -> Bool {
        LoginModel.shared.check(log: log, pass: pass)
        
    }
}

class User {
    let login: String
    let name: String
    let status: String
    let avatar: UIImage
    
    init(login: String, name: String, status: String, avatar: UIImage){
        self.login = login
        self.name = name
        self.status = status
        self.avatar = avatar
    }
}

protocol UserService {
    func input(login: String) -> User?
}
