//
//  Checker.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 25.10.2022.
//

import UIKit

public final class Checker {
    
    public static var shared: Checker = .init()
    
    private let log = "rvronski"
    private let pass = "qwerty"

    func check(login: String, password: String) -> Bool {
        if login == log & password == pass {
            return true
        } else {
            return false
        }
    }
}
