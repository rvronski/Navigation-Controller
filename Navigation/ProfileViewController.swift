//
//  ProfileViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 16.07.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    private lazy var profileHeader: ProfileHeaderView = {
        let profileHeader = ProfileHeaderView(frame: .zero)
        return profileHeader
    }()
    
      
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(profileHeader)
        self.navigationItem.title = "Профиль"
        }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.profileHeader.frame = CGRect(x: 0, y: 88, width: 414, height: 808)
    }
}

