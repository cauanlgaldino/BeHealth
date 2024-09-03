//
//  LoginView.swift
//  BeHealth
//
//  Created by Joao Roberto Fernandes Magalhaes on 27/08/24.
//

import SwiftUI

struct LoginView: View {
    @State var username = ""
    @State var password = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State var isLoginSuccessful: Bool = false
    @Binding var isAuthenticated: Bool
    @FocusState private var usernameFocused: Bool
    @FocusState private var passwordFocused: Bool
    @StateObject private var viewModel = UserViewModel()
    var body: some View {
        ZStack {
            Image("loginscreen")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .containerRelativeFrame([.horizontal, .vertical])
                .scaleEffect(1.1)
            VStack(spacing: 20) {
                Text("Login")
                    .font(.system(size: 32))
                    .fontDesign(.rounded)
                    .foregroundStyle(.iconcolor)
                    .fontWeight(.semibold)
                usernameTextField
                passwordTextField
                loginButton
            }
            .padding(32)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        dismissKeyboard()
                    } label: {
                        Text("OK")
                    }
                    .buttonStyle(.borderless)
                }
            }
        }
    }
}

private extension LoginView {
    var usernameTextField: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack{
                Image(systemName:"person")
                    .font(.system(size: 24))
                Text("Nome de Usuário")
            }
                .font(.headline)
                .foregroundColor(.iconcolor)
            TextField("Insira seu username", text: $username)
                .padding(12)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .foregroundColor(.verdeoliva)
                .textContentType(.username)
                .textFieldStyle(.plain)
                .focused($usernameFocused)
                .submitLabel(.next)
                .onSubmit {
                    passwordFocused = true
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.verdeoliva, lineWidth: 2)
                )
        }
    }
    var passwordTextField: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName:"lock")
                    .font(.system(size: 24))
                Text("Senha")
            }
                .font(.headline)
                .foregroundColor(.iconcolor)
            SecureField("Insira sua senha", text: $password)
                .padding(12)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .foregroundColor(.verdeoliva)
                .textContentType(.password)
                .focused($passwordFocused)
                .submitLabel(.go)
                .onSubmit {
                    submit()
                }
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.verdeoliva, lineWidth: 2)
                )
        }
    }
    var loginButton: some View {
        Button {
            submit()
        } label: {
            Text("Entrar")
                .bold()
                .frame(width: 200, height: 50, alignment: .center)
                .background(Color.tabcolor)
                .foregroundColor(.verdeoliva)
                .cornerRadius(8)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Erro"),
                message: Text(alertMessage),
                dismissButton: .default(Text("Tentar novamente"))
            )
        }
    }
}
private extension LoginView {
    func submit() {
        Task {
            // MARK: Colocar chamada de função
            let result = await viewModel.loginUser(username: username, password: password)
            switch result {
            case .success(let success):
                if success {
                    isLoginSuccessful = true
                    isAuthenticated = true
                } else {
                    alertMessage = "Erro inesperado ao fazer login"
                    showAlert = true
                }
            case .failure(let error):
                switch error {
                case .userNotFound:
                    alertMessage = "Usuário não encontrado. Verifique seu nome de usuário."
                    showAlert = true
                    usernameFocused = true
                case .invalidCredentials:
                    alertMessage = "Credenciais inválidas. Verifique sua senha."
                    showAlert = true
                    passwordFocused = true
                case .keychainError:
                    alertMessage = "Falha ao salvar token. Tente novamente."
                    showAlert = true
                case .networkError(let networkError):
                    alertMessage = "Erro de rede: \(networkError.localizedDescription)"
                    showAlert = true
                }
            }
        }
    }
}
extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
//#Preview {
//    LoginView()
//}
