//
//  AppDelegate.swift
//  TodoListApp
//
//  Created by Have Dope on 31.08.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc = LoadingAssembly().makeLoadingViewController()
        self.window?.rootViewController = UINavigationController(rootViewController:vc)
        self.window?.makeKeyAndVisible()
        setupAppearance()
        return true
    }
    
    func setupAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    
    
}

