//
//  PostService.swift
//  Login
//
//  Created by honorio on 26/08/24.
//

import Foundation
import UIKit

struct PostService {
    func getposts(on baseURL: URL) async throws -> [Post]? {
        let url = baseURL.appending(path: "/posts")
        let (data, response) = try await URLSession.shared.data(from: url)
        try checkConection(data: data, response: response)
        do {
            let posts = try JSONDecoder().decode([Post].self, from: data)
            return posts
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
    
    func createPost(on baseURL: URL, token: String, text: String) async throws {
        let url = baseURL.appendingPathComponent("posts")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        // Enviando o texto diretamente como corpo da requisição
        request.httpBody = text.data(using: .utf8)
        let (data, response) = try await URLSession.shared.data(for: request)
        try checkConection(data: data, response: response)
    }
    func createImagePost(on baseURL: URL, with token: String, user: User?) async throws  {
        let url = baseURL.appending(path: "posts")
        let create = Post.Create(text: "psyduck",
                                 media: convertImageToBase64String(img: UIImage(imageLiteralResourceName: "psyduck")),
                                 user: user)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(create)

        let (data, response) = try await URLSession.shared.data(for: request)

        try checkConection(data: data, response: response)

    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    func convertBase64StringToImage (imageBase64String:String) -> UIImage? {
        let imageData = Data(base64Encoded: imageBase64String)
        let image = UIImage(data: imageData!)
        return image!
    }
}
