//
//  criar_usuario_view.swift
//  BeHealth
//
//  Created by Daniel Victor Bamberg Oppelt on 26/08/24.
//

import SwiftUI

class FormViewModel: ObservableObject {
    @State var nome = ""
    @State var sobrenome = ""
    @State var senha = ""
    @State var confirmarSenha = ""
    @State var usuario = ""
}

struct criar_usuario_view: View {
    
    @StateObject var viewModel = FormViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section (header: Text("Dados Pessoais")) {
                        TextField ("Nome",
                                   text: $viewModel.nome)
                        TextField ("Sobrenome",
                                   text: $viewModel.sobrenome)
                    }
                    
                    Section (header: Text("Usuário"), footer: Text("Seu nome de usuário deve conter pelo menos 5 caracteres")){
                        
                        TextField ("Nome de Usuário", text:
                                        $viewModel.usuario)
                        
                }
                    
                    Section (header: Text("Senha"), footer: Text("Sua senha deve conter pelo menos 5 caracteres")){
                        
                        SecureField ("Criar Senha", text:
                                        $viewModel.senha)
                        SecureField ("Confirmar Senha", text:
                                        $viewModel.confirmarSenha)
                }
                    
                    
                    
                }
                
                Button (action: {
                    
                }, label: {
                    Text("Continuar")
                        .frame(width: 200,
                               height: 50,
                               alignment: .center)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius (8)
                })

                
            }
            .navigationTitle("Criar Conta")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

#Preview {
    criar_usuario_view()
}
