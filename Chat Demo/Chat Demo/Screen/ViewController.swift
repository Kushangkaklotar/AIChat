//
//  ViewController.swift
//  Chat Demo
//
//  Created by Kushang  on 01/03/25.
//

import UIKit
import Alamofire
import GoogleGenerativeAI

struct GeminiResponseObj: Codable {
    let candidates: [Candidate]
}

struct Candidate: Codable {
    let content: Content
}

struct Content: Codable {
    let parts: [Part]
}

struct Part: Codable {
    let text: String
}

class ViewController: UIViewController {
    
    // MARK: - IB Outlet -
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatTextView: UITextField!
    @IBOutlet weak var chatIconImageView: UIImageView!
    
    // MARK: - Variables -
    let geminiApiUrl = "https://generativelanguage.googleapis.com/v1/models/gemini-2.0-flash:generateContent?key=\(API_KEY)"
    var chatArray: [chatData] = []
    
    // MARK: - Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
//        Utility.clearUserDefaults()
        self.chatArray = Utility.loadChatArray()
        self.manageUI()
        self.registerCell()
        if !self.chatArray.isEmpty {
            self.chatTableView.scrollToBottom(isAnimated: true)
        }
    }
    
    // MARK: - Function's -
    func manageUI(){
        self.headerView.layer.cornerRadius = 45
        self.textFieldView.layer.cornerRadius = self.textFieldView.frame.height/2
        self.textFieldView.layer.borderColor = UIColor.black.cgColor
        self.textFieldView.layer.borderWidth = 1
        self.headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.headerView.clipsToBounds = true
        
        self.chatIconImageView.layer.cornerRadius = 20
    }
    
    func registerCell(){
        self.chatTableView.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "ChatCell")
    }
    
    // MARK: - IB Actoin method -
    @IBAction func onSend(_ sender: Any) {
        self.sendToGemini(prompt: self.chatTextView.text ?? "") { response in
            if let reply = response {
                self.chatArray.append(chatData(message: reply, isMyMessage: false, time: Utility.getCurrentTimestamp()))
                DispatchQueue.main.async {
                    self.chatTableView.reloadData()
                    self.chatTableView.scrollToBottom(isAnimated: true)
                }
                Utility.saveChatArray(self.chatArray)
                print("Gemini says: \(reply)")
            } else {
                print("Failed to get a reply.")
            }
        }
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
// MARK: - Extension -


// MARK: - Delegate method -
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        cell.chatDataSet = self.chatArray[indexPath.row]
        return cell
    }
}

// MARK: - API Call -
extension ViewController {
    func sendToGemini(prompt: String, completion: @escaping (String?) -> Void) {
        self.chatArray.append(chatData(message: prompt, isMyMessage: true, time: Utility.getCurrentTimestamp()))
        self.chatTableView.reloadData()
        self.chatTableView.scrollToBottom(isAnimated: true)
        self.chatTextView.text = ""
//        Utility.saveChatArray(self.chatArray)

        guard let url = URL(string: geminiApiUrl) else {
            completion("Invalid URL")
            return
        }

        let requestBody: [String: Any] = [
            "contents": [
                [
                    "role": "user",
                    "parts": [
                        ["text": prompt]
                    ]
                ]
            ]
        ]

        AF.request(url, method: .post,parameters: requestBody, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"]).responseData { response in
            switch response.result {
            case .success(let data):
                if let statusCode = response.response?.statusCode, statusCode != 200 {
                    let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
                    completion("Gemini says: \(errorMessage)")
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(GeminiResponse.self, from: data)
                    let reply = decoded.candidates.first?.content.parts.first?.text
                    completion(reply)
                } catch {
                    completion("Failed to decode: \(error.localizedDescription)")
                }
            case .failure(let error):
                completion("Network error: \(error.localizedDescription)")
            }
        }
    }
}
