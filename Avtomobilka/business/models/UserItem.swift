//
//  UserItem.swift
//  Avtomobilka
//
//  Created by Vladimir Vaskin on 31.07.2023.
//

import Foundation

struct UserItem: Codable {
    
    struct Avatar: Codable {
        var path: String
        var url: URL
    }
    
    private var _avatar: Avatar
    var id: Int
    var name: String
    var avatar: URL {
        _avatar.url
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "username"
        case _avatar = "avatar"
    }
}
