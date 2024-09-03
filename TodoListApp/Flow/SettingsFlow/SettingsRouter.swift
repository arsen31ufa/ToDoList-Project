//
//  SettingsRouter.swift
//  TodoListApp
//
//  Created by Have Dope on 03.09.2024.
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
