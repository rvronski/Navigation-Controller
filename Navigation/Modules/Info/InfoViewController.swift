//
//  InfoViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 19.07.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private var namesResidents: [String]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        showNames()
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
            
            self.myButton.topAnchor.constraint(equalTo: self.infoTextLabel.bottomAnchor, constant: 16),
            self.myButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.myButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.myButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.infoTextLabel.bottomAnchor.constraint(equalTo: self.myButton.topAnchor, constant: -16),
            self.infoTextLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.infoTextLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.infoTextLabel.heightAnchor.constraint(equalToConstant: 100),
            
            self.infoPlanetLabel.bottomAnchor.constraint(equalTo: self.infoTextLabel.topAnchor),
            self.infoPlanetLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.infoPlanetLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.infoPlanetLabel.heightAnchor.constraint(equalToConstant: 50),
            
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.tableView.bottomAnchor.constraint(equalTo: self.infoPlanetLabel.topAnchor),
            
            
           
            
           
            
            
        ])
    }
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(InfoTableVIewCell, forCellReuseIdentifier: "InfoCell")
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
        button.setTitle("Text", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(showe), for: .touchUpInside)
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
    
    private lazy var namesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = .link
        button.setTitle("Names", for: .normal)
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
    @objc func showNames() {
        
        loadName { [weak self] name in
            DispatchQueue.main.async {
                self?.namesResidents = name
                }
            }
        }
    
    @objc func showe() {
        self.infoTextLabel.text = namesResidents?.randomElement()
    }
}
    

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        namesResidents?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoTableVIewCell
        let viewModel = In.ViewModel(name: "Video \(indexPath.row + 1)")
        cell.setup(viewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let select: String = videoArray[indexPath.row]
        DispatchQueue.global().async {
            self.loadYoutube(videoID: select) { [weak self] urlText in
                DispatchQueue.main.async {
                    self?.wv.loadHTMLString(urlText, baseURL: nil)
                }
                
            }
        }
        
    }
    
}
