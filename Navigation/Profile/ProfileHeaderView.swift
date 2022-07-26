//
//  ProfileView.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 23.07.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 16, y: 16, width: 100, height: 100))
        imageView.backgroundColor = .orange
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = UIImage(named: "IMG_1824")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel(frame: CGRect(x: 152, y: 27, width: 350, height: 21.5))
        nameLabel.text = "Роман Вронский"
        nameLabel.font = UIFont(name: "bold", size: 18)
        nameLabel.textColor = .black
        return nameLabel
    }()
    
    private lazy var disctiptionLabel: UILabel = {
        let discriptionLabel = UILabel(frame: CGRect(x: 152 , y: 58.5, width: 350, height: 21.5))
        discriptionLabel.text = "Waiting for something..."
        discriptionLabel.font = UIFont(name: "regular", size: 14)
        discriptionLabel.textColor = .gray
        return discriptionLabel
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 152, y: 27, width: 350, height: 73))
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 16, y: 166, width: 382, height: 50))
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemBlue
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var statusTextField: UITextField = {
        let status = UITextField(frame: CGRect(x: 152, y: 110, width: 246, height: 40))
        status.textColor = .black
        status.layer.cornerRadius = 12
        status.layer.borderWidth = 1
        status.layer.borderColor = UIColor.black.cgColor
        status.font = UIFont(name: "regular", size: 15)
        status.backgroundColor = .white
        status.addTarget(self, action: #selector(self.statusTextChanged), for: .editingChanged)
        status.textAlignment = .center
        status.placeholder = "Статус"
        status.clearsOnBeginEditing = true
        status.becomeFirstResponder()
        return status
    }()
    
    private var statusText: String = " "
    
    @objc func statusTextChanged(_ textField: UITextField){
        
        statusText = textField.text!
        
    }
    @objc func buttonPressed(){
        
        disctiptionLabel.text =  statusText
        statusTextField.resignFirstResponder()
        statusTextField.placeholder = ""
        statusTextField.text = ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
        self.backgroundColor = .systemGray5
        self.addSubview(self.avatarImage)
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.nameLabel)
        self.stackView.addArrangedSubview(self.disctiptionLabel)
        self.addSubview(self.button)
        self.addSubview(statusTextField)
    }
}
