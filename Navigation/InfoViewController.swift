//
//  InfoViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 19.07.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .tintColor
        self.view.addSubview(myButton)
        self.myButton.center = view.center
    }
    
    lazy var myButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 35))
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = .clear
        button.setTitle("Push", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(self.tapAlert), for: .touchUpInside)
        return button
    }()
    
    @objc func tapAlert() {
        let alertController = UIAlertController(title: "Сообщение", message: "Хотите открыть сообщение?", preferredStyle: .actionSheet)
        let firstAction = UIAlertAction(title: "Да", style: .default){ _ in
            print("Да")
        }
        let secondAction = UIAlertAction(title: "Нет", style: .destructive){ _ in
            print("Нет")
        }
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        self.present(alertController, animated: true)
    }
}
