//
//  InfoViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 19.07.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.myButton)
        self.view.addSubview(self.infoLabel)
        
        NSLayoutConstraint.activate([
            self.infoLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.infoLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.infoLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.infoLabel.heightAnchor.constraint(equalToConstant: 200),
            
            self.myButton.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor, constant: 16),
            self.myButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.myButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.myButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    private lazy var infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        return infoLabel
    }()
    
   private lazy var myButton: UIButton = {
        let button = UIButton()
       button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.white.cgColor
       button.backgroundColor = .link
        button.setTitle("Push", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(self.showText), for: .touchUpInside)
        return button
    }()
    
    @objc func showText() {
       
            InfoNetworkManager.request { [weak self] textArray in
                DispatchQueue.main.async {
                    self?.infoLabel.text = textArray?.randomElement()
                }
            }
        
    }
}
