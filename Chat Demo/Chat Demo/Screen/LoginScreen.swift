//
//  LoginScreen.swift
//  Chat Demo
//
//  Created by Kushang  on 28/04/25.
//

import UIKit

class LoginScreen: UIViewController {

    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var textfieldView: UIView!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.manageUI()
        self.goButton.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.8862745098, blue: 0.8078431373, alpha: 1).withAlphaComponent(0.5)
        self.nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if text != "" {
            self.goButton.layer.borderColor = UIColor.black.cgColor
            self.goButton.layer.borderWidth = 1
            self.goButton.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.8862745098, blue: 0.8078431373, alpha: 1)
            self.goButton.isEnabled = true
        } else {
            self.goButton.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.8862745098, blue: 0.8078431373, alpha: 1).withAlphaComponent(0.5)
            self.goButton.layer.borderWidth = 0
            self.goButton.isEnabled = false
        }
    }
    
    @IBAction func onGobutton(_ sender: Any) {
        UserDefaults.standard.set(self.nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "USER_NAME")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "HomeScreen") as? HomeScreen {
            vc.userName = self.nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func manageUI(){
        self.upperView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.upperView.layer.cornerRadius = UIScreen.main.bounds.width/2
        
        self.textfieldView.layer.cornerRadius = self.textfieldView.frame.height/2
        self.textfieldView.layer.borderColor = UIColor.black.cgColor
        self.textfieldView.layer.borderWidth = 1
        
        self.goButton.layer.cornerRadius = self.goButton.frame.height/2
    }
}
