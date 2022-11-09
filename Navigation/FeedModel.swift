//
//  FeedModel.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 09.11.2022.
//

import Foundation

class FeedModel {
    
    var secretWord = "пароль"
    
    func check(word: String) -> Bool {
        word == secretWord ? true : false 
    }
}
