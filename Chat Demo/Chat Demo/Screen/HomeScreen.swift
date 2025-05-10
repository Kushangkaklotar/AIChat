//
//  HomeScreen.swift
//  Chat Demo
//
//  Created by Kushang  on 10/05/25.
//

import UIKit

class HomeScreen: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    var userName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.manageUI()
        self.nameLabel.text = userName
    }
    
    @IBAction func onChat(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onLogOut(_ sender: Any) {
        self.logOut()
    }
    
    func manageUI(){
        self.headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        self.headerView.layer.cornerRadius = self.headerView.frame.height/2
        
        self.chatButton.layer.cornerRadius = self.chatButton.frame.height/2
    }
    
    func logOut(){
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { _ in
            UserDefaults.standard.removeObject(forKey: USER_DEFAULTS)
            UserDefaults.standard.removeObject(forKey: "USER_NAME")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "LoginScreen") as? LoginScreen {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }))

        present(alert, animated: true, completion: nil)
    }
}
