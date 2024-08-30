//
//  PostView.swift
//  BeHealth
//
//  Created by honorio on 30/08/24.
//

import SwiftUI

struct PostView: View {
    @State private var liked = false
    @State private var comment = false
    var body: some View {
        ZStack {
            Color.verdemeleca
            VStack(spacing: 0) {
                HStack {
                    Circle()
                        .frame(width: 40, height: 40)
                    VStack(alignment: .leading) {
                        Text("Name")
                        Text("@username")
                    }
                    Spacer()
                    Button {
                    } label: {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                    }
                }
                .padding(.leading,8)
                .padding(.top, 8)
                .padding(.trailing, 16)
                .padding(.bottom, 8)
                Rectangle()
                    .fill(.secondary)
                VStack {
                    HStack {
                        Button {
                            liked.toggle()
                        } label: {
                            Image(systemName: liked ? "heart.fill" : "heart")
                        }
                        Text("23")
                            .padding(.trailing, 20)
                        Button {
                            comment = true
                        } label: {
                            Image(systemName: "message")
                        }

                        Text("24")
                    }
                    .padding(8)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity)
        .cornerRadius(10)
        .sheet(isPresented: $comment) {
            CommentView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
}


struct CommentView: View {
    var body: some View {
        NavigationStack {
            Text("Hello")
                .navigationTitle("Comentários")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PostView()
}
