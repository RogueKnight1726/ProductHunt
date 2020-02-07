//
//  Posts.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//

import Foundation



struct PostCollection: Codable{
    var posts: [Post]?
}

struct Post: Codable{
    
    var comments_count: Int?
    var id: Int?
    var name: String?
    var tagline: String?
    var votes_count: Int?
    var day: String?
    var thumbnail: Thumbnail?
}

struct Thumbnail: Codable{
    var id: Int?
    var media_type: String?
    var image_url: String?
}
