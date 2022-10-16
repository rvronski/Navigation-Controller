//
//  ProfileView.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 23.07.2022.
//

import UIKit
import SnapKit

protocol ProfileTableViewDelegate: AnyObject {
    func changeLayout() 
}

class ProfileHeaderView: UIView {
   
    lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .orange
        imageView.contentMode = .scaleToFill
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = UIImage(named: "IMG_1824")
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.zPosition = .greatestFiniteMagnitude
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel(frame: CGRect(x: 152, y: 27, width: 100, height: 21.5))
        nameLabel.text = "Роман Вронский"
        nameLabel.font = UIFont(name: "bold", size: 18)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private lazy var disctiptionLabel: UILabel = {
        let discriptionLabel = UILabel(frame: CGRect(x: 152 , y: 58.5, width: 100, height: 21.5))
        discriptionLabel.text = "Waiting for something..."
        discriptionLabel.font = UIFont(name: "regular", size: 14)
        discriptionLabel.textColor = .gray
        discriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return discriptionLabel
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 152, y: 27, width: 100, height: 73))
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    

    private lazy var setStatusButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 16, y: 166, width: 100, height: 50))
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var statusTextField: UITextField = {
        let status = UITextField(frame: CGRect(x: 152, y: 110, width: 100, height: 40))
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
//        status.becomeFirstResponder()
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    weak var delegate: ProfileTableViewDelegate?
    private var statusText: String = " "
    
    @objc func statusTextChanged(_ textField: UITextField){
        
        statusText = textField.text ?? "No text"
        
    }
    @objc func buttonPressed(){
        
        disctiptionLabel.text = statusText
        statusTextField.resignFirstResponder()
        statusTextField.placeholder = ""
        statusTextField.text = ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        self.setupGesture()
        self.gestureAvatar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.height/2
    }

    private func setupView() {
        self.backgroundColor = .systemGray5
        self.addSubview(self.avatarImage)
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.nameLabel)
        self.stackView.addArrangedSubview(self.disctiptionLabel)
        self.addSubview(self.setStatusButton)
        self.addSubview(statusTextField)
        self.bringSubviewToFront(self.avatarImage)
         
        avatarImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.lessThanOrEqualToSuperview().multipliedBy(0.2415)
            make.height.equalTo(avatarImage.snp.width)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.width.equalToSuperview().multipliedBy(0.57)
            make.leading.equalTo(avatarImage.snp.trailing).offset(20)
        }
        statusTextField.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.leading.equalTo(stackView.snp.leading)
            make.height.equalTo(40)
            make.width.equalToSuperview().multipliedBy(0.57)
        }
        
        setStatusButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(statusTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(5)
            make.height.equalTo(50)
        }
        
    }
    private func gestureAvatar() {
        let gestureAvatar = UITapGestureRecognizer(target: self, action: #selector(tapAvatar))
        self.avatarImage.addGestureRecognizer(gestureAvatar)
    }
    @objc func tapAvatar() {
        self.delegate?.changeLayout()
    }
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.addGestureRecognizer(tapGesture)
    }
    @objc private func hideKeyboard() {
        self.endEditing(true)
        
    }
    
    
}

