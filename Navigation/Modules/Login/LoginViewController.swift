//
//  LogInViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 02.08.2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    enum LoginErrors: Error {
        case noLogin
        case userNotFound
        
    }
    
    private let brutForce = BrutForce()
    
    private let viewModel: LoginViewModelProtocol
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
//        passwordTextField.text = "qwerty"
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
        loginTextfield.placeholder = "Login/email"
//        loginTextfield.text = "rvronski"
        loginTextfield.layer.borderColor = UIColor.gray.cgColor
        loginTextfield.font = UIFont(name: "sysemFont", size: 16)
        loginTextfield.textColor = .black
        loginTextfield.autocapitalizationType = .none
        loginTextfield.textAlignment = .justified
        loginTextfield.keyboardType = .emailAddress
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        loginTextfield.leftView = paddingView
        loginTextfield.leftViewMode = .always
        loginTextfield.becomeFirstResponder()
        return loginTextfield
    }()
    
    private lazy var brutForceButton: UIButton = {
        let brutForceButton = UIButton()
        brutForceButton.translatesAutoresizingMaskIntoConstraints = false
        brutForceButton.setTitle("Подобрать пароль", for: .normal)
        brutForceButton.setTitleColor(.systemBlue, for: .normal)
        brutForceButton.addTarget(self, action: #selector(brutForceButtonDidTap), for: .touchUpInside)
        return brutForceButton
    }()
    
    private lazy var signUpButton: UIButton = {
        let signUpButton = UIButton()
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle("SignUp", for: .normal)
        signUpButton.setTitleColor(.systemBlue, for: .normal)
        signUpButton.addTarget(self, action: #selector(didPushSignUpButton), for: .touchUpInside)
        return signUpButton
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .darkGray
//        activityIndicator.isHidden = true
        return activityIndicator
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
        button.setBackgroundImage(UIImage(named: "Blue_pixel.png"), for: .normal)
        button.setTitle("Log in", for: .normal)
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        button.clipsToBounds = true
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
        self.tabBarController?.tabBar.isHidden = true
        
    }
    private func setupView() {
        self.view.addSubview(scrollView)
        self.view.backgroundColor = .white
        self.scrollView.addSubview(self.stackView)
        self.scrollView.addSubview(self.brutForceButton)
        self.scrollView.addSubview(self.signUpButton)
        self.stackView.addArrangedSubview(loginTextField)
        self.stackView.addArrangedSubview(activityIndicator)
        self.stackView.addArrangedSubview(passwordTextField)
        self.scrollView.addSubview(self.button)
        self.scrollView.addSubview(self.logoImage)
        self.passwordTextField.bringSubviewToFront(activityIndicator)
       
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.logoImage.centerYAnchor.constraint(lessThanOrEqualTo: self.scrollView.centerYAnchor, constant: -220),
            self.logoImage.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.logoImage.heightAnchor.constraint(equalToConstant: 100),
            self.logoImage.widthAnchor.constraint(equalTo: self.logoImage.heightAnchor, multiplier: 1),
            
            self.stackView.topAnchor.constraint(lessThanOrEqualTo: self.logoImage.bottomAnchor, constant: 120),
            self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.stackView.heightAnchor.constraint(equalToConstant: 100),
            
            self.button.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 16),
            self.button.leftAnchor.constraint(equalTo: self.stackView.leftAnchor),
            self.button.rightAnchor.constraint(equalTo: self.stackView.rightAnchor),
            self.button.heightAnchor.constraint(equalToConstant: 50),
            
            self.brutForceButton.topAnchor.constraint(equalTo: self.button.bottomAnchor, constant: 16),
            self.brutForceButton.leftAnchor.constraint(equalTo: self.button.leftAnchor),
            self.brutForceButton.rightAnchor.constraint(equalTo: self.button.rightAnchor),
            self.brutForceButton.heightAnchor.constraint(equalToConstant: 20),
            
            self.signUpButton.topAnchor.constraint(equalTo: self.brutForceButton.bottomAnchor, constant: 10),
            self.signUpButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.signUpButton.widthAnchor.constraint(equalToConstant: 100),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 20),
            
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.passwordTextField.centerYAnchor),
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.passwordTextField.centerXAnchor),
//            self.activityIndicator.bottomAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: -2),
//            self.activityIndicator.topAnchor.constraint(equalTo: self.passwordTextField.topAnchor, constant: 2),
            
        ])
    }
  private var loginDelegate: LoginViewControllerDelegate?
    
//    func showRegistrationVC() {
//        let regVC = RegisterViewController(viewModel: LoginViewModel())
//        self.window?.rootViewController?.present(regVC, animated: true)
//    }
    override func loadView() {
        super.loadView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                return
            } else {
                self.viewModel.viewInputDidChange(viewInput: .tapLoginButton(self.viewModel))
            }
        }
        
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
    
    override func viewWillDisappear(_ animated: Bool) {
//        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @objc func didTapButton()  {
//#if DEBUG
//        let service = TestUserService()
//
//#else
//        let service = CurrentUserService()
//#endif
        guard let email = loginTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !email.isEmpty else {
            tapAlert()
            return
        }
        
//        do {
//            let client = try service.input(login: email)
            let loginInspector = LoginInspector()
            self.loginDelegate? = loginInspector
            let result = loginDelegate?.checkCredentials(email: email, password: password)
                if result == true {
                    self.viewModel.viewInputDidChange(viewInput: .tapLoginButton(self.viewModel))
                } else {
                    self.alertDismiss(title: "Пользователь не найден", message: "Зарегестрируйтесь в приложении") {
                        self.navigationController?.pushViewController(RegisterViewController(viewModel: self.viewModel), animated: false)
                    }
                }
                
            }
//            let input = try loginInspector.check(log: loginTextField.text!, pass: passwordTextField.text!)
//            if input == true {
//                viewModel.viewInputDidChange(viewInput: .tapLoginButton( client, viewModel))
            
//        } catch {
//            tapAlert()
//        }
    
    
    private func alertDismiss(title: String, message: String?, completionHandler: @escaping () -> Void) {
         
         let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
         let ok = UIAlertAction(title: "ОК", style: .default) { _ in
             completionHandler()
         }
         alertController.addAction(ok)
         
         present(alertController, animated: true, completion: nil)
     }
    
    private func alertOk(title: String, message: String?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ОК", style: .default)
        
        alertController.addAction(ok)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func tapAlert()  {
        let alertControler = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
       let firstAction = UIAlertAction(title: "Ok", style: .default){ _ in
           self.loginTextField.becomeFirstResponder()
       }

       alertControler.addAction(firstAction)
        self.present(alertControler, animated: true)

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
    
    @objc private func brutForceButtonDidTap() {
        var newPassword = ""
        self.passwordTextField.text = ""
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global().async {
           let password = LoginModel.shared.randomString(length: 4)
            newPassword = self.brutForce.bruteForce(passwordToUnlock: password)
            group.leave()
        }
        group.notify(queue: .main) {
            self.passwordTextField.text = newPassword
            self.passwordTextField.isSecureTextEntry = false
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
  
    @objc private func didPushSignUpButton() {
        let vcReg = RegisterViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(vcReg, animated: true)
    }
}





