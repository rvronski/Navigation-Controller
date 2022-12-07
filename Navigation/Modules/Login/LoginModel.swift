//
//  Checker.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 25.10.2022.
//

import UIKit

protocol LoginViewControllerDelegate {
    func check(log: String, pass: String) throws -> Bool
}

public final class LoginModel {
    
    public static var shared: LoginModel = .init()
    private var newPassword = " "
    func randomString(length: Int) -> String  {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        newPassword = String((0..<length).map{ _ in letters.randomElement()! })
        password = newPassword
        return newPassword
    }
    
    private let login = "rvronski"
    private var password = "qwerty"
    
    func check(log: String, pass: String) -> Bool {
        login == log && password == pass ? true : false
        
    }
}
struct LoginInspector: LoginViewControllerDelegate {
    
    func check(log: String, pass: String) throws -> Bool {
        guard LoginModel.shared.check(log: log, pass: pass) == true else { throw LoginViewController.LoginErrors.noLogin }
        return true
        
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
    func input(login: String) throws -> User
}
