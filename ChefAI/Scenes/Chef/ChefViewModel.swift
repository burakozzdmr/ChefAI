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
        
        fetchChatMessage()
    }
    
    func sendMessage(promptText: String) {
        let userMessage = UserChatModel(message: promptText, type: .user)
        StorageManager.shared.addChatMessage(with: userMessage)
        fetchChatMessage()
        
        geminiService.sendPrompt(prompt: geminiPrompt + promptText) { [weak self] geminiResponse in
            guard let self else { return }
            switch geminiResponse {
            case .success(let messageList):
                if let responseText = messageList.candidates.first?.content.parts.first?.text {
                    let geminiMessage = UserChatModel(message: responseText, type: .gemini)
                    StorageManager.shared.addChatMessage(with: geminiMessage)
                    fetchChatMessage()
                }
            case .failure(let error):
                print(error.errorMessage)
            }
        }
    }
    
    func fetchChatMessage() {
        chatMessageList = StorageManager.shared.fetchChatMessages()
        delegate?.didUpdateData()
    }
    
    func resetChatMessages() {
        StorageManager.shared.removeAllChatMessages()
        fetchChatMessage()
    }
}
