//
//  TabView.swift
//  BeHealth
//
//  Created by Cauan Lopes Galdino on 01/09/24.
//

import Foundation
import SwiftUI


struct TavView: View {
    @State var isPresenting = false
    @State var selectedItem: Int = 1
    @State var capturedImage: UIImage?
    @State var oldSelectedItem: Int = 1
    @EnvironmentObject var router: Router
    @StateObject private var viewModel = UserViewModel()
    var body: some View {
        TabView(selection: $selectedItem) {
            NavigationStack {
                FeedView()
            }
                .tabItem {
                    Label("Feed", systemImage: "house.fill")
                }.tag(1)
            Color(.black)
                .ignoresSafeArea()
                .tabItem {
                    Label("Camera", systemImage: "camera.fill")
                }.tag(2)
            PerfilPage()
                .tabItem {
                    Label("Foto de Perfil", systemImage: "person.circle")
                }
                .tag(3)
        }
        .tint(.verdeoliva)
        .onChange(of: selectedItem) {    // SwiftUI 2.0 track changes
                if 2 == selectedItem {
                self.isPresenting = true
                } else {
                    self.oldSelectedItem = $0
                }
            }
        .sheet(isPresented: $isPresenting, onDismiss: {
                self.selectedItem = self.oldSelectedItem
            }) {
                LiveCameraView(capturedImage: $capturedImage)
        }
    }
}
