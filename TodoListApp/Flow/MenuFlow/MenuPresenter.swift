//
//  MenuPresenter.swift
//  TodoListApp
//
//  Created by Ars
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
