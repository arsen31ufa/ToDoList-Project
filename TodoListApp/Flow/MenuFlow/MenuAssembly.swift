//
//  MenuAssembly.swift
//  TodoListApp
//
//  Created by Have Dope on 01.09.2024.
//

import Foundation

class MenuAssembly {
    func makeMenuViewController(todoList:[TodoEntity]) -> MenuViewController {
        let vc = MenuViewController()
        let router = menuRouter(viewcontroller: vc)
        let presenter = MenuPresenter(viewcontroller: vc, todoList: todoList)
        vc.presenter = presenter
        return vc
    }
}
