//
//  VisualizarPerfil.swift
//  BeHealth
//
//  Created by Joao Roberto Fernandes Magalhaes on 31/08/24.
//

import SwiftUI

struct VisualizarPerfil: View {
    @State private var isFollowing = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.iconcolor, lineWidth: 4)
                            )
                            .shadow(radius: 10)
                            .padding(.top, 30)
                        Text("Gisele Albuquerque")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(.iconcolor)
                        Text("""
                             Odonto 🦷
                             Vida fitness🏃‍♀️💪
                             """)
                        .fontDesign(.rounded)
                        .font(.system(size: 16, design: .rounded))
                        .foregroundColor(.iconcolor)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.top, 10)
                        HStack(spacing: 30) {
                            VStack {
                                Text("3")
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .foregroundStyle(.iconcolor)
                                Text("Posts")
                                    .font(.system(size: 14, design: .rounded))
                                    .foregroundColor(.black)
                                    .bold()
                                    .fontDesign(.rounded)
                            }
                            VStack {
                                Text("1270")
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .foregroundStyle(.iconcolor)
                                Text("Seguidores")
                                    .font(.system(size: 14, design: .rounded))
                                    .foregroundColor(.black)
                                    .bold()
                                    .fontDesign(.rounded)
                            }
                            VStack {
                                Text("12")
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .foregroundStyle(.iconcolor)
                                Text("Seguindo")
                                    .font(.system(size: 14, design: .rounded))
                                    .foregroundColor(.black)
                                    .bold()
                                    .fontDesign(.rounded)
                            }
                        }
                        .padding(.top, 20)
                        Button(action: {
                            isFollowing.toggle()
                        }) 
                        {
                            Text(isFollowing ? "Seguindo" : "Seguir")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .foregroundColor(isFollowing ? .tabcolor : .iconcolor)
                                .padding()
                                .frame(width: 120)
                                .background(isFollowing ? Color.iconcolor : Color.tabcolor)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(isFollowing ? Color.iconcolor : Color.iconcolor)
                                )
                        }
                        .padding(.top, 20)
                        HStack {
                            ForEach(0..<3) { index in
                                Post(postTitle: "Post \(index + 1)",
                                     postContent: "Este é o conteúdo do post número \(index + 1).")
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                        .background(Color.white)
                        .shadow(radius: 0)
                        Spacer()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    VisualizarPerfil()
}
