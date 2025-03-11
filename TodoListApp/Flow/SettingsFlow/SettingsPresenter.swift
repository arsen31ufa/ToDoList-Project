//
//  SettingsPresenter.swift
//  TodoListApp
//
//  Created by Ars
//

import Foundation


class SettingsPresenter {
    let viewcontroller: SettingsViewController
    let router: SettingsRouter
    
    init(viewcontroller: SettingsViewController, router: SettingsRouter) {
        self.viewcontroller = viewcontroller
        self.router = router
    }
    
    func goToMenu(){
        router.goToMenu()
    }
}
