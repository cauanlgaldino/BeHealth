//
//  Criar_usuario_view.swift
//  BeHealth
//
//  Created by Joao Roberto Fernandes Magalhaes on 29/08/24.
//

import SwiftUI

struct CreateUser: View {
    @State private var nome = ""
    @State private var sobrenome = ""
    @State private var senha = ""
    @State private var confirmarSenha = ""
    @State private var usuario = ""
    @State private var alertMessage = ""
    @State private var mensagemdesenhasdiferentes = false
    @State private var mensagemdesenhascurtas = false
    @State private var mensagemnomeinvalido = false
    @State private var mensagemusuarioinvalido = false
    @State private var showAlert = false
    @State var isCreated: Bool = false
    @Binding var isAuthenticated: Bool
    @EnvironmentObject var router: Router
    @StateObject private var viewModel = UserViewModel()
    private var criaruservalido: Bool {
        return senhaValida && nomeValido && usuarioValido
    }
    private var nomeValido: Bool {
        return nome.count > 2
    }
    private var usuarioValido: Bool {
        return usuario.count > 5
    }
    private var senhaValida: Bool {
        return senha == confirmarSenha && senha.count > 5
    }
    var body: some View {
        ZStack {
            Color.white
            Image("back")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .containerRelativeFrame([.horizontal, .vertical])
            VStack(spacing: 12) {
                Image("logo")
                    .padding(.top, 24)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Nome")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.iconcolor)
                    TextField("John", text: $nome)
                        .padding(4)
                        .background(Color.white)
                        .cornerRadius(8)
                        .foregroundColor(.iconcolor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.iconcolor, lineWidth: 2)
                        )
                        .onChange(of: nome) { _ in
                            validarNome()
                        }
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Sobrenome")
                        .font(.headline)
                        .foregroundColor(.iconcolor)
                    TextField("Doe", text: $sobrenome)
                        .padding(4)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.iconcolor, lineWidth: 2)
                        )
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Nome de Usuário")
                        .font(.headline)
                        .foregroundColor(.iconcolor)
                    TextField("Nome de Usuário", text: $usuario)
                        .padding(4)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.iconcolor, lineWidth: 2)
                        )
                        .onChange(of: usuario) { _ in
                            validarUsuario()
                        }
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Criar Senha")
                        .font(.headline)
                        .foregroundColor(.iconcolor)
                    SecureField("Criar Senha", text: $senha)
                        .padding(4)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.iconcolor, lineWidth: 2)
                        )
                        .textContentType(.newPassword)
                        .onChange(of: senha) { _ in
                            validarSenhas()
                        }
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text("Confirmar Senha")
                        .font(.headline)
                        .foregroundColor(.iconcolor)
                    SecureField("Confirmar Senha", text: $confirmarSenha)
                        .padding(4)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.iconcolor, lineWidth: 2)
                        )
                        .textContentType(.newPassword)
                        .onChange(of: confirmarSenha) { _ in
                            validarSenhas()
                        }
                }
                if mensagemdesenhasdiferentes {
                    Text("As senhas não coincidem")
                        .foregroundColor(.red)
                } else if mensagemdesenhascurtas {
                    Text("A senha deve ter mais de 5 caracteres")
                        .foregroundColor(.red)
                } else if mensagemusuarioinvalido {
                    Text("O nome de usuario precisa ter mais de 5 caracteres")
                        .foregroundColor(.red)
                } else if mensagemnomeinvalido {
                    Text("O nome precisa ter mais de 2 caracteres")
                        .foregroundColor(.red)
                }
                Button {
                    Task {
                        let result = await viewModel.createUsers(
                            username: usuario,
                            name: nome+" "+sobrenome,
                            password: senha
                        )
                        switch result {
                        case .success(let success):
                            if success {
                                isCreated = true
                                isAuthenticated = true
                            } else {
                                alertMessage = "Erro inesperado ao criar usuário"
                                showAlert = true
                            }
                        case .failure(let error):
                            switch error {
                            case .userExists:
                                alertMessage = "Nome de usuário já existe. Por favor defina outro."
                                showAlert = true
                            case .keychainError:
                                alertMessage = "Falha ao salvar token. Tente novamente."
                                showAlert = true
                            case .networkError(let networkError):
                                alertMessage = "Erro de rede: \(networkError.localizedDescription)"
                                showAlert = true
                            }
                        }
                        
                    }
                } label: {
                    Text("Continuar")
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Color.tabcolor)
                        .foregroundColor(.iconcolor)
                        .cornerRadius(8)
                        .bold()
                        .fontDesign(.rounded)
                        .opacity(criaruservalido ? 1.0 : 0.5)
                }
                .padding(.top, 12)
                .disabled(!criaruservalido)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Erro"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("Tentar novamente"))
                    )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .textFieldStyle(.roundedBorder)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .padding(32)
        }
        .scrollContentBackground(.hidden)
    }
    private func validarSenhas() {
        mensagemdesenhasdiferentes = senha != confirmarSenha
        mensagemdesenhascurtas = senha.count <= 5
    }
    private func validarNome() {
        mensagemnomeinvalido = nome.count <= 2
    }
    private func validarUsuario() {
        mensagemusuarioinvalido = usuario.count <= 5
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateUser()
//            .preferredColorScheme(.light)
//    }
//}
//
//#Preview {
//    CreateUser()
//}
