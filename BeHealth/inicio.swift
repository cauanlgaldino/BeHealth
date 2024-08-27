//
//  inicio.swift
//  BeHealth
//
//  Created by Joao Roberto Fernandes Magalhaes on 26/08/24.
//

import SwiftUI

struct inicio: View {
    var body: some View {
        VStack {
            Spacer()
            Text("BeHealth")
                .font(.system(size: 32))
                .fontDesign(.rounded)
                .fontWeight(.semibold)
                .foregroundStyle(.iconcolor)
            List{
                Section{
                    NavigationLink(destination: Login()){
                        VStack{
                            Text("Criar Usuario").bold()
                                .font(.system(size: 16))
                                .foregroundColor(.iconcolor)
                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        }
                    }
                    NavigationLink(destination: Login()){
                        VStack{
                            Text("Login").bold()
                                .font(.system(size: 16))
                                .foregroundColor(.iconcolor)
                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        }
                    }
                    
                } .listRowSeparator(.hidden)
                    .padding()
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 11)
                            .fill(.tabcolor)
                            .padding()
                    )
            }.listStyle(.plain)
                .background {
                    Color(.backgroundcolor).ignoresSafeArea()
                }
        
        }
        .padding()
        .background(.backgroundcolor)
    }
}

#Preview {
    inicio()
}
