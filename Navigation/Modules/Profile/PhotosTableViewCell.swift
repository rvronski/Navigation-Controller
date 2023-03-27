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
        firstPhotoView.image = UIImage(named: "1")
        firstPhotoView.clipsToBounds = true
        return firstPhotoView
    }()
    
    private lazy var secondPhotoView: UIImageView = {
        let secondPhotoView = UIImageView()
        secondPhotoView.translatesAutoresizingMaskIntoConstraints = false
        secondPhotoView.layer.cornerRadius = 6
        secondPhotoView.image = UIImage(named: "2")
        secondPhotoView.clipsToBounds = true
        return secondPhotoView
    }()
    private lazy var thirdPhotoView: UIImageView = {
        let thirdPhotoView = UIImageView()
        thirdPhotoView.layer.cornerRadius = 6
        thirdPhotoView.translatesAutoresizingMaskIntoConstraints = false
        thirdPhotoView.backgroundColor = .green
        thirdPhotoView.clipsToBounds = true
        thirdPhotoView.image = UIImage(named: "3")
        return thirdPhotoView
    }()
    private lazy var fourthPhotoView: UIImageView = {
        let fourthPhotoView = UIImageView()
        fourthPhotoView.layer.cornerRadius = 6
        fourthPhotoView.translatesAutoresizingMaskIntoConstraints = false
        fourthPhotoView.backgroundColor = .red
        fourthPhotoView.clipsToBounds = true
        fourthPhotoView.image = UIImage(named: "4")
        return fourthPhotoView
    }()
    
    private lazy var photosLabel: UILabel = {
       let photosLabel = UILabel()
        photosLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        photosLabel.translatesAutoresizingMaskIntoConstraints = false
        photosLabel.textColor = .createColor(light: .black, dark: .white)
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
    func setup(with image: Photos) {
        self.firstPhotoView.image = UIImage(named: image.imageName)
        self.secondPhotoView.image = UIImage(named: image.imageName)
        self.thirdPhotoView.image = UIImage(named: image.imageName)
        self.fourthPhotoView.image = UIImage(named: image.imageName)
        
    }
    
    func setupView() {
        self.contentView.addSubview(photosLabel)
//        contentView.addSubviewself.contentView.addSubview(photoStack)
        self.contentView.addSubview(firstPhotoView)
        self.contentView.addSubview(secondPhotoView)
        self.contentView.addSubview(thirdPhotoView)
        self.contentView.addSubview(fourthPhotoView)
        self.contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
        
            self.photosLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            self.photosLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            
//            self.photoStack.topAnchor.constraint(equalTo: self.photosLabel.topAnchor, constant: 12),
//            self.photoStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
//            self.photoStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
//            self.photoStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            
            self.firstPhotoView.topAnchor.constraint(equalTo: self.photosLabel.bottomAnchor, constant: 12),
            self.firstPhotoView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            self.firstPhotoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            self.firstPhotoView.heightAnchor.constraint(equalTo:self.contentView.widthAnchor, multiplier: 0.2210),
            self.firstPhotoView.widthAnchor.constraint(equalTo:self.firstPhotoView.heightAnchor),

    


            self.secondPhotoView.leadingAnchor.constraint(equalTo: self.firstPhotoView.trailingAnchor, constant: 8 ),
            self.secondPhotoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            self.secondPhotoView.heightAnchor.constraint(equalTo:self.contentView.widthAnchor, multiplier: 0.2210),
            self.secondPhotoView.widthAnchor.constraint(equalTo:self.secondPhotoView.heightAnchor),


            
            self.thirdPhotoView.leadingAnchor.constraint(equalTo: self.secondPhotoView.trailingAnchor, constant: 8 ),
            self.thirdPhotoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            self.thirdPhotoView.heightAnchor.constraint(equalTo:self.contentView.widthAnchor, multiplier: 0.2210),
            self.thirdPhotoView.widthAnchor.constraint(equalTo:self.thirdPhotoView.heightAnchor),

            
            self.fourthPhotoView.leadingAnchor.constraint(equalTo: self.thirdPhotoView.trailingAnchor, constant: 8 ),
            self.fourthPhotoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            self.fourthPhotoView.heightAnchor.constraint(equalTo:self.contentView.widthAnchor, multiplier: 0.2210),
            self.fourthPhotoView.widthAnchor.constraint(equalTo:self.fourthPhotoView.heightAnchor),
            self.fourthPhotoView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),

            
            self.button.centerYAnchor.constraint(equalTo: self.photosLabel.centerYAnchor),
            self.button.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12)
            
                                 
        
        
        ])
        
    }
    
    
}
