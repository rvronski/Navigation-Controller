//
//  InfoViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 19.07.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private var namesResidents = [String]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        tableView.estimatedRowHeight = 50
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.register(InfoTableVIewCell.self, forCellReuseIdentifier: "InfoCell")
        return tableView
    }()
    
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
        button.setTitle("text".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(showText), for: .touchUpInside)
        return button
    }()
    private lazy var planetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = .link
        button.setTitle("orbitalPeriod".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(self.showPlanetOrbital), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        InfoNetworkManager.loadResidents {[weak self] name in
            let group = DispatchGroup()
            group.enter()
            DispatchQueue.global().async {
                self?.namesResidents.append(name ?? "")
                group.leave()
            }
            group.notify(queue: .main) {
                self?.tableView.reloadData()
                print(self?.namesResidents ?? " ")
            }
        }
        
    }
    
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.myButton)
        self.view.addSubview(self.infoTextLabel)
        self.view.addSubview(self.planetButton)
        self.view.addSubview(self.infoPlanetLabel)
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.planetButton.topAnchor.constraint(equalTo: self.myButton.bottomAnchor, constant: 16),
            self.planetButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            self.planetButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.planetButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.planetButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.myButton.topAnchor.constraint(equalTo: self.infoPlanetLabel.bottomAnchor, constant: 16),
            self.myButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.myButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.myButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.infoPlanetLabel.topAnchor.constraint(equalTo: self.infoTextLabel.bottomAnchor),
            self.infoPlanetLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.infoPlanetLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.infoPlanetLabel.heightAnchor.constraint(equalToConstant: 50),
            
            self.infoTextLabel.bottomAnchor.constraint(equalTo: self.infoPlanetLabel.topAnchor, constant: -16),
            self.infoTextLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.infoTextLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.infoTextLabel.heightAnchor.constraint(equalToConstant: 100),
            
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.tableView.bottomAnchor.constraint(equalTo: self.infoTextLabel.topAnchor),
        ])
    }
    
    @objc func showText() {
        self.tableView.reloadData()
        InfoNetworkManager.loadText { [weak self] textArray in
            DispatchQueue.main.async {
                self?.infoTextLabel.text = textArray?.randomElement()
            }
        }
        
    }
    
    @objc func showPlanetOrbital() {
        InfoNetworkManager.loadOrbitalPeriod { [weak self] orbital_period in
            DispatchQueue.main.async {
                self?.infoPlanetLabel.text = "\("orbitalPeriod".localized) - \(orbital_period ?? "0")"
            }
        }
    }
}


extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        namesResidents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! InfoTableVIewCell
        cell.setupInfo(text: namesResidents[indexPath.row])
        return cell
    }
}

