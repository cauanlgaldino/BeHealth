//
//  criar_usuario_view.swift
//  BeHealth
//
//  Created by Daniel Victor Bamberg Oppelt on 26/08/24.
//

import SwiftUI

//class FormViewModel: ObservableObject {
//    @State var nome = ""
//    @State var sobrenome = ""
//    @State var senha = ""
//    @State var confirmarSenha = ""
//    @State var usuario = ""
//}

//struct criar_usuario_view: View {
//    
//    @StateObject var viewModel = FormViewModel()
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                Color.white
//                    .ignoresSafeArea()
//                VStack {
//                            TextField ("Nome",
//                                       text: $viewModel.nome)
//                            .frame(width: 300, height: 40)
//                            .background(Color.white)
//                            .cornerRadius(8)
//                            .foregroundColor(.blue)
//                            .overlay(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(Color.iconcolor, lineWidth: 2)
//                                .frame(width: 300, height: 40)
//                            )
//                            TextField ("Sobrenome",
//                                       text: $viewModel.sobrenome)
//                                .frame(width: 300, height: 40, alignment: .center)
//                                .background(Color.white)
//                                .cornerRadius(8)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(Color.iconcolor, lineWidth: 2)
//                                        .frame(width: 300, height: 40)
//                                )
//                                .padding()
//                            TextField ("Nome de Usuário", text:
//                                        $viewModel.usuario)
//                            .frame(width: 300, height: 35, alignment: .center)
//                            .background(Color.white)
//                            .cornerRadius(8)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color.iconcolor, lineWidth: 2)
//                                    .frame(width: 300, height: 40)
//                            )
//                            .padding()
//                           SecureField ("Criar Senha", text:
//                                            $viewModel.senha)
//                            .frame(width: 300, height: 40, alignment: .center)
//                            .background(Color.white)
//                            .cornerRadius(8)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color.iconcolor, lineWidth: 2)
//                                    .frame(width: 300, height: 40)
//                            )
//                            SecureField ("Confirmar Senha", text:
//                                            $viewModel.confirmarSenha)
//                            .frame(width: 300, height: 40, alignment: .center)
//                            .background(Color.white)
//                            .cornerRadius(8)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color.iconcolor, lineWidth: 2)
//                                    .frame(width: 300, height: 40)
//                            )
//                    
//                  Button (action: {
//                    }, label: {
//                        Text("Continuar")
//                            .frame(width: 200,
//                                   height: 50,
//                                   alignment: .center)
//                            .background(Color.tabcolor)
//                            .foregroundColor(.iconcolor)
//                            .cornerRadius (8)
//                            .bold()
//                            .fontDesign(.rounded)
//                    })
//                }.ignoresSafeArea()
//                    .padding(20)
//                    .textFieldStyle(.roundedBorder)
//                    .disableAutocorrection(true)
//                    .textInputAutocapitalization(.never)
//                .toolbar {
//                    ToolbarItem(placement: .topBarLeading) {
//                                    Text("Criar conta")
//                                        .font(.system(size: 32))
//                                        .foregroundColor(.iconcolor)
//                                        .bold()
//                                        .fontDesign(.rounded)
//                                }
//                            }
//                .foregroundColor(.iconcolor)
//            }
//        }.scrollContentBackground(.hidden)
//    }
//    
//    struct ContentView_Previews: PreviewProvider {
//        static var previews: some View {
//            criar_usuario_view()
//                .preferredColorScheme(.light)
//        }
//    }
//}
//
//#Preview {
//    criar_usuario_view()
//}

