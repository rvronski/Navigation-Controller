//
//  PhotosViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 17.08.2022.
//

import UIKit
import iOSIntPackage
class PhotosViewController: UIViewController {
    
//    let facade = ImagePublisherFacade()
//    private func subscribe() {
//        facade.subscribe(self)
//
//        facade.addImagesWithTimer(time: 0.5, repeat: 20, userImages: newArray)
//    }
    
    func filterArrayPhoto() {
        photos.forEach { foto in self.filterPhoto.append(UIImage(named: foto.imageName)!)
        }
        let imageProcessor = ImageProcessor()
        let start = DispatchTime.now()
        imageProcessor.processImagesOnThread(sourceImages: self.filterPhoto, filter: .process, qos: .userInteractive) { [weak self] image in
            DispatchQueue.main.async {
                self?.imageArray = image.compactMap { foto in
                    if let foto = foto {
                        return UIImage(cgImage: foto)
                    } else {
                        return nil
                    }
                }
                self?.photosCollectionView.reloadData()
                
            }
            let end = DispatchTime.now()
            
            
            let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
            let timeInterval = Double(nanoTime) / 1_000_000_000
            print("Время выполнения функции: \(timeInterval)")
            
        }
    }
    
    private enum Constants {
        static let numberOfItemsInLine: CGFloat = 3
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }()
    
    private lazy var photosCollectionView: UICollectionView = {
        let photosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        photosCollectionView.translatesAutoresizingMaskIntoConstraints = false
        photosCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefultCell")
        photosCollectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCell")
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        return photosCollectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🍎 view did load")
        self.setupView()
        self.setupNavigationBar()
        self.filterArrayPhoto()
//        self.timeInterval()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.photosCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        facade.removeSubscription(for: self)
//        facade.rechargeImageLibrary()
        
    }
    private func setupNavigationBar() {
        self.navigationItem.title = "Photo Gallery"
    }
     var photos:[Photos] = [ photo1, photo2, photo3, photo4, photo5, photo6, photo7, photo8, photo9, photo10, photo11, photo12, photo13, photo14, photo15, photo16, photo17, photo18, photo19, photo20]
    var filterPhoto = [UIImage]()
    var imageArray = [UIImage]()
    private func setupView() {
        self.view.addSubview(photosCollectionView)
        self.view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            self.photosCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.photosCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.photosCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.photosCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            
            
            
        ])
    }
    
    
}
extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefultCell", for: indexPath)
            return cell
        }
        print("🍋 setup cell")
        
        cell.setup(with: imageArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = (collectionView.frame.width - 32) / Constants.numberOfItemsInLine
        
        return CGSize(width: itemWidth, height: itemWidth)
        
    }
    
    
}
//extension PhotosViewController: ImageLibrarySubscriber {
//
//    func receive(images: [UIImage]) {
//        filterFoto = images
//        self.photosCollectionView.reloadData()
//        print("🍉")
//    }
   

