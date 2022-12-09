//
//  FeedModel.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 09.11.2022.
//

import Foundation

protocol FeedViewModelProtocol: ViewModelProtocol {
    func check(word: String, completiton: (Result <Bool, Error>) -> Void)
}

class FeedViewModel: FeedViewModelProtocol {
    
    var secretWord = "Пароль"
    
    func check(word: String, completiton: (Result <Bool, Error>) -> Void)  {
        if word == secretWord {
            completiton(.success(true))
        } else {
            completiton(.failure(FeedViewController.FeedErrors.wordIsWrong))
        }
    }
}
