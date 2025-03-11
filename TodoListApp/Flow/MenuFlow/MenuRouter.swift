//
//  menuRouter.swift
//  TodoListApp
//
//  Created by Ars
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
