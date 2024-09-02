//
//  UserController.swift
//  Login
//
//  Created by honorio on 22/08/24.
//

import Foundation
import SwiftUI

@MainActor
class UserViewModel: ObservableObject {
    @AppStorage("username") var username: String?
    @Published var users: [User] = []
    @Published var follows: [Follow] = []
    let baseURL = URL(string: "http://maionese.local:8080")!

    private let userService = UserService()
    private let followService = FollowService()
    private let keychain = KeychainManager()
    private let service = "com.login.app"
    func fetchUsers() async {
        do {
            let fetchedUsers = try await userService.getUsers(on: baseURL)
            users = fetchedUsers ?? []
        } catch {
            print("Falha ao carregar Usuários")
        }
    }
    func fetchFollows() async {
        do {
            let fetchedFollows = try await followService.getFollowers(on: baseURL)
            follows = fetchedFollows ?? []
        } catch {
            print("Erro ao buscar seguidores")
        }
    }
    func fetchMe(session: String) async -> Bool {
        do {
            let fetchedMe = try await userService.me(on: baseURL, with: session)
            username = fetchedMe.username
            return true
        } catch {
            print("Erro ao recuperar usuário autenticado")
            return false
        }
    }
    func createFollow(follower: User) async {
        do {
            // swiftlint:enable:this non_optional_string_data_conversion
            guard let retrievedData = keychain.readData(forService: service, account: username!),
                  let session = String(data: retrievedData, encoding: .utf8) else {
                print("Erro ao recuperar Keychain")
                return
            }
            let fetchedMe = try await userService.me(on: baseURL, with: session)
            _ = try await followService.createFollow(
                    on: baseURL,
                    token: session,
                    followerId: fetchedMe.id,
                    followingId: follower.id
            )
        } catch {
            print("Erro ao adicionar seguidor")
        }
    }
    func createUsers(username: String, name: String, password: String) async -> Result<Bool, CreateLoginError> {
        let userExists = await checkUserExistence(username: username)
        guard !userExists else {
            return .failure(.userExists)
        }
        do {
            let session = try await userService.createUser(on: baseURL, username: username, name: name, password: password)
            let data = session.data(using: .utf8)!
            if keychain.storeData(data: data, forService: service, account: username) {
                Task {
                    await fetchMe(session: session)
                }
                return .success(true)
            } else {
                return .failure(.keychainError)
            }
        } catch {
            return .failure(.networkError(error))
        }
    }
    func checkUserExistence(username: String) async -> Bool {
        do {
            let fetchedUsers = try await userService.getUsers(on: baseURL)
            return fetchedUsers!.contains { $0.username == username }
        } catch {
            print("Falha ao verificar usuários")
            return false
        }
    }
    func loginUser(username: String, password: String) async -> Result<Bool, LoginError> {
        let userExists = await checkUserExistence(username: username)
        guard userExists else {
            return .failure(.userNotFound)
        }
        do {
            let session = try await userService.login(on: baseURL, username: username, password: password)
            let data = session.data(using: .utf8)!
            _ = keychain.deleteData(forService: service, account: username)
            if keychain.storeData(data: data, forService: service, account: username) {
                Task {
                    await fetchMe(session: session)
                }
                return .success(true)
            } else {
                return .failure(.keychainError)
            }
        } catch {
            return .failure(.invalidCredentials)
        }
    }
    func logoutUser() async -> Bool {
        do {
            // swiftlint:enable:this non_optional_string_data_conversion
            guard let retrievedData = keychain.readData(forService: service, account: username!),
                  let session = String(data: retrievedData, encoding: .utf8) else {
                print("Erro ao recuperar Keychain")
                return false
            }
            try await userService.logout(on: baseURL, with: session)
//            _ = keychain.deleteData(forService: service, account: username!)
        } catch {
            print("Erro ao fazer logout")
            return false
        }
        return true
    }
    func updateBio(token: String, bio: String) async {
        do {
            _ = try await userService.updateBio(on: baseURL, token: token, bio: bio)
        } catch {
            print("Erro ao atualizar BIO")
        }
    }
}
