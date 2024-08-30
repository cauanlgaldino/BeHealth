//
//  Start.swift
//  BeHealth
//
//  Created by Joao Roberto Fernandes Magalhaes on 27/08/24.
//

import SwiftUI

struct Start: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                   .ignoresSafeArea()
                Image("initialscreen")
                    .resizable()
                    .scaledToFill()
                VStack {
                    NavigationLink(destination: LoginView()) {
                        VStack(alignment: .leading) {
                            Text("Criar Usuario").bold()
                                .frame(width: 300, height: 50, alignment: .center)
                                .background(Color.tabcolor)
                                .foregroundColor(.iconcolor)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    NavigationLink(destination: LoginView()) {
                        VStack(alignment: .leading) {
                            Text("Login").bold()
                                .frame(width: 300, height: 50, alignment: .center)
                                .background(Color.iconcolor)
                                .foregroundColor(.tabcolor)
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    Start()
}
