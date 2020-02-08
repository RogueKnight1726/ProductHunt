//
//  Comments.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//

import Foundation

struct CommentsCollection: Codable{
    
    var comments: [Comment]?
}

struct Comment: Codable{
    
    var id: Int?
    var body: String?
    var parent_comment_id: Int?
    var votes: Int?
    var user: User
    var maker: Bool?
    var child_comments: [Comment]?
}


struct User: Codable{
    var id: Int?
    var name: String?
    var image_url: ProfilePicture?
}

struct ProfilePicture: Codable{
    var url: String?
}

extension ProfilePicture {
    enum CodingKeys: String, CodingKey {
        case url = "60px"
    }
}
