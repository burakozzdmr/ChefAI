//
//  EmbedFormatter.swift
//  ChefAI
//
//  Created by Burak Özdemir on 10.05.2025.
//

import Foundation

class EmbedFormatter {
    static func convertToEmbed(from url: String) -> String {
        if url.contains("youtube.com/watch?v=") {
            return url.replacingOccurrences(of: "watch?v=", with: "embed/")
        } else if url.contains("youtu.be/") {
            return url.replacingOccurrences(of: "youtu.be/", with: "www.youtube.com/embed/")
        }
        return ""
    }
}
