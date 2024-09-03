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
            TavView()
//            NavigationStack(path: $router.navPath) {
//                Start()
//                    .navigationDestination(for: Router.Destination.self) { destination in
//                        switch destination {
//                        case .feed:
//                            FeedView()
//                        case .login:
//                            LoginView()
//                        case .settings:
//                            ConfigPage()
//                        case .contentView:
//                            ContentView()
//                        case .searchView:
//                            SearchView()
//                        }
//                    }
//            }
//            .environmentObject(router)
        }
    }
}
