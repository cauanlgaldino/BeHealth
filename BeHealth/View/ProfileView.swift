//
//  PerfilPage.swift
//  BeHealth
//
//  Created by Joao Roberto Fernandes Magalhaes on 28/08/24.
//

import SwiftUI

struct PerfilPage: View {
    private let userService = UserService()
    private let keychain = KeychainManager()
    private let service = "com.login.app"
    private let account = "currentUser"
    @AppStorage("username") var username = ""
    //    @StateObject var photoVm = PhotoSelectorViewModel()
    @StateObject var userVm = UserViewModel()
    @State private var showPicker: Bool = false
    @State private var croppedImage: UIImage?
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    if let avatar = userVm.user?.avatar {
                        let avatarURL = userVm.baseURL.appending(path: avatar)
                        AsyncImage(url: avatarURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.verdeoliva, lineWidth: 4)
                                )
                                .shadow(radius: 10)
                                .padding(.top, 50)
                                .onTapGesture(){
                                    showPicker.toggle()
                                }
                                .cropImagePicker(mode: .circle, show: $showPicker, croppedImage: $croppedImage)
                        } placeholder: {
                            ProgressView()
                        }
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.verdeoliva, lineWidth: 4)
                            )
                            .shadow(radius: 10)
                            .padding(.top, 50)
                            .onTapGesture(){
                                showPicker.toggle()
                            }
                            .cropImagePicker(mode: .circle, show: $showPicker, croppedImage: $croppedImage)
                    }
                    Text("\(userVm.user?.name ?? "")")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .padding(.top, 10)
                        .foregroundColor(.verdeoliva)
                    Text("\(userVm.user?.bio ?? "")")
                    .fontDesign(.rounded)
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(.verdeoliva)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
//                    HStack {
//                        ForEach(0..<3) { index in
//                            Post(postTitle: "Post \(index + 1)",
//                                 postContent: "Este é o conteúdo do post número \(index + 1).")
//                        }
//                    }
//                    .padding(.horizontal)
//                    .padding(.top, 20)
//                    .background(Color.backgroundcolor)
//                    .shadow(radius: 0)
//                    Spacer()
                }
            }
        }
        .onChange(of: croppedImage) {
            Task {
                await userVm.sendAvatar(avatarImage: croppedImage!)
                if let retrievedData = keychain.readData(forService: service, account: username), let token = String(data: retrievedData, encoding: .utf8) {
                    userVm.user = try await userService.me(on: userVm.baseURL, with: token)
                }
            }
        }
        .onAppear{
            Task{
                if let retrievedData = keychain.readData(forService: service, account: username), let token = String(data: retrievedData, encoding: .utf8) {
                    userVm.user = try await userService.me(on: userVm.baseURL, with: token)
                }
            }
        }
//        .refreshable {
//            Task{
//                if let retrievedData = keychain.readData(forService: service, account: username), let token = String(data: retrievedData, encoding: .utf8) {
//                    userVm.user = try await userService.me(on: userVm.baseURL, with: token)
//                }
//            }
//        }
    }
}
#Preview {
    PerfilPage()
}
// MARK: Seguidores
// HStack(spacing: 30) {
//    VStack {
//        Text("3")
//            .font(.system(size: 22, weight: .bold, design: .rounded))
//            .foregroundStyle(.iconcolor)
//        Text("Posts")
//            .font(.system(size: 14, design: .rounded))
//            .foregroundColor(.black)
//            .bold()
//            .fontDesign(.rounded)
//    }
//    VStack {
//        Text("12")
//            .font(.system(size: 22, weight: .bold, design: .rounded))
//            .foregroundStyle(.iconcolor)
//        Text("Seguidores")
//            .font(.system(size: 14, design: .rounded))
//            .foregroundColor(.black)
//            .bold()
//            .fontDesign(.rounded)
//    }
//    VStack {
//        Text("5")
//            .font(.system(size: 22, weight: .bold, design: .rounded))
//            .foregroundStyle(.iconcolor)
//        Text("Seguindo")
//            .font(.system(size: 14, design: .rounded))
//            .foregroundColor(.black)
//            .bold()
//            .fontDesign(.rounded)
//    }
// }
// .padding(.top, 20)
