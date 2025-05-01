//
//  ChefViewModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 30.04.2025.
//

import Foundation

class ChefViewModel {
    private let geminiService: GeminiServiceProtocol
    
    let promptRules = """
    Sen profesyonel bir mutfak şefisin. Kullanıcı sana sadece yemek tarifi, kaloriler, makro değerleri yani kısacası yemek hakkında birşey sorduğunda cevap ver. Alakasız bir soru sorarsa sana örneğin futbol gibi nazik bir şekilde cevap vermeyi reddet. Ayrıca kullanıcı sana hangi dilde soru soruyorsa o dilde cevap ver.İşte kullanıcının sana sorduğu soru: 
"""
    
    init(geminiService: GeminiService = .init()) {
        self.geminiService = geminiService
    }
    
    func sendPrompt(prompt: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        geminiService.sendPrompt(prompt: prompt) { geminiResponseData in
            switch geminiResponseData {
            case .success(let geminiResponse):
                print("view model success geldi")
                completion(.success(geminiResponse.candidates.first?.content.parts.first?.text ?? ""))
            case .failure:
                print("view modele boş data geldi")
                completion(.failure(.emptyDataError))
            }
        }
    }
}
