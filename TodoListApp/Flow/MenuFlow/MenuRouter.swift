//
//  menuRouter.swift
//  TodoListApp
//
//  Created by Have Dope on 01.09.2024.
//

import Foundation

class menuRouter{
    
    let viewcontroller:MenuViewController
    init(viewcontroller: MenuViewController) {
        self.viewcontroller = viewcontroller
    }
    
    func goToSettings(){
        let vc = SettingsAssembly().makeSettingsViewController()
        viewcontroller.navigationController?.pushViewController(vc, animated: true)
    }
}
