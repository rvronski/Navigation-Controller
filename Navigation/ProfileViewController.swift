//
//  ProfileViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 16.07.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    private lazy var profileHeader: ProfileHeaderView = {
        let profileHeader = ProfileHeaderView(frame:CGRect(x: 0, y: 88, width: 100, height: 100))
        profileHeader.translatesAutoresizingMaskIntoConstraints = false
        return profileHeader
    }()
    let photoCell = PhotosTableViewCell()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
       
        
     return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupGesture()
        self.tabBarController?.tabBar.isHidden = false
        
    }

   private var posts:[Post] = [post1, post2, post3]
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    private func setupView(){
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(profileHeader)
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            self.profileHeader.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.profileHeader.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.profileHeader.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.profileHeader.heightAnchor.constraint(equalToConstant: 220),
            
            self.tableView.topAnchor.constraint(equalTo: self.profileHeader.bottomAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    private func setupGesture() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            self.view.addGestureRecognizer(tapGesture)
        }
        @objc private func hideKeyboard() {
            self.view.endEditing(true)
    
        }
   
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotosTableViewCell
            return cell
        } else {
            guard let cell1 = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {  let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            cell1.setup(with: posts[indexPath.row])
            return cell1
        }
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section > 0 {
            return self.posts.count
        }
        return 0
    }
     
    
    
   
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && indexPath.section == 0 {
            let vc1 = PhotosViewController()
            self.navigationController?.pushViewController(vc1, animated: true)
        } else {
            return
        }
    }
    
}
   


