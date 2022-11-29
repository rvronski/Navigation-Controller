//
//  FeedViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 15.07.2022.
//

import UIKit

class FeedViewController: UIViewController {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.view.addSubview(self.button)
        self.view.addSubview(self.textField)
        self.view.addSubview(self.checkLabel)
        
        stackViewConstraints()
        setupGesture()
        button.tapButton = { [weak self] in
            let result = FeedViewModel().check(word: (self?.textField.text)!)
            if result == true {
                self?.checkLabel.backgroundColor = .green
            } else {
                self?.checkLabel.backgroundColor = .red
            }
        }
        
    }
    private lazy var button = CustomButton(buttonText: "Push", textColor: .white, background: .systemBlue, frame: .zero)
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 16
        textField.textAlignment = .center
        return textField
    }()
    private lazy var checkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.cornerRadius = 50
        label.clipsToBounds = true
        return label
    }()
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        checkLabel.layer.cornerRadius = checkLabel.frame.height/2
//
//    }

    private func stackViewConstraints() {
        NSLayoutConstraint.activate([
            
            self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.button.heightAnchor.constraint(equalToConstant: 50),
            self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            self.textField.bottomAnchor.constraint(equalTo: self.button.topAnchor, constant: -20),
            self.textField.trailingAnchor.constraint(equalTo: self.button.trailingAnchor),
            self.textField.leadingAnchor.constraint(equalTo: self.button.leadingAnchor),
            self.textField.heightAnchor.constraint(equalToConstant: 50),
            
            self.checkLabel.bottomAnchor.constraint(equalTo: self.textField.topAnchor, constant: -20),
            self.checkLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.checkLabel.heightAnchor.constraint(equalToConstant: 100),
            self.checkLabel.widthAnchor.constraint(equalTo: self.checkLabel.heightAnchor)
        ])
        
        
    }
    struct Post {
        var title: String
    }
    
    var post4 = Post(title: "Привет!")

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
        
    }
    
}


    
    
    

