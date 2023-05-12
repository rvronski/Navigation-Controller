//
//  Validators.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 11.05.2023.
//

import Foundation

class Validators {
    
    static func isFilled(firstname: String?, email: String?, password: String?) -> Bool {
        guard !(firstname ?? "").isEmpty,
            !(email ?? "").isEmpty,
            !(password ?? "").isEmpty else {
                return false
        }
        return true
    }
    
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
    
    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}
