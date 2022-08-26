//
//  AvatarView.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 23.08.2022.
//

import UIKit
protocol AvatarViewDelegate: AnyObject {
    func changeLayout()
}
class AvatarView: UIView {
    let header = ProfileHeaderView()
    let profileVC = ProfileViewController()
   
    lazy var closeButton: UIButton = {
       let closeButton = UIButton()
        closeButton.isHidden = true
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(UIImage(systemName: "multiply.circle"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
       return closeButton
    }()
    @objc func closeView() {
//        let avatarImage = header.avatarImage
//        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .calculationModeCubic) {
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) { [self] in
//                self.isHidden = true
        self.delegate?.changeLayout()
//                avatarImage.transform =  CGAffineTransform(scaleX: 2.0, y: 2.0)
//                avatarImage.center = ProfileViewController().center
//                avatarImage.layer.zPosition = .greatestFiniteMagnitude
//                self.avatarView.bringSubviewToFront(avatarImage)

            }


   
    weak var delegate: AvatarViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupAvatarView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAvatarView()  {
        self.addSubview(closeButton)
        self.backgroundColor = .black
        NSLayoutConstraint.activate([
            
            self.closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.closeButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,constant: -10),
            self.closeButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            self.closeButton.heightAnchor.constraint(equalTo: self.closeButton.widthAnchor)
            
        ])
    }
}
