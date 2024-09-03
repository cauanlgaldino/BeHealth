//
//  Post.swift
//  Login
//
//  Created by honorio on 26/08/24.
//

import Foundation

struct Post: Codable {
    var id: UUID
    var text: String
    var media: String?
    var tag: String?
    var userId: UUID
    var user: User?
    var likeCount: Int
    var createdAt: String
    var updatedAt: String
}

extension Post {
    struct Create: Encodable {
        var text: String
        var media: String?
    }
}
