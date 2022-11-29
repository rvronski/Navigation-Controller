//
//  FeedModel.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 09.11.2022.
//

import Foundation

protocol FeedViewModelProtocol: ViewModelProtocol {
    func check(word: String) -> Bool
}

class FeedViewModel: FeedViewModelProtocol {
    
    var secretWord = "пароль"
    
    func check(word: String) -> Bool {
        word == secretWord ? true : false 
    }
}
