//
//  SettingsAssembly.swift
//  TodoListApp
//
//  Created by Have Dope on 03.09.2024.
//

import Foundation

class SettingsAssembly{
    func makeSettingsViewController() -> SettingsViewController{
        let vc = SettingsViewController()
        let router = SettingsRouter(viewcontroller: vc)
        let presenter = SettingsPresenter(viewcontroller: vc, router: router)
        vc.presenter = presenter
        return vc
    }
}
