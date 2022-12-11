//
//  VideoTableViewCell.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 10.12.2022.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    struct ViewModel {
        var name: String
        
    }
    
    private lazy var nameLabel: UILabel = {
       let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: ViewModel) {
        self.nameLabel.text = viewModel.name
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
