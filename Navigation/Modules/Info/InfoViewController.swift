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
        self.view.addSubview(self.infoTextLabel)
        self.view.addSubview(self.planetButton)
        self.view.addSubview(self.infoPlanetLabel)
        
        NSLayoutConstraint.activate([
            self.infoTextLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.infoTextLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.infoTextLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.infoTextLabel.heightAnchor.constraint(equalToConstant: 100),
            
            self.infoPlanetLabel.bottomAnchor.constraint(equalTo: self.infoTextLabel.topAnchor),
            self.infoPlanetLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.infoPlanetLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.infoPlanetLabel.heightAnchor.constraint(equalToConstant: 50),
            
            self.myButton.topAnchor.constraint(equalTo: self.infoTextLabel.bottomAnchor, constant: 16),
            self.myButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.myButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.myButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.planetButton.topAnchor.constraint(equalTo: self.myButton.bottomAnchor, constant: 16),
            self.planetButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.planetButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.planetButton.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
    }
    
    private lazy var infoTextLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        return infoLabel
    }()
    
    private lazy var infoPlanetLabel: UILabel = {
        let infoLabel = UILabel()
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
        button.setTitle("Text", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(self.showText), for: .touchUpInside)
        return button
    }()
    private lazy var planetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = .link
        button.setTitle("Orbital Period", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(self.showPlanetOrbital), for: .touchUpInside)
        return button
    }()
    
    @objc func showText() {
        
        InfoNetworkManager.loadText { [weak self] textArray in
            DispatchQueue.main.async {
                self?.infoTextLabel.text = textArray?.randomElement()
            }
        }
        
    }
    
    @objc func showPlanetOrbital() {
        
        loadOrbitalPeriod { orbital_period in
            DispatchQueue.main.async {
                self.infoPlanetLabel.text = "Орбитальный период - \(orbital_period ?? "0")"
            }
        }
    }
}
