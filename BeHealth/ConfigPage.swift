//
//  ConfigPage.swift
//  BeHealth
//
//  Created by Joao Roberto Fernandes Magalhaes on 28/08/24.
//
import SwiftUI

struct ConfigPage: View {
    @State private var nome: String = "Gabriel Silveira"
    @State private var username: String = "gabriels"
    @State private var senha: String = "password123"
    @State private var bio: String = """
Contador\nEm busca de perder uns quilinhos
"""
    var body: some View {
        ZStack {
            Color.backgroundcolor
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("Editar Perfil")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                Form {
                    Section(header: Text("Informações Pessoais")
                        .foregroundColor(.iconcolor)) {
                        TextField("Nome", text: $nome)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .frame(width: 300, height: 60)
                            .background(Color.backgroundcolor)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.iconcolor, lineWidth: 2)
                                    .frame(width: 300, height: 40)
                            )
                        TextField("Username", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .frame(width: 300, height: 60)
                            .background(Color.backgroundcolor)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.iconcolor, lineWidth: 2)
                                    .frame(width: 300, height: 40)
                            )
                        SecureField("Senha", text: $senha)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .frame(width: 300, height: 60)
                            .background(Color.backgroundcolor)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.iconcolor, lineWidth: 2)
                                    .frame(width: 300, height: 40)
                            )
                        TextField("Bio", text: $bio, axis: .vertical)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                            .lineLimit(3...5)
                            .frame(width: 300)       
                    }
                    .listRowBackground(Color.backgroundcolor)
                    .listRowSeparator(.hidden)
                    Section {
                        Button(action: {
                            print("Dados atualizados:")
                            print("Nome: \(nome)")
                            print("Username: \(username)")
                            print("Bio: \(bio)")
                        }
                    )
            {
                            Text("Salvar Alterações")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.iconcolor)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.tabcolor)
                                .cornerRadius(10)
                        }
                        Button(action: {
                            print("Usuário deslogado")
                        }
                    )
            {
                            Text("Logout")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                    }
                    .listRowBackground(Color.backgroundcolor)
                    .listRowSeparator(.hidden)
                }
                .scrollContentBackground(.hidden)
                .background(Color.backgroundcolor)
            }
            .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    ConfigPage()
}
