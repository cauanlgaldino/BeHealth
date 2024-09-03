//
//  CropView.swift
//  BeHealth
//
//  Created by Cauan Lopes Galdino on 01/09/24.
//

import SwiftUI

struct HomeCropView: View {
    @Binding var selectedItem: Int
    @Binding var oldSelectedItem: Int
    @State var showPicker: Bool = false
    @State private var isPresentingCamera = true
    @State private var capturedImage: UIImage?
    @State private var imageCropped: UIImage?
    @State private var showCropView: Bool = false
    @State private var selectedCropType: Crop = .rectangle
    
    var body: some View {
        NavigationStack {
            VStack {
                if let imageCropped {
                    Image(uiImage: imageCropped)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 400)
                } else {
                    Color(.black)
                        .ignoresSafeArea()
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
            .fullScreenCover(isPresented: $isPresentingCamera) {
                LiveCameraView(capturedImage: $capturedImage)
                    .ignoresSafeArea()
            } 
            .fullScreenCover(isPresented: $showCropView) {
                if let capturedImage {
                    CropView(crop: selectedCropType, image: capturedImage) { croppedImage, status in
                        if let croppedImage {
                            imageCropped = croppedImage
                            showCropView = false // Fecha a CropView
                        }
                    }
                }
            }
            .onChange(of: capturedImage) { newValue in
                if newValue != nil {
                    // Quando uma imagem é capturada, mostramos a CropView
                    showCropView = true
                    isPresentingCamera = false // Fecha a câmera
                }
            }
        }
        .onAppear {
            // Inicia a apresentação da câmera quando a HomeCropView aparece
            isPresentingCamera = true
        }
    }
}
