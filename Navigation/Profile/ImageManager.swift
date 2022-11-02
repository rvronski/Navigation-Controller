//
//  ImageManager.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 01.11.2022.
//

import UIKit
import iOSIntPackage

class ImageManager {
    let photoArray = [ photo1, photo2, photo3, photo4, photo5, photo6, photo7, photo8, photo9, photo10, photo11, photo12, photo13, photo14, photo15, photo16, photo17, photo18, photo19, photo20]
    
    let imageProcessor = ImageProcessor()
    var completetion:(UIImage?) -> ()
    init(completetion: @escaping (UIImage?) -> () ) {
        self.completetion = completetion
    }
    func filterImage(image: [Photos]) {
//       let image = photoArray
        imageProcessor.processImage(sourceImage: UIImage(named: image.description)!, filter: .tonal, completion: completetion)
    }
    
    
}
