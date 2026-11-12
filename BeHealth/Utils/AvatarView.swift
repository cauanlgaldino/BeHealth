//
//  AvatarView.swift
//  BeHealth
//
//  Created by honorio on 03/09/24.
//

import SwiftUI


struct AvatarView: View {
    let url: URL?
    let size: CGFloat
    var body: some View {
        Group {
            if let url = url {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size, height: size)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.verdeoliva, lineWidth: 4)
                        )
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size, height: size)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.verdeoliva, lineWidth: 4)
                    )
            }
        }
    }
}
