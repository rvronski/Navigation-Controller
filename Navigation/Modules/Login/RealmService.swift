//
//  RealmService.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 03.01.2023.
//

import Foundation
import RealmSwift

class RealmService {
//    let realm = try! Realm()
//    let pass = try? keyChain.getData("pass")
//    let config = Realm.Configuration(encryptionKey: pass)
    func saveUser(password: String, login: String) {
        let pass = try? keyChain.getData("pass")
        let config = Realm.Configuration(encryptionKey: pass)
        do {
            let realm = try Realm(configuration: config)
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
        } catch {
            print(error)
        }
        
    }
}
