//
//  Post.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 08.08.2022.
//

import Foundation

struct Post {
    var author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int
}

var post1 = Post(author: "boris", description: "Отдыхаю на море", image: "878i7", likes: 26, views: 41)
var post2 = Post(author: "Anna", description: "😂", image: "img2134", likes: 200, views: 250)
var post3 = Post(author: "gamer", description: "«Краснодар» обыграл ЦСКА (1:0) и обошел «армейцев» в таблице.Единственный гол на 75-й минуте встречи забил полузащитник краснодарцев Никита Кривцов.Благодаря победе «Краснодар» опередил «армейцев» в турнирной таблице РПЛ и поднялся на четвертое место с 49 очками в 29 матчах. ЦСКА опустился на пятую строчку (47 баллов в 29 играх).", image: "football", likes: 174, views: 290)
