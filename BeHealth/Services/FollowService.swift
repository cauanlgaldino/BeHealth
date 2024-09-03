//
//  FollowService.swift
//  Login
//
//  Created by honorio on 27/08/24.
//

import Foundation

struct FollowService {
    func getFollowers(on baseURL: URL) async throws -> [Follow]? {
        let url = baseURL.appending(path: "/follow")
        let (data, response) = try await URLSession.shared.data(from: url)
        try checkConection(data: data, response: response)
        do {
            let follows = try JSONDecoder().decode([Follow].self, from: data)
            return follows
        } catch {
            throw ServiceError.decodingError
        }
    }
    func checkConection(data: Data?, response: URLResponse) throws {
        if let response = response as? HTTPURLResponse {
            switch response.statusCode {
            case 200..<300:
                print("😸 Sucesso! \(response.statusCode)")
            default:
                print("🙀 Erro \(response.statusCode)")
                throw ServiceError.invalidResponseCase(code: response.statusCode, body: data)
            }
        }
    }
    func createFollow(on baseURL: URL, token: String, followerId: UUID, followingId: UUID) async throws {
        let url = baseURL.appendingPathComponent("/follow")
        let create = Follow.Create(followerId: followerId, followingId: followingId)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        request.httpBody = try JSONEncoder().encode(create)
        let (data, response) = try await URLSession.shared.data(for: request)
        try checkConection(data: data, response: response)
    }
}
