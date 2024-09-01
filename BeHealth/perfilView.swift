//
//  perfilView.swift
//  BeHealth
//
//  Created by Joao Roberto Fernandes Magalhaes on 28/08/24.
//

import SwiftUI

struct PerfilView: View {
    var body: some View {
        ZStack {
            Color.backgroundcolor
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
                        .padding(.top, 50)
                    Text("Gabriel Silveira")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .padding(.top, 10)
                        .foregroundColor(.iconcolor)
                    Text("""
                 Contador
                 Em busca de perder uns quilinhos
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
                            Text("12")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .foregroundStyle(.iconcolor)
                            Text("Seguidores")
                                .font(.system(size: 14, design: .rounded))
                                .foregroundColor(.black)
                                .bold()
                                .fontDesign(.rounded)
                        }
                        VStack {
                            Text("5")
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
                    HStack(spacing: 20.0) {
                            ForEach(0..<3) { index in
                            postMV(postTitle: "Post \(index + 1)",
                                   postContent: "Este é o conteúdo do post número \(index + 1).")
                            }
                        }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    .background(Color.backgroundcolor)
                   // .cornerRadius(0)
                    .shadow(radius: 0)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    perfilView()
}
