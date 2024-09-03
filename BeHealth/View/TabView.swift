//
//  TabView.swift
//  BeHealth
//
//  Created by Cauan Lopes Galdino on 01/09/24.
//

import Foundation
import SwiftUI

//struct TavView: View {
//    @State var isPresenting = false
//    @State var selectedItem: Int = 1
//    @State var oldSelectedItem: Int = 1
//    @EnvironmentObject var router: Router
//    @StateObject private var viewModel = UserViewModel()
//    @State private var showPicker: Bool = false
//
//    var body: some View {
//        TabView(selection: $selectedItem) {
//            FeedView()
//                .tabItem {
//                    Label("Feed", systemImage: "house.fill")
//                }.tag(1)
//            HomeCropView(selectedItem: $selectedItem, oldSelectedItem: $oldSelectedItem)
//                .tabItem {
//                    Label("Camera", systemImage: "camera.fill")
//                }.tag(2)
//            PerfilPage()
//                .tabItem {
//                    Label("Foto de Perfil", systemImage: "person.circle")
//                }
//                .tag(3)
//        }
//        .tint(.verdeoliva)
//        .onChange(of: selectedItem) {    // SwiftUI 2.0 track changes
//            if 2 == selectedItem {
//                self.isPresenting = true
//            } else {
//                self.oldSelectedItem = $0
//            }
//        }
//    }
//}

struct TavView: View {
    @State var selectedItem: Int = 1
    @State var oldSelectedItem: Int = 1
    @State private var showPicker: Bool = false
    @EnvironmentObject var router: Router
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        TabView(selection: $selectedItem) {
            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "house.fill")
                }.tag(1)
            HomeCropView(selectedItem: $selectedItem, oldSelectedItem: $oldSelectedItem)
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
        .onChange(of: selectedItem) { newValue in
            if newValue == 2 {
                // Quando a aba da câmera é selecionada, podemos fazer algo se necessário
                oldSelectedItem = selectedItem
            }
        }
    }
}
