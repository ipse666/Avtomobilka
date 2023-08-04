//
//  PostItem.swift
//  Avtomobilka
//
//  Created by Vladimir Vaskin on 26.07.2023.
//

import Foundation

struct PostItem: Codable {
    var id: Int
    var text: String
    var likeCount: Int
    var createdAt: String
    var commentCount: Int
    var img: URL
    var author: UserItem
    
    enum CodingKeys: String, CodingKey {
        case id, text, img, author
        case likeCount = "like_count"
        case createdAt = "created_at"
        case commentCount = "comment_count"
    }
}

struct PostItems: Codable {
    var posts: [PostItem]
}
