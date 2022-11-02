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



public final class Checker {
    
    public static var shared: Checker = .init()
    
    private let login = "rvronski"
    private let password = "qwerty"
    
//    func check(log: String, pass: String) -> Bool {
//        if login == log  {
//            if password == pass {
//                return true
//            } else {
//                return false
//            }
//        }
//        return false
//    }
    
    func check(log: String, pass: String) -> Bool {
        login == log  && password == pass ? true : false
    }
}


struct LoginInspector: LoginViewControllerDelegate {
    
    func check(log: String, pass: String) -> Bool {
        Checker.shared.check(log: log, pass: pass)
    
    }
}

