//
//  BeHealthApp.swift
//  BeHealth
//
//  Created by Cauan Lopes Galdino on 23/08/24.
//

import SwiftUI

@main
struct BeHealthApp: App {
    @ObservedObject var router = Router()
    @AppStorage("username") var username: String?
    @State private var isAuthenticated = false
    @State private var isAuthenticationChecked = false
    @StateObject private var viewModel = UserViewModel()
    private let service = "com.login.app"
    private let keychain = KeychainManager()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                if isAuthenticationChecked {
                    if isAuthenticated {
                        TavView()
                    } else {
                        StartView()
                            .navigationDestination(for: Router.Destination.self) { destination in
                                switch destination {
                                case .feedView:
                                    FeedView()
                                case .loginView:
                                    LoginView()
                                case .settings:
                                    ConfigPage()
                                case .contentView:
                                    ContentView()
                                case .searchView:
                                    SearchView()
                                case .createUserView:
                                    CreateUser()
                                }
                            }
                    }
                } else {
                    ProgressView("Verificando autenticação...")
                }
            }
            .environmentObject(router)
            .task {
                await checkAuthentication()
            }
        }
    }
    
    private func checkAuthentication() async {
        if let session = retrieveSession(), await viewModel.fetchMe(session: session) {
            isAuthenticated = true
        } else {
            isAuthenticated = false
        }
        isAuthenticationChecked = true
    }

    
    // Método para recuperar o session do Keychain
    private func retrieveSession() -> String? {
        guard let username = username,
              let retrievedData = keychain.readData(forService: service, account: username),
              let session = String(data: retrievedData, encoding: .utf8) else {
            print("Erro ao recuperar Keychain")
            return nil
        }
        return session
    }
}
