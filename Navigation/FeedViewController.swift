//
//  FeedViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 15.07.2022.
//

import UIKit

class FeedViewController: UIViewController {
    private lazy var stackViewButtons: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.button)
        self.view.addSubview(self.stackViewButtons)
        self.stackViewButtons.addArrangedSubview(self.button1)
        self.stackViewButtons.addArrangedSubview(self.button)
        let stackViewConstraints = stackViewConstraints()
        NSLayoutConstraint.activate(stackViewConstraints)
        
    }
    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 500, width: 200, height: 50))
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.setTitle("me", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)

        return button
    }()
    
    private lazy var button1: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 500, width: 200, height: 50))
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.setTitle("Push", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
    
        return button
    }()
    
    private func stackViewConstraints() -> [NSLayoutConstraint] {
        let centrXConstraint = self.stackViewButtons.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let centrYConstraint = self.stackViewButtons.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let trailingConstraint = self.stackViewButtons.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        return [centrXConstraint, centrYConstraint, trailingConstraint]
    }
    struct Post {
        var title: String
    }
    
    var post = Post(title: "Привет!")
    
    @objc private func didTapButton() {
        let vc = PostViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    
}


    
    
    

