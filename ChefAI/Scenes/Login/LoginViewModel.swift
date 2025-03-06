//
//  LoginViewModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import Foundation

class LoginViewModel {
    private let service: AuthServiceProtocol
    
    init(service: AuthService = .init()) {
        self.service = service
    }
    
    func signIn(with email: String, and password: String, completion: @escaping (Error?) -> Void) {
        service.signIn(with: email, and: password, completion: completion)
    }
}
