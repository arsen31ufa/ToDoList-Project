//
//  LoadingRouter.swift
//  TodoListApp
//
//  Created by Ars
//

import Foundation
import UIKit

class LoadingRouter{
    let viewController: LoadingViewController
    
    init(viewController: LoadingViewController) {
        self.viewController = viewController
    }
    
    // Переход в меню
    func goToMenu(todoList:[TodoEntity]){
        let controller = UINavigationController(rootViewController:MenuAssembly().makeMenuViewController(todoList: todoList))
        controller.navigationBar.isHidden = true
        controller.modalPresentationStyle = .fullScreen
        self.viewController.present(controller, animated: true)
    }
}
