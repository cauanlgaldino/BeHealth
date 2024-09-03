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
        TrackableScrollView(
            header: {
                HStack {
                    Text("Feed")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.verdeoliva)
                        .padding(.leading, 16)
                    Spacer()
                    Button {
                        Task {
                            await viewModel.logoutUser()
                        }
                        router.navigateToRoot()
                    } label: {
                        Text("Logout")
                    }
                    NavigationLink(destination: SearchView()){
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                    }
                    .padding(.trailing, 16)
                }
            },
            content: {
                VStack(spacing: 16) {
                    PostView()
                    PostView()
                    PostView()
                }
                .padding(.trailing, 16)
                .padding(.leading, 16)
            }
        )
    }
}

#Preview {
    FeedView()
}


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
