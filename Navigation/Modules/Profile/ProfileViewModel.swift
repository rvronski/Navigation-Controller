//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 18.11.2022.
//

import UIKit

protocol ProfileViewModelProtocol: ViewModelProtocol {
    func updateState(viewInput: ProfileViewModel.ViewInput)
}

final class ProfileViewModel: ProfileViewModelProtocol {
    
    
    enum ViewInput {
        case tapAvatar
        case statusButtonDidTap
        case photoCellDidTap
    }
    
     var coordinator: ProfileCoordinator?
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
            
        case .tapAvatar:
            func change() {
                var isAvatarIncreased = false
                let avatarView = AvatarView()
                let closeButton = avatarView.closeButton
                let avatarImage = avatarView.avatarImageView
                let widthScreen = UIScreen.main.bounds.width
                let widthAvatar = avatarImage.bounds.width
                let width = widthScreen / widthAvatar
                
                UIView.animateKeyframes(withDuration: 2, delay: 0, options: .calculationModeCubic) {
                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) { [] in
                        avatarView.isHidden = false
                        avatarView.bringSubviewToFront(avatarImage)
                        avatarView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                        avatarImage.transform = isAvatarIncreased ? .identity : CGAffineTransform(scaleX: width, y: width)
                        avatarImage.layer.borderWidth = isAvatarIncreased ? 3 : 0
                        avatarImage.center = isAvatarIncreased ? CGPoint(x: 63.166666666666664, y: 63.166666666666664) : CGPoint(x: avatarView.bounds.midX, y: avatarView.bounds.midY)
                        avatarImage.layer.cornerRadius = isAvatarIncreased ? avatarImage.frame.height/2 : 0
                        closeButton.isHidden = isAvatarIncreased ? true : false
                    }
                    
                } completion: { _ in
                    isAvatarIncreased.toggle()
                    if isAvatarIncreased == false {
                        avatarView.isHidden = true
                    }
                }
            }
        case .statusButtonDidTap:
            let view = ProfileView()
            view.disctiptionLabel.text = view.statusText
            view.statusTextField.resignFirstResponder()
            view.statusTextField.placeholder = ""
            view.statusTextField.text = ""
        case .photoCellDidTap:
            coordinator?.photoCellDidTap()
        }
    }
}
