//
//  RealmLoginModel.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 06.01.2023.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    
    @Persisted var login: String
    @Persisted var password: String
    convenience init(login: String, password: String) {
        self.init()
        self.login = login
        self.password = password
        
        
    }
}
