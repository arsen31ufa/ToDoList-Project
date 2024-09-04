//
//  LoadingPresenter.swift
//  TodoListApp
//
//  Created by Have Dope on 31.08.2024.
//

import Foundation
import UIKit

protocol LoadingPresenterProtocol{
    var viewController: LoadingViewController { get }
    var router:LoadingRouter { get }
    func startProgress()
    func fetchData()
    func goToMenu()
}

class LoadingPresenter {
    
    let viewController: LoadingViewController
    let router:LoadingRouter
    var isDataLoading = false
    
    init(viewController: LoadingViewController, router: LoadingRouter) {
        self.viewController = viewController
        self.router = router
    }
    
}

extension LoadingPresenter: LoadingPresenterProtocol{
    //Навигация
    func goToMenu() {
        guard isDataLoading == true else {fetchData(); return }
        let todoList = ApiService.shared.todos
        router.goToMenu(todoList: todoList)
    }
    
    //Старт
    func startProgress() {
        fetchData()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.viewController.updateProgress(to: 1)
        }
    }
    
    // проверка на наличиен/получение данных
    func fetchData() {
        ApiService.shared.fetchTodos{ (data, error) in
            if data != nil {
                self.isDataLoading = true
            } else {
                print("⚠️", error ?? "")
            }
        }
    }
    
    
    
}
