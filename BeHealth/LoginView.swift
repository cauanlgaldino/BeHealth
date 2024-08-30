//
//  LoginView.swift
//  BeHealth
//
//  Created by Joao Roberto Fernandes Magalhaes on 27/08/24.
//

import SwiftUI

struct LoginView: View {
    struct Usuario {
        var nome: String = ""
        var senha: String = ""
    }
    @State private var usuario: Usuario = .init()
    @FocusState private var imputFocused: Bool
    var body: some View {
    ZStack {
        Color.white
           .ignoresSafeArea()
            Image("loginscreen")
             .resizable()
             .scaledToFill()
             .frame(width: 480, height: 500)
            .ignoresSafeArea()
        VStack {
                Text("Login")
                    .font(.system(size: 32))
                    .fontDesign(.rounded)
                   .foregroundStyle(.iconcolor)
                    .fontWeight(.semibold)
                usernameTxtVw
                .padding(.horizontal,10)
                passwordTxtVw
                .padding(.horizontal,10)
                submitBtn
            }
            .ignoresSafeArea()
            .padding(20)
            .textFieldStyle(.roundedBorder)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button(action: resignKeyboard) {
                        Text("OK")
                    }
                    .buttonStyle(.borderless)
                    .border(.secondary)
                }
            }
            .onSubmit(of: .text, submit)
        }
    }
}

private extension LoginView {
    var usernameTxtVw: some View {
        TextField("Usuario", text: $usuario.nome, prompt: Text("Insira seu username").foregroundColor(.iconcolor))
            .textContentType(.username)
            .focused($imputFocused)
            .frame(width: 300, height: 50)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.iconcolor, lineWidth: 2)
                    .frame(width: 300, height: 35)
            )
    }
    var passwordTxtVw: some View {
        SecureField("Usuario", text: $usuario.senha, prompt: Text("Insira sua senha").foregroundColor(.iconcolor))
            .textContentType(.password)
            .focused($imputFocused)
            .submitLabel(.done)
            .frame(width: 300, height: 50, alignment: .center)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.iconcolor, lineWidth: 2)
                    .frame(width: 300, height: 35)
            )
            .padding()
    }
    var submitBtn: some View {
        Button(action: submit) {
            Text("Entrar")
                .bold()
                .frame(width: 200, height: 50, alignment: .center)
                .background(Color.tabcolor)
                .foregroundColor(.iconcolor)
                .cornerRadius(8)
        }
    }
}
private extension LoginView {
    func submit() {
        print("The user imputted: \(usuario)")
        resignKeyboard()
    }
    func resignKeyboard() { if #available(iOS 15, *) {
        imputFocused = false
    } else {
        dismissKeyboard()
    }
    }
}
extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#Preview {
    LoginView()
}
