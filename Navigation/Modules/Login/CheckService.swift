//
//  CheckService.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 16.12.2022.
//

import Foundation
import Firebase
import FirebaseDatabase
import UIKit

protocol CheckerServiceProtocol {
    func checkCredentials(email: String, password: String,  completion: @escaping ((Bool) -> Void))
    func signUp(email: String, password: String, userName: String, completion: @escaping ((Int) -> Void))
}

class CheckerService: CheckerServiceProtocol {
    
    func checkCredentials(email: String, password: String,  completion: @escaping ((Bool) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password ) {  result, error in
            guard error == nil else {
                print("Need to registration")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func signUp(email: String, password: String, userName: String, completion: @escaping ((Int) -> Void)) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email,
                                            password: password,
                                            completion: { result, error  in
            guard error == nil else {
                print("Account creation failed")
                completion(1)
                return
            }
            
            if let result = result {
                print("UID:", result.user.uid)
                let ref = Database.database().reference().child("Users")
                ref.child(result.user.uid).updateChildValues(["userName": userName,
                                                              "email": email,
                                                              "admin": false])
                
                Auth.auth().currentUser?.sendEmailVerification { error in
                    if let error = error {
                        print("error sendEmailVerification", error)
                        completion(2)
                    } else {
                        
                    }
                }
            }
        })
    }
        
   
    
}
