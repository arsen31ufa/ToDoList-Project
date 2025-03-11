//
//  SettingsRouter.swift
//  TodoListApp
//
//  Created by Ars
//

import Foundation

class SettingsRouter {
    let viewcontroller:SettingsViewController
    
    init(viewcontroller: SettingsViewController) {
        self.viewcontroller = viewcontroller
    }
    
    func goToMenu(){
        viewcontroller.navigationController?.popViewController(animated: true)
    }
}
