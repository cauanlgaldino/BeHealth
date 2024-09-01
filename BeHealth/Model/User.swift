//
//  User.swift
//  Login
//
//  Created by honorio on 22/08/24.
//

import Foundation

struct User: Codable {
    var id: UUID
    var username: String
    var name: String
    var avatar: String?
    var bio: String?
}

extension User {
    struct Create: Encodable {
        var username: String
        var name: String
        var password: String
    }
}

struct Session: Decodable {
    let token: String
    let user: User
}
