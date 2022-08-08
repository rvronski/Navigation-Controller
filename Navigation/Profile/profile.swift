//
//  profile.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 09.08.2022.
//

import UIKit

class ProfileViewController1: UIViewController {
    private lazy var profileHeader: ProfileHeaderView = {
        let profileHeader = ProfileHeaderView(frame:CGRect(x: 0, y: 88, width: 100, height: 100))
        profileHeader.translatesAutoresizingMaskIntoConstraints = false
        return profileHeader
    }()
    
    private lazy var button: UIButton = {
      let button = UIButton(frame: CGRect(x: 16, y: 300, width: 0, height: 50))
        button.backgroundColor = .orange
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Нажми", for: .normal)
        return button
    }()
      
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(profileHeader)
        self.view.addSubview(button)
        self.setupGesture()
        self.navigationItem.title = "Профиль"
        let profileHeaderViewConstraints = self.profileHeaderViewConstraints()
        let buttonConstraints = self.buttonConstraints()
        NSLayoutConstraint.activate(profileHeaderViewConstraints + buttonConstraints)
        }
    private func buttonConstraints() -> [NSLayoutConstraint] {
        let bottomConstraint = self.button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        let leadingConstraint = self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingConstraint = self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let heightContraint = self.button.heightAnchor.constraint(equalToConstant: 50)
        return [bottomConstraint, trailingConstraint, leadingConstraint, heightContraint]
    }
    
    private func profileHeaderViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = self.profileHeader.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leftConstraint = self.profileHeader.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let rightConstraint = self.profileHeader.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let heightConstraint = self.profileHeader.heightAnchor.constraint(equalToConstant: 220)
        return [topAnchor, leftConstraint, rightConstraint, heightConstraint]
    }
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
        
    }
}

