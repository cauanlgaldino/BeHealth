//
//  PostViewModel.swift
//  Login
//
//  Created by honorio on 26/08/24.
//
// swiftlint:disable all


import Foundation
import PhotosUI
import _PhotosUI_SwiftUI
import SwiftUI

@MainActor
class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var images = [UIImage]()
    @Published var selectedPhotos = [PhotosPickerItem]()
    var viewModel = UserViewModel()
    let baseURL = URL(string: "http://maionese.local:8080")!
    private let postService = PostService()
    private let userService = UserService()
    private let keychain = KeychainManager()
    private let service = "com.login.app"
    func fetchPosts() async {
        do {
            let fetchedPosts = try await postService.getposts(on: baseURL)
            posts = fetchedPosts ?? []
        } catch ServiceError.invalidResponseCase(let code, let body) {
            print("Error code: \(code)")
            if let body, let stringified = String(data: body, encoding: .utf8) {
                print("Error body: \(stringified)")
            }
        } catch {
            print(error)
        }
    }
    
    func cretePost(text: String, username: String) async {
        do {
            guard let retrievedData = keychain.readData(forService: service, account: username), let session = String(data: retrievedData, encoding: .utf8) else {
                return print("Erro ao recuperar token")
            }
            let _ = try await postService.createPost(on: baseURL, token: session, text: text)
        } catch {
            print("Erro ao criar post")
        }
    }
    
    func createImagePost(account: String) async {
        do {
            guard let retrievedData = keychain.readData(forService: service, account: account), let session = String(data: retrievedData, encoding: .utf8) else {
                return print("Erro ao recuperar token")
            }
            try await postService.createImagePost(on: baseURL, with: session, user: viewModel.user)
        } catch {
            print("Erro")
        }
    }
    
    
}
