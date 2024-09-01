//
//  Start.swift
//  BeHealth
//
//  Created by Joao Roberto Fernandes Magalhaes on 27/08/24.
//

import SwiftUI

struct Start: View {
    @EnvironmentObject var router: Router
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            Image("initialscreen")
                .resizable()
                .scaledToFill()
            VStack {
                Button {
                    router.navigate(to: .login)
                } label: {
                    Text("Criar Usuario").bold()
                        .frame(width: 300, height: 50, alignment: .center)
                        .background(Color.tabcolor)
                        .foregroundColor(.iconcolor)
                        .cornerRadius(8)
                }
                .padding()
                Button {
                    router.navigate(to: .login)
                } label: {
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
#Preview {
    Start()
}
