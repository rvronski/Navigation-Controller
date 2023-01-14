//
//  RealmService.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 03.01.2023.
//

import Foundation
import RealmSwift

class RealmService {
    let realm = try! Realm()
    
    func saveUser(password: String, login: String) {
        let user = RealmUser(login: login, password: password)
        let users = Array(realm.objects(RealmUser.self))
        guard users.count > 0 else { return try! realm.write({
            realm.add(user)
            
        }) }
        users.forEach { i in
            if user.password == i.password {
                if user.login == i.login {
                    print("пользователь существует")
                } else {
                    try! realm.write({
                        realm.add(user)
                    })
                }
            }
            
            
        }
    }
}
