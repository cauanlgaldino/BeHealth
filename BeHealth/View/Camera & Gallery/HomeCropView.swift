//
//  CropView.swift
//  BeHealth
//
//  Created by Cauan Lopes Galdino on 01/09/24.
//

import SwiftUI

struct HomeCropView: View {
    @State private var showPicker: Bool = false
    @State private var croppedImage: UIImage?
    var body: some View {
        NavigationStack {
            VStack {
                if let croppedImage {
                    Image(uiImage: croppedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 400)
                } else {
                    Text("Nenhuma imagem selecionada")
                        .font(.caption)
                        .foregroundColor(.black)
                }
            }
            .navigationTitle("Seleção para corte")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showPicker.toggle()
                    } label: {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.callout)
                    }
                    .tint(.black)
                }
            }
            .cropImagePicker(mode: .square, show: $showPicker, croppedImage: $croppedImage)
        }
    }
}
