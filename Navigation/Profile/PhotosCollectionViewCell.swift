//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 17.08.2022.
//

import UIKit
import iOSIntPackage
class PhotosCollectionViewCell: UICollectionViewCell {
    
    private lazy var photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        return photoImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let imageProcessor = ImageProcessor()
    
    
    func setup(with image: UIImage) {
        let photoVC = PhotosViewController()
        let array = [image]
        for i in array {
            
            self.photoImageView.image = i
            photoVC.receive(images: array)
        }
    }
    func setupView() {
        self.contentView.addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            self.photoImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.photoImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.photoImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.photoImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            
        ])
    }
}
