//
//  MenuAssembly.swift
//  TodoListApp
//
//  Created by Ars
//

import Foundation

class MenuAssembly {
    func makeMenuViewController(todoList:[TodoEntity]) -> MenuViewController {
        let vc = MenuViewController()
        let router = menuRouter(viewcontroller: vc)
        let presenter = MenuPresenter(viewcontroller: vc, router: router, todoList: todoList)
        vc.presenter = presenter
        return vc
    }
}
