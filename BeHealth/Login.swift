//
//  Login.swift
//  BeHealth
//
//  Created by Joao Roberto Fernandes Magalhaes on 26/08/24.
//

import SwiftUI

struct Login: View {
    var body: some View {
        NavigationStack{
            VStack{
                TextField("Usuario", text: .constant(""), prompt: Text("Insira seu username"))
                TextField("Senha", text: .constant(""), prompt: Text("Insira seu username"))
            }
            SecureField("Senha", text: . constant(""),prompt: Text("Insira sua senha") )
        }
    }
}
#Preview {
    Login()
}
