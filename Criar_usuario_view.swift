//
//  Criar_usuario_view.swift
//  BeHealth
//
//  Created by Joao Roberto Fernandes Magalhaes on 29/08/24.
//

import SwiftUI

        class FormViewModel: ObservableObject {
            @Published var nome = ""
            @Published var sobrenome = ""
            @Published var senha = ""
            @Published var confirmarSenha = ""
            @Published var usuario = ""
            var isPasswordMatching: Bool {
                return senha == confirmarSenha && !senha.isEmpty
            }
        }
        struct Criar_usuario_view: View {
        @StateObject var viewModel = FormViewModel()
        @State private var showPasswordMismatchMessage = false
       var body: some View {
            NavigationView {
                ZStack {
                    Color.white
//                    Image("back")
//                        .resizable()
//                        .scaledToFill()
//                        .padding(.trailing, 70)
                        .ignoresSafeArea()
                    VStack(spacing: 20) {
                        TextField("Nome", text: $viewModel.nome)
                            .frame(width: 300, height: 40)
                            .background(Color.white)
                            .cornerRadius(8)
                            .foregroundColor(.iconcolor)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.iconcolor, lineWidth: 2)
                                    .frame(width: 300, height: 40)
                            )
                        TextField("Sobrenome", text: $viewModel.sobrenome)
                            .frame(width: 300, height: 40, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.iconcolor, lineWidth: 2)
                                    .frame(width: 300, height: 40)
                            )
                        TextField("Nome de Usuário", text: $viewModel.usuario)
                            .frame(width: 300, height: 35, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.iconcolor, lineWidth: 2)
                                    .frame(width: 300, height: 40)
                            )
                        SecureField("Criar Senha", text: $viewModel.senha)
                            .frame(width: 300, height: 40, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.iconcolor, lineWidth: 2)
                                    .frame(width: 300, height: 40)
                            )
                            .textContentType(.newPassword)
                        .onChange(of: viewModel.senha) { _ in
                                validatePasswords()
                            }
                        
                        SecureField("Confirmar Senha", text: $viewModel.confirmarSenha)
                            .frame(width: 300, height: 40, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.iconcolor, lineWidth: 2)
                                    .frame(width: 300, height: 40)
                            )
                            .textContentType(.newPassword)
                        .onChange(of: viewModel.confirmarSenha) { _ in
                                validatePasswords()
                            }
                       if showPasswordMismatchMessage {
                            Text("As senhas não coincidem")
                                .foregroundColor(.red)
                        }
                        Button(action: {
                        }, label: {
                            Text("Continuar")
                                .frame(width: 200, height: 50, alignment: .center)
                                .background(Color.tabcolor)
                                .foregroundColor(.iconcolor)
                                .cornerRadius(8)
                                .bold()
                                .fontDesign(.rounded)
                        })
                        .disabled(!viewModel.isPasswordMatching)
                    }
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .padding(20)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Text("Criar conta")
                                .font(.system(size: 32))
                                .foregroundColor(.iconcolor)
                                .bold()
                                .fontDesign(.rounded)
                                .padding(.top, 180)
                        }
                    }
                    .foregroundColor(.iconcolor)
                }
            }
            .scrollContentBackground(.hidden)
        }
        
        private func validatePasswords() {
            showPasswordMismatchMessage = !viewModel.isPasswordMatching
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            CriarUsuarioView()
                .preferredColorScheme(.light)
        }
    }

    #Preview {
        Criar_usuario_view()
    }
