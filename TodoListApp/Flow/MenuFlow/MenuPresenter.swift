//
//  MenuPresenter.swift
//  TodoListApp
//
//  Created by Have Dope on 01.09.2024.
//

import Foundation


class MenuPresenter{
    let viewcontroller: MenuViewController
    let todoList: [TodoEntity]
    
    init(viewcontroller: MenuViewController, todoList: [TodoEntity]) {
        self.viewcontroller = viewcontroller
        self.todoList = todoList
    }
}
