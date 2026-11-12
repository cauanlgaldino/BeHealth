//
//  CustomImagePickerView.swift
//  BeHealth
//
//  Created by Cauan Lopes Galdino on 01/09/24.
//

import SwiftUI
import PhotosUI

extension View {
    @ViewBuilder
    func cropImagePicker(mode: Crop, show: Binding<Bool>, croppedImage: Binding<UIImage?>) -> some View {
        CustomImagePickerView(mode: mode, show: show, croppedImage: croppedImage) {
            self
        }
    }
    @ViewBuilder
    func frame(_ size: CGSize) -> some View {
        self
            .frame(width: size.width, height: size.height)
    }
    func haptics(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}

private struct CustomImagePickerView<Content: View>: View {
    var content: Content
    var mode: Crop
    @Binding var show: Bool
    @Binding var croppedImage: UIImage?
    init(mode: Crop, show: Binding<Bool>, croppedImage: Binding<UIImage?>, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self._show = show
        self._croppedImage = croppedImage
        self.mode = mode
    }
    @State private var photosItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
//    @State private var showDialog: Bool = false
    @State private var selectedCropType: Crop = .circle
    @State private var showCropView: Bool = false
    var body: some View {
        content
            .photosPicker(isPresented: $show, selection: $photosItem)
            .onChange(of: photosItem) { newValue in
                if let newValue {
                    Task {
                        if let imageData = try? await newValue.loadTransferable(type: Data.self), let image = UIImage(data: imageData) {
                            await MainActor.run {
                                selectedImage = image
//                                showDialog.toggle()
                                showCropView.toggle()
                            }
                        }
                    }
                }
            }
//            .confirmationDialog("", isPresented: $showDialog) {
//                ForEach(options.indices, id: \.self) { index in
//                    Button(options[index].name()) {
//                        selectedCropType = options[index]
//                        showCropView.toggle()
//                    }
//                }
//            }
            .fullScreenCover(isPresented: $showCropView) {
                selectedImage = nil
            } content: {
                CropView(crop: selectedCropType, image: selectedImage) { croppedImage, status in
                    if let croppedImage {
                        self.croppedImage = croppedImage
                    }
                }
            }
    }
}

struct CropView: View {
    var crop: Crop
    var image: UIImage?
    var onCrop: (UIImage?, Bool) -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var scale: CGFloat = 1
    @State private var lastScale: CGFloat = 0
    @State private var offset: CGSize = .zero
    @State private var lastStoredOffset: CGSize = .zero
    @GestureState private var isInteracting: Bool = false
    var body: some View {
        NavigationStack {
            imageView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    Color.black
                        .ignoresSafeArea()
                }
                .navigationTitle("Crop View")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(Color.black, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            let renderer = ImageRenderer(content: imageView(true))
                            renderer.proposedSize = .init(crop.size())
                            if let image = renderer.uiImage {
                                onCrop(image, true)
                            } else {
                                onCrop(nil, false)
                            }
                            dismiss()
                        } label: {
                            Image(systemName: "checkmark")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                }
        }
    }
    @ViewBuilder
    private func imageView(_ hideGrids: Bool = false) -> some View {
        let cropSize = crop.size()
        GeometryReader { geometry in
            let size = geometry.size
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(content: {
                        GeometryReader { proxy in
                            let rect = proxy.frame(in: .named("CROPVIEW"))
                            Color.clear
                                .onChange(of: isInteracting) { _ in
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        if rect.minX > 0 {
                                            offset.width = (offset.width - rect.minX)
                                            haptics(.medium)
                                        }
                                        if rect.minY > 0 {
                                            offset.height = (offset.height - rect.minY)
                                            haptics(.medium)
                                        }
                                        if rect.maxX < size.width {
                                            offset.width = (rect.minX - offset.width)
                                            haptics(.medium)
                                        }
                                        if rect.maxY < size.height {
                                            offset.height = (rect.minY - offset.height)
                                            haptics(.medium)
                                        }
                                    }
                                }
                        }
                    })
                    .frame(size)
                    .onChange(of: isInteracting) { newValue in
                        if !newValue {
                            lastStoredOffset = offset
                        }
                    }
            }
        }
        .scaleEffect(scale)
        .offset(offset)
        .overlay(content: {
            if !hideGrids {
                grids()
            }
        })
        .coordinateSpace(name: "CROPVIEW")
        .gesture(
            DragGesture()
                .updating($isInteracting, body: { _, out, _ in
                    out = true
                }).onChanged({ value in
                    let translation = value.translation
                    offset = CGSize(width: translation.width + lastStoredOffset.width, height: translation.height + lastStoredOffset.height)
                })
        )
        .gesture(
            MagnificationGesture()
                .updating($isInteracting, body: { _, out, _ in
                    out = true
                }).onChanged({ value in
                    let updatedScale = value + lastScale
                    scale = (updatedScale < 1 ? 1 : updatedScale)
                }).onEnded({ _ in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        if scale < 1 {
                            scale = 1
                            lastScale = 0
                        } else {
                            lastScale = scale - 1
                        }
                    }
                })
        )
        .frame(cropSize)
        .cornerRadius(crop == .circle ? cropSize.height / 2 : 0)
    }
    
    @ViewBuilder
    private func grids() -> some View {
        ZStack {
            HStack {
                ForEach(1...5, id: \.self) { _ in
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(width: 1)
                        .frame(maxWidth: .infinity)
                }
            }
            VStack {
                ForEach(1...5, id: \.self) { _ in
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(height: 1)
                        .frame(maxHeight: .infinity)
                }
            }
        }
    }
}

// Preview
#Preview {
    CropView(crop: .square, image: UIImage(systemName: "bicycle.fill")) { _, _ in }
}
