//
//  ContentView.swift
//  BeHealth
//
//  Created by Cauan Lopes Galdino on 23/08/24.
//

import SwiftUI

enum Tabs: String {
    case feed
}

struct ContentView: View {
    @State var showSplash: Bool = false
    @State var selectedTab: Tabs = .feed
    @EnvironmentObject var router: Router
    @StateObject private var viewModel = UserViewModel()
    var body: some View {
        TabView(selection: $selectedTab) {
                FeedView()
                .tabItem {
                    Label("Inicio", systemImage: "house.fill")
                }
        }
        .toolbar {
            switch selectedTab {
            case .feed:
                Button {
                    Task {
                        await viewModel.logoutUser()
                    }
                    router.navigateToRoot()
                } label: {
                    Text("Logout")
                }
                Button {
                    Task {
                        await viewModel.logoutUser()
                    }
                    router.navigate(to: .searchView)
                } label: {
                    Image(systemName: "magnifyingglass")
                }
            }
        }
        .tint(.verdeoliva)
        .navigationTitle(selectedTab.rawValue.capitalized)
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
    }
}
#Preview {
    ContentView()
}
