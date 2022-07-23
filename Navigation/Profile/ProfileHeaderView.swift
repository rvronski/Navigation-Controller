//
//  ProfileView.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 23.07.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
   private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 16, y: 104, width: 100, height: 100))
       imageView.backgroundColor = .orange
       imageView.layer.cornerRadius = 50
       imageView.layer.borderWidth = 3
       imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
   private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel(frame: CGRect(x: 136, y: 115, width: 300, height: 20.5))
       nameLabel.text = "Роман Вронский"
       nameLabel.font = UIFont(name: "bold", size: 18)
       nameLabel.textColor = .black
        return nameLabel
    }()
    
   private lazy var disctiptionLabel: UILabel = {
        let discriptionLabel = UILabel(frame: CGRect(x: 136 , y: 190, width: 300, height: 20.5))
       disctiptionLabel.text = "Waiting for something"
       disctiptionLabel.font = UIFont(name: "regular", size: 14)
       discriptionLabel.textColor = .gray
        return discriptionLabel
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 136, y: 115, width: 400, height: 71))
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        return stackView
    }()
    
private lazy var button: UIButton = {
     let button = UIButton(frame: CGRect(x: 16, y: 220, width: 382, height: 50))
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemBlue
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
        self.addSubview(self.avatarImage)
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.nameLabel)
        self.stackView.addArrangedSubview(self.disctiptionLabel)
        self.addSubview(self.button)
    }
}
