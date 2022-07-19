//
//  PostViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 15.07.2022.
//

import UIKit

class PostViewController: UIViewController{
    let vc = FeedViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.navigationItem.title = vc.post.title
    }
    
    
    
}
