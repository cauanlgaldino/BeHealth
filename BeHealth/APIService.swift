//
//  APIService.swift
//  BeHealth
//
//  Created by Joao Roberto Fernandes Magalhaes on 26/08/24.
//

import Foundation

class APIService{
    static let shared = APIService()
    enum APIError: Error{
        case error
    }
    func login(credentials: Credentials,
               completion: @escaping (REsult<Bool, APIError>) -> Void)
}
