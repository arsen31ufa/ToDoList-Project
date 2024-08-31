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
        let vc = LoadingAssebly().makeLoadingViewController()
        self.window?.rootViewController = UINavigationController(rootViewController:vc)
        self.window?.makeKeyAndVisible()
        return true
    }


}

