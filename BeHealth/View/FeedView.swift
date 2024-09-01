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
        .padding(16)
    }
}

#Preview {
    NavigationStack {
        FeedView()
            .navigationTitle("Feed")
    }
}
