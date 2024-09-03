//
//  FeedView.swift
//  BeHealth
//
//  Created by honorio on 30/08/24.
//

import SwiftUI

struct FeedView: View {
    @State private var isLoggedOut: Bool = false
    @StateObject private var viewModel = PostViewModel()
    @StateObject private var userVM = UserViewModel()
    @AppStorage("username") var username: String?
    let service = PostService()
    var body: some View {
        List {
            ForEach(viewModel.posts, id: \.id) { post in
                if let mediaString = post.media,
                   let image = service.convertBase64StringToImage(imageBase64String: mediaString) {
                    if let user = userVM.getUser(by: post.user_id) {
                        PostView(name: user.name,
                                 username: user.username,
                                 image: image,
                                 url: user.avatar != nil ? viewModel.baseURL.appendingPathComponent(user.avatar!) : nil)
                    } else {
                        Text("Usuário não encontrado")
                    }
                }
            }
        }
        .refreshable {
            Task {
                await viewModel.fetchPosts()
            }
        }
        .onAppear {
            Task {
                await userVM.fetchUsers()
                await viewModel.fetchPosts()
                await viewModel.createImagePost(account: username!)
            }
        }
        .toolbar {
            Button {
                Task {
                    await userVM.logoutUser()
                }
            } label: {
                Text("Logout")
            }
            NavigationLink(destination: SearchView()) {
                Image(systemName: "magnifyingglass")
            }
        }
        .navigationTitle("Feed")
        .navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    FeedView()
//}


//import SwiftUI
//
//struct FeedView: View {
//    @State private var isLoggedOut: Bool = false
//    @StateObject private var viewModel = UserViewModel()
//    @EnvironmentObject var router: Router
//    var body: some View {
//        TrackableScrollView {
//            Text("Feed")
//                .font(.largeTitle)
//        } content: {
//            PostView()
//            PostView()
//            PostView()
//        }
//        .padding(.trailing, 16)
//        .padding(.leading, 16)
//    }
//}
//
//#Preview {
//    NavigationStack {
//        FeedView()
//            .navigationTitle("Feed")
//    }
//}
