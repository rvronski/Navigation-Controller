//
//  InfoTableVIewCell.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 14.12.2022.
//

import UIKit

class InfoTableVIewCell: UITableViewCell {
   
    
    private lazy var nameLabel: UILabel = {
       let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .black
        return nameLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInfo(text: String) {
        self.nameLabel.text = text
       
    }
    
    private func setupView() {
        self.contentView.addSubview(self.nameLabel)
        
        NSLayoutConstraint.activate([
            self.nameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.nameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.nameLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}
