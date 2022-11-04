//
//  ImageManager.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 01.11.2022.
//

import UIKit
import iOSIntPackage

class ImageManager {
    
    
    let imageProcessor = ImageProcessor()
    
    func filterImage(image: [Photos]) -> [UIImage] {
        var photoArray = [UIImage]()
        for i in image {
            imageProcessor.processImage(sourceImage: UIImage(named: i.imageName )!, filter: .noir) { photoArray.append($0!) }
        }
          return photoArray
        }
        
    
        
    }
    
let processor = ImageManager()
let photoVC = PhotosViewController()
let newArray = processor.filterImage(image: photoVC.photos)
    



