//
//  Follow.swift
//  Login
//
//  Created by honorio on 27/08/24.
//

import Foundation

struct Follow: Codable {
    var id: UUID
    var followerId: UUID
    var followingId: UUID
}

extension Follow {
    struct Create: Encodable {
        var followerId: UUID
        var followingId: UUID
    }
}
