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
    init(viewController: LoadingViewController, router: LoadingRouter) {
        self.viewController = viewController
        self.router = router
    }
    
}
extension LoadingPresenter: LoadingPresenterProtocol{
    
    func goToMenu() {
        router.goToMenu()
    }
    
    func startProgress() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.viewController.updateProgress(to: 1)
        }
    }
    
    func fetchData() {
        DispatchQueue.global(qos: .background).async {
            ApiService.shared.fetchTodos()
        }
    }
    
    
}
