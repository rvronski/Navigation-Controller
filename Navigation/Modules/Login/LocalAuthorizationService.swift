//
//  LocalAuth.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 09.04.2023.
//

import Foundation
import LocalAuthentication

class LocalAuthorizationService {
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
        var error: NSError?
        let context = LAContext()
        let canUseBiometricks = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if let error = error {
            print(error)
            authorizationFinished(false)
        }
        guard canUseBiometricks else {
            authorizationFinished(false)
            return
        }
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Войти с помощью пароля") { success, error in
            if let error = error {
                print(error)
            }
        }
    }
}
