//
//  loginViewModel.swift
//  BeHealth
//
//  Created by Joao Roberto Fernandes Magalhaes on 26/08/24.
//

import Foundation

class loginViewModel: ObservableObject{
    @Published var credentials = Credentials
    @Published var showProgressView = false
    
    var loginDisabled : Bool {
        credentials.email.isEmpty || credentials.password.isEmpty
    }
    func login(completion: @escaping(Bool) -> Void){
        showProgressView = true
        APIService.shared.login(credentials: credentials) { [unowned self](result: Result<Bool, APIService.AP])}
    }
}
