//
//  String.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 08.03.2023.
//

import Foundation

extension String {
    var localized: String {
       return NSLocalizedString(self, comment: "comment")
    }
}
