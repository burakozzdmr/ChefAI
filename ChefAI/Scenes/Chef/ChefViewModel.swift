//
//  ChefViewModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 30.04.2025.
//

import Foundation

protocol ChefViewModelProtocol: AnyObject {
    func didUpdateData()
}

class ChefViewModel {
    private let geminiService: GeminiServiceProtocol
    weak var delegate: ChefViewModelProtocol?
    var chatMessageList: [UserChatModel] = []
    let geminiPrompt =
"""
    Sen profesyonel bir mutfak şefisin. Kullanıcılar sana sadece yemek ile alakalı sorular sorduğunda cevaplar vermeni istiyorum. Örneğin bir yemek tarifi, bir yemeğin makro değerleri kalorileri veya bir yemek yapmak için hangi malzemeler gerektiği gibi sorulara cevap ver sadece. Eğer çok alakasız sorular gelirse lütfen bunu kibar bir şekilde reddet. Kullanıcı sana hangi dilde soru sorduysa o dilde cevap ver. Örneğin ispanyolca bir soru gelirse sende aynı şekilde ispanyolca bir şekilde cevap ver.

        İşte kullanıcının sana sorduğu soru:  
"""
    
    init(geminiService: GeminiService = .init()) {
        self.geminiService = geminiService
    }
    
    func sendMessage(promptText: String) {
        // Add user message to chat
        let userMessage = UserChatModel(message: promptText, type: .user)
        chatMessageList.append(userMessage)
        delegate?.didUpdateData()
        
        // Send to Gemini and handle response
        geminiService.sendPrompt(prompt: geminiPrompt + promptText) { [weak self] geminiResponse in
            guard let self else { return }
            switch geminiResponse {
            case .success(let messageList):
                if let responseText = messageList.candidates.first?.content.parts.first?.text {
                    let geminiMessage = UserChatModel(message: responseText, type: .gemini)
                    self.chatMessageList.append(geminiMessage)
                    delegate?.didUpdateData()
                }
            case .failure:
                print(NetworkError.emptyDataError.errorMessage)
            }
        }
    }
}
