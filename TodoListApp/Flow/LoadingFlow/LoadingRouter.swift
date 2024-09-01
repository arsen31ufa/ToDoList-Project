//
//  LoadingRouter.swift
//  TodoListApp
//
//  Created by Have Dope on 31.08.2024.
//

import Foundation
import UIKit

class LoadingRouter{
    let viewController: LoadingViewController
    
    init(viewController: LoadingViewController) {
        self.viewController = viewController
    }
    func goToMenu(todoList:[TodoEntity]){
        let controller = UINavigationController(rootViewController:MenuAssembly().makeMenuViewController(todoList: todoList))
        controller.modalPresentationStyle = .fullScreen
        self.viewController.present(controller, animated: true)
    }
}
