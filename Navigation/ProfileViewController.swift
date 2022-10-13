//
//  ProfileViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 16.07.2022.
//

import UIKit
import StorageService
class ProfileViewController: UIViewController {
    private lazy var avatarView: AvatarView = {
        let avatarView = AvatarView()
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.delegate = self
        return avatarView
    }()
    
    
    private lazy var profileHeader: ProfileHeaderView = {
        let profileHeader = ProfileHeaderView()
        profileHeader.delegate = self
        profileHeader.translatesAutoresizingMaskIntoConstraints = false
        return profileHeader
    }()
    
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
        self.avatarView.isHidden = true
    }
    
    private func setupView(){
        #if DEBUG
        self.view.backgroundColor = .systemBackground
        #else
        self.view.backgroundColor = .systemGreen
        #endif
        
        self.view.addSubview(tableView)
        self.view.addSubview(avatarView)
        self.view.addSubview(profileHeader)
        self.view.bringSubviewToFront(avatarView)
        
        NSLayoutConstraint.activate([
            
            
            
            self.avatarView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.avatarView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.avatarView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.avatarView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.avatarView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.profileHeader.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.profileHeader.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.profileHeader.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.profileHeader.heightAnchor.constraint(equalToConstant: 220),
            
            self.tableView.topAnchor.constraint(equalTo: self.profileHeader.bottomAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            
        ] )
    }
    private var avatarWidthConstraint: NSLayoutConstraint?
    private var avatarHeightConstraint: NSLayoutConstraint?
    
    var isAvatarIncreased = false
    
    
    
    func changeLayoutAvatar() {
        let closeButton = avatarView.closeButton
        let avatarImage = self.avatarView.avatarImageView
        let widthScreen = UIScreen.main.bounds.width
        let widthAvatar = avatarImage.bounds.width
        let width = widthScreen / widthAvatar
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .calculationModeCubic) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) { [self] in
                self.avatarView.isHidden = false
                self.avatarView.bringSubviewToFront(avatarImage)
                self.avatarView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                avatarImage.transform = self.isAvatarIncreased ? .identity : CGAffineTransform(scaleX: width, y: width)
                avatarImage.layer.borderWidth = self.isAvatarIncreased ? 3 : 0
                avatarImage.center = self.isAvatarIncreased ? CGPoint(x: 63.166666666666664, y: 63.166666666666664) : CGPoint(x: self.avatarView.bounds.midX, y: self.avatarView.bounds.midY)
                avatarImage.layer.cornerRadius = self.isAvatarIncreased ? avatarImage.frame.height/2 : 0
                closeButton.isHidden = self.isAvatarIncreased ? true : false
            }
            
        } completion: { _ in
            self.isAvatarIncreased.toggle()
            if self.isAvatarIncreased == false {
                self.avatarView.isHidden = true
            }
        }
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
        self.tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 && indexPath.section == 0 {
            let vc1 = PhotosViewController()
            self.navigationController?.pushViewController(vc1, animated: true)
        }
    }
    
}

extension ProfileViewController: AvatarViewDelegate, ProfileTableViewDelegate {
    func changeLayout() {
        self.changeLayoutAvatar()
    }
}
    


