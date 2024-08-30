//
//  Post.swift
//  BeHealth
//
//  Created by Joao Roberto Fernandes Magalhaes on 28/08/24.
//

import SwiftUI

struct Post: View {
        var postTitle: String
        var postContent: String

        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                Text(postTitle)
                    .font(.headline)
                    .foregroundColor(.iconcolor)
                Text(postContent)
                    .font(.body)
                    .foregroundColor(.black)
                    .lineLimit(2)
              Divider()
            }
            .padding()
            .background(Color(.tabcolor))
            .cornerRadius(8)
            .shadow(radius: 3)
        }
    }

#Preview {
    Post(
    postTitle: "Título do Post", postContent:
        "Este é o conteúdo do post. Ele será exibido com uma linha de limite de texto para evitar sobreposição.")
}
