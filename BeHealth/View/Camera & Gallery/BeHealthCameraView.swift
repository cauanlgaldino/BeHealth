//
//  BeHealthCameraView.swift
//  BeHealth
//
//  Created by Cauan Lopes Galdino on 01/09/24.
//

import SwiftUI

struct BeHealthCameraView: View {
    @State private var capturedImage: UIImage?
    @State private var isCustomCameraViewPresented = false
    var body: some View {
        ZStack {
            if capturedImage != nil {
                Image(uiImage: capturedImage!)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                Color(UIColor.systemBackground)
            }
            VStack {
                Spacer()
                Button(action: {
                    isCustomCameraViewPresented.toggle()
                }, label: {
                    Image(systemName: "camera.fill")
                        .font(.largeTitle)
                        .padding()
                        .background()
                        .foregroundColor(.white)
                        .clipShape(Circle())
                })
                .padding(.bottom)
                .sheet(isPresented: $isCustomCameraViewPresented, content: {
                    LiveCameraView(capturedImage: $capturedImage)
                        .ignoresSafeArea()
                        .presentationDetents([.large])
                })
                
            }
        }
    }
}

#Preview {
    BeHealthCameraView()
}
