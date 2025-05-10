//
//  SplashScreen.swift
//  Chat Demo
//
//  Created by Kushang  on 10/05/25.
//

import UIKit

class SplashScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if let userName = UserDefaults.standard.string(forKey: "USER_NAME") {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let vc = storyboard.instantiateViewController(withIdentifier: "HomeScreen") as? HomeScreen {
                    vc.userName = userName
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let vc = storyboard.instantiateViewController(withIdentifier: "LoginScreen") as? LoginScreen {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}
