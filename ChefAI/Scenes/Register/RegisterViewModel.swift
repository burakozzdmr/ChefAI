//
//  RegisterViewModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import Foundation

class RegisterViewModel {
    private let service: AuthServiceProtocol
    
    init(service: AuthService = .init()) {
        self.service = service
    }
    
    func signUp(with email: String, and password: String, completion: @escaping (Error?) -> Void) {
        service.signUp(with: email, and: password, completion: completion)
    }
}
