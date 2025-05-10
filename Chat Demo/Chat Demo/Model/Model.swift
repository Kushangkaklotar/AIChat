//
//  Model.swift
//  Chat Demo
//
//  Created by Kushang  on 19/04/25.
//

import Foundation

// MARK: - For Genini API Call -
struct GeminiRequest: Codable {
    struct Content: Codable {
        let parts: [Part]
    }
    struct Part: Codable {
        let text: String
    }
    
    let contents: [Content]
}

struct GeminiResponse: Codable {
    struct Candidate: Codable {
        struct Content: Codable {
            struct Part: Codable {
                let text: String
            }
            let parts: [Part]
        }
        let content: Content
    }
    let candidates: [Candidate]
}

struct GeminiAPIError: Codable {
    struct APIErrorDetail: Codable {
        let code: Int
        let message: String
        let status: String
    }
    let error: APIErrorDetail
}

// MARK: - For TableView Manage -
struct chatData: Codable {
    let message: String
    let isMyMessage: Bool
    let time: TimeInterval
}

