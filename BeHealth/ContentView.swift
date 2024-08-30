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
        ZStack {
            if self.showSplash {
                TabView {

                        FeedView()
                        .tabItem {
                            Label("Inicio", systemImage: "house.fill")
                        }

                }
                .tint(.iconcolor)
            }         }
        .onAppear {
            UITabBar.appearance().backgroundColor = .tabcolor
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation { self.showSplash = true }
            }
        }
    }
}
#Preview {
    ContentView()
}
