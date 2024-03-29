//
//  Post.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 08.08.2022.
//

import UIKit

public struct Post {
   public var author: String
    public var description: String
    public var image: UIImage
    public var likes: Int
    public var views: Int
}

public var post1 = Post(author: "boris", description: "postComment".localized, image: UIImage(named: "878i7")!, likes: 0,  views: 41)
public var post2 = Post(author: "Anna", description: "😂", image: UIImage(named:"img2134")!, likes: 0, views: 250)
public var post3 = Post(author: "gamer", description: "footballPostComment".localized, image: UIImage(named:"football")!, likes: 0,  views: 290)
 var posts:[Post] = [post1, post2, post3]
