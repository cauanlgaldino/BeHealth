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

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
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
            .environmentObject(router)
        }
    }
}
