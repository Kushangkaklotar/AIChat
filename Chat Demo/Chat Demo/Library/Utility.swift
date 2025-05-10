//
//  Utility.swift
//  Chat Demo
//
//  Created by Kushang  on 23/04/25.
//

import Foundation

class Utility {
    static let shared = Utility()
    
    class func saveChatArray(_ chatArray: [chatData]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(chatArray) {
            UserDefaults.standard.set(encoded, forKey: USER_DEFAULTS)
        }
    }

    class func loadChatArray() -> [chatData] {
        if let data = UserDefaults.standard.data(forKey: USER_DEFAULTS) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([chatData].self, from: data) {
                return decoded
            }
        }
        return []
    }

    class func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: Date())
    }

    class func getCurrentTimestamp() -> TimeInterval {
        return Date().timeIntervalSince1970
    }

    class func convertTimestampToDateString(_ timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    class func clearUserDefaults() {
        let defaults = UserDefaults.standard
        if let appDomain = Bundle.main.bundleIdentifier {
            defaults.removePersistentDomain(forName: appDomain)
        }
        defaults.synchronize()
    }

}
