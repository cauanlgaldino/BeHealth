//
//  ContentView.swift
//  BeHealth
//
//  Created by Cauan Lopes Galdino on 23/08/24.
//

import SwiftUI

struct ContentView: View {
    @State var showSplash: Bool = false
    var body: some View {
        NavigationView {
            TabView {
                FeedView()
                    .tabItem {
                        Label("Inicio", systemImage: "house.fill")
                    }
            }
            .tint(.verdeoliva)
        }
    }
}
#Preview {
    ContentView()
}
