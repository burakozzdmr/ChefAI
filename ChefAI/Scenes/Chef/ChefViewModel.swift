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
    private(set) var chatMessageList: [String] = []
    weak var delegate: ChefViewModelProtocol?
    
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
