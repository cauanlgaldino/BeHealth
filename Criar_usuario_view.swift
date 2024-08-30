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
    
    var criaruservalido: Bool {
        return senhavalida && nomevalido && usuariovalido
    }
    var nomevalido: Bool {
        return nome.count > 2
    }
    var usuariovalido: Bool {
        return usuario.count > 5
    }
    var senhavalida: Bool {
        return senha == confirmarSenha && senha.count > 5
    }
}
struct Criar_usuario_view: View {
    @StateObject var viewModel = FormViewModel()
    @State private var mensagemdesenhasdiferentes = false
    @State private var mensagemdesenhascurtas = false
    @State private var mensagemnomeinvalido = false
    @State private var mensagemusuarioinvalido = false
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                Image("back")
                    .resizable()
                    .scaledToFill()
                    .padding(.trailing, 50)
                    .ignoresSafeArea()
                VStack(spacing: 10) {
                    Image("logo")
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Nome")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.iconcolor)
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
                            .onChange(of: viewModel.nome) { _ in
                                nomevalido()
                            }
                    }
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Sobrenome")
                            .font(.headline)
                            .foregroundColor(.iconcolor)
                        TextField("Sobrenome", text: $viewModel.sobrenome)
                            .frame(width: 300, height: 40, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.iconcolor, lineWidth: 2)
                                    .frame(width: 300, height: 40)
                            )
                    }
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Nome de Usuário")
                            .font(.headline)
                            .foregroundColor(.iconcolor)
                        TextField("Nome de Usuário", text: $viewModel.usuario)
                            .frame(width: 300, height: 35, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.iconcolor, lineWidth: 2)
                                    .frame(width: 300, height: 40)
                            )
                            .onChange(of: viewModel.usuario) { _ in
                                usuariovalido()
                            }
                    }
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Criar Senha")
                            .font(.headline)
                            .foregroundColor(.iconcolor)
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
                    }
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Confirmar Senha")
                            .font(.headline)
                            .foregroundColor(.iconcolor)
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
                    }
                    if mensagemdesenhasdiferentes {
                        Text("As senhas não coincidem")
                            .foregroundColor(.red)
                    } else if mensagemdesenhascurtas {
                        Text("A senha deve ter mais de 5 caracteres")
                            .foregroundColor(.red)
                    }
                    else if mensagemusuarioinvalido {
                        Text("O nome de usuario precisa ter mais de 5 caracteres")
                            .foregroundColor(.red)
                    }
                    else if mensagemnomeinvalido {
                        Text("O nome precisa ter mais de 2 caracteres")
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
                    .disabled(!viewModel.criaruservalido)
                }
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .padding(10)
            }
        }
        .scrollContentBackground(.hidden)
    }
    
    private func validatePasswords() {
        mensagemdesenhasdiferentes = viewModel.senha != viewModel.confirmarSenha
        mensagemdesenhascurtas = viewModel.senha.count <= 5
    }
    private func nomevalido() {
        mensagemnomeinvalido = viewModel.nome.count <= 2
    }
    private func usuariovalido() {
        mensagemusuarioinvalido = viewModel.usuario.count <= 5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Criar_usuario_view()
            .preferredColorScheme(.light)
    }
}

#Preview {
    Criar_usuario_view()
}
