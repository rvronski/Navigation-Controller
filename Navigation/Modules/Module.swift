//
//  Module.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 12.11.2022.
//

import UIKit


protocol ViewModelProtocol: AnyObject {}

struct Module {
    enum ModuleType {
        case login
        case profile
        case feed
        case music
        case info
        case like
        
    }
    
    let moduleType: ModuleType
    let viewModel: ViewModelProtocol
    let view: UIViewController
    
}

extension Module.ModuleType {
    var tabBarItem: UITabBarItem {
        switch self {
        case .login:
            fallthrough
        case .profile:
            return UITabBarItem(title: "profileTabBar".localized, image: UIImage(systemName: "person"), tag: 0)
        case .feed:
            return UITabBarItem(title: "newslineTabBar".localized, image: UIImage(systemName: "chart.bar.doc.horizontal"), tag: 2)
            case .music:
            return UITabBarItem(title: "multimediaTabBar".localized, image: UIImage(systemName: "tv.music.note"), tag: 1)
        case .info:
            return UITabBarItem(title: "infoTabBar".localized, image: UIImage(systemName: "info"), tag: 3)
        case .like:
            return UITabBarItem(title: "likeTabBar".localized, image: UIImage(systemName: "heart.fill"), tag: 4)
       
        }
    }
}
