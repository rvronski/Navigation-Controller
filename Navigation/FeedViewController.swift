//
//  FeedViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 15.07.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.button)
        self.button.center = view.center
    
        
    }
    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 500, width: 200, height: 50))
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.setTitle(post.title, for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
    
        return button
    }()
    
    struct Post {
        var title: String
    }
    
    var post = Post(title: "Привет!")
    
    @objc private func didTapButton() {
        let vc = PostViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


    
    
    

//Создайте FeedViewController и ProfileViewController и добавьте их как root view controller у навигационных контроллеров.
//Добавьте PostViewController для показа выбранного поста. Поменяйте заголовок у контроллера и цвет главной view. Добавьте кнопку на FeedViewController и сделайте переход на экран поста. Контроллер должен показаться в стеке UINavigationController.
//Создайте структуру Post со свойством title: String. Создайте объект типа Post в FeedViewController и передайте его в PostViewController. В классе PostViewController выставьте title полученного поста в качестве заголовка контроллера.
//На PostViewController добавьте Bar Button Item в навигейшн бар. При нажатии на него должен открываться новый контроллер InfoViewController. Контроллер должен показаться модально.
//На InfoViewController создайте кнопку. При нажатии на неё должен показаться UIAlertController с заданным title, message и двумя UIAlertAction. При нажатии на UIAlertAction в консоль должно выводиться сообщение.
