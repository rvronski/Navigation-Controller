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
        case feed
        case music
        case info
        
    }
    let moduleType: ModuleType
    let viewModel: ViewModelProtocol
    let view: UIViewController
    
}

extension Module.ModuleType {
    var tabBarItem: UITabBarItem {
        switch self {
        case .login:
            return UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 0)
        case .feed:
            return UITabBarItem(title: "Лента", image: UIImage(systemName: "chart.bar.doc.horizontal"), tag: 2)
            case .music:
            return UITabBarItem(title: "Мультимедиа", image: UIImage(systemName: "tv.music.note"), tag: 1)
        case .info:
            return UITabBarItem(title: "Инфо", image: UIImage(systemName: "info"), tag: 3)
        }
    }
}
