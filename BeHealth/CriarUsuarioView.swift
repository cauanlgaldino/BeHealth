//
//  criar_usuario_view.swift
//  BeHealth
//
//  Created by Daniel Victor Bamberg Oppelt on 26/08/24.
//

import SwiftUI

class FormViewModel: ObservableObject {

}

struct CriarUsuarioView: View {
    @State var nome = ""
    @State var sobrenome = ""
    @State var senha = ""
    @State var confirmarSenha = ""
    @State var usuario = ""
    @State var disableButton = true
    @StateObject var viewModel = FormViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Dados Pessoais")) {
                        TextField("Nome",
                                  text: $nome)
                        TextField("Sobrenome",
                                  text: $sobrenome)
                    }
                    Section(header: Text("Usuário"), footer: Text("Nome de usuário deve conter pelo menos 5 caracteres")) {
                        TextField("Nome de Usuário", text:
                                    $usuario)
                    }
                    Section(header: Text("Senha"), footer: Text("Sua senha deve conter pelo menos 5 caracteres")) {
                        SecureField("Criar Senha", text:
                                        $senha)
                        SecureField("Confirmar Senha", text:
                                        $confirmarSenha)
                    }
                }
                Button {
                    if (senha == confirmarSenha) {
                       disableButton = false
                        
                    }
                } label: {
                    Text("Continuar")
                        .frame(width: 200,
                               height: 50,
                               alignment: .center)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(disableButton)
            }
            .navigationTitle("Criar Conta")
        }
    }
}

#Preview {
    CriarUsuarioView()
}


