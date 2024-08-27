//
//  LoginView.swift
//  BeHealth
//
//  Created by Joao Roberto Fernandes Magalhaes on 27/08/24.
//

import SwiftUI

struct LoginView: View {
    struct Usuario {
        var nome : String = ""
        var senha : String = ""
    }
    @State private var usuario : Usuario = .init()
    @FocusState private var imputFocused: Bool
    var body: some View {
        
        VStack{
            Text("Login")
                .font(.system(size: 32))
                .fontDesign(.rounded)
                .foregroundStyle(.iconcolor)
                .fontWeight(.semibold)
            usernameTxtVw
            passwordTxtVw
            submitBtn
        }
        .ignoresSafeArea()
        .padding()
        .textFieldStyle(.roundedBorder)
        .disableAutocorrection(true)
        .textInputAutocapitalization(.never)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard){
                Spacer()
                Button(action: resignKeyboard){
                    Text("OK")
                }
                .buttonStyle(.borderless)
                .border(.secondary)
                
            }
        }
        .onSubmit(of: .text,submit)
    }
}

#Preview {
    ContentView()
}

private extension LoginView{
    var usernameTxtVw : some View {
        TextField("Usuario", text: $usuario.nome, prompt: Text("Insira seu username"))
            .textContentType(.username)
            .focused($imputFocused)
    }
    var passwordTxtVw : some View {
        SecureField("Usuario", text: $usuario.senha, prompt: Text("Insira seu username"))
            .textContentType(.password)
            .focused($imputFocused)
            .submitLabel(.done)
    }
    var submitBtn : some View {
        Button(action: submit)   {
            Text("Submit")
                .padding(EdgeInsets())
                .background(.tabcolor)
            
        }
        
    }
}
private extension LoginView{
    func submit(){
        print ("The user imputted: \(usuario)")
        resignKeyboard()
    }
    func resignKeyboard() { if #available(iOS 15, *){
            imputFocused = false
        } else {
            dismissKeyboard()
        }
    }
}
extension View{
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),to: nil, from: nil, for: nil)
    }
}


#Preview {
    LoginView()
}
