//
//  ProfileViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 16.07.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    let profileHeader = ProfileHeaderView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.view.addSubview(profileHeader)
        
        
        func viewWillLayoutSubviews() {
            
        
    }
}
}
