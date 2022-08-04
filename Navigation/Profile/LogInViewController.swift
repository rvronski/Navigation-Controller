//
//  LogInViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 02.08.2022.
//

import UIKit

class LogInViewController: UIViewController {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.textColor = .black
        passwordTextField.font = UIFont(name: "sysemFont", size: 16)
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        passwordTextField.leftView = paddingView
        passwordTextField.leftViewMode = .always
        return passwordTextField
    }()
    
    private lazy var loginTextField: UITextField = {
        var loginTextfield = UITextField()
        loginTextfield.translatesAutoresizingMaskIntoConstraints = false
        loginTextfield.placeholder = "Login"
        loginTextfield.layer.borderColor = UIColor.gray.cgColor
        loginTextfield.font = UIFont(name: "sysemFont", size: 16)
        loginTextfield.textColor = .black
        loginTextfield.autocapitalizationType = .none
        loginTextfield.textAlignment = .justified
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        loginTextfield.leftView = paddingView
        loginTextfield.leftViewMode = .always
        return loginTextfield
    }()
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.spacing = 0
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.clipsToBounds = true
        return stackView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var logoImage: UIImageView = {
        let logoImage = UIImageView()
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.backgroundColor = .clear
        logoImage.image = UIImage(named: "logo.png")
        logoImage.clipsToBounds = true
        return logoImage
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupGesture()
        
    }
    private func setupView() {
        self.view.addSubview(scrollView)
        self.view.backgroundColor = .white
        self.scrollView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(loginTextField)
        self.stackView.addArrangedSubview(passwordTextField)
        self.scrollView.addSubview(self.button)
        self.scrollView.addSubview(self.logoImage)
        
        let scrollViewConstraints = scrollViewConstraints()
        let imageConstraints = imageConstraints()
        let stackConstraints = stackConstraints()
        let buttonConstraints = buttonConstraints()
        NSLayoutConstraint.activate(scrollViewConstraints + stackConstraints + buttonConstraints + imageConstraints)
    }
    private func scrollViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let trailingConstraint = self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let leadingConstraint  = self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let bottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        return [topConstraint,trailingConstraint, leadingConstraint, bottomConstraint]
    }
    
    private func imageConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = self.logoImage.centerYAnchor.constraint(lessThanOrEqualTo: self.scrollView.centerYAnchor, constant: -120)
        let centerXConstraint = self.logoImage.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let heightConstraint = self.logoImage.heightAnchor.constraint(equalToConstant: 100)
        let widthConstraint = self.logoImage.widthAnchor.constraint(equalTo: self.logoImage.heightAnchor, multiplier: 1)
        return [centerYConstraint, centerXConstraint, heightConstraint, widthConstraint]
    }
    private func stackConstraints() -> [NSLayoutConstraint] {
        let topConsraint = self.stackView.topAnchor.constraint(lessThanOrEqualTo: self.logoImage.bottomAnchor, constant: 120)
        let leftAnchor = self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16)
        let rightAnchor = self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16)
//        let centerYAnchor = self.stackView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: 50)
        let heightConstraint = self.stackView.heightAnchor.constraint(equalToConstant: 100)
    return [ leftAnchor, rightAnchor,topConsraint, heightConstraint]
    }
    private func buttonConstraints() -> [NSLayoutConstraint] {
        let topConsraint = self.button.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 16)
        let leftAnchor = self.button.leftAnchor.constraint(equalTo: self.stackView.leftAnchor)
        let rightAnchor = self.button.rightAnchor.constraint(equalTo: self.stackView.rightAnchor)
//        let centerYConstraint = self.button.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor,constant: 166)
        let heightConstraint = self.button.heightAnchor.constraint(equalToConstant: 50)
        return [topConsraint, leftAnchor, rightAnchor, heightConstraint]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didHideKeyboard(_:)),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loginTextField.becomeFirstResponder()
    }
    
    @objc func didTapButton() {
     let vc = ProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        self.hideKeyboard()
    }
    @objc func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let loginButtonBottomPointY = self.button.frame.origin.y + self.button.frame.height
            let keyboardOriginY = self.view.frame.height - keyboardHeight
            
            let offset = keyboardOriginY <= loginButtonBottomPointY
            ? loginButtonBottomPointY - keyboardOriginY + 16
            : 0
            
            self.scrollView.contentOffset = CGPoint(x: 0, y: offset)
        }
    }
    @objc private func didHideKeyboard(_ notification: Notification) {
        self.hideKeyboard()
    }
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
        self.scrollView.setContentOffset(.zero, animated: true)
    }
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
}
