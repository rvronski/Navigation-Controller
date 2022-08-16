//
//  PhotosViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 17.08.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return layout
    }()
    
    private lazy var photosCollectionView: UICollectionView = {
        let photosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        photosCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return photosCollectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()

        
    }
    
    private func setupView() {
        self.view.addSubview(photosCollectionView)
        
        NSLayoutConstraint.activate([
            self.photosCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.photosCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.photosCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.photosCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        
        
        
        ])
    }

  
}
