//
//  AuthError.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 11.05.2023.
//

import Foundation

enum AuthError {
    case notFilled
    case invalidEmail
    case unknownError
    case serverError
}
extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .invalidEmail:
            return NSLocalizedString("email_is_not_valid", comment: "")
        case .unknownError:
            /// we will use server_error key to display user internal error
            return NSLocalizedString("server_error", comment: "")
        case .serverError:
            return NSLocalizedString("server_error", comment: "")
        }
    }
}
