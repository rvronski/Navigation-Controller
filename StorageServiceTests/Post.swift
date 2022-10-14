//
//  Post.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 08.08.2022.
//

import Foundation

public struct Post {
   public var author: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
}

public var post1 = Post(author: "boris", description: "Отдыхаю на море", image: "878i7", likes: 26, views: 41)
public var post2 = Post(author: "Anna", description: "😂", image: "img2134", likes: 200, views: 250)
public var post3 = Post(author: "gamer", description: "«Краснодар» обыграл ЦСКА (1:0) и обошел «армейцев» в таблице.Единственный гол на 75-й минуте встречи забил полузащитник краснодарцев Никита Кривцов.Благодаря победе «Краснодар» опередил «армейцев» в турнирной таблице РПЛ и поднялся на четвертое место с 49 очками в 29 матчах. ЦСКА опустился на пятую строчку (47 баллов в 29 играх).", image: "football", likes: 174, views: 290)
