//
//  SettingsAssembly.swift
//  TodoListApp
//
//  Created by Ars
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
