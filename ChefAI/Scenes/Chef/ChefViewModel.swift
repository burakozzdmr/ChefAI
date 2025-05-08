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
    var chatMessageList: [String] = []
    let geminiPrompt =
"""
    Sen profesyonel bir mutfak şefisin. Kullanıcılar sana sadece yemek ile alakalı sorular sorduğunda cevaplar vermeni istiyorum. Örneğin bir yemek tarifi, bir yemeğin makro değerleri kalorileri veya bir yemek yapmak için hangi malzemeler gerektiği gibi sorulara cevap ver sadece. Eğer çok alakasız sorular gelirse lütfen bunu kibar bir şekilde reddet. Kullanıcı sana hangi dilde soru sorduysa o dilde cevap ver. Örneğin ispanyolca bir soru gelirse sende aynı şekilde ispanyolca bir şekilde cevap ver.

        İşte kullanıcının sana sorduğu soru: 
"""
    
    init(geminiService: GeminiService = .init()) {
        self.geminiService = geminiService
    }
    
    func sendMessage(promptText: String) {
        geminiService.sendPrompt(prompt: promptText) { [weak self] geminiResponse in
            guard let self else { return }
            switch geminiResponse {
            case .success(let messageList):
                self.chatMessageList.append(messageList.candidates.first?.content.parts.first?.text ?? "")
                print(messageList.candidates.first?.content.parts.first?.text ?? "")
                DispatchQueue.main.async {
                    self.delegate?.didUpdateData()
                }
            case .failure:
                print(NetworkError.emptyDataError.errorMessage)
            }
        }
    }
}
