//
//  Color.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 27.03.2023.
//

import UIKit


extension UIColor {
    
    static func createColor(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? light : dark
        }
    }
}

