//
//  ProfileViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 16.07.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    lazy var profileHeader: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.view.addSubview(profileHeader)
        }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.profileHeader.frame = self.view.bounds
    }
}

