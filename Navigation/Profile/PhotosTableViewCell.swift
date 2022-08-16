//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 14.08.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    

    
    private lazy var firstPhotoView: UIImageView = {
        let firstPhotoView = UIImageView()
        firstPhotoView.translatesAutoresizingMaskIntoConstraints = false
        firstPhotoView.layer.cornerRadius = 6
        firstPhotoView.backgroundColor = .darkGray

        return firstPhotoView
    }()
    
    private lazy var secondPhotoView: UIImageView = {
        let secondPhotoView = UIImageView()
        secondPhotoView.translatesAutoresizingMaskIntoConstraints = false
        secondPhotoView.layer.cornerRadius = 6
        secondPhotoView.backgroundColor = .orange
        return secondPhotoView
    }()
    private lazy var thirdPhotoView: UIImageView = {
        let thirdPhotoView = UIImageView()
        thirdPhotoView.layer.cornerRadius = 6
        thirdPhotoView.translatesAutoresizingMaskIntoConstraints = false
        thirdPhotoView.backgroundColor = .green
        return thirdPhotoView
    }()
    private lazy var fourthPhotoView: UIImageView = {
        let fourthPhotoView = UIImageView()
        fourthPhotoView.layer.cornerRadius = 6
        fourthPhotoView.translatesAutoresizingMaskIntoConstraints = false
        fourthPhotoView.backgroundColor = .red
        return fourthPhotoView
    }()
    
    private lazy var photosLabel: UILabel = {
       let photosLabel = UILabel()
        photosLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        photosLabel.translatesAutoresizingMaskIntoConstraints = false
        photosLabel.textColor = .black
        photosLabel.text = "Photos"
        return photosLabel
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.contentView.addSubview(photosLabel)
        self.contentView.addSubview(firstPhotoView)
        self.contentView.addSubview(secondPhotoView)
        self.contentView.addSubview(thirdPhotoView)
        self.contentView.addSubview(fourthPhotoView)
        self.contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
        
            self.photosLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            self.photosLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            
            self.firstPhotoView.topAnchor.constraint(equalTo: self.photosLabel.bottomAnchor, constant: 12),
            self.firstPhotoView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            self.firstPhotoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
           
            
            self.secondPhotoView.leadingAnchor.constraint(equalTo: self.firstPhotoView.trailingAnchor, constant: 8 ),
            self.secondPhotoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            
            self.thirdPhotoView.leadingAnchor.constraint(equalTo: self.secondPhotoView.trailingAnchor, constant: 8 ),
            self.thirdPhotoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            
            self.fourthPhotoView.leadingAnchor.constraint(equalTo: self.thirdPhotoView.trailingAnchor, constant: 8 ),
            self.fourthPhotoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            
            self.button.centerYAnchor.constraint(equalTo: self.photosLabel.centerYAnchor),
            self.button.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12)
            
                                 
        
        
        ])
        
    }
    
    
}
