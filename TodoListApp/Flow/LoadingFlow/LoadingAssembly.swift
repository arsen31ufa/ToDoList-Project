//
//  LoadingAssebly.swift
//  TodoListApp
//
//  Created by Ars
//

import Foundation


class LoadingAssembly{
    func makeLoadingViewController() -> LoadingViewController{
        let vc = LoadingViewController()
        let router = LoadingRouter(viewController: vc)
        let presenter = LoadingPresenter(viewController: vc, router: router)
        vc.presenter = presenter
        return vc
    }
}
