//
//  AppDelegate.swift
//  Chat Demo
//
//  Created by Kushang  on 01/03/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navVC : UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.navigation()
        return true
    }
    
    
    func navigation(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "SplashScreen") as! SplashScreen
        self.navVC = UINavigationController(rootViewController: nextViewController)
        self.navVC?.isNavigationBarHidden = true
        self.navVC?.interactivePopGestureRecognizer?.isEnabled = false
        self.navVC?.interactivePopGestureRecognizer?.delegate = nil
        self.window?.rootViewController = nil
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
    }
}

