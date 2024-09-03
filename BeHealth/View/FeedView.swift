//
//  FeedView.swift
//  BeHealth
//
//  Created by honorio on 30/08/24.
//

import SwiftUI

struct FeedView: View {
    @State private var isLoggedOut: Bool = false
    @StateObject private var viewModel = UserViewModel()
    @EnvironmentObject var router: Router
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                PostView()
                PostView()
                PostView()
            }
        }
        .toolbar {
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
        .padding(16)
        .navigationTitle("Feed")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        FeedView()
            .navigationTitle("Feed")
    }
}
