//
//  Post.swift
//  Login
//
//  Created by honorio on 26/08/24.
//
// swiftlint:disable all

import Foundation

struct Post: Codable {
    var id: UUID
    var text: String
    var media: String?
    var tag: String?
    var user_id: UUID
    var user: User?
    var like_count: Int
    var created_at: String
    var updated_at: String
}

extension Post {
    struct Create: Encodable {
        var text: String
        var media: String?
        var user: User?
    }
}
