//
//  MenuPresenter.swift
//  TodoListApp
//
//  Created by Have Dope on 01.09.2024.
//

import Foundation


class MenuPresenter{
    let viewcontroller: MenuViewController
    let router: menuRouter
    var todoList: [TodoEntity]
    
    init(viewcontroller: MenuViewController, router: menuRouter, todoList: [TodoEntity]) {
        self.viewcontroller = viewcontroller
        self.router = router
        self.todoList = todoList
    }
    func goToSettings(){
        router.goToSettings()
    }
}
