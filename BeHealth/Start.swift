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
                Color.backgroundcolor
                    .ignoresSafeArea()
                VStack {
                    Text("BeHealth")
                        .font(.system(size: 32))
                        .fontDesign(.rounded)
                        .bold()
                        .foregroundStyle(.iconcolor)
                    NavigationLink(destination: LoginView()) {
                        VStack(alignment: .leading) {
                            Text("Criar Usuario").bold()
                                .frame(width: 200, height: 50, alignment: .center)
                                .background(Color.tabcolor)
                                .foregroundColor(.iconcolor)
                                .cornerRadius(8)
                        }
                    }
                    NavigationLink(destination: LoginView()) {
                        VStack(alignment: .leading) {
                            Text("Login").bold()
                                .frame(width: 200, height: 50, alignment: .center)
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
