//
//  Factory.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 29.10.2022.
//

import Foundation


protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
    
}

