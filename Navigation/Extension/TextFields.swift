//
//  TextFields.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 11.05.2023.
//

import UIKit

class LoginTF: UITextField {
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor.gray.cgColor
        backgroundColor = .white
        font = UIFont(name: "sysemFont", size: 16)
        textColor = .black
        attributedPlaceholder = NSAttributedString(string: "Login/email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray ])
        autocapitalizationType = .none
        textAlignment = .justified
        keyboardType = .emailAddress
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        leftView = paddingView
        leftViewMode = .always
        becomeFirstResponder()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PasswordTF: UITextField {
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray ])
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        textColor = .black
//        passwordTextField.text = "qwerty"
        font = UIFont(name: "sysemFont", size: 16)
        autocapitalizationType = .none
        isSecureTextEntry = true
        backgroundColor = .white
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        leftView = paddingView
        leftViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomTF: UITextField {
    init(placeHolder: String, secureTextEntry: Bool, keyBoardType: UIKeyboardType) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray ])
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        textColor = .black
        font = UIFont(name: "sysemFont", size: 16)
        autocapitalizationType = .none
        isSecureTextEntry = secureTextEntry
        keyboardType = keyBoardType
        backgroundColor = .white
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        leftView = paddingView
        leftViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
