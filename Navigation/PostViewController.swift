//
//  PostViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 15.07.2022.
//

import UIKit

class PostViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.text)
    }
    
    lazy var text:UITextView = {
        let text = UITextView(frame: CGRect(x: 0, y: 0, width: 25, height: 100), textContainer: NSTextContainer())
        return text
    }()

    
}
