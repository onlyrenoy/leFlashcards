//
//  AppDelegate.swift
//  Hard75
//
//  Created by Renoy Chowdhury on 17/07/24.
//

import UIKit

@_exported import Stevia

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let home = UINavigationController(rootViewController: Main())
        home.navigationBar.tintColor = .white
        self.window?.rootViewController = home
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

